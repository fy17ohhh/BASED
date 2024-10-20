package com.explorer.result;

import com.explorer.dao.Dataset;
import com.explorer.enumeration.Code;

import java.util.List;
public class DatasetListResult extends Result {
    public static DatasetListResult success(List<Dataset> datasets) {
        DatasetListResult result = new DatasetListResult();
        result.setCode(Code.SUCCESS.getCode());
        result.setMsg("success");
        result.setData(datasets);
        return result;
    }

    public static DatasetListResult error() {
        DatasetListResult result = new DatasetListResult();
        result.setCode(Code.ERROR.getCode());
        result.setMsg("error in fetching datasets");
        return result;
    }
}