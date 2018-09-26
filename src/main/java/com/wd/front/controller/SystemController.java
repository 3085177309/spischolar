package com.wd.front.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.News;
import com.wd.backend.model.Page;
import com.wd.backend.model.UpdateLog;
import com.wd.front.service.NewsServiceI;
import com.wd.front.service.PageServiceI;
import com.wd.front.service.UpdateLogServiceI;
import com.wd.util.AjaxResult;

/**
 * 系统相关的操作
 * @author Shenfu<651777512@qq.com>
 *
 */
@Controller
@RequestMapping("/system")
public class SystemController {
	
	@Autowired
	private UpdateLogServiceI logService;
	
	@Autowired
	private NewsServiceI newsService;
	
	@Autowired
	private PageServiceI pageService;
	
	@RequestMapping(value = { "/guide" }, method = { RequestMethod.GET })
	public String guide(HttpServletRequest request){
		return "sites/guide";
	}
	
	@RequestMapping(value = { "/usage" }, method = { RequestMethod.GET })
	public String usage(HttpServletRequest request){
		return "sites/usage";
	}
	
	@RequestMapping(value = { "/subject" }, method = { RequestMethod.GET })
	public String subject(){
		return "sites/subject";
	}
	
	/**
	 * 系统日志列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/log/list" }, method = { RequestMethod.GET })
	public String log(HttpServletRequest request){
		Pager p=logService.findPager();
		request.setAttribute("data", p);
		return "sites/logs";
	}
	
	/**
	 * 系统日志详情
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/log/{id}" }, method = { RequestMethod.GET })
	public String detail(@PathVariable Integer id,HttpServletRequest request){
		UpdateLog ulog=logService.detail(id);
		request.setAttribute("next", logService.next(id));
		request.setAttribute("prev", logService.prev(id));
		request.setAttribute("log", ulog);
		logService.addReadTimes(id);
		return "sites/log";
	}
	
	/**
	 * 点赞
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/price/{id}" }, method = { RequestMethod.GET })
	public String price(@PathVariable Integer id,HttpServletRequest request){
		logService.addPriceTimes(id);
		return "true";
	}
	
	/**
	 * 系统公告
	 * @return
	 */
	@RequestMapping(value = { "/news/list" }, method = { RequestMethod.GET })
	public String news(HttpServletRequest request){
		Pager p=newsService.findPager();
		request.setAttribute("data", p);
		return "sites/newsList";
	}
	
	/**
	 * 公告详情
	 * @param id
	 * @return
	 */
	@RequestMapping(value = { "/news/{id}" }, method = { RequestMethod.GET })
	public String news(@PathVariable Integer id,HttpServletRequest request){
		News news = newsService.detail(id);
		request.setAttribute("news", news);
		request.setAttribute("next", newsService.next(id));
		request.setAttribute("prev", newsService.prev(id));
		newsService.addReadTimes(id);//点击次数+1
		return "sites/news";
	}
	
	@RequestMapping(value = { "/news/praise/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult praiseNews(@PathVariable Integer id){
		newsService.addPraiseTimes(id);
		return new AjaxResult("谢谢您的赞美!");
	}
	
	@RequestMapping(value = { "/log/praise/{id}" }, method = { RequestMethod.GET })
	@ResponseBody
	public AjaxResult praise(@PathVariable Integer id){
		logService.addPriceTimes(id);
		return new AjaxResult("谢谢您的赞美!");
	}
	
	@RequestMapping(value = { "/page/{id}" }, method = { RequestMethod.GET })
	public String page(@PathVariable Integer id,HttpServletRequest request){
		Page p=pageService.get(id);
		request.setAttribute("page", p);
		return "sites/page";
	}

}
