package com.explorer.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.explorer.result.DatasetBiasStatsResult;
import com.explorer.result.DatasetDescriptionResult;
import com.explorer.result.DatasetListResult;
import com.explorer.result.DatasetMetricValuesResult;
import com.explorer.result.MetricDetailsResult;
import com.explorer.service.DatasetService;
import com.explorer.service.MetricService;

@RestController
@CrossOrigin
@RequestMapping("/api/dataset")
public class DatasetController {
    @Resource
    private DatasetService datasetService;
    @Resource
    private MetricService metricService;

    @GetMapping("/list")
    @ResponseBody
    public DatasetListResult getDatasetList() {
        return datasetService.getDatasetList();
    }

    @GetMapping("/description")
    @ResponseBody
    public DatasetDescriptionResult getDatasetDescription(@RequestParam("datasetNameCode") String datasetNameCode) {
        return datasetService.getDatasetDescription(datasetNameCode);
    }

    @GetMapping("/bias/stats")
    @ResponseBody
    public DatasetBiasStatsResult getDatasetBiasStats(@RequestParam("datasetNameCode") String datasetNameCode) {
        return datasetService.getDatasetBiasStats(datasetNameCode);
    }

    @GetMapping("/metric/values")
    @ResponseBody
    public DatasetMetricValuesResult getMetricValues(@RequestParam("datasetNameCode") String datasetNameCode) {
        return datasetService.getDatasetMetricValues(datasetNameCode);
    }

    @GetMapping("/metric/details")
    @ResponseBody
    public MetricDetailsResult getMetricDetails(@RequestParam("metricName") String metricName) {
        return metricService.getMetricDetails(metricName);
    }
}
