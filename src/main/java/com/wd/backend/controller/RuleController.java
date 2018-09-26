package com.wd.backend.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Database;
import com.wd.backend.model.LinkRule;
import com.wd.backend.service.RuleServiceI;
import com.wd.exeception.SystemException;

//@Controller
//@RequestMapping("/backend/rule")
public class RuleController {

	@Autowired
	private RuleServiceI ruleService;

	@RequestMapping(value = { "/index/{orgId}" }, method = { RequestMethod.GET })
	public String index(@PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("orgId", orgId);
		return "backend/rule/index";
	}

	/**
	 * 查找数据库列表
	 * 
	 * @param key
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/dbList/{orgId}" }, method = { RequestMethod.POST, RequestMethod.GET })
	public String dbList(@PathVariable Integer orgId, String key, HttpServletRequest request) {
		Pager pager = ruleService.searchDbList(key);
		request.setAttribute("pager", pager);
		request.setAttribute("orgId", orgId);
		request.setAttribute("key", key);
		return "backend/rule/dbList";
	}

	/**
	 * 进入机构规则列表首页
	 * 
	 * @param dbId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/ruleIndex/{dbId}/{orgId}" }, method = { RequestMethod.GET })
	public String ruleIndex(@PathVariable Integer dbId, @PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("dbId", dbId);
		request.setAttribute("orgId", orgId);

		Database database = ruleService.searchDbDetail(dbId);

		request.setAttribute("database", database);

		return "backend/rule/dbRuleIndex";
	}

	/**
	 * 查找机构规则列表
	 * 
	 * @param dbId
	 * @param orgId
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/ruleList/{dbId}/{orgId}" }, method = { RequestMethod.GET })
	public String searchRuleList(@PathVariable Integer dbId, @PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("dbId", dbId);
		request.setAttribute("orgId", orgId);

		Pager pager = ruleService.searchRuleList(orgId, dbId);

		request.setAttribute("pager", pager);

		return "backend/rule/ruleList";
	}

	@RequestMapping(value = { "/add/{orgId}/{dbId}" }, method = { RequestMethod.GET })
	public String add(@PathVariable Integer orgId, @PathVariable Integer dbId, HttpServletRequest request) throws IOException {
		request.setAttribute("orgId", orgId);
		request.setAttribute("dbId", dbId);
		request.setAttribute("opt", "add");
		return "backend/rule/ruleDetail";
	}

	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(LinkRule linkRule, HttpServletRequest request) throws IOException {
		try {
			ruleService.add(linkRule);
		} catch (SystemException e) {
			request.setAttribute("error", e.getMessage());
			request.setAttribute("opt", "add");
			request.setAttribute("rule", linkRule);
			if (null != linkRule) {
				request.setAttribute("orgId", linkRule.getOrgId());
				request.setAttribute("dbId", linkRule.getDbId());
			}
			return "backend/rule/ruleDetail";
		}
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "ruleList/" + linkRule.getDbId() + "/" + linkRule.getOrgId();
	}

	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(LinkRule linkRule, HttpServletRequest request) throws IOException {
		try {
			ruleService.edit(linkRule);
		} catch (SystemException e) {
			request.setAttribute("error", e.getMessage());
			if (null != linkRule) {
				request.setAttribute("rule", linkRule);
				request.setAttribute("orgId", linkRule.getOrgId());
				request.setAttribute("dbId", linkRule.getDbId());
			}
			return "backend/rule/ruleDetail";
		}
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX + "ruleList/" + linkRule.getDbId() + "/" + linkRule.getOrgId();
	}

	@RequestMapping(value = { "/edit/{ruleId}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer ruleId, HttpServletRequest request) throws IOException {
		request.setAttribute("opt", "edit");
		LinkRule linkRule = ruleService.searchRuleDetail(ruleId);
		request.setAttribute("rule", linkRule);
		if (null != linkRule) {
			request.setAttribute("orgId", linkRule.getOrgId());
			request.setAttribute("dbId", linkRule.getDbId());
		} else {
			request.setAttribute("error", "无法找到该规则!");
		}
		return "backend/rule/ruleDetail";
	}

	@RequestMapping(value = { "/del/{ruleId}" }, method = { RequestMethod.GET })
	public void del(@PathVariable Integer ruleId, HttpServletResponse response) throws IOException {
		ruleService.del(ruleId);
		response.getWriter().println("{}");
	}
}
