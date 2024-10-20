CREATE DATABASE IF NOT EXISTS DSA4288;
USE DSA4288;

DROP TABLE IF EXISTS bias_metrics_details;
DROP TABLE IF EXISTS dataset_bias_statistics;
DROP TABLE IF EXISTS dataset_bias_metrics;
DROP TABLE IF EXISTS dataset_overview;

CREATE TABLE dataset_overview (
    dataset_id INT AUTO_INCREMENT PRIMARY KEY,
    dataset_name_display VARCHAR(255) NOT NULL,
    dataset_name_code VARCHAR(255) NOT NULL,
    description TEXT,
    publisher VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE dataset_bias_statistics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dataset_id INT,
    bias_category VARCHAR(255),  -- Category like 'gender', 'age_group'
    bias_category_display VARCHAR(255), -- Display label for categories, e.g. 'Age Group'
    bias_category_value VARCHAR(255),  -- Values like 'female', 'male'
    bias_category_value_count INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (dataset_id) REFERENCES dataset_overview(dataset_id) ON DELETE CASCADE
);

CREATE TABLE dataset_bias_metrics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dataset_id INT,
    bias_category VARCHAR(255), -- Category like 'gender', 'age_group'
	bias_category_display VARCHAR(255), -- Display label for categories, e.g. 'Age Group'
    metric_name VARCHAR(255) NOT NULL, -- e.g., 'imbalance_ratio'
    metric_name_display VARCHAR(255), -- e.g., 'Imbalance Ratio'
    metric_value FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (dataset_id) REFERENCES dataset_overview(dataset_id) ON DELETE CASCADE
);

CREATE TABLE bias_metrics_details (
    metric_id INT AUTO_INCREMENT PRIMARY KEY,
    metric_name VARCHAR(255) NOT NULL, -- e.g., 'imbalance_ratio'
    metric_symbol VARCHAR(255) NOT NULL,
    metric_description TEXT,
    metric_range TEXT,
    metric_relation_to_bias VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO dataset_overview (dataset_name_display, dataset_name_code, description, publisher) 
VALUES 
('VCTK', 'vctk', 'The VCTK Corpus includes around 44-hours of speech data uttered by 110 English speakers with various accents. Each speaker reads out about 400 sentences, which were selected from a newspaper, the rainbow passage and an elicitation paragraph used for the speech accent archive.', 'University of Edinburgh, The Centre for Speech Technology Research (CSTR)'),
('Common Voice Corpus 17.0',  'common_voice_corpus_17.0', 'Mozilla Common Voice is a large-scale, open-source voice dataset contributed by volunteers. It is used for various speech-related machine learning tasks such as automatic speech recognition.', 'Mozilla Foundation'),
('Multilingual Librispeech', 'multilingual_librispeech', 'The Multilingual LibriSpeech dataset is a large multilingual corpus suitable for speech research. The dataset is derived from read audiobooks from LibriVox and consists of 8 languages - English, German, Dutch, Spanish, French, Italian, Portuguese, Polish. It includes about 44.5K hours of English and a total of about 6K hours for other languages.', 'Meta, formerly Facebook'),
('Voxpopuli', 'voxpopuli', 'VoxPopuli is a large-scale multilingual speech corpus for representation learning, semi-supervised learning and interpretation. The raw data is collected from 2009-2020 European Parliament event recordings. We acknowledge the European Parliament for creating and sharing these materials. This implementation contains transcribed speech data for 18 languages. It also contains 29 hours of transcribed speech data of non-native English intended for research in ASR for accented speech (15 L2 accents)', 'Meta, formerly Facebook'),
('Tedlium Release 1', 'tedlium_release_1', 'The TED-LIUM corpus is English-language TED talks, with transcriptions, sampled at 16kHz. The release 1 contains 118 hours of speech audio data and 774 audio talks and automatically aligned transcriptions.', 'LIUM (Laboratoire d\'Informatique de l\'Université du Mans)'),
('Audio MNIST', 'audio_mnist', 'The Audio MNIST dataset is similar to the classic MNIST dataset but in audio format. It contains recordings of different speakers saying digits from 0 to 9. The dataset contains 3,000 audio clips stored as .wav files. Each file is named in the format [digit]_[speaker]_[instance].wav, where digit is the spoken digit (0-9), speaker is the name of the speaker, and instance is a unique identifier for the recording.', 'Sören Becker et al.'),
('MUSAN Speech Librivox', 'musan_speech_librivox', 'MUSAN is a corpus of music, speech, and noise recordings. This dataset is suitable for training models for voice activity detection (VAD) and music/speech discrimination. Our corpus is released under a flexible Creative Commons license. The dataset consists of music from several genres, speech from twelve languages, and a wide assortment of technical and non-technical noises. MUSAN Speech Librivox contains speech data from Librivox (librivox.org)', 'Snyder et al.'),
('Google Chilean Spanish', 'google_chilean_spanish', 'This dataset consists of 7 hours of transcribed high-quality audio of Chilean Spanish sentences recorded by 31 volunteers. The dataset is intended for speech technologies. Its supported tasks include (1) Supported text-to-speech, text-to-audio: The dataset can be used to train a model for Text-To-Speech (TTS). (2)automatic-speech-recognition, speaker-identification: The dataset can also be used to train a model for Automatic Speech Recognition (ASR). The model is presented with an audio file and asked to transcribe the audio file to written text. The most common evaluation metric is the word error rate (WER).', 'Yoach Lacombe'),
('Google Tamil', 'google_tamil', 'This dataset consists of 7 hours of transcribed high-quality audio of Tamil sentences recorded by 50 volunteers. The dataset is intended for speech technologies. Its supported tasks include (1) text-to-speech, text-to-audio: The dataset can be used to train a model for Text-To-Speech (TTS). (2) automatic-speech-recognition, speaker-identification: The dataset can also be used to train a model for Automatic Speech Recognition (ASR). The model is presented with an audio file and asked to transcribe the audio file to written text. The most common evaluation metric is the word error rate (WER).', 'Yoach Lacombe'),
('nEMO', 'nemo', 'nEMO is a simulated dataset of emotional speech in the Polish language. The corpus contains over 3 hours of samples recorded with the participation of nine actors portraying six emotional states: anger, fear, happiness, sadness, surprise, and a neutral state. The text material used was carefully selected to represent the phonetics of the Polish language. The corpus is available for free under the Creative Commons license (CC BY-NC-SA 4.0). Its supported tasks include (1) audio-classification: This dataset was mainly created for the task of speech emotion recognition. Each recording is labeled with one of six emotional states (anger, fear, happiness, sadness, surprised, and neutral). Additionally, each sample is labeled with speaker id and speaker gender. Because of that, the dataset can also be used for different audio classification tasks. (2) automatic-speech-recognition: The dataset includes orthographic and normalized transcriptions for each audio recording, making it a useful resource for automatic speech recognition (ASR) tasks. The sentences were carefully selected to cover a wide range of phonemes in the Polish language. (3) text-to-speech: The dataset contains emotional audio recordings with transcriptions, which can be valuable for developing TTS systems that produce emotionally expressive speech.', 'Adam Mickiewicz University\'s Center for Artificial Intelligence');

INSERT INTO bias_metrics_details (metric_name, metric_symbol, metric_description, metric_range, metric_relation_to_bias)
VALUES 
('normalized_standard_deviation', 'NSD', 'The normalized standard deviation measures the variability in the distribution of different groups within a dataset, adjusted for the total range of values.', 
'(0, 1]', 
'High standard deviation can indicate potential bias in the dataset, as the distribution of subgroups are very uneven.'),
('inverse_imbalance_ratio', 'IR^(-1)', 'Inverse Imbalance Ratio is a measure used to assess the balance or skewness of a dataset in terms of group representation.', 
'(0, 1]', 'Values close to 0 indicating strongly biased populations and 1 indicating unbiased ones'),
('simpsons_index', 'D', 'Simpson\'s Index is a measure of diversity which takes into account the number of categories present, as well as the relative abundance of each category.', 
'(0, 1]', 'This metric ranges from 1 for extremely biased populations with a single represented group, and approaches 0 for increasingly diverse populations');

-- vctk

INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count)
VALUES
(1, 'accent', 'Accent', 'English', 27272),
(1, 'accent', 'Accent', 'Scottish', 15222),
(1, 'accent', 'Accent', 'NorthernIrish', 5160),
(1, 'accent', 'Accent', 'Irish', 7246),
(1, 'accent', 'Accent', 'Indian', 2328),
(1, 'accent', 'Accent', 'Welsh', 750),
(1, 'accent', 'Accent', 'American', 16806),
(1, 'accent', 'Accent', 'Canadian', 6302),
(1, 'accent', 'Accent', 'SouthAfrican', 3374),
(1, 'accent', 'Accent', 'Australian', 1646),
(1, 'accent', 'Accent', 'NewZealand', 844),
(1, 'accent', 'Accent', 'British', 796),

(1, 'gender', 'Gender', 'F', 50828),
(1, 'gender', 'Gender', 'M', 37328),

(1, 'age', 'Age', '10-19', 10912),
(1, 'age', 'Age', '30-39', 2468),
(1, 'age', 'Age', '20-29', 74776),

(1, 'region', 'Region', 'Southern England', 6946),
(1, 'region', 'Region', 'Surrey', 1504),
(1, 'region', 'Region', 'Cumbria', 778),
(1, 'region', 'Region', 'Stockton-on-tees', 794),
(1, 'region', 'Region', 'Staffordshire', 744),
(1, 'region', 'Region', 'West Dumfries', 714),
(1, 'region', 'Region', 'Manchester', 1824),
(1, 'region', 'Region', 'Fife', 2436),
(1, 'region', 'Region', 'Belfast', 4316),
(1, 'region', 'Region', 'SW England', 1004),
(1, 'region', 'Region', 'Perth', 706),
(1, 'region', 'Region', 'London', 786),
(1, 'region', 'Region', 'Dublin', 3210),
(1, 'region', 'Region', 'Selkirk', 716),
(1, 'region', 'Region', 'Argyll', 950),
(1, 'region', 'Region', '', 5064),
(1, 'region', 'Region', 'Aberdeen', 1612),
(1, 'region', 'Region', 'SE England', 962),
(1, 'region', 'Region', 'Edinburgh', 4124),
(1, 'region', 'Region', 'Cardiff', 750),
(1, 'region', 'Region', 'Galloway', 758),
(1, 'region', 'Region', 'Birmingham', 638),
(1, 'region', 'Region', 'Nottingham', 962),
(1, 'region', 'Region', 'Orkney', 712),
(1, 'region', 'Region', 'West Lothian', 966),
(1, 'region', 'Region', 'Ross', 696),
(1, 'region', 'Region', 'Athlone', 844),
(1, 'region', 'Region', 'Yorkshire', 1758),
(1, 'region', 'Region', 'Newcastle', 2458),
(1, 'region', 'Region', 'Suffolk', 866),
(1, 'region', 'Region', 'Essex', 932),
(1, 'region', 'Region', 'Midlothian', 832),
(1, 'region', 'Region', 'Oxford', 924),
(1, 'region', 'Region', 'NE England', 916),
(1, 'region', 'Region', 'Cheshire', 818),
(1, 'region', 'Region', 'Leicester', 810),
(1, 'region', 'Region', 'France', 410),
(1, 'region', 'Region', 'Cork', 938),
(1, 'region', 'Region', 'York', 848),
(1, 'region', 'Region', 'San Francisco', 846),
(1, 'region', 'Region', 'New York', 1524),
(1, 'region', 'Region', 'Tipperary', 810),
(1, 'region', 'Region', 'California', 1606),
(1, 'region', 'Region', 'North Carolina', 822),
(1, 'region', 'Region', 'Montreal', 622),
(1, 'region', 'Region', 'Toronto', 1542),
(1, 'region', 'Region', 'Philadelphia', 844),
(1, 'region', 'Region', 'Ontario', 840),
(1, 'region', 'Region', 'Alabama', 846),
(1, 'region', 'Region', 'Tennessee', 846),
(1, 'region', 'Region', 'Iowa', 846),
(1, 'region', 'Region', 'Hamilton', 1680),
(1, 'region', 'Region', 'County Down', 842),
(1, 'region', 'Region', 'Cape Town', 846),
(1, 'region', 'Region', 'Alberta', 1618),
(1, 'region', 'Region', 'Napa', 844),
(1, 'region', 'Region', 'Pretoria', 846),
(1, 'region', 'Region', 'English Sydney', 798),
(1, 'region', 'Region', 'Indiana', 842),
(1, 'region', 'Region', 'Chicago', 846),
(1, 'region', 'Region', 'English', 1692),
(1, 'region', 'Region', 'Johannesburg', 1682),
(1, 'region', 'Region', 'Pennsylvania', 846),
(1, 'region', 'Region', 'Ohio', 818),
(1, 'region', 'Region', 'Florida', 794),
(1, 'region', 'Region', 'Derry', 844),
(1, 'region', 'Region', 'New Jersey', 1696),
(1, 'region', 'Region', 'Donegal', 602);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(1, 'accent', 'Accent', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.2921),
(1, 'accent', 'Accent', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.015),
(1, 'accent', 'Accent', 'simpsons_index', 'Simpson\'s Index', 0.8201),

(1, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(1, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.7344),
(1, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.4883),

(1, 'age', 'Age', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.4464),
(1, 'age', 'Age', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.033),
(1, 'age', 'Age', 'simpsons_index', 'Simpson\'s Index', 0.2644),

(1, 'region', 'Region', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.1691),
(1, 'region', 'Region', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0059),
(1, 'region', 'Region', 'simpsons_index', 'Simpson\'s Index', 0.9746);

-- common_voice_corpus_17.0
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) VALUES
(2, 'language', 'Language', 'Abkhaz', 98514),
(2, 'language', 'Language', 'Afrikaans', 603),
(2, 'language', 'Language', 'Amharic', 2431),
(2, 'language', 'Language', 'Arabic', 184211),
(2, 'language', 'Language', 'Assamese', 3798),
(2, 'language', 'Language', 'Asturian', 2205),
(2, 'language', 'Language', 'Azerbaijani', 430),
(2, 'language', 'Language', 'Bashkir', 366294),
(2, 'language', 'Language', 'Basaa', 4052),
(2, 'language', 'Language', 'Belarusian', 1714060),
(2, 'language', 'Language', 'Bulgarian', 24481),
(2, 'language', 'Language', 'Bengali', 1089375),
(2, 'language', 'Language', 'Breton', 37536),
(2, 'language', 'Language', 'Catalan', 3604627),
(2, 'language', 'Language', 'Central Kurdish', 172163),
(2, 'language', 'Language', 'Hakha Chin', 8528),
(2, 'language', 'Language', 'Czech', 250140),
(2, 'language', 'Language', 'Chuvash', 23563),
(2, 'language', 'Language', 'Welsh', 133673),
(2, 'language', 'Language', 'Danish', 19144),
(2, 'language', 'Language', 'German', 1600683),
(2, 'language', 'Language', 'Dhivehi', 52776),
(2, 'language', 'Language', 'Dioula', 468),
(2, 'language', 'Language', 'Greek', 32687),
(2, 'language', 'Language', 'English', 3547364),
(2, 'language', 'Language', 'Esperanto', 1304356),
(2, 'language', 'Language', 'Spanish', 2008575),
(2, 'language', 'Language', 'Estonian', 40353),
(2, 'language', 'Language', 'Basque', 543028),
(2, 'language', 'Language', 'Persian', 425710),
(2, 'language', 'Language', 'Finnish', 22551),
(2, 'language', 'Language', 'French', 1412681),
(2, 'language', 'Language', 'Frisian', 167558),
(2, 'language', 'Language', 'Irish', 12065),
(2, 'language', 'Language', 'Galician', 136912),
(2, 'language', 'Language', 'Guarani', 24635),
(2, 'language', 'Language', 'Hausa', 13279),
(2, 'language', 'Language', 'Hebrew', 6374),
(2, 'language', 'Language', 'Hindi', 25419),
(2, 'language', 'Language', 'Sorbian, Upper', 3189),
(2, 'language', 'Language', 'Haitian', 5),
(2, 'language', 'Language', 'Hungarian', 172393),
(2, 'language', 'Language', 'Armenian', 46177),
(2, 'language', 'Language', 'Interlingua', 23248),
(2, 'language', 'Language', 'Indonesian', 70181),
(2, 'language', 'Language', 'Igbo', 5792),
(2, 'language', 'Language', 'Icelandic', 54),
(2, 'language', 'Language', 'Italian', 463942),
(2, 'language', 'Language', 'Japanese', 379482),
(2, 'language', 'Language', 'Georgian', 227529),
(2, 'language', 'Language', 'Kabyle', 925759),
(2, 'language', 'Language', 'Kazakh', 4089),
(2, 'language', 'Language', 'Kurmanji Kurdish', 101244),
(2, 'language', 'Language', 'Korean', 4418),
(2, 'language', 'Language', 'Kyrgyz', 42645),
(2, 'language', 'Language', 'Luganda', 445839),
(2, 'language', 'Language', 'Ligurian', 6046),
(2, 'language', 'Language', 'Lao', 324),
(2, 'language', 'Language', 'Lithuanian', 34130),
(2, 'language', 'Language', 'Latgalian', 28732),
(2, 'language', 'Language', 'Latvian', 238301),
(2, 'language', 'Language', 'Moksha', 681),
(2, 'language', 'Language', 'Meadow Mari', 450647),
(2, 'language', 'Language', 'Macedonian', 23116),
(2, 'language', 'Language', 'Malayalam', 11444),
(2, 'language', 'Language', 'Mongolian', 21280),
(2, 'language', 'Language', 'Marathi', 21717),
(2, 'language', 'Language', 'Hill Mari', 60361),
(2, 'language', 'Language', 'Maltese', 18257),
(2, 'language', 'Language', 'Erzya', 3954),
(2, 'language', 'Language', 'Taiwanese (Minnan)', 35785),
(2, 'language', 'Language', 'Nepali', 2105),
(2, 'language', 'Language', 'Western Sierra Puebla Nahuatl', 44),
(2, 'language', 'Language', 'Dutch', 156216),
(2, 'language', 'Language', 'Norwegian Nynorsk', 2537),
(2, 'language', 'Language', 'Northern Sotho', 20),
(2, 'language', 'Language', 'Occitan', 10267),
(2, 'language', 'Language', 'Odia', 11730),
(2, 'language', 'Language', 'Ossetian', 386),
(2, 'language', 'Language', 'Punjabi', 4479),
(2, 'language', 'Language', 'Polish', 179117),
(2, 'language', 'Language', 'Pashto', 2755),
(2, 'language', 'Language', 'Portuguese', 225799),
(2, 'language', 'Language', 'Quechua Chanka', 7),
(2, 'language', 'Language', 'Romansh Sursilvan', 11478),
(2, 'language', 'Language', 'Romansh Vallader', 4150),
(2, 'language', 'Language', 'Romanian', 54719),
(2, 'language', 'Language', 'Russian', 237644),
(2, 'language', 'Language', 'Kinyarwanda', 2749122),
(2, 'language', 'Language', 'Sakha', 12159),
(2, 'language', 'Language', 'Santali (Ol Chiki)', 1286),
(2, 'language', 'Language', 'Sardinian', 2591),
(2, 'language', 'Language', 'Slovak', 32231),
(2, 'language', 'Language', 'Saraiki', 9369),
(2, 'language', 'Language', 'Slovenian', 18107),
(2, 'language', 'Language', 'Albanian', 3064),
(2, 'language', 'Language', 'Serbian', 13042),
(2, 'language', 'Language', 'Swedish', 67170),
(2, 'language', 'Language', 'Swahili', 795976),
(2, 'language', 'Language', 'Tamil', 304829),
(2, 'language', 'Language', 'Telugu', 2133),
(2, 'language', 'Language', 'Thai', 418269),
(2, 'language', 'Language', 'Tigrinya', 92),
(2, 'language', 'Language', 'Tigre', 2208),
(2, 'language', 'Language', 'Turkmen', 6014),
(2, 'language', 'Language', 'Toki Pona', 23174),
(2, 'language', 'Language', 'Turkish', 176398),
(2, 'language', 'Language', 'Tatar', 47752),
(2, 'language', 'Language', 'Twi', 387),
(2, 'language', 'Language', 'Uyghur', 165864),
(2, 'language', 'Language', 'Ukrainian', 131699),
(2, 'language', 'Language', 'Urdu', 210018),
(2, 'language', 'Language', 'Uzbek', 301301),
(2, 'language', 'Language', 'Vietnamese', 21258),
(2, 'language', 'Language', 'Votic', 529),
(2, 'language', 'Language', 'Yiddish', 96),
(2, 'language', 'Language', 'Yoruba', 7494),
(2, 'language', 'Language', 'Cantonese', 173593),
(2, 'language', 'Language', 'Tamazight', 2145),
(2, 'language', 'Language', 'Chinese (China)', 890885),
(2, 'language', 'Language', 'Chinese (Hong Kong)', 138794),
(2, 'language', 'Language', 'Chinese (Taiwan)', 151916),
(2, 'language', 'Language', 'Zulu', 35),
(2, 'language', 'Language', 'Zaza', 724),

(2, 'age', 'Age', 'unknown', 9898208.609999996),
(2, 'age', 'Age', 'twenties', 8969325.560000002),
(2, 'age', 'Age', 'thirties', 3958473.7399999993),
(2, 'age', 'Age', 'teens', 1642143.4199999997),
(2, 'age', 'Age', 'fourties', 2366494.0800000005),
(2, 'age', 'Age', 'fifties', 1949586.1600000006),
(2, 'age', 'Age', 'sixties', 1711972.9800000007),
(2, 'age', 'Age', 'seventies', 180846.44999999998),
(2, 'age', 'Age', 'eighties', 32271.34),
(2, 'age', 'Age', 'nineties', 2855.17),

(2, 'gender', 'Gender', 'male_masculine', 14131505.76),
(2, 'gender', 'Gender', 'female_feminine', 6625939.929999999),
(2, 'gender', 'Gender', 'unknown', 9997676.049999997);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(2, 'age', 'Age', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.3425),
(2, 'age', 'Age', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0003),
(2, 'age', 'Age', 'simpsons_index', 'Simpson\'s Index', 0.7783),

(2, 'language', 'Language', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.1665),
(2, 'language', 'Language', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0),
(2, 'language', 'Language', 'simpsons_index', 'Simpson\'s Index', 0.9448),

(2, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.4089),
(2, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.4689),
(2, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.6368);

-- Multilingual LibriSpeech
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) VALUES
(3, 'language', 'Language', 'German', 476805),
(3, 'language', 'Language', 'Dutch', 380457),
(3, 'language', 'Language', 'French', 263055),
(3, 'language', 'Language', 'Spanish', 225494),
(3, 'language', 'Language', 'Italian', 62133),
(3, 'language', 'Language', 'Portuguese', 39230),
(3, 'language', 'Language', 'Polish', 26075),

(3, 'gender', 'Gender', 'M', 3124),
(3, 'gender', 'Gender', 'F', 3208);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(3, 'language', 'Language', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.3637),
(3, 'language', 'Language', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0574),
(3, 'language', 'Language', 'simpsons_index', 'Simpson\'s Index', 0.7705),

(3, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(3, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.9738),
(3, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.5);

-- voxpopuli
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) 
VALUES 
(4, 'language', 'Language', 'English', 186077),
(4, 'language', 'Language', 'German', 112550),
(4, 'language', 'Language', 'French', 77030),
(4, 'language', 'Language', 'Spanish', 54081),
(4, 'language', 'Language', 'Polish', 38187),
(4, 'language', 'Language', 'Italian', 25010),
(4, 'language', 'Language', 'Romanian', 27060),
(4, 'language', 'Language', 'Hungarian', 20306),
(4, 'language', 'Language', 'Czech', 21128),
(4, 'language', 'Language', 'Dutch', 23335),
(4, 'language', 'Language', 'Finnish', 9074),
(4, 'language', 'Language', 'Croatian', 12938),
(4, 'language', 'Language', 'Slovak', 11916),
(4, 'language', 'Language', 'Slovene', 3297),
(4, 'language', 'Language', 'Estonian', 935),
(4, 'language', 'Language', 'Lithuanian', 501),

(4, 'gender', 'Gender', 'female', 224867),
(4, 'gender', 'Gender', 'male', 398558),

(4, 'accent', 'Accent', 'Romanian', 485),
(4, 'accent', 'Accent', 'Polish', 852),
(4, 'accent', 'Accent', 'Czech', 974),
(4, 'accent', 'Accent', 'Hungarian', 676),
(4, 'accent', 'Accent', 'Finnish', 590),
(4, 'accent', 'Accent', 'Dutch', 1151),
(4, 'accent', 'Accent', 'German', 1074),
(4, 'accent', 'Accent', 'French', 737),
(4, 'accent', 'Accent', 'Spanish', 419),
(4, 'accent', 'Accent', 'Italian', 360),
(4, 'accent', 'Accent', 'Estonian', 289),
(4, 'accent', 'Accent', 'Lithuanian', 178),
(4, 'accent', 'Accent', 'Croatian', 127),
(4, 'accent', 'Accent', 'Slovak', 409),
(4, 'accent', 'Accent', 'Slovene', 66);


INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(4, 'language', 'Language', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.2573),
(4, 'language', 'Language', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0027),
(4, 'language', 'Language', 'simpsons_index', 'Simpson\'s Index', 0.8436),

(4, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(4, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.5642),
(4, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.4612),

(4, 'accent', 'Accent', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.3061),
(4, 'accent', 'Accent', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0573),
(4, 'accent', 'Accent', 'simpsons_index', 'Simpson\'s Index', 0.9099);

-- tedlium_release_1
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count)
VALUES
(5, 'gender', 'Gender', 'Male', 40866),
(5, 'gender', 'Gender', 'Female', 17678),
(5, 'gender', 'Gender', 'Unknown', 319),

(5, 'accent', 'Accent', 'Native', 34372),
(5, 'accent', 'Accent', 'Foreign', 24491);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(5, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.4097),
(5, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0078),
(5, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.4278),

(5, 'accent', 'Accent', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(5, 'accent', 'Accent', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.7125),
(5, 'accent', 'Accent', 'simpsons_index', 'Simpson\'s Index', 0.4859);

-- audio_mnist
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count)
VALUES
(6, 'accent', 'Accent', 'German', 20500),
(6, 'accent', 'Accent', 'German/Spanish', 500),
(6, 'accent', 'Accent', 'South Korean', 500),
(6, 'accent', 'Accent', 'Spanish', 1000),
(6, 'accent', 'Accent', 'Madras', 500),
(6, 'accent', 'Accent', 'Levant', 500),
(6, 'accent', 'Accent', 'English', 500),
(6, 'accent', 'Accent', 'Chinese', 1500),
(6, 'accent', 'Accent', 'Brasilian', 500),
(6, 'accent', 'Accent', 'Italian', 1000),
(6, 'accent', 'Accent', 'Egyptian_American?', 500),
(6, 'accent', 'Accent', 'South African', 500),
(6, 'accent', 'Accent', 'Arabic', 500),
(6, 'accent', 'Accent', 'Danish', 500),
(6, 'accent', 'Accent', 'French', 500),
(6, 'accent', 'Accent', 'Tamil', 500),

(6, 'gender', 'Gender', 'male', 24000),
(6, 'gender', 'Gender', 'female', 6000),

(6, 'age', 'Age', '30-39', 7500),
(6, 'age', 'Age', '20-29', 21000),
(6, 'age', 'Age', '40-49', 500),
(6, 'age', 'Age', 'above 60', 1000);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(6, 'accent', 'Accent', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.2342),
(6, 'accent', 'Accent', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.025),
(6, 'accent', 'Accent', 'simpsons_index', 'Simpson\'s Index', 0.5472),

(6, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(6, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.25),
(6, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.32),

(6, 'age', 'Age', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.4034),
(6, 'age', 'Age', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0238),
(6, 'age', 'Age', 'simpsons_index', 'Simpson\'s Index', 0.4461);

-- musan_speech_librivox
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) 
VALUES 
(7, 'language', 'Language', 'german', 16),
(7, 'language', 'Language', 'english', 76),
(7, 'language', 'Language', 'spanish', 11),
(7, 'language', 'Language', 'chinese', 7),
(7, 'language', 'Language', 'latin', 1),
(7, 'language', 'Language', 'italian', 8),
(7, 'language', 'Language', 'french', 11),
(7, 'language', 'Language', 'hebrew', 4),
(7, 'language', 'Language', 'russian', 9),
(7, 'language', 'Language', 'tagalog', 3),
(7, 'language', 'Language', 'portuguese', 9),
(7, 'language', 'Language', 'hungarian', 1),
(7, 'language', 'Language', 'danish', 1),
(7, 'language', 'Language', 'arabic', 1),
(7, 'language', 'Language', 'dutch', 9),
(7, 'language', 'Language', 'japanese', 3),
(7, 'language', 'Language', 'polish', 2),

(7, 'gender', 'Gender', 'Female', 86),
(7, 'gender', 'Gender', 'Male', 86);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(7, 'language', 'Language', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.2271),
(7, 'language', 'Language', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.0132),
(7, 'language', 'Language', 'simpsons_index', 'Simpson\'s Index', 0.779),

(7, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.0),
(7, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 1.0),
(7, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.5029);

-- google_chilean_spanish
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) 
VALUES 
(8, 'gender', 'Gender', 'Female', 1738),
(8, 'gender', 'Gender', 'Male', 2636);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(8, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(8, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.6593),
(8, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.479);

-- google_tamil
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) 
VALUES 
(9, 'gender', 'Gender', 'Female', 2335),
(9, 'gender', 'Gender', 'Male', 1956);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(9, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(9, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.8377),
(9, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.4962);

-- nemo
-- Inserting emotion data
INSERT INTO dataset_bias_statistics (dataset_id, bias_category, bias_category_display, bias_category_value, bias_category_value_count) 
VALUES 
(10, 'emotion', 'Emotion', 'surprised', 669),
(10, 'emotion', 'Emotion', 'neutral', 809),
(10, 'emotion', 'Emotion', 'sadness', 769),
(10, 'emotion', 'Emotion', 'happiness', 749),
(10, 'emotion', 'Emotion', 'fear', 736),
(10, 'emotion', 'Emotion', 'anger', 749),

(10, 'gender', 'Gender', 'male', 2412),
(10, 'gender', 'Gender', 'female', 2069),

(10, 'age', 'Age', '23', 1529),
(10, 'age', 'Age', '27', 539),
(10, 'age', 'Age', '24', 794),
(10, 'age', 'Age', '28', 1080),
(10, 'age', 'Age', '26', 539);

INSERT INTO dataset_bias_metrics (dataset_id, bias_category, bias_category_display, metric_name, metric_name_display, metric_value)
VALUES
(10, 'emotion', 'Emotion', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.2994),
(10, 'emotion', 'Emotion', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.8269),
(10, 'emotion', 'Emotion', 'simpsons_index', 'Simpson\'s Index', 0.833),

(10, 'gender', 'Gender', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.5),
(10, 'gender', 'Gender', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.8578),
(10, 'gender', 'Gender', 'simpsons_index', 'Simpson\'s Index', 0.4972),

(10, 'age', 'Age', 'normalized_standard_deviation', 'Normalized Standard Deviation', 0.3779),
(10, 'age', 'Age', 'inverse_imbalance_ratio', 'Inverse Imbalance Ratio', 0.3525),
(10, 'age', 'Age', 'simpsons_index', 'Simpson\'s Index', 0.7653);