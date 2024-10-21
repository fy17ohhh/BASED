<template>
  <div class="instructions">
    <h1>Instructions</h1>
    <h3>
      This is an experiment feature of BASED, which allows you to upload own
      speech files to get the predicted accent distributions.
    </h3>
    <h3>To start:</h3>
    <p>
      1. Ensure that all your speech files are English, as our model only
      predicts english accents.
    </p>
    <p>
      2. Click on the "Select Files" button to select the speech files you want
      to upload, the files will be automatically upload.
    </p>
    <p>
      3. You can also click on the uploaded files and press 'delete' to remove
      the files.
    </p>
    <p>4. You will see the result once the prediction is out. Cheers!👏</p>
  </div>
  <div class="upload-container">
    <el-upload
      class="upload"
      :http-request="customRequest"
      :show-file-list="true"
      :on-preview="handlePreview"
      :on-remove="handleRemove"
      :file-list="fileList"
      multiple
    >
      <el-button slot="trigger" size="small" type="primary" class="large-button"
        >Choose files</el-button
      >
    </el-upload>
  </div>
  <div v-if="accents.length">
    <h1>Accent Distribution:</h1>
    <div class="chart-container">
      <Doughnut
        :data="{
          labels: Object.keys(accentCounts),
          datasets: [
            {
              data: Object.values(accentCounts),
              backgroundColor: [
                '#69f098',
                '#f07669',
                '#69d3f0',
                '#f0e569',
                '#e8e6d3',
                '#FF9F40',
                '#FF6384',
                '#36A2EB',
                '#FFCE56',
                '#4BC0C0',
                '#9966FF',
                '#FF9F40',
              ],
            },
          ],
        }"
      />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { Doughnut } from "vue-chartjs";
import { Chart as ChartJS, Title, Tooltip, Legend, ArcElement } from "chart.js";

ChartJS.register(Title, Tooltip, Legend, ArcElement);

export default {
  components: {
    Doughnut,
  },
  data() {
    return {
      accents: [],
      fileList: [],
      chartData: {
        labels: [],
        datasets: [
          {
            data: [],
            backgroundColor: [
              "#69f098",
              "#f07669",
              "#69d3f0",
              "#f0e569",
              "#e8e6d3",
              "#FF9F40",
              "#FF6384",
              "#36A2EB",
              "#FFCE56",
              "#4BC0C0",
              "#9966FF",
              "#FF9F40",
            ],
          },
        ],
      },
    };
  },
  computed: {
    accentCounts() {
      const accentArray = Object.values(this.accents).map((x) => x.data);
      return accentArray.reduce((acc, accent) => {
        acc[accent] = (acc[accent] || 0) + 1;
        return acc;
      }, {});
    },
  },
  methods: {
    customRequest({ file, onProgress, onSuccess, onError }) {
      const formData = new FormData();
      formData.append("files", file);
      axios
        .post("http://localhost:5050/api/predict", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
          onUploadProgress: (event) => {
            let percent = Math.round((event.loaded * 100) / event.total);
            onProgress({ percent });
          },
        })
        .then((response) => {
          this.accents.push({ file: file, data: response.data });
          onSuccess(response.data);
          console.log(response.data);
        })
        .catch((error) => {
          onError(error);
        });
    },
    handlePreview(file) {
      console.log(file);
    },
    handleRemove(file, fileList) {
      this.fileList = fileList;
      this.accents = this.accents.filter(
        (accent) => accent.file.name !== file.name
      );
      console.log(this.accents);
      console.log(file, fileList);
    },
  },
};
</script>

<style scoped>
.upload-container {
  margin-bottom: 50px;
}
button {
  border-radius: 12px;
  background-color: #111b47;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #505f98;
}

input[type="file"] {
  border-radius: 12px;
  border: none;
}

.instructions {
  text-align: left;
  margin: 100px;
}

.instructions h1 {
  margin-bottom: 50px;
}

.chart-container {
  width: 300px;
  height: 300px;
  margin: 0 auto;
}
.large-button {
  font-size: 18px;
  padding: 15px 30px;
}
</style>
