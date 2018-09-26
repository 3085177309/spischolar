package com.wd.backend.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Org;
import com.wd.backend.model.PurchaseDB;
import com.wd.backend.service.PurchaseDBServiceI;

/**
 * 购买的数据库管理
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/backend/org/resource/purchasedb")
public class PurchaseDBController {
	
	@Autowired
	private PurchaseDBServiceI pdService;
	
	@RequestMapping(value = { "/list/{orgFlag}" }, method = { RequestMethod.GET })
	public String list(@PathVariable String orgFlag,HttpServletRequest request){
		String dbType = request.getParameter("dbType");
		Pager pager=pdService.findPager(orgFlag,dbType);
		request.setAttribute("datas", pager);
		return "back/purchasedb/list";
	}
	
	@RequestMapping(value = { "/del/{orgFlag}/{id}" }, method = { RequestMethod.GET })
	public String del(@PathVariable String orgFlag,@PathVariable Integer id,HttpServletRequest request){
		pdService.delete(id);
		String dbType = request.getParameter("dbType");
		request.setAttribute("msg", "删除成功!");
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/resource?orgFlag="+orgFlag + "&dbType=" + dbType;
	}
	
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public String add(PurchaseDB pd){
		pdService.add(pd);
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/resource?orgFlag="+pd.getOrgFlag() +"&dbType=" + pd.getDbType();
	}
	
	@RequestMapping(value = { "/edit/{id}" }, method = { RequestMethod.GET })
	public String edit(@PathVariable Integer id,HttpServletRequest request){
		PurchaseDB  pdb=pdService.detail(id);
		request.setAttribute("detail", pdb);
		return "backend/purchasedb/edit";
	}
	
	@RequestMapping(value = { "/edit" }, method = { RequestMethod.POST })
	public String edit(PurchaseDB pd,HttpServletRequest request){
		pdService.edit(pd);
		request.setAttribute("msg", "馆藏资源修改成功");
		return UrlBasedViewResolver.REDIRECT_URL_PREFIX+"/backend/org/resource?orgFlag="+pd.getOrgFlag() +"&dbType=" + pd.getDbType();
//		request.setAttribute("location", "backend/org/resource/");
//		return "backend/success";
	}
	
	@RequestMapping(value = { "/findSchool" }, method = { RequestMethod.GET })
	public String findSchool(HttpServletRequest request) {
		request.setAttribute("show",5);
		Org backloginOrg =(Org)request.getSession().getAttribute("org");
		String orgFlag=backloginOrg.getFlag();
		String val = request.getParameter("val");
		String dbType = request.getParameter("dbType");
		Pager pager = pdService.findSchool(val,orgFlag,dbType);
		request.setAttribute("datas", pager);
		request.setAttribute("type", 1);
		request.setAttribute("val", val);
		request.setAttribute("dbType", dbType);
		return "back/org/resource";
	}

}
