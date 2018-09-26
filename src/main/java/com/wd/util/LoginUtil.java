package com.wd.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.interceptor.LoginInterceptor;
import com.wd.front.listener.SessionListener;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.front.service.UserServiceI;

/**
 * 登陆设置
 * @author Administrator
 *
 */
public class LoginUtil {
	
	private static final Logger logger=Logger.getLogger(LoginUtil.class);

	private static Pattern p = Pattern.compile("(\\w*\\.?){1}\\.(com.cn|net.cn|gov.cn|org\\.nz|org.cn|com|net|org|gov|cc|biz|info|cn|co)",Pattern.CASE_INSENSITIVE);
	/**
	 * 自动登录
	 * @param request
	 * @param response
	 * @throws SystemException
	 */
	public static boolean automaticLogin(HttpServletRequest request, HttpServletResponse response) throws SystemException {
		Member user = null;
		Map<String, String> map = getCookie(request);
		if(map != null && map.containsKey("username") && map.containsKey("password")) {
			UserServiceI userService = SpringContextUtil.getBean(UserServiceI.class);
			user = userService.login(map.get("username"), map.get("password"),request,response);
		}
		if(user != null){//登录成功
			if(user.getStat() == 1) {//登录成功
				int time = 60*60*24*7;
				Map<String, String> maps = new HashMap<String, String>();
				maps.put("username", user.getEmail());
				maps.put("password", user.getPwd());
				creatCookie(map,request,response,time);
				request.getSession().setAttribute("spischolarID", user.getId()+"");
				request.getSession().setAttribute(Comm.MEMBER_SESSION_NAME, user);
				SessionListener.addSessionMap(request.getSession(), user.getId().toString());
				return true;
			}
			return false;
		}else{
			return false;
		}
	}

	public static String getDomain(HttpServletRequest request){
		String host = request.getHeader("host");
		String domain = "";
		Matcher m = p.matcher(host);
		if (m.find()){
			domain = m.group();
		}else{
			return "localhost";
		}
		return domain;
	}

	/**
	 * 创建cookie
	 * @param map
	 * @param response
	 * @param time
	 */
	public static void creatCookie(Map<String, String> map,HttpServletRequest request, HttpServletResponse response,int time) {

		for (Map.Entry<String, String> entry : map.entrySet()) {
			Cookie cookie = new Cookie(entry.getKey(), entry.getValue());
			cookie.setPath("/");
			cookie.setDomain(getDomain(request));
			cookie.setMaxAge(time); 
			response.addCookie(cookie);
			
	    }
	}
	/**
	 * 获取cookie
	 * @param request
	 * @return
	 */
	public static Map<String, String> getCookie(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		Map<String, String> map = new HashMap<String, String>();
		if(cookies != null && cookies.length != 0) {
			for(int i = 0; i < cookies.length; i++) {
				map.put(cookies[i].getName(), cookies[i].getValue());
			}
			return map;
		}
		return null;
	}
	
	/**
	 * 用于下次自动登陆，给用户浏览器设置cookie（保存用户名和密码）
	 */
	public static void rember(HttpServletRequest req, HttpServletResponse resp) {
		String rember = (String) req.getSession().getAttribute("rember");
		//用于下次自动登陆，给用户浏览器设置cookie（保存用户名和密码）
		if(rember != null) {
			Member user=(Member)req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
			Map<String, String> map = new HashMap<String, String>();
			map.put("username", user.getEmail());
			map.put("password", user.getPwd());
			int time = 60*60*24*7;
			creatCookie(map,req,resp,time);
			req.getSession().removeAttribute("rember");
		}
	}
	
	/**
	 * 登陆的相关处理!前提条件（如果校内登陆必定要有ORG_SESSION_NAME）
	 * @throws SystemException 
	 */
	public static Member loginHandle(HttpServletRequest request, HttpServletResponse response,Member member) throws SystemException {
		OrgDaoI orgDao = SpringContextUtil.getBean(OrgDaoI.class);
		CacheModuleI cacheModule = SpringContextUtil.getBean(CacheModuleI.class);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		
		if(member.getForbidden() == 2) {
			member.setInfo("对不起，您的账号登录异常，如果需要继续使用，请联系Spischolar服务中心：1962740172@qq.com");
			return member;
		}
		OrgBO orgs = (OrgBO) request.getSession().getAttribute(Comm.ORG_SESSION_NAME);
		if(orgs == null) {
			String ip =IpUtil.getIpAddr(request);
			orgs = cacheModule.findOrgByIpFromCache(ip);
			if(orgs == null) {
				if(member.getPermission() != 1 && member.getPermission() != 3 && member.getPermission() != 4) {
					member.setInfo("您还没有校外访问权限，请耐心等待！");
					return member;
				} 
				Org org=orgDao.findByFlag(member.getSchoolFlag());
				if(null != org){
					orgs = new OrgBO();
					BeanUtils.copyProperties(org, orgs);
				} else {
					member.setInfo("查找不到您的学校信息，无法登陆！");
					return member;
				}
			}
			request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgs);
			request.setAttribute(Comm.ORG_FLAG_NAME, orgs.getFlag());
		}
		
		if(member.getUserType() == 1) {//如果是管理员
			Org org=orgDao.findByFlag(member.getSchoolFlag());
			request.getSession().setAttribute("org", org);
		}
		if(member.getPermission() == 3) {
			member.setStat(1);
			member.setInfo("您提交的校外访问申请已经审核通过！");
		} else {
			member.setStat(1);
			member.setInfo("登录成功！");
		}
		int isOnline = 1;
		if(member.getIsOnline() == 1 && Comm.Mobile.equals(isMobile)) {//1为电脑登陆2为手机登陆
			isOnline = 3;
		} else if(member.getIsOnline() == 2 && !Comm.Mobile.equals(isMobile)) {
			isOnline = 3;
		} else if(member.getIsOnline() == 0 && Comm.Mobile.equals(isMobile)) {
			isOnline = 2;
		} else if(member.getIsOnline() == 0 && !Comm.Mobile.equals(isMobile)) {
			isOnline = 1;
		}  else {
			SessionListener.imposedOut(request,response,request.getSession(),member.getId().toString());
		}
		member.setIsOnline(isOnline);
		member.setLoginTime(new Date());
		member.setLoginCount(member.getLoginCount()+1);
		member.setLoginIP(IpUtil.getIpAddr(request));
		return member;
	}
	
	/**
	 * 后台登陆的相关处理!前提条件（如果校内登陆必定要有ORG_SESSION_NAME）
	 * @throws SystemException 
	 */
	public static Member backLoginHandle(HttpServletRequest request,HttpServletResponse response, Member member) throws SystemException {
		OrgDaoI orgDao = SpringContextUtil.getBean(OrgDaoI.class);
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		
		if(member.getForbidden() == 2) {
			member.setInfo("对不起，您的账号登录异常，如果需要继续使用，请联系Spischolar服务中心：1962740172@qq.com");
			return member;
		}
		if(member.getUserType() == 0) {
			member.setInfo("登录帐号或密码错误!");
			return member;
		}else {
			Org org=orgDao.findByFlag(member.getSchoolFlag());
			if(null == org){
				member.setInfo("查找不到您的学校信息，无法登陆！");
				return member;
			} 
			request.getSession().setAttribute("org", org);
			OrgBO orgBO = new OrgBO();
			BeanUtils.copyProperties(org, orgBO);
			request.getSession().setAttribute(Comm.ORG_SESSION_NAME, orgBO);
			request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
		}
		member.setStat(1);
		member.setInfo("登录成功！");
		int isOnline = 1;
		if(member.getIsOnline() == 1 && Comm.Mobile.equals(isMobile)) {//1为电脑登陆2为手机登陆
			isOnline = 3;
		} else if(member.getIsOnline() == 2 && !Comm.Mobile.equals(isMobile)) {
			isOnline = 3;
		} else if(member.getIsOnline() == 0 && Comm.Mobile.equals(isMobile)) {
			isOnline = 2;
		} else if(member.getIsOnline() == 0 && !Comm.Mobile.equals(isMobile)) {
			isOnline = 1;
		}  else {
			SessionListener.imposedOut(request,response,request.getSession(),member.getId().toString());
		}
		member.setIsOnline(isOnline);
		member.setLoginTime(new Date());
		member.setLoginCount(member.getLoginCount()+1);
		member.setLoginIP(IpUtil.getIpAddr(request));
		return member;
	}

}
