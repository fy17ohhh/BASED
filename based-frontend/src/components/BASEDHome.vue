<template>
  <div class="based-container">
    <div class="bias-header">
      <h2>BASED Homepage</h2>
    </div>

    <div class="instructions">
      <hr />
      <h4>Instructions</h4>
      <hr />
      <p>Type the name or part of the name of the dataset you are looking for, and click on a row in the table to highlight and select the dataset for further information on the dataset, including the bias summary for the data, statistics metrics for bias, and the detailed description of the dataset.</p>
    </div>

    <div class="search-section">
      <el-input v-model="searchQuery" placeholder="Search for datasets names" class="search-input"></el-input>
      <el-button @click="clearSearch" type="primary" class="clear-btn">Clear</el-button>
      <br />

      <el-table
          ref="singleTable"
          :data="paginatedData"
          highlight-current-row
          @current-change="handleCurrentChange"
          :row-style="{ background: '#fcefdc' }"
          :header-cell-style="{ background: '#fcefdc'}"
          style="width: 100%">
        <el-table-column
            label="Index"
            width="100">
          <template v-slot="scope">
            {{ (currentPage - 1) * pageSize + scope.$index + 1 }}
          </template>
        </el-table-column>
        <el-table-column
            property="datasetNameDisplay"
            label="Dataset Name">
        </el-table-column>
        <el-table-column
            property="publisher"
            label="Publisher(s)/Author(s)">
        </el-table-column>
      </el-table>
    </div>
    <div class="pagination-and-submit-controls">
      <el-pagination
          class="pagination-controls"
          @current-change="handlePageChange"
          :current-page="currentPage"
          :page-size="pageSize"
          layout="prev, pager, next"
          :total="filteredData.length">
      </el-pagination>
      <el-button @click="submitDataset" type="primary" class="submit-btn">Submit</el-button>
    </div>

    <div v-if="selectedDataset" class="subsection">
      <nav class="subsection-nav">
        <button @click="currentSubsection = 'biasOverview'" class="subsection-link" :class="{ 'active-link': currentSubsection === 'biasOverview' }">Bias Overview</button>
        <button @click="currentSubsection = 'statisticsMetrics'" class="subsection-link" :class="{ 'active-link': currentSubsection === 'statisticsMetrics' }">Statistics Metrics</button>
        <button @click="currentSubsection = 'datasetDescription'" class="subsection-link" :class="{ 'active-link': currentSubsection === 'datasetDescription' }">Dataset Description</button>
      </nav>
      <component class="subsectionComponent" :is="currentSubsectionComponent" :description="datasetDescriptionData" :bias-overview="biasOverviewData" :statistics-metrics="statisticsMetricsData"/>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import DatasetDescription from "@/components/DatasetDescription.vue";
import BiasOverview from "@/components/BiasOverview.vue";
import StatisticsMetrics from "@/components/StatisticsMetrics.vue";

export default {
  name: 'BASEDHome',
  components: {
    DatasetDescription,
    BiasOverview,
    StatisticsMetrics
  },
  data() {
    return {
      dataList: [],
      searchQuery: '',
      currentPage: 1,
      pageSize: 5,
      currentRow: null,
      currentSubsection: 'biasOverview',
      selectedDataset: null,
      datasetDescriptionData: null,
      biasOverviewData: null,
      statisticsMetricsData: null
    };
  },
  computed: {
    filteredData() {
      return Array.isArray(this.dataList) ? this.dataList.filter(item =>
          item.datasetNameCode.includes(this.searchQuery.toLowerCase())
      ) : [];
    },
    paginatedData() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.filteredData.slice(start, end);
    },
    currentSubsectionComponent() {
      switch (this.currentSubsection) {
        case 'statisticsMetrics':
          return 'StatisticsMetrics';
        case 'biasOverview':
          return 'BiasOverview';
        default:
          return 'DatasetDescription';
      }
    }
  },
  mounted() {
    axios.get("http://localhost:8081/api/dataset/list").then((resp) => {
      this.dataList = Array.isArray(resp.data.data) ? resp.data.data : [];
    }).catch(error => {
      this.dataList = [];
    });
  },
  methods: {
    setCurrent(row) {
      this.$refs.singleTable.setCurrentRow(row);
    },
    handleCurrentChange(val) {
      this.currentRow = val;
    },
    handlePageChange(page) {
      this.currentPage = page;
    },
    clearSearch() {
      this.searchQuery = '';
    },
    submitDataset() {
      if (this.currentRow) {
        const datasetNameCode = this.currentRow.datasetNameCode;
        console.log("Selected Dataset Name Code:", datasetNameCode);
        this.selectedDataset = datasetNameCode;
        axios.get(`http://localhost:8081/api/dataset/description?datasetNameCode=${datasetNameCode}`)
            .then(response => {
              this.datasetDescriptionData = response.data.data;
              console.log("Dataset Description Data:", this.datasetDescriptionData);
            })
            .catch(error => {
              console.error("Error fetching dataset description:", error);
            });
        axios.get(`http://localhost:8081/api/dataset/bias/stats?datasetNameCode=${datasetNameCode}`)
            .then(response => {
              this.biasOverviewData = response.data.data;
              console.log("Bias Overview Data:", this.biasOverviewData);
            })
            .catch(error => {
              console.error("Error fetching bias overview:", error);
            });
        axios.get(`http://localhost:8081/api/dataset/metric/values?datasetNameCode=${datasetNameCode}`)
            .then(response => {
              this.statisticsMetricsData = response.data.data;
              console.log("Statistics Metrics Data:", this.statisticsMetricsData);
            })
            .catch(error => {
              console.error("Error fetching statistics metrics:", error);
            });
      } else {
        console.log("No dataset selected");
      }
    }
  }
};
</script>

<style scoped>
based-container {
  padding: 20px;
  background-color: #f9f9f9;
}

.bias-header {
  text-align: center;
  margin-bottom: 20px;
  font-size: 28px;
}

.instructions {
  margin-bottom: 40px;
  text-align: left;
}

.instructions h4 {
  font-weight: bold;
  margin-left: 30px;
  color: #111b47;
  font-size: 25px;
}

.instructions p {
  text-align: justify;
  margin-left: 30px;
  margin-right: 180px;
  color: #6f7cb2;
  font-size: 18px;
  line-height: 1.5;
}

.search-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #fcefdc;
  padding: 20px;
  border-radius: 5px;
  margin: 20px;
}

.search-input {
  width: 100%;
  margin-bottom: 10px;
  background-color: #fcefdc;
}

.clear-btn {
  background-color: #fcefdc;
  color: black;
  margin-left: 0;
  border-color: #fcefdc;
}

.clear-btn:hover {
  background-color: #f7c781;
  border-color: #f7c781;
  color: black;
}

.pagination-and-submit-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 20px;
}

.submit-btn {
  background-color: #111b47;
  color: white;
  border-color: #111b47;
}

.submit-btn:hover {
  background-color: #6f7cb2;
  border-color: #6f7cb2;
  color: white;
}

.subsection {
  margin: 80px 20px 0px 20px;
}

.subsection-nav {
  display: flex;
  justify-content: space-around;
  margin-bottom: 20px;
}

.subsection-link {
  padding: 10px;
  color: #6f7cb2;
  text-decoration: none;
  border-bottom: 2px solid transparent;
  transition: border-color 0.3s;
  background: transparent;
  border: none;
  cursor: pointer;
  font-size: 28px;
}

.subsection-link:hover {
  border-bottom: 1px solid #6f7cb2;
}

.active-link {
  border-bottom: 1px solid #111b47;
}
.subsectionComponent {
  margin-top: 20px;
}
</style>
<style lang="scss" scoped>
::v-deep(.el-table tbody tr:hover > td) {
  background-color: #ffe5bf !important;
}

::v-deep(.el-table__body tr.current-row > td) {
  background-color: #ffe5bf !important;
}
</style>