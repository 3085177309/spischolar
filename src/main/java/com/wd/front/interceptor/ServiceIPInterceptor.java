package com.wd.front.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.cxf.message.Message;
import org.apache.cxf.phase.PhaseInterceptorChain;
import org.apache.cxf.transport.http.AbstractHTTPDestination;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import com.wd.util.IpUtil;

/**
 * 服务提供的IP验证,对异常的处理
 * @author Administrator
 *
 */
//@Aspect
//@Component
public class ServiceIPInterceptor {
	
	private static final Logger log=Logger.getLogger(ServiceIPInterceptor.class);
	
	/**
	 * 定义一个围绕执行的
	 * @param pjp
	 * @return
	 */
	@Around("execution(* com.wd.service.WSSearchService.*(..))")
	public String validate(ProceedingJoinPoint  pjp){
		Message message = PhaseInterceptorChain.getCurrentMessage();
		HttpServletRequest request = (HttpServletRequest)message.get(AbstractHTTPDestination.HTTP_REQUEST);
		String ip=IpUtil.getIpAddr(request);
		log.info("用户访问:"+ip);
		boolean allow=false;
		if(StringUtils.isEmpty(ip)){
			allow= false;
		}else if("127.0.0.1".equals(ip) ||ip.startsWith("192.168.1.")){
			allow= true;
		}else if(ip.startsWith("202.197.77.")){
			allow= true;
		}
		if(!allow){
			return "{'errorCode':2,'errorMsg':'没有验证通过!你的IP无法访问!'}";
		}
		try{
			String result=(String)pjp.proceed();
			return result;
		}catch(Throwable e){
			log.error("Service执行出错!",e);
			return String.format("{'errorCode':1,'errorMsg':'%s'}", e.getMessage());
		}
	}

}
