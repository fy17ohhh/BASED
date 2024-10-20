package com.explorer.dao;

import lombok.Data;
import java.sql.Timestamp;
@Data
public class Dataset {
    private int datasetId;
    private String datasetNameDisplay;
    private String datasetNameCode;
    private String description;
    private String publisher;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}