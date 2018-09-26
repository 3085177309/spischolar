package com.wd.backend.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.SystemException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wd.backend.bo.AuthorityDatabaseBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.service.AuthorityDataBaseServiceI;

@Controller
@RequestMapping("/backend/authorityDatabase")
public class AuthorityDatabaseController {

	@Autowired
	private AuthorityDataBaseServiceI authorityDBService;

	@RequestMapping(value = { "/index" }, method = { RequestMethod.GET })
	public String index() {
		return "backend/authorityDatabase/index";
	}

	/**
	 * 添加数据库分区信息
	 * 
	 * @param authority
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public void add(AuthorityDatabaseBO authorityDatabase, HttpServletResponse response) {
		String rs = "{}";
		try {
			authorityDBService.add(authorityDatabase);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 删除数据库分区信息
	 * 
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/del/{id}" }, method = { RequestMethod.GET })
	public void del(@PathVariable Integer id, HttpServletResponse response) {
		authorityDBService.del(id);
		try {
			response.getWriter().print("{}");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据关键词获取数据库分区信息列表
	 * 
	 * @param keyword
	 *            关键词为空，则按照查询所有方式查找
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String keyword, HttpServletRequest request) {
		Pager pager = authorityDBService.search(keyword);
		request.setAttribute("pager", pager);
		request.setAttribute("keyword", keyword);
		return "backend/authorityDatabase/list";
	}

	@RequestMapping(value = { "/edit/{id}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer id, HttpServletRequest request) {
		AuthorityDatabaseBO authorityDatabase = authorityDBService.detail(id);
		request.setAttribute("authorityDatabase", authorityDatabase);
		return "backend/authorityDatabase/detail";
	}

	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(AuthorityDatabaseBO authorityDatabase, HttpServletRequest request) {
		try {
			authorityDBService.edit(authorityDatabase);
		} catch (SystemException e) {
			request.setAttribute("error", e.getMessage());
		}
		request.setAttribute("authorityDatabase", authorityDatabase);
		if (null != authorityDatabase) {
			request.setAttribute("id", authorityDatabase.getId());
		}
		return "backend/authorityDatabase/detail";
	}
}
