package com.wd.front.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.model.Member;
import com.wd.comm.Comm;

/**
 * 检测用户是否登录的拦截器
 * @author Administrator
 *
 */
public class MemberLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
		Member member =(Member) req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		String id = (String) req.getSession().getAttribute("spischolarID");
		//未登陆用户使用cookie
/**		Cookie[] cookies = req.getCookies();
		if(cookies != null && cookies.length != 0) {
			for(int i = 0; i < cookies.length; i++) {
				Cookie c = cookies[i];
				if(c.getName().equals("spischolarID")) {
					req.getSession().setAttribute("spischolarID", c.getValue());
					return true;
				}
			}
		}
	**/	
		if(member == null && id == null){
			resp.sendRedirect(req.getContextPath()+"/user/login");
			return false;
		}
		return true;
	}

}
