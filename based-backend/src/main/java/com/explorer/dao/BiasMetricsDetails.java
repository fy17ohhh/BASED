package com.explorer.dao;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class BiasMetricsDetails {
    private int metricId;
    private String metricName;
    private String metricSymbol;
    private String metricDescription;
    private String metricRange;
    private String metricRelationToBias;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}