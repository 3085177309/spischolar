package com.wd.backend.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wd.backend.bo.Pager;
import com.wd.front.service.SearchLogServiceI;

@Controller
@RequestMapping("/backend/log")
public class LogController {

	@Autowired
	private SearchLogServiceI searchLogService;

	@RequestMapping(value = { "/index/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String index(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Map<String, Integer> map = searchLogService.searchOverview(orgFlag, siteFlag, time);
		request.setAttribute("overViewMap", map);
		Calendar calendar = Calendar.getInstance();
		int currentMonth = calendar.get(Calendar.MONTH);
		List<Integer> mothList = new ArrayList<Integer>(currentMonth);
		for (int i = 1; i <= currentMonth; i++) {
			mothList.add(i);
		}
		request.setAttribute("time", time);
		request.setAttribute("mothList", mothList);
		return "backend/log/index";
	}

	/**
	 * 期刊主要检索词
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/journalWord/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalWordLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchJournalWordLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalWordLog";
	}

	/**
	 * 期刊主要检索issn
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/issnLog/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalIssnLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchIssnLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalIssnLog";
	}

	/**
	 * 期刊主要检索体系
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/sysLog/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalSysLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchSysLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalSysLog";
	}

	/**
	 * 期刊主要检索体系--学科
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/sysSubjLog/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalSysSubjLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchSysSubjLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalSysSubjLog";
	}

	/**
	 * 期刊详细页查看日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/detailLog/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalDetailjLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchDetailLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalDetailLog";
	}

	/**
	 * 期刊主页连接打开日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/journalHomePage/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String journalHomePageLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchJournalMainLinkLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/journalLinkLog";
	}

	/**
	 * 期刊文章标题检索
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/docTitleLog/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String docTitleLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchDocTitleLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/docSearchLog";
	}

	/**
	 * 文章主页打开日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = { "/docHomePage/{orgFlag}/{siteFlag}" }, method = { RequestMethod.GET })
	public String docHomePageLog(Integer time, @PathVariable String orgFlag, @PathVariable String siteFlag, HttpServletRequest request) throws IOException {
		Pager pager = searchLogService.searchDocHomePageLog(orgFlag, siteFlag, time);
		request.setAttribute("pager", pager);
		request.setAttribute("orgFlag", orgFlag);
		request.setAttribute("siteFlag", siteFlag);
		request.setAttribute("time", time);
		return "backend/log/docLinkLog";
	}
}
