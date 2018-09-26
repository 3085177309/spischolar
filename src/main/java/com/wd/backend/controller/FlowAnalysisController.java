package com.wd.backend.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wd.backend.model.Org;
import com.wd.backend.model.VisitLog;
import com.wd.backend.service.FlowAnalysisServiceI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.util.AjaxResult;
import com.wd.util.FileUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;

/**
 * 流量分析
 * @author 杨帅菲
 *
 */

@Controller
@RequestMapping("/backend/flow")
public class FlowAnalysisController {
	private static final Logger log=Logger.getLogger(FlowAnalysisController.class);
	
	@Autowired
	private FlowAnalysisServiceI flowAnalysisService;
	
	@Autowired
	private OrgInfoServiceI orgInfoService;
	
	
	/**
	 * 流量查询
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/flowQuery" }, method = { RequestMethod.GET })
	public String flowQuery(HttpServletRequest request) {
		request.setAttribute("show",2);
		return "/back/flow/flowQuery";
	}
	@RequestMapping(value = { "/flowQuery/table" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult findBrowseListForTable(HttpServletRequest request){
		String[] compareSchoolName = request.getParameterValues("compareSchoolName");
		String[] compareSchool = request.getParameterValues("compareSchool");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String sort = request.getParameter("sort");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		if(StringUtils.isEmpty(sort)) {
            sort = "pv_down";
        }
		List<Map<String, Object>> list = flowAnalysisService.flowQueryTableList(compareSchool, compareSchoolName, beginTime, endTime,sort,type);
		Map< String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("sort", sort);
		String js = JsonUtil.obj2Json(map);
		return new AjaxResult(js);
	}
	@RequestMapping(value = { "/flowQuery/list" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult findBrowseList(HttpServletRequest request){
		String day = request.getParameter("day");
		String school = request.getParameter("school");
		String schoolName = request.getParameter("schoolName");
		String[] compareSchoolName = request.getParameterValues("compareSchoolName");
		if(compareSchoolName.length == 1 && "".equals(compareSchoolName[0])) {
			compareSchoolName[0] = schoolName;
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String[] types = request.getParameterValues("types");	//数据类型（浏览量pv,访客数uv,ip）
		if(types == null) {
			types = new String[]{"浏览量（PV）"};
		}
		if(StringUtils.isEmpty(day)) {
            day = "1";
        }
		String[] compareSchool = request.getParameterValues("compareSchool");
		if(compareSchool.length == 1 && "".equals(compareSchool[0])) {
			compareSchool[0] = school;
		}
		String js = null;
		if(compareSchool == null || "".equals(compareSchool)) {
            compareSchool = null;
        }
		try {
			js = flowAnalysisService.flowQueryMapList(compareSchoolName, compareSchool, type, beginTime, endTime, types, Integer.parseInt(day));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new AjaxResult(js);
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/flowQuery/download" }, method = { RequestMethod.GET })
	public void downLoad(HttpServletRequest request ,HttpServletResponse response){
		String day = "1";  //暂时默认
		long startTimne = System.currentTimeMillis();
		long endsTime = 0;
		String school = request.getParameter("school");
		String schoolName = request.getParameter("schoolName");
		String[] schools = null;
		String[] schoolNames = null;
		if("all".equals(school)) {
			List<Org> list = orgInfoService.findAll();
			int size =  list.size();
			schools = new String[size];
			schoolNames = new String[size];
			for(int i= 0; i<list.size();i++) {
				schools[i] = list.get(i).getFlag();
				schoolNames[i] = list.get(i).getName();
			}
		} else {
			schools = new String[]{school};
			schoolNames = new String[]{schoolName};
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = request.getParameter("type");//数据类型（原始数据，添加数据）
		if(StringUtils.isEmpty(type)) {
            type = "-1";
        }
		String[] types = request.getParameterValues("types");	//数据类型（浏览量pv,访客数uv,ip）
		String typeNames = "";
		for(String typeName : types) {
			typeNames += typeName;
		}
		String fileName= schoolName +" " + typeNames + ":" + beginTime + "-" + endTime + ".xls";//创建文件名
		String path = null;
		try {
			Map<String, Object> json = null;
			json = flowAnalysisService.downloadFlowQuery(schoolNames, type, beginTime, endTime, types, schools, Integer.parseInt(day));
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			path = realPath+ fileName;
			flowAnalysisService.creat(json,path);
			endsTime = System.currentTimeMillis();
			log.info("creat=" + ((endsTime - startTimne) / 1000) + "秒");
		} catch (Exception e) {
			e.printStackTrace();
		}
		 try {
	        	fileName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			} 
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
		try{
			response.setContentType("application/octet-stream"); 
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", fileName));
	    	File file = new File(path);
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	
	    }finally{
	    	if(bis!=null){
	    		try{
	    			bis.close();
	    			bis=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	if(bos!=null){
	    		try{
	    			bos.close();
	    			bos=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	endsTime = System.currentTimeMillis();
			log.info("downLoad=" + ((endsTime - startTimne) / 1000) + "秒");
	    }
	}
	
	/**
	 * 访问历史
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/visitHistory" }, method = { RequestMethod.GET })
	public String findBrowseListByPage(HttpServletRequest request) {
		request.setAttribute("show",2);
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if("wdkj".equals(school)) {
            school = "";
        }
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		String val = request.getParameter("val");
		String ip = request.getParameter("ip");
		String refererUrl = request.getParameter("refererUrl");
		String offset = request.getParameter("offset");
		
		if(SimpleUtil.strIsNull(school)) {
            school=null;
        }
		if(SimpleUtil.strIsNull(val)) {
            val=null;
        }
		if(SimpleUtil.strIsNull(ip)) {
            ip=null;
        }
		if(SimpleUtil.strIsNull(refererUrl)) {
            refererUrl=null;
        }
		
		request.setAttribute("offset", offset);
		request.setAttribute("school", school);
		request.setAttribute("val", val);
		request.setAttribute("ip", ip);
		request.setAttribute("refererUrl", refererUrl);
		List<Map<String, Object>> list = flowAnalysisService.visitHistory(school, val, ip, refererUrl,type);
		Long  count =  (long) 0;
		if(list.size()>0) {
			count = (Long ) list.get(0).get("count");
		}
		request.setAttribute("count", count);
		request.setAttribute("visiteList", list);
		return "/back/flow/visitHistory";
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/flowQuery/downloadHistory" }, method = { RequestMethod.GET })
	public void downLoadHistory(HttpServletRequest request ,HttpServletResponse response){
		String type = request.getParameter("type");//数据类型（原始数据，添加数据）
		long startTimne = System.currentTimeMillis();
		long endsTime = 0;
		String school = request.getParameter("school");
		String schoolName = request.getParameter("schoolName");
		if("all".equals(school)) {
			school = null;
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String fileName= schoolName +":"+ beginTime + "-" + endTime + ".xls";//创建文件名
		String path = null;
		try {
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			path = realPath+ fileName;
			flowAnalysisService.creatHistory(school,type,beginTime,endTime,path);
			endsTime = System.currentTimeMillis();
			log.info("creat=" + ((endsTime - startTimne) / 1000) + "秒");
		} catch (Exception e) {
			e.printStackTrace();
		}
		 try {
	        	fileName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			} 
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
		try{
			response.setContentType("application/octet-stream"); 
	    	response.setHeader("Content-disposition",  String.format("attachment; filename=\"%s\"", fileName));
	    	File file = new File(path);
	    	FileInputStream stream = new FileInputStream(file);
		    bis = new BufferedInputStream(stream);
		    bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
	            bos.write(buff, 0, bytesRead);  
	        } 
	    }catch(Exception e){
	    	
	    }finally{
	    	if(bis!=null){
	    		try{
	    			bis.close();
	    			bis=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	if(bos!=null){
	    		try{
	    			bos.close();
	    			bos=null;
	    		}catch(Exception e){
	    			
	    		}
	    	}
	    	endsTime = System.currentTimeMillis();
			log.info("downLoad=" + ((endsTime - startTimne) / 1000) + "秒");
	    }
	}
	
	/**
	 * 访问报告
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/visitlog" }, method = { RequestMethod.GET })
	public String visitlog(HttpServletRequest request) {
		request.setAttribute("show",2);
		String name = request.getParameter("val");
		String offset = request.getParameter("offset");
		if(StringUtils.isEmpty(name)) {
            name = null;
        }
		String remark = request.getParameter("remark");
		if(StringUtils.isEmpty(remark)) {
            remark = null;
        }
		List<VisitLog> list = flowAnalysisService.findVisitLog(name,remark);
		int count = flowAnalysisService.findVisitLogCount(name,remark);
		request.setAttribute("val", name);
		request.setAttribute("remark", remark);
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("offset", offset);
		return "/back/flow/visitlog";
	}
}
