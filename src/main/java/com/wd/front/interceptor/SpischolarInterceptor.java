package com.wd.front.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.model.Member;
import com.wd.comm.Comm;

/**
 * 测试账号拦截器（不允许访问修改密码）
 * @author Administrator
 *
 */
public class SpischolarInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
		Member user=(Member)req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user != null && "spischolar".equals(user.getUsername())) {
			return false;
		}
		return true;
	}

}
