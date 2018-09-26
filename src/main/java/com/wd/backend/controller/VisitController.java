package com.wd.backend.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.LinkedMap;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.NewOld;
import com.wd.backend.model.Org;
import com.wd.backend.model.VisiteInformation;
import com.wd.backend.module.es.BrowseSearchI;
import com.wd.backend.service.VisitServiceI;
import com.wd.util.AjaxResult;
import com.wd.util.DateUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;

/**
 * 用户分析
 * @author 杨帅菲
 *
 */
@Controller
@RequestMapping("/backend/visit")
public class VisitController {
	
	@Autowired
	private VisitServiceI visitService;
	
	/**
	 * 新老访客
	 * @return
	 */
	@RequestMapping(value = { "/newOld" }, method = { RequestMethod.GET })
	public String newOld(String beginTime, String endTime, String day,HttpServletRequest request) {
		request.setAttribute("show",3);
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		if(day==null){
			day="1";
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			beginTime = df.format(new Date());
			endTime = df.format(new Date());
		}
		List<Map<String, Object>> list = visitService.getNewOld(type, null, beginTime, endTime);
		if(list.size() == 0) {
			for(int i=0;i<2;i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("pv", 0);map.put("uv", 0);map.put("avgTime", 0);map.put("avgPage", 0);
				map.put("jump", 0);map.put("register", 0);map.put("memberType", i);
				list.add(map);
			}
		} else if(list.size() == 1) {
			int memberType = Integer.parseInt(list.get(0).get("memberType").toString()) ;
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("pv", 0);map.put("uv", 0);map.put("avgTime", 0);map.put("avgPage", 0);
			map.put("jump", 0);map.put("register", 0);
			if(memberType == 1) {
				map.put("memberType", 0);
			} else {
				map.put("memberType", 1);
			}
			list.add(map);
		}
		
		int newTotal = visitService.getNewOldBroListTotal(type, null, beginTime, endTime, 0);
		int oldTotal = visitService.getNewOldBroListTotal(type, null, beginTime, endTime, 1);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("day", day);
		//request.setAttribute("type", type);
		request.setAttribute("list", list);
		request.setAttribute("newTotal", newTotal);
		request.setAttribute("oldTotal", oldTotal);
		return "back/visit/newOld";
	}
	/**
	 * 获取新访客的 来源网站	所属单位	浏览量 的列表信息  ajax方式
	 * @param request
	 * @return
	 */
	@RequestMapping(value={ "/newOld/newBrowseCountImp"},method={ RequestMethod.POST})
	@ResponseBody
	public AjaxResult newBrowseCountImp(HttpServletRequest request) {
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String beginTime=request.getParameter("beginTime");
		String endTime=request.getParameter("endTime");
		String offset=request.getParameter("offset");
		List<Map<String, Object>> newList = visitService.getNewOldBroList(type,null, beginTime, endTime, 0,offset);
		String js = JsonUtil.obj2Json(newList);
		System.out.println(js);
		return new AjaxResult(js);
	}
	/**
	 * 获取老访客的 来源网站	所属单位	浏览量 的列表信息  ajax方式
	 * @param request
	 * @return
	 */
	@RequestMapping(value={ "/newOld/oldBrowseCountImp"},method={ RequestMethod.POST})
	@ResponseBody
	public AjaxResult oldBrowseCountImp(HttpServletRequest request) {
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String beginTime=request.getParameter("beginTime");
		String endTime=request.getParameter("endTime");
		String offset=request.getParameter("offset");
		List<Map<String, Object>> oldList = visitService.getNewOldBroList(type,null, beginTime, endTime, 1,offset);
		String js = JsonUtil.obj2Json(oldList);
		System.out.println(js);
		return new AjaxResult(js);
	}
	/**
	 * 访客来源
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/comefrom" }, method = { RequestMethod.GET })
	public String visiteCome(HttpServletRequest request) {
		request.setAttribute("show",3);
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		String beginTime = request.getParameter("beginTime");
		String offset = request.getParameter("offset");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String day = request.getParameter("day");
		String sort = request.getParameter("sort");
		
		if(SimpleUtil.strIsNull(school)) {
            school = null;
        }
		request.setAttribute("school", school);
		if(SimpleUtil.strIsNull(sort)) {
            sort = "pv_down";
        }
		request.setAttribute("sort", sort);
		
		//request.setAttribute("type", type);
		request.setAttribute("day", day);
		
		
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		
		//if(SimpleUtil.strIsNull(type)) type = "0";
		if(SimpleUtil.strIsNull(beginTime)) {
            beginTime = df.format(new Date());
        }
		if(SimpleUtil.strIsNull(endTime)) {
            endTime = df.format(new Date());
        }
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		List<Map<String, Object>> list = visitService.findVisiteCome(school,beginTime, endTime, type,sort);
		int count = 0;
		if(list.size()>0) {
			count = Integer.parseInt(list.get(0).get("count").toString());
		}
		request.setAttribute("offset", offset);
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		return "back/visit/comefrom";
	}
	/**
	 * 地域分布
	 * @param request
	 * @return
	 */
	@RequestMapping(value={ "/findRegion"},method={ RequestMethod.GET})
	public String findRegion(HttpServletRequest request) {
		request.setAttribute("show",3);
		//Org org =(Org)request.getSession().getAttribute("org");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String day = request.getParameter("day");
		String province = request.getParameter("province");
		String offset = request.getParameter("offset");
		String sort = request.getParameter("sort");
		if(SimpleUtil.strIsNull(sort)) {
            sort = "pv_down";
        }
		
		request.setAttribute("province", province);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		//request.setAttribute("type", type);
		request.setAttribute("day", day);
		request.setAttribute("sort", sort);
		
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		
		//if(SimpleUtil.strIsNull(type)) type = "0";
		if(SimpleUtil.strIsNull(beginTime)) {
            beginTime = df.format(new Date());
        }
		if(SimpleUtil.strIsNull(endTime)) {
            endTime = df.format(new Date());
        }
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		
		
		if(endTime != null) {
            endTime = endTime + " 23:59:59";
        }
		String[] types = {"浏览量（PV）","访客数（UV）","IP数","平均访问时长","平均访问页数","跳出率"};
		List<Org> orgList = (List<Org>) request.getSession().getAttribute("orgList");
		
		List<Map<String, Object>> dataList = visitService.findRegionTableList(types, province, beginTime, endTime, type, offset,sort);
		if(StringUtils.isNotEmpty(province) && !"all".equals(province)) {
			for(int i=0;i<dataList.size();i++) {
				Map<String, Object> data = dataList.get(i);
				String orgFlag = data.get("schoolFlag").toString();
				for(Org org : orgList) {
					if(org.getFlag().equals(orgFlag)) {
						data.put("schoolName", org.getName());
						break;
					}
				}
			}
		}
		int count =0;
		if(dataList.size()>0) {
			count = Integer.parseInt(dataList.get(0).get("count").toString());
		}
		request.setAttribute("count", count);
		request.setAttribute("list", dataList);
		return "back/visit/findRegion";
	}
	/**
	 * 地域分布图表
	 * @param request
	 * @return
	 */
	@RequestMapping(value={ "/findRegion"},method={ RequestMethod.POST})
	@ResponseBody
	public AjaxResult findRegionP(HttpServletRequest request) {
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String[] types = request.getParameterValues("types");
		
		//if(type == null || type.equals("")) type = "0";
		if(beginTime == null || "".equals(beginTime)) {
            beginTime = null;
        }
		if(endTime == null || "".equals(endTime)) {
            endTime = null;
        }
		if(endTime != null) {
            endTime = endTime + " 23:59:59";
        }
		
		Map<String, Object> result = visitService.findRegion(types, beginTime, endTime, type);
		String js = JsonUtil.obj2Json(result);
		return new AjaxResult(js);
	}
	/**
	 * 留存用户
	 * @return
	 */
	@RequestMapping(value = { "/keep" }, method = { RequestMethod.GET })
	public String keep(String beginTime, String endTime, String day,HttpServletRequest request) {
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		request.setAttribute("show",3);
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		if(day==null){
			//type="0";
			day="1";
			beginTime = DateUtil.getDate(df.format(new Date()), 0, 0, -7);
			endTime = df.format(new Date());
		}
		if("".equals(school)){
			school=null;
		}
		List<Map<String, Object>> result = visitService.getKeepUser(type, beginTime, endTime, day, school);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("day", day);
		//request.setAttribute("type", type);
		request.setAttribute("school", school);
		request.setAttribute("result", result);
		return "back/visit/keep";
	}
	
	@Autowired
	private BrowseSearchI browseSearch;
	
	@RequestMapping(value = { "/visitPage" }, method = { RequestMethod.GET })
	public String visitPage(String beginTime, String endTime, String day,HttpServletRequest request){
		request.setAttribute("show",3);
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		//if(StringUtils.isEmpty(type)) type = "0";
		if("all".equals(school)) {
            school = null;
        }
		if(day==null){
			//type="0"; 
			day="1";
			SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			beginTime = df.format(new Date())+" 00:00:00";
			endTime = df.format(new Date())+" 23:59:59";
		}else{
			beginTime = beginTime+" 00:00:00";
			endTime = endTime+" 23:59:59";
		}

		List<Map<String, Object>> visitPage = browseSearch.visitPage(beginTime, endTime, school, type);
		
		request.setAttribute("beginTime", beginTime.substring(0, 10));
		request.setAttribute("endTime", endTime.substring(0, 10));
		request.setAttribute("school", school);
		request.setAttribute("day", day);
		//request.setAttribute("type", type);
		request.setAttribute("resultList", visitPage);
		return "back/visit/visitPage";
	}
}
