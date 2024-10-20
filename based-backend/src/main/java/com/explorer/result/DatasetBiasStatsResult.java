package com.explorer.result;

import java.util.List;
import java.util.Map;

import com.explorer.dao.DatasetBiasStats;
import com.explorer.enumeration.Code;
public class DatasetBiasStatsResult extends Result {
    public static DatasetBiasStatsResult success(List<DatasetBiasStats> statsValueCounts) {
        DatasetBiasStatsResult result = new DatasetBiasStatsResult();
        result.setCode(Code.SUCCESS.getCode());
        result.setMsg("success");
        result.setData(statsValueCounts);
        return result;
    }

    public static DatasetBiasStatsResult error() {
        DatasetBiasStatsResult result = new DatasetBiasStatsResult();
        result.setCode(Code.ERROR.getCode());
        result.setMsg("error in fetching bias statistics");
        return result;
    }
}