package com.explorer.mapper;

import com.explorer.dao.BiasMetricsDetails;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MetricMapper {
    @Select("SELECT * FROM bias_metrics_details WHERE metric_name = #{metricName}")
    BiasMetricsDetails getMetricDetails(String metricName);
}