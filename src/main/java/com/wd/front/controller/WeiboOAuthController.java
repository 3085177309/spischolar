package com.wd.front.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

/**
 * 微博认证登录
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/weibo")
public class WeiboOAuthController {
	
	private String clientID;
	
	private String clientSecret;
	
	@RequestMapping(value = { "/oauth" }, method = { RequestMethod.GET })
	public String oauth() throws UnsupportedEncodingException{
		String oauthUrl="https://api.weibo.com/oauth2/authorize?client_id=%s&response_type=code&redirect_uri=%s";
		oauthUrl=String.format(oauthUrl, clientID,URLEncoder.encode("http://www.spischolar.com/weibo/callback","UTF-8"));
		return UrlBasedViewResolver.FORWARD_URL_PREFIX+oauthUrl;
	}
	
	@RequestMapping(value = { "/callback" }, method = { RequestMethod.GET })
	public String callback(HttpServletRequest request){
		String code=request.getParameter("code");
		String accessTokenUrl="https://api.weibo.com/oauth2/access_token?client_id=%s&client_secret=%s&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE";
		return "";
	}

}
