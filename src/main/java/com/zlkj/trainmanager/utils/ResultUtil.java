package com.zlkj.trainmanager.utils;

public class ResultUtil {
    /**
     * 成功带参数
     *
     * @param object
     * @return
     */
    public static Result success(Object object, int code) {
        Result result = new Result();
        result.setCode(code);
        result.setMsg("成功");
        result.setData(object);
        return result;
    }

    /**
     * 成功不带参数
     *
     * @return
     */
    public static Result success() {
        return success(null, 0);
    }

    /**
     * 失败
     *
     * @param code
     * @param msg
     * @return
     */
    public static Result error(Integer code, String msg) {
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }

    /**
     * 失败
     *
     * @param resultEnum
     * @return
     */
    public static Result error2(ResultEnum resultEnum) {
        Result result = new Result();
        result.setCode(resultEnum.getCode());
        result.setMsg(resultEnum.getMsg());
        return result;
    }

}