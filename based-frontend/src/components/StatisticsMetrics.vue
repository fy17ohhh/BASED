<template>
  <div class="statistics-metrics-container">
    <div
      v-if="groupedData"
      v-for="(items, categoryDisplay) in groupedData"
      :key="categoryDisplay"
      class="metric-item"
    >
      <h3 class="category-title">{{ categoryDisplay }}</h3>

      <div v-for="item in items" :key="item.id" class="metric-details">
        <div class="metric-row">
          <div
            class="metric-value-left"
            :class="
              item.metricName.toLowerCase().replace(/_/g, '-').concat('-value')
            "
          >
            {{ item.metricValue }}
          </div>

          <div class="metric-bar-container">
            <div
              class="metric-bar"
              :class="item.metricName.toLowerCase().replace(/_/g, '-')"
              :style="{
                width:
                  calculatePercentage(item.metricName, item.metricValue) + '%',
              }"
            ></div>
            <div class="metric-name">
              {{ item.metricNameDisplay }}
              <el-tooltip
                v-if="metricDetails[item.metricName]"
                :content="`${
                  metricDetails[item.metricName]?.metricDescription
                }`"
                placement="bottom"
                @click.stop.prevent
              >
                <i class="el-icon-question" />
              </el-tooltip>
            </div>
          </div>

          <div class="metric-percentage">
            {{ calculateStar(item.metricName, item.metricValue) }}
            <el-tooltip
              v-if="metricDetails[item.metricName]"
              :content="`${
                metricDetails[item.metricName]?.metricRelationToBias
              }`"
              placement="bottom"
              @click.stop.prevent
            >
              <i class="el-icon-question" />
            </el-tooltip>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps, ref, watch } from "vue";
import axios from "axios";

const props = defineProps({
  statisticsMetrics: {
    type: Object,
    required: true,
    default: () => ({ data: [] }),
  },
});

const groupedData = ref({});
const metricDetails = ref({});

const processStatisticsMetricsData = async () => {
  if (props.statisticsMetrics) {
    props.statisticsMetrics.forEach((item) => {
      if (!groupedData.value[item.biasCategoryDisplay]) {
        groupedData.value[item.biasCategoryDisplay] = [];
      }
      groupedData.value[item.biasCategoryDisplay].push(item);
    });

    // Fetch metric details for each metric
    const metricNames = [
      ...new Set(props.statisticsMetrics.map((item) => item.metricName)),
    ];
    for (const metricName of metricNames) {
      try {
        const response = await axios.get(
          `http://localhost:8081/api/dataset/metric/details?metricName=${metricName}`
        );
        metricDetails.value[metricName] = response.data.data;
      } catch (error) {
        console.error(
          `Error fetching details for metric ${metricName}:`,
          error
        );
      }
    }

    console.log("Grouped Data based on bias category: ", groupedData.value);
    console.log("Metric Details: ", metricDetails.value);
  } else {
    console.error("Statistics Metrics Data is null or undefined");
  }
};

const calculatePercentage = (metricName, metricValue) => {
  let percentage = 0;
  percentage = (metricValue / 1) * 100;
  return percentage.toFixed(0);
};

const calculateStar = (metricName, metricValue) => {
  let star = "";
  switch (metricName) {
    case "normalized_standard_deviation":
      star = calculateStarRating1(metricValue);
      break;
    case "inverse_imbalance_ratio":
      star = calculateStarRating2(metricValue);
      break;
    case "simpsons_index":
      star = calculateStarRating1(metricValue);
      break;
    default:
      star = "N/A";
  }
  return star;
};

const calculateStarRating1 = (metricValue) => {
  let star = "";
  if (metricValue >= 0.8) {
    star = "5-star (high bias)";
  } else if (metricValue >= 0.6) {
    star = "4-star (moderate bias)";
  } else if (metricValue >= 0.4) {
    star = "3-star (neutral)";
  } else if (metricValue >= 0.2) {
    star = "2-star (low bias)";
  } else {
    star = "1-star (rare bias)";
  }
  return star;
};

const calculateStarRating2 = (metricValue) => {
  let star = "";
  if (metricValue <= 0.2) {
    star = "5-star (high bias)";
  } else if (metricValue <= 0.4) {
    star = "4-star (moderate bias)";
  } else if (metricValue <= 0.6) {
    star = "3-star (neutral)";
  } else if (metricValue <= 0.8) {
    star = "2-star (low bias)";
  } else {
    star = "1-star (rare bias)";
  }
  return star;
};

watch(
  () => props.statisticsMetrics,
  () => {
    groupedData.value = {};
    processStatisticsMetricsData();
  },
  { immediate: true }
);
</script>

<style scoped>
.statistics-metrics-container {
  max-width: 800px;
  margin: auto;
}

.metric-item {
  margin-bottom: 40px;
}

.category-title {
  font-size: 24px;
  font-weight: bold;
  margin: 50px 0;
  text-align: left;
}

.metric-details {
  margin-bottom: 15px;
}

.metric-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.metric-value-left {
  font-size: 24px;
  font-weight: bold;
  padding-right: 20px;
  width: 80px;
  text-align: center;
}

.metric-bar-container {
  width: 100%;
  border-radius: 5px;
  overflow: hidden;
  margin: 30px 20px 30px 20px;
  position: relative;
}

.metric-bar {
  height: 10px;
  border-radius: 5px;
}

.simpsons-index {
  background-color: #8bc34a;
}

.inverse-imbalance-ratio {
  background-color: #ff7043;
}

.normalized-standard-deviation {
  background-color: #42a5f5;
}

.simpsons-index-value {
  color: #8bc34a;
}

.inverse-imbalance-ratio-value {
  color: #ff7043;
}

.normalized-standard-deviation-value {
  color: #42a5f5;
}

.metric-name {
  text-align: left;
  margin-top: 10px;
  font-size: 18px;
}

.metric-percentage {
  display: flex;
  font-size: 18px;
  font-weight: 700;
  color: #9e9e9e;
  width: 200px;
}
</style>
