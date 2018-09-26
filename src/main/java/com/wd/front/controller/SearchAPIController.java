package com.wd.front.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.front.bo.SearchCondition;

/**
 * 老的API搜索接口兼容
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/")
public class SearchAPIController {
	
	/**
	 * 老版本发布的期刊搜索接口 ：
	 * http://spischolar.com/list/result
	 * 现在的接口改为 ：
	 * http://spischolar.com/journal/search/list
	 * 简单的做了一次重定向处理。
	 * @param conditoin
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "list/result" }, method = { RequestMethod.GET })
	public String search(SearchCondition conditoin, HttpServletRequest request) {
		String req = request.getQueryString();
		String value="";
		if(req.indexOf("value")!=-1){
			value=req.substring(req.indexOf("value"));
			if(value.indexOf("&")!=-1){
				value=value.substring(0, value.indexOf("&"));
			}
		}else{
			value=req;
		}
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/journal/search/list?"+value;
	}
	/**
	 * 老版本发布的文章搜索接口 ：
	 * http://spischolar.com/docList
	 * 现在的接口改为 ：
	 * http://spischolar.com/scholar/list
	 * 简单的做了一次重定向处理。
	 * @return
	 */
	@RequestMapping(value = { "docList" }, method = { RequestMethod.GET })
	public String webSearch(SearchCondition conditoin, HttpServletRequest request) {
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/scholar/list?"+request.getQueryString();
	}
	/**
	 * 老版本发布的接口 ：
	 * http://spischolar.com/front/search/qkdh/list/result
	 * 现在的接口改为 ：
	 * http://spischolar.com/list/result
	 * 简单的做了一次重定向处理。
	 * @param siteFlag
	 * @param page
	 * @param conditoin
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "front/search/{siteFlag}/{page}/result" }, method = { RequestMethod.GET })
	public String oldSearch(@PathVariable String siteFlag, @PathVariable String page,SearchCondition conditoin, HttpServletRequest request) {
		String req = request.getQueryString();
		String value="";
		if(req.indexOf("value")!=-1){
			value=req.substring(req.indexOf("value"));
			if(value.indexOf("&")!=-1){
				value=value.substring(0, value.indexOf("&"));
			}
		}else{
			value=req;
		}
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/journal/search/list?"+value;
	}
	
	@RequestMapping(value = { "front/search/qkdh" }, method = { RequestMethod.GET })
	public String oldSearchs(SearchCondition conditoin, HttpServletRequest request) {
		String req = request.getQueryString();
		String value="";
		if(req.indexOf("value")!=-1){
			value=req.substring(req.indexOf("value"));
			if(value.indexOf("&")!=-1){
				value=value.substring(0, value.indexOf("&"));
			}
		}else{
			value=req;
		}
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/journal/search/list?"+value;
	}

}
