package com.wd.front.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//import weibo4j.Oauth;
//import weibo4j.Users;
//import weibo4j.http.AccessToken;
///import weibo4j.model.User;




import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.Hot;
import com.wd.backend.model.Member;
import com.wd.backend.model.Org;
import com.wd.comm.Comm;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.front.service.SearchLogServiceI;
import com.wd.front.service.UserServiceI;

@Controller("frontIndexController")
@RequestMapping("/")
public class IndexController {
	
	@Autowired
	private SearchLogServiceI searchLogService;
	/**用户信息修改*/
	@Autowired
	private UserServiceI userService;
	
	@Autowired
	private OrgInfoServiceI orgService;
	
	@RequestMapping(value = { "/" }, method = { RequestMethod.GET })
	public String index(HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception{
		response.setContentType("text/hmtl;charset=utf-8");
		String isMobile = (String) request.getSession().getAttribute("isMobile");
		OrgBO org = (OrgBO) session.getAttribute(Comm.ORG_SESSION_NAME);
		String orgFlag=null;
		if(org!=null){
			orgFlag=org.getFlag();
			session.setAttribute("oaFirst", org.getZyyx());
		}else{
			orgFlag="ydd";
			session.setAttribute("oaFirst", "0");
		}
		Member member=(Member) session.getAttribute(Comm.MEMBER_SESSION_NAME);
		
		String isImposedOut = (String) session.getAttribute("isImposedOut");
		if(isImposedOut != null) {
			session.removeAttribute("isImposedOut");
			request.setAttribute("isImposedOut", isImposedOut);
		}
		if(member!=null){//已经登录的页面
			return isMobile+"sites/indexout";
		}else{
			return isMobile+"sites/index";
		}
	}
	//qq登录
	private boolean qqLogin(String code, HttpServletRequest request,HttpSession session) throws Exception {
		String jsonUrl = "https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&client_id=101241932&client_secret=3646311873be2e8359352f3f587d2cd7&code="+code+"&state=test&redirect_uri=http://test.spischolar.com/journal/";
		String ss = getInfoByUrl(jsonUrl);
		if(ss.indexOf("access_token=")==-1){
			return false;
		}
		String access_token =ss.substring(ss.indexOf("access_token=")+"access_token=".length(),ss.indexOf("&"));
		String refresh_token=ss.substring(ss.indexOf("refresh_token=")+"refresh_token".length()+1,ss.length());
		String url2 = "https://graph.qq.com/oauth2.0/token?grant_type=refresh_token&client_id=101241932&client_secret=3646311873be2e8359352f3f587d2cd7&refresh_token="+refresh_token;
		String url3 ="https://graph.qq.com/oauth2.0/me?access_token="+access_token;
		String openidresult = getInfoByUrl(url3);
		openidresult=openidresult.substring(openidresult.indexOf("{"),openidresult.indexOf("}")+1);
		JSONObject  json = JSONObject.fromObject(openidresult);
		String openid=json.get("openid").toString();
		String url4 = "https://graph.qq.com/user/get_user_info?access_token="+access_token+"&oauth_consumer_key=101241932&openid="+openid;
		String result =getInfoByUrl(url4); 
		String nickname=JSONObject.fromObject(result).getString("nickname");
		Member member=userService.getqqlogin(access_token);
		if(member!=null && !"".equals(member.getUsername())){
			long nowTime = System.currentTimeMillis();
			long registertime = member.getRegisterTime().getTime();
			long i = (nowTime-registertime)/1000;
			//QQ授权时间 有效期为3个月 7776000秒 ，快过期进行自动续期
			if(i-7776000>0){
				ss=getInfoByUrl(url2);
				access_token =ss.substring(ss.indexOf("access_token=")+"access_token=".length(),ss.indexOf("&"));
				url3 ="https://graph.qq.com/oauth2.0/me?access_token="+access_token;
				openidresult = getInfoByUrl(url3);
				openidresult=openidresult.substring(openidresult.indexOf("{"),openidresult.indexOf("}")+1);
				json = JSONObject.fromObject(openidresult);
				openid=json.get("openid").toString();
				url4 = "https://graph.qq.com/user/get_user_info?access_token="+access_token+"&oauth_consumer_key=101241932&openid="+openid;
				result =getInfoByUrl(url4);
				nickname=JSONObject.fromObject(result).getString("nickname");
				member.setAccessToken(access_token);member.setNickname(nickname);
				member.setUsername(nickname);member.setRegisterTime(new Date());
			}else{
				//同步QQ昵称
				if(!nickname.equals(member.getNickname())){
					//修改用户表昵称
					member.setNickname(nickname);
					member.setUsername(nickname);
				}
			}
			member.setLoginTime(new Date());
			//修改用户表信息 
			userService.updateQQLogin(member);
			session.setAttribute(Comm.MEMBER_SESSION_NAME, member);
			if(StringUtils.isNotBlank(member.getSchoolFlag())){//如果学校标识不为空
				Org org=orgService.getOrgByFlag(member.getSchoolFlag());
				if(null != org){
					OrgBO orgBO = new OrgBO();
					BeanUtils.copyProperties(org, orgBO);
					session.setAttribute(Comm.ORG_SESSION_NAME, orgBO);
					request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
				}
			}
			return true;
		}else{
			//直接插入用户表 access_token存入access_token字段  作为QQ登录用户的唯一标识  loginType=1 QQ登录
			Member newMember = new Member();
			newMember.setAccessToken(access_token);newMember.setNickname(nickname);newMember.setUsername(nickname);
			newMember.setRegisterTime(new Date());newMember.setLoginTime(new Date());newMember.setLoginType("1");
			int id =userService.insertQQLogin(newMember);
			newMember.setId(id);
			session.setAttribute(Comm.MEMBER_SESSION_NAME, newMember);
		}
		return false;
	}
	private String getInfoByUrl(String jsonUrl) throws Exception{
		URL url = new URL(jsonUrl);  
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();  
        connection.connect();  
        InputStream inputStream = connection.getInputStream();  
        //对应的字符编码转换  
        Reader reader = new InputStreamReader(inputStream, "UTF-8");  
        BufferedReader bufferedReader = new BufferedReader(reader);  
        String str = null;  
        StringBuffer sb = new StringBuffer();  
        while ((str = bufferedReader.readLine()) != null) {  
            sb.append(str);  
        }  
        reader.close();  
        connection.disconnect();
		return sb.toString();
	}
	//微博登录
	/*
	private boolean weiboLogin(String code, HttpServletRequest request,HttpSession session) throws Exception {
		Oauth oauth = new Oauth();
		AccessToken accesstoken = oauth.getAccessTokenByCode(code);
		String access_token = accesstoken.getAccessToken();
		String uid = accesstoken.getUid();
		Users um = new Users(access_token);
		User user = um.showUserById(uid);
		String nickname = user.getScreenName();
		Member member=userService.getqqlogin(uid);
		if(member!=null && !"".equals(member.getUsername())){
			member.setAccessToken(uid);member.setNickname(nickname);
			member.setUsername(nickname);member.setLoginTime(new Date());
			//修改用户表信息 
			userService.updateQQLogin(member);
			session.setAttribute(Comm.MEMBER_SESSION_NAME, member);
			if(StringUtils.isNotBlank(member.getSchoolFlag())){//如果学校标识不为空
				Org org=orgService.getOrgByFlag(member.getSchoolFlag());
				if(null != org){
					OrgBO orgBO = new OrgBO();
					BeanUtils.copyProperties(org, orgBO);
					session.setAttribute(Comm.ORG_SESSION_NAME, orgBO);
					request.setAttribute(Comm.ORG_FLAG_NAME, org.getFlag());
				}
			}
			return true;
		}else{
			Member newMember = new Member();
			newMember.setAccessToken(uid);newMember.setNickname(nickname);newMember.setUsername(nickname);
			newMember.setRegisterTime(new Date());newMember.setLoginTime(new Date());newMember.setLoginType("2");
			int id =userService.insertQQLogin(newMember);
			newMember.setId(id);
			session.setAttribute(Comm.MEMBER_SESSION_NAME, newMember);
		}
		return false;
	}*/
}
