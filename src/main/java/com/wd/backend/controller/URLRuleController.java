package com.wd.backend.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.URLRule;
import com.wd.backend.service.URLRuleServiceI;

/**
 * url规则管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/backend/org/resource/urlrule")
public class URLRuleController {
	
	@Autowired
	private URLRuleServiceI urlRuleService;
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.GET })
	public String add(HttpServletRequest request) {
		return "backend/urlrule/add";
	}
	
	/**
	 * 添加一条URL规则
	 * @param rule
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(URLRule rule,HttpServletRequest request){
		urlRuleService.add(rule);
		String orgFlag=rule.getOrgFlag();
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/resource?orgFlag="+orgFlag;
	}
	
	/**
	 * URL规则列表
	 * @param orgFlag
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/list/{orgFlag}" }, method = { RequestMethod.GET })
	public String list(@PathVariable String orgFlag,HttpServletRequest request){
		Pager pager=urlRuleService.searchPage(orgFlag);
		request.setAttribute("datas", pager);
		request.setAttribute("orgFlag", orgFlag);
		return "back/urlrule/list";
	}
	
	/**
	 * 删除一条记录
	 * @param orgFlag
	 * @param ruleID
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/del/{orgFlag}/{ruleID}" }, method = { RequestMethod.GET })
	public String del(@PathVariable String orgFlag,@PathVariable Integer ruleID,HttpServletRequest request){
		urlRuleService.delete(ruleID);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/resource?orgFlag="+orgFlag;
	}

}
