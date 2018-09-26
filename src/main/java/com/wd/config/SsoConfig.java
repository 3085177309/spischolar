package com.wd.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by DimonHo on 2018/1/17.
 */
public class SsoConfig {

    //@Value("${base-service}")
    private String baseService;

    //@Value("${register-service}")
    private String registerService;

    //@Value("${pswdmodify-service}")
    private String pswdmodifyService;

    //@Value("${mailprofile-service}")
    private String mailprofileService;

    private String logoutService;

    public String getLogoutService() {
        return logoutService;
    }

    public void setLogoutService(String logoutService) {
        this.logoutService = logoutService;
    }

    public String getBaseService() {
        return baseService;
    }

    public void setBaseService(String baseService) {
        this.baseService = baseService;
    }

    public String getRegisterService() {
        return registerService;
    }

    public void setRegisterService(String registerService) {
        this.registerService = registerService;
    }

    public String getPswdmodifyService() {
        return pswdmodifyService;
    }

    public void setPswdmodifyService(String pswdmodifyService) {
        this.pswdmodifyService = pswdmodifyService;
    }

    public String getMailprofileService() {
        return mailprofileService;
    }

    public void setMailprofileService(String mailprofileService) {
        this.mailprofileService = mailprofileService;
    }
}
