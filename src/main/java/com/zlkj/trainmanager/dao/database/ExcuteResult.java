package com.zlkj.trainmanager.dao.database;

import java.io.Serializable;

public class ExcuteResult implements Serializable {
    private int returnCode;
    private String returnMessage;
    private String excepMessage;
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public ExcuteResult() {
    }

    public ExcuteResult(int returnCode, String returnMessage) {
        this.returnCode = returnCode;
        this.returnMessage = returnMessage;
    }

    public ExcuteResult(int returnCode, String returnMessage, String id) {
        super();
        this.returnCode = returnCode;
        this.returnMessage = returnMessage;
        this.id = id;
    }

    public ExcuteResult(int returnCode, String returnMessage,
                        String excepMessage, String id) {
        this.returnCode = returnCode;
        this.returnMessage = returnMessage;
        this.excepMessage = excepMessage;
        this.id = id;
    }

    public int getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(int returnCode) {
        this.returnCode = returnCode;
    }

    public String getReturnMessage() {
        return returnMessage;
    }

    public void setReturnMessage(String returnMessage) {
        this.returnMessage = returnMessage;
    }

    public String getExcepMessage() {
        return excepMessage;
    }

    public void setExcepMessage(String excepMessage) {
        this.excepMessage = excepMessage;
    }
}
