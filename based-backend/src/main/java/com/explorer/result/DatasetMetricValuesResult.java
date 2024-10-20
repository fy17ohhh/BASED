package com.explorer.result;

import java.util.List;

import com.explorer.dao.DatasetBiasMetrics;
import com.explorer.enumeration.Code;
public class DatasetMetricValuesResult extends Result {
    public static DatasetMetricValuesResult success(List<DatasetBiasMetrics> metricValues) {
        DatasetMetricValuesResult result = new DatasetMetricValuesResult();
        result.setCode(Code.SUCCESS.getCode());
        result.setMsg("success");
        result.setData(metricValues);
        return result;
    }

    public static DatasetMetricValuesResult error() {
        DatasetMetricValuesResult result = new DatasetMetricValuesResult();
        result.setCode(Code.ERROR.getCode());
        result.setMsg("error in fetching metric values");
        return result;
    }
}