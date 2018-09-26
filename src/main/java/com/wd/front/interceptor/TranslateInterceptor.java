package com.wd.front.interceptor;

import com.wd.backend.bo.OrgBO;
import com.wd.comm.Comm;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.IpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by DimonHo on 2018/2/27.
 */
public class TranslateInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private CacheModuleI cacheModule;
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
                             Object obj) throws Exception {

        OrgBO orgBO = (OrgBO) req.getSession().getAttribute(Comm.ORG_SESSION_NAME);
        if (null == orgBO){
            String ip = IpUtil.getIpAddr(req);
            orgBO = cacheModule.findOrgByIpFromCache(ip);
            req.getSession().setAttribute(Comm.ORG_SESSION_NAME,orgBO);
        }
        String flag = orgBO.getFlag();
        if ("hnmu".equals(flag)){ //只有湖南医药学院才有的功能
            return true;
        }
        return false;
    }
}
