package com.explorer.service;

import com.explorer.dao.Dataset;
import com.explorer.dao.DatasetBiasMetrics;
import com.explorer.dao.DatasetBiasStats;
import com.explorer.mapper.DatasetMapper;
import com.explorer.result.DatasetBiasStatsResult;
import com.explorer.result.DatasetDescriptionResult;
import com.explorer.result.DatasetListResult;
import com.explorer.result.DatasetMetricValuesResult;

import org.springframework.stereotype.Service;
import java.util.List;

import javax.annotation.Resource;

@Service
public class DatasetService {
    @Resource
    private DatasetMapper datasetMapper;

    public DatasetListResult getDatasetList() {
        try {
            List<Dataset> datasets = datasetMapper.getDatasetList();
            return DatasetListResult.success(datasets);
        } catch (Exception e) {
            return DatasetListResult.error();
        }
    }

    public DatasetDescriptionResult getDatasetDescription(String datasetNameCode) {
        try {
            String description = datasetMapper.getDescriptionByName(datasetNameCode);
            return DatasetDescriptionResult.success(description);
        } catch (Exception e) {
            return DatasetDescriptionResult.error();
        }
    }

    public DatasetBiasStatsResult getDatasetBiasStats(String datasetNameCode) {
        try {
            List<DatasetBiasStats> biasStats = datasetMapper.getBiasCategoryValueCount(datasetNameCode);
            if (biasStats.size() == 0) {
                return DatasetBiasStatsResult.error();
            }
            return DatasetBiasStatsResult.success(biasStats);
        } catch (Exception e) {
            return DatasetBiasStatsResult.error();
        }
    }

    public DatasetMetricValuesResult getDatasetMetricValues(String datasetNameCode) {
        try {
            List<DatasetBiasMetrics> metricValues = datasetMapper.getBiasMetricsValue(datasetNameCode);
            if (metricValues.size() == 0) {
                return DatasetMetricValuesResult.error();
            }
            return DatasetMetricValuesResult.success(metricValues);
        } catch (Exception e) {
            return DatasetMetricValuesResult.error();
        }
    }

}