package com.explorer.enumeration;

public enum Code {
    SUCCESS(1),
    ERROR(0);

    private final int code;

    Code(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}