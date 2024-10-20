package com.explorer.result;

import com.explorer.enumeration.Code;
public class DatasetDescriptionResult extends Result {
    public static DatasetDescriptionResult success(String description) {
        DatasetDescriptionResult result = new DatasetDescriptionResult();
        result.setCode(Code.SUCCESS.getCode());
        result.setMsg("success");
        result.setData(description);
        return result;
    }

    public static DatasetDescriptionResult error() {
        DatasetDescriptionResult result = new DatasetDescriptionResult();
        result.setCode(Code.ERROR.getCode());
        result.setMsg("error in fetching dataset description");
        return result;
    }
}