package com.explorer.dao;

import lombok.Data;

@Data
public class DatasetBiasMetrics {
    private String biasCategory;
    private String biasCategoryDisplay;
    private String metricName;
    private String metricNameDisplay;
    private float metricValue;
}