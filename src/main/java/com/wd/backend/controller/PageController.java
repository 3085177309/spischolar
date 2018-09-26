package com.wd.backend.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Page;
import com.wd.backend.service.PageManagerI;

@Controller
@RequestMapping("/backend/page")
public class PageController {
	
	@Autowired
	private PageManagerI pageManager;
	
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String key,HttpServletRequest request){
		Pager p= pageManager.findByPager();
		request.setAttribute("data", p);
		return "backend/page/list";
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.GET })
	public String add(){
		return "backend/page/add";
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(Page page,HttpServletRequest request){
		pageManager.add(page);
		request.setAttribute("msg", "添加单页成功");
		request.setAttribute("location", "backend/page/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/edit/{id}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer id,HttpServletRequest request){
		Page p=pageManager.get(id);
		request.setAttribute("page", p);
		return "backend/page/edit";
	}
	
	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(Page page,HttpServletRequest request){
		pageManager.edit(page);
		request.setAttribute("msg", "编辑单页成功");
		request.setAttribute("location", "backend/page/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/delete/{id}" }, method = { RequestMethod.GET })
	public String delete(@PathVariable Integer id){
		pageManager.delete(id);
		return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/page/list";
	}

}
