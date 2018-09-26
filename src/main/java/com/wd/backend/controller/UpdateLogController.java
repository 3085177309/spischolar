package com.wd.backend.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.wd.backend.bo.Pager;
import com.wd.backend.model.UpdateLog;
import com.wd.backend.service.UpdateLogManagerI;

@Controller
@RequestMapping("/backend/updatelog")
public class UpdateLogController {
	
	@Autowired
	private UpdateLogManagerI updateLogService;
	
	@RequestMapping(value = { "/list" }, method = { RequestMethod.GET })
	public String list(String key,HttpServletRequest request){
		Pager pager=updateLogService.search(key,1);
		request.setAttribute("data", pager);
		return "backend/updatelog/list";
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.GET })
	public String add(){
		return "backend/updatelog/add";
	}
	
	@RequestMapping(value = { "/varify" }, method = { RequestMethod.GET })
	public String varify(UpdateLog log,HttpServletRequest request){
		updateLogService.updateView(log);
		//return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/updatelog/list";
		request.setAttribute("msg", "设置成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(UpdateLog log,HttpServletRequest request){
		updateLogService.add(log);
		request.setAttribute("msg", "机构系统公告成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/edit/{logId}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer logId,HttpServletRequest request){
		UpdateLog log=updateLogService.detail(logId);
		request.setAttribute("log", log);
		return "backend/updatelog/edit";
	}
	
	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(UpdateLog log,HttpServletRequest request){
		updateLogService.edit(log);
		request.setAttribute("msg", "编辑系统更新日志成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
	}
	
	@RequestMapping(value = { "/delete/{logId}" }, method = { RequestMethod.GET })
	public String delete(@PathVariable Integer logId,HttpServletRequest request){
		updateLogService.delete(logId);
		request.setAttribute("msg", "删除成功");
		request.setAttribute("location", "backend/updatelog/list");
		return "backend/success";
		//return  UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/updatelog/list";
	}



}
