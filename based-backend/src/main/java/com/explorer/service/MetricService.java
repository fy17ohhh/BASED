package com.explorer.service;

import com.explorer.dao.BiasMetricsDetails;
import com.explorer.mapper.MetricMapper;
import com.explorer.result.MetricDetailsResult;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class MetricService {
    @Resource
    private MetricMapper metricMapper;

    public MetricDetailsResult getMetricDetails(String metricName) {
        try {
            BiasMetricsDetails biasMetricsDetails = metricMapper.getMetricDetails(metricName);
            return MetricDetailsResult.success(biasMetricsDetails);
        } catch (Exception e) {
            return MetricDetailsResult.error();
        }
    }
}