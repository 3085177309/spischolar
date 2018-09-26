package com.wd.comm.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.AntPathMatcher;

import com.wd.backend.bo.PersonBO;
import com.wd.backend.controller.IndexController;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.dao.SystemManageDaoI;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Person;
import com.wd.backend.model.Powers;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.util.JsonUtil;

public class NewPermissionFilter implements Filter{
	//private SystemManageDaoI sysDao;
	private static final Logger log=Logger.getLogger(NewPermissionFilter.class);
	/**
	 * 指定需要进行权限控制的目录
	 */
	private String dir;
	/**
	 * 登录页地址
	 */
	private String login;
	/**
	 * 登出页地址
	 */
	private String logout;
	
	@Autowired
	private PersonDaoI personDao;
	@Autowired
	private OrgDaoI orgDao;
	
	/**
	 * 验证码地址
	 */
	private String validateImg;
	private String backendIndex;
	private AntPathMatcher antPathMatcher = new AntPathMatcher();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.dir = filterConfig.getInitParameter("dir");
		this.login = filterConfig.getInitParameter("login");
		this.logout = filterConfig.getInitParameter("logout");
		this.backendIndex = filterConfig.getInitParameter("backendIndex");
		this.validateImg=filterConfig.getInitParameter("validateImg");
		this.personDao = (PersonDaoI)new ClassPathXmlApplicationContext("beans-mybatis.xml").getBean("personDao");
		this.orgDao = (OrgDaoI)new ClassPathXmlApplicationContext("beans-mybatis.xml").getBean("orgDao");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		/**
		Person pe = (Person) req.getSession().getAttribute("person");
		Member user = (Member)req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if(pe == null && user != null && user.getUserType() == 1) {
			Person person = new Person();
			person.setEmail(user.getEmail());
			person.setPassword(user.getPwd());
			Person p = personDao.findByEmailPwd(person);
			req.getSession().setAttribute("person", p);
		//	req.getSession().setAttribute("user", p);
			Org org=orgDao.findById(p.getOrgId());
		//	req.getSession().setAttribute("backend:loginOrg", org);
			req.getSession().setAttribute("org", org);
			req.getSession().setAttribute("backendOrgFlag", org.getFlag());
		}
		**/
		// 禁用缓存
		resp.setHeader("Pragma ", "No-cache ");
		resp.setHeader("Cache-Control ", "no-cache ");
		resp.setDateHeader("Expires ", 0);
		String reqPath = req.getServletPath();
		Member person = (Member) req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		if (reqPath.startsWith(dir) && !reqPath.startsWith(this.login) && !reqPath.startsWith(this.logout) && !reqPath.startsWith(this.validateImg) && !reqPath.contains("member/list/findPwd")) {
//			Person person = (Person) req.getSession().getAttribute("person");
			if (null == person || person.getUserType() != 1) {
				// 跳转到登录页
				resp.sendRedirect(req.getContextPath() + this.login);
				return;
			} 
		} else if (reqPath.startsWith(this.login) || reqPath.startsWith(this.login + "/")) {
			// 如果进入的是登录页，判断是否登录
			if (null != person && person.getUserType() == 1) {
				// 跳转到首页
				resp.sendRedirect(req.getContextPath() + this.backendIndex);
				return;
			}
		}
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}

	public void setLogin(String login) {
		this.login = login;
	}

	public void setBackendIndex(String backendIndex) {
		this.backendIndex = backendIndex;
	}

	public void setValidateImg(String validateImg) {
		this.validateImg = validateImg;
	}
	
}
