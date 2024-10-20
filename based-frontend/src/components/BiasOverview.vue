<template>
  <div class="bias-category-container">
    <div v-for="(items, categoryDisplay) in groupedData" :key="categoryDisplay" class="bias-category">
      <h3>{{ categoryDisplay }}</h3>
      <div class="chart-container">
        <Doughnut :data="{
          labels: items.map(item => item.biasCategoryValue),
          datasets: [{
            data: items.map(item => item.biasCategoryValueCount),
            backgroundColor: ['#69f098', '#f07669', '#69d3f0', '#f0e569', '#e8e6d3', '#FF9F40', '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40']
          }]
        }"/>
      </div>
    </div>
  </div>
</template>
<script setup>
import {defineProps, ref, watch} from 'vue';
import {Doughnut} from "vue-chartjs";
import {Chart as ChartJS, Title, Tooltip, Legend, ArcElement} from 'chart.js';

ChartJS.register(Title, Tooltip, Legend, ArcElement);

const props = defineProps({
  biasOverview: {
    type: Object,
    required: true,
    default: () => ({data: []})
  }
});

const groupedData = ref({});

const processBiasOverviewData = () => {
  groupedData.value = {};
  if (props.biasOverview) {
    props.biasOverview.forEach(item => {
      if (!groupedData.value[item.biasCategoryDisplay]) {
        groupedData.value[item.biasCategoryDisplay] = [];
      }
      groupedData.value[item.biasCategoryDisplay].push(item);
    });
    console.log("Grouped Data based on bias category: ", groupedData.value);
  } else {
    console.error('Bias Overview Data is null or undefined');
  }
};

watch(() => props.biasOverview, () => {
  groupedData.value = {};
  processBiasOverviewData();
}, {immediate: true});
</script>

<style scoped>
h3 {
  font-size: 25px;
  color: #111b47;
}

.bias-category-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.bias-category {
  flex: 1 1 calc(50% - 20px);
  box-sizing: border-box;
  margin-bottom: 40px;
}

.chart-container {
  width: 400px;
  height: 400px;
  margin: 0 auto;
}
</style>