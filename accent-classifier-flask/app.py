from transformers import AutoFeatureExtractor, AutoModelForAudioClassification
from flask import Flask, request, jsonify
from flask_cors import CORS
from pydub import AudioSegment
import numpy as np
import io
import torch

app = Flask(__name__)
CORS(app)

LABEL_MAPPING = {0: 'Native', 1: 'Foreign'}

model = AutoModelForAudioClassification.from_pretrained('model/')
feature_extractor = AutoFeatureExtractor.from_pretrained('model/')

def preprocess_audio(audio_array):
    inputs = feature_extractor(audio_array, sampling_rate=16000, max_length=16000*25, truncation=True, return_tensors="pt")
    return {'input_values': inputs.input_values[0].numpy()}

def predict_audio(inputs):
    inputs = torch.tensor(inputs['input_values'], dtype=torch.float32).unsqueeze(0).to("cpu")
    with torch.no_grad():
        logits = model(inputs).logits
    predicted_class = torch.argmax(logits, dim=-1).item()
    return predicted_class

@app.route('/api/predict', methods=['POST'])
def predict():
    files = request.files.getlist('files')
    predictions = []
    for file in files:
        audio = AudioSegment.from_file(io.BytesIO(file.read()), format="wav")
        audio_array = np.array(audio.get_array_of_samples())

        inputs = preprocess_audio(audio_array)
        prediction = predict_audio(inputs)
        predictions.append(LABEL_MAPPING[prediction])

    return predictions, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5050)