package com.explorer.dao;

import lombok.Data;
@Data
public class DatasetBiasStats {
    private String biasCategory;
    private String biasCategoryDisplay;
    private String biasCategoryValue;
    private int biasCategoryValueCount;
}