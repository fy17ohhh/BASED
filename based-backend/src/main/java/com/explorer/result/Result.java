package com.explorer.result;

import com.explorer.enumeration.Code;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result {
    private int code; // response code: 1 success 0 error
    private String msg; // response message
    private Object data; // response data

    // success response
    public static Result success(String message){
        return new Result(Code.SUCCESS.getCode(),message,null);
    }

    // success response with data
    public static Result success(String message, Object data){
        return new Result(Code.SUCCESS.getCode(), message,data);
    }
    // failed response
    public static Result error(String msg){
        return new Result(Code.ERROR.getCode(), msg,null);
    }
}
