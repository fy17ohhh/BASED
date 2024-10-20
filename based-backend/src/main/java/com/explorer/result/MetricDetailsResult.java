package com.explorer.result;

import com.explorer.dao.BiasMetricsDetails;
import com.explorer.enumeration.Code;

public class MetricDetailsResult extends Result {
    public static MetricDetailsResult success(BiasMetricsDetails biasMetricsDetails) {
        MetricDetailsResult result = new MetricDetailsResult();
        result.setCode(Code.SUCCESS.getCode());
        result.setMsg("success");
        result.setData(biasMetricsDetails);
        return result;
    }

    public static MetricDetailsResult error() {
        MetricDetailsResult result = new MetricDetailsResult();
        result.setCode(Code.ERROR.getCode());
        result.setMsg("error in fetching metric details");
        return result;
    }
}