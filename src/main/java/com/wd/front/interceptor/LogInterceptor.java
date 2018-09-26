package com.wd.front.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wd.front.module.cache.CacheModuleI;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.SystemLog;
import com.wd.comm.Comm;
import com.wd.front.service.SearchLogServiceI;
import com.wd.front.service.UserServiceI;
import com.wd.util.IpUtil;


/**
 * 日志记录拦截器。
 * @author Shenfu
 *
 */
public class LogInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger log=Logger.getLogger(LogInterceptor.class);
	
	@Autowired
	private SearchLogServiceI logService;

	@Autowired
	private CacheModuleI cacheModule;
	
	/**用户信息修改*/
	@Autowired
	private UserServiceI userService;

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
		String ip=IpUtil.getIpAddr(request);
		String orgFlag=null;
		String orgName=null;
		OrgBO org = null;
		if (request.getSession() != null){
			org = (OrgBO) request.getSession().getAttribute(Comm.ORG_SESSION_NAME);
		}else{
			org = cacheModule.findOrgByIpFromCache(ip);
		}
		if(org != null){
			orgFlag=org.getFlag();
			orgName=org.getName();
		}
		String field=request.getRequestURI(),value=request.getQueryString();
		SystemLog log=new SystemLog();
		log.setDate(new Date());
		log.setIp(ip);
		log.setOrgFlag(orgFlag);
		log.setOrgName(orgName);
		log.setValue(value);
		log.setField(field);
		log.setType(0);
		log.setSiteFlag(request.getSession().getId());//Session ID做为标志位
		logService.addAsynSearchLog(log);
	}

}
