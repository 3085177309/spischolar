package com.wd.front.interceptor;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.ChickPage;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.backend.model.Person;
import com.wd.comm.Comm;
import com.wd.exeception.SystemException;
import com.wd.front.listener.SessionListener;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.front.service.UserServiceI;
import com.wd.util.AjaxResult;
import com.wd.util.IpUtil;
import com.wd.util.LoginUtil;
import com.wd.util.MD5Util;
import com.wd.util.SpringContextUtil;

/**
 * 根据IP判断用户的机构
 * @author Shenfu
 *
 */
public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger=Logger.getLogger(LoginInterceptor.class);
	
	@Autowired
	private CacheModuleI cacheModule;
	
	/**用户信息修改*/
	@Autowired
	private UserServiceI userService;
	
	@Autowired
	private OrgInfoServiceI orgService;
	
	@Autowired
	private PersonDaoI personDao;
	@Autowired
	private OrgDaoI orgDao;
	
	@Value("${source}")
	private int source;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
		req.getSession().setAttribute("source", source);
		isOutSchool(req, resp);			//校外自动登陆本馆已购问题
		if(hasUserInfo(req)) {
			//LoginUtil.rember(req, resp);
			return true;
		} else {
			if(!isImposedOut(req, resp)) {
				return false;
			}
			//将sessionID保存的cookie以方便非正常退出浏览器后再次访问本网站能够获取上次访问的用户信息
			String sessionId = req.getSession().getId();
			Map<String, String> maps = new HashMap<String, String>();
			maps.put("thisId", sessionId);
			int time = 60*60*24*7;
			LoginUtil.creatCookie(maps,req,resp,time);
			//进行自动登陆，成功后直接访问页面
			boolean isAutomaticLogin = LoginUtil.automaticLogin(req, resp);
			if(isAutomaticLogin) {
				return true;
			} else {//非正常退出浏览器后再次访问，获取上次访问的用户信息
				String sessionID = null;
				Map<String, String> map = LoginUtil.getCookie(req);
				if(map != null && map.containsKey("thisId")) {
					sessionID = map.get("thisId");
				}
				try {
					HttpSession session = SessionListener.getSession(sessionID);
					if(session != null && !sessionID.equals(sessionId)) {
						logger.info("切换session成功，sessionId：" + sessionID);
						Member user = (Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
						OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
						req.getSession().setAttribute(Comm.MEMBER_SESSION_NAME, user);
						req.getSession().setAttribute(Comm.ORG_SESSION_NAME, org);
						session.invalidate();
						return true;
					}
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		if(isOutSchool(req, resp)) {
			return true;
		} else {
			resp.sendRedirect(req.getContextPath()+"/user/login");
			//resp.sendRedirect("http://sso.wd.com/login?service=http://web.com:8888/journal");
			return false;
		}
		
	}
	
	/**
	 * 判断ip
	 * @param req
	 * @param resp
	 * @return 校外返回false，校内返回true
	 * @throws SystemException
	 * @throws IOException
	 */
	private boolean isOutSchool(HttpServletRequest req, HttpServletResponse resp) throws SystemException, IOException {
		String ip =IpUtil.getIpAddr(req);
		OrgBO org = cacheModule.findOrgByIpFromCache(ip);  //通过IP获得机构名
		if(null == org) {
			logger.info("校外来访问的ip： "+ip);
			req.getSession().setAttribute("visitIP", ip);
			req.getSession().setAttribute("outSchool", true);//校外登陆没有本馆已购选择
			req.getSession().setAttribute("status", "5");
			return false;  //不允许校外访问，校外访问需要登陆权限
		} else {
			req.getSession().setAttribute(Comm.ORG_SESSION_NAME, org);
			String siteFlag=org.getSiteFlag();
			req.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
			req.setAttribute(Comm.SITE_FLAG_NAME, siteFlag);
			tourist(req, resp, ip, org);
			return true;
		}
	}
	
	/**
	 * 游客身份验证与创建
	 * @param req
	 * @param resp
	 * @param ip
	 * @param org
	 */
	private void tourist(HttpServletRequest req, HttpServletResponse resp,String ip,OrgBO org) {
		String id = (String) req.getSession().getAttribute("spischolarID");
		if(id == null) {
			Map<String, String> map = LoginUtil.getCookie(req);
			if(map !=null && map.containsKey("spischolarID")) {
				req.getSession().setAttribute("spischolarID", map.get("spischolarID"));
				int ieMessage = userService.getIeMessage(Integer.parseInt(map.get("spischolarID")));
				if(ieMessage == 0) {
                    req.getSession().setAttribute("ieMessage", true);
                }
//				Member  member= userService.detail(Integer.parseInt(map.get("spischolarID")));
//				if(member.isShowQunwpa()) {
//					req.getSession().setAttribute("showQunwpa", true);
//				}
				userService.updateTourist(Integer.parseInt(map.get("spischolarID")),ip);
				return;
			} else {
				Member member = new Member();
				member.setPwd("Tourist54321");
				member.setEmail("Tourist");
				member.setUsername("Tourist");
				member.setSchool(org.getName());
				member.setSchoolFlag(org.getFlag());
				member.setRegisterIp(ip);
				int ids = userService.register(member);
				req.getSession().setAttribute("spischolarID", ids+"");
				Map<String, String> newMap = new HashMap<String, String>();
				newMap.put("spischolarID", ids+"");
				int time = 60*60*24*365;
				LoginUtil.creatCookie(newMap, req,resp, time);
				req.getSession().setAttribute("ieMessage", true);
				req.getSession().setAttribute("showQunwpa", true);
			}
		} else {
			req.getSession().setAttribute("ieMessage", false);
			req.getSession().setAttribute("showQunwpa", false);
		}
	}
	
	
	/**
	 * 是否包含用户信息,包含用户信息证明已登录或具有访问权限
	 * @return
	 */
	private boolean hasUserInfo(HttpServletRequest req) {
		Member user=(Member)req.getSession().getAttribute(Comm.MEMBER_SESSION_NAME);
		String id = (String) req.getSession().getAttribute("spischolarID");
		if(user == null) {
			Cookie[] cookies = req.getCookies();
			if (cookies!=null){
				for (Cookie cookie:cookies){
					if ("username".equals(cookie.getName()) && cookie.getValue()!=null){
						user = userService.findByUsername(cookie.getValue());
						req.getSession().setAttribute(Comm.MEMBER_SESSION_NAME,user);
						req.getSession().setAttribute("ieMessage", false);
						if (user != null && user.getSchoolFlag() != null){
							Org org = orgDao.findByFlag(user.getSchoolFlag());
							if(null != org){
								OrgBO orgs = new OrgBO();
								BeanUtils.copyProperties(org, orgs);
								req.getSession().setAttribute(Comm.ORG_SESSION_NAME,orgs);
							}
						}
						SessionListener.addSessionMap(req.getSession(),user.getId().toString());
						return true;
					}
				}
			}
		} else {
			req.getSession().setAttribute("ieMessage", false);
			return true;
		}
		if(id == null) {
			return false;
		}
		req.getSession().setAttribute("ieMessage", false);
		return true;
	}
	
	public boolean isImposedOut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String isImposedOut = (String) req.getSession().getAttribute("imposedOut");
		if(isImposedOut != null) {
			req.getSession().removeAttribute("imposedOut");
			req.getSession().setAttribute("isImposedOut", "挤出登陆");
			Map<String, String> map = new HashMap<String, String>();
			map.put("username", null);
			map.put("password", null);
			map.put("thisId", null);
			int time = 0;
			LoginUtil.creatCookie(map, req,resp, time);
			resp.sendRedirect(req.getContextPath()+"/");
			return false;
		}
		return true;
	}

	
	/**
	 * 判断一段时间内分访问次数，超过一定数量则需要输入验证码
	 * @param req
	 * @return
	 */
	public boolean acquisition(HttpServletRequest req) {
		Calendar c = Calendar.getInstance();
		int minute = c.get(Calendar.MINUTE); 
		int second = c.get(Calendar.SECOND); 
		int time = minute*60 + second;
		Map<Integer, Integer> appMap = new HashMap<Integer, Integer>();
		appMap = (Map<Integer, Integer>) req.getSession().getAttribute("appMap");
		if(appMap.size() >= 10) {
			int oldTime = appMap.get(1);
			if((time - oldTime) <= 60 && (time - oldTime) > 0) {
				appMap.clear();
				req.getSession().setAttribute("appMap",appMap);
				return false;
			} else {
				for(int i= 1; i < 10; i++) {
					appMap.put(i, appMap.get(i+1));
				}
				appMap.put(10, time);
			}
		} else {
			appMap.put(appMap.size() + 1, time);
		}
		req.getSession().setAttribute("appMap",appMap);
		return true;
	}
	
}

