package com.wd.backend.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.News;
import com.wd.backend.model.Person;
import com.wd.backend.service.NewsManagerI;

@Controller
@RequestMapping("/backend/news")
public class NewsController {
	
	@Autowired
	private NewsManagerI newsService;
	/**
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String type,String key,HttpServletRequest request){
		request.setAttribute("show",6);
		Pager pager=newsService.search(key,type);
		request.setAttribute("data", pager);
		request.setAttribute("type", type);
		return "back/system/publish";
	}
	
	@RequestMapping(value = { "/list/varify/{id}/{isShow}" }, method = { RequestMethod.GET })
	public String varify(@PathVariable Integer id,@PathVariable Integer isShow,HttpServletRequest request){
		newsService.verify(id, isShow);
		request.setAttribute("msg", "设置成功");
		request.setAttribute("location", "backend/news/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/list/add" }, method = { RequestMethod.POST })
	public String add(News news,HttpServletRequest request){
		Person p = (Person) request.getSession().getAttribute("user");
		news.setPublishers(p.getId()+"");
		newsService.add(news);
		request.setAttribute("msg", "添加公告成功");
		request.setAttribute("location", "backend/news/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/list/edit/{newsId}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer newsId,HttpServletRequest request){
		News news=newsService.detail(newsId);
		request.setAttribute("news", news);
		request.setAttribute("method", "edit");
		return "back/system/edit";
	}
	@RequestMapping(value = { "/list/delete/{newsId}" }, method = { RequestMethod.GET })
	public String delete(@PathVariable Integer newsId){
		newsService.delete(newsId);
		return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/news/list";
	}
	**/
	@RequestMapping(value = { "/add" }, method = { RequestMethod.GET })
	public String add(HttpServletRequest request){
		request.setAttribute("method", "add");
		return "back/system/edit";
	}
	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(News news,HttpServletRequest request){
		newsService.update(news);
		request.setAttribute("msg", "更新公告成功");
		request.setAttribute("location", "backend/news/list");
		return "backend/success";
	}

}
