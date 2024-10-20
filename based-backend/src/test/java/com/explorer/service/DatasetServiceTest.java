package com.explorer.service;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.annotation.Resource;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class DatasetServiceTest {
    @Resource
    private DatasetService datasetService;

//    @Test
//    public void testGetDescription() {
//        assertNotNull(datasetService.getDatasetList());
//    }
}
