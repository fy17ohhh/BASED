package com.explorer.mapper;

import com.explorer.dao.Dataset;
import com.explorer.dao.DatasetBiasMetrics;
import com.explorer.dao.DatasetBiasStats;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;


@Mapper
public interface DatasetMapper {

    @Select("SELECT * FROM dataset_overview")
    List<Dataset> getDatasetList();

    @Select("SELECT description FROM dataset_overview WHERE dataset_name_code = #{datasetNameCode}")
    String getDescriptionByName(String datasetNameCode);

    @Select("SELECT dbs.bias_category AS biasCategory, dbs.bias_category_display AS biasCategoryDisplay, " +
            "dbs.bias_category_value AS biasCategoryValue, dbs.bias_category_value_count AS biasCategoryValueCount " +
            "FROM dataset_overview do " +
            "JOIN dataset_bias_statistics dbs ON do.dataset_id = dbs.dataset_id " +
            "WHERE do.dataset_name_code = #{datasetNameCode} ")
    List<DatasetBiasStats> getBiasCategoryValueCount(@Param("datasetNameCode") String datasetNameCode);

    @Select("SELECT dbm.bias_category AS biasCategory, dbm.bias_category_display AS biasCategoryDisplay, " +
            "dbm.metric_name AS metricName, dbm.metric_name_display AS metricNameDisplay, " +
            "dbm.metric_value AS metricValue " +
            "FROM dataset_overview do " +
            "JOIN dataset_bias_metrics dbm ON do.dataset_id = dbm.dataset_id " +
            "WHERE do.dataset_name_code = #{datasetNameCode} ")
    List<DatasetBiasMetrics> getBiasMetricsValue(@Param("datasetNameCode") String datasetNameCode);
}