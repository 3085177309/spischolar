package com.wd.front.bo;


import java.util.Date;

/**
 * Created by DimonHo on 2018/2/28.
 */
public class TransCount {

    private String orgFlag;
    private Date transDay;
    private int transCount;

    public String getOrgFlag() {
        return orgFlag;
    }

    public void setOrgFlag(String orgFlag) {
        this.orgFlag = orgFlag;
    }

    public Date getTransDay() {
        return transDay;
    }

    public void setTransDay(Date transDay) {
        this.transDay = transDay;
    }

    public int getTransCount() {
        return transCount;
    }

    public void setTransCount(int transCount) {
        this.transCount = transCount;
    }

}
