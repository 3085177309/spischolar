package com.wd.backend.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.DownloadInfo;
import com.wd.backend.model.Org;
import com.wd.backend.service.ContentAnalysisServiceI;
import com.wd.backend.service.DocDeliveryManagerI;
import com.wd.backend.service.DownloadRecordManagerI;
import com.wd.util.AjaxResult;
import com.wd.util.DateUtil;
import com.wd.util.FileUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;

@Controller
@RequestMapping("/backend/contentAnalysis")
public class ContentAnalysisController {
	@Autowired
	private ContentAnalysisServiceI contService;
	
	@RequestMapping(value = { "/searchAnalysis" }, method = { RequestMethod.GET })
	public String searchAnalysis(HttpServletRequest request){
		request.setAttribute("show",4);
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		endTime=DateUtil.handleEndTime(endTime);
		/*beginTime = DateUtil.handleBeginTime(beginTime);
		if(!school.equals("wdkj")) beginTime = beginTime.substring(0, 4) + "-01-01";*/
		if(!"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String key = request.getParameter("key");
		String sort = request.getParameter("sort");
		if(SimpleUtil.strIsNull(sort)) {
            sort = "num_down";
        }
		request.setAttribute("beginTime", beginTime);
		System.out.println(endTime.substring(0,10));
		request.setAttribute("endTime", endTime.substring(0,10));
		if("wdkj".equals(school) && StringUtils.isEmpty(request.getParameter("school"))) {
			String offset =request.getParameter("offset");
			Pager pager = contService.findSearch(beginTime, endTime, type, offset,key,sort);
			request.setAttribute("pager", pager);
			request.setAttribute("offset", offset);
			request.setAttribute("sort", sort);
			request.setAttribute("key", key);
			return "back/contentAnalysis/searchAnalysisAll";
		}
		if(!StringUtils.isEmpty(request.getParameter("school"))){
			school= request.getParameter("school");
			if("all".equals(school)) {
				school = null;
			}
		}
		
		int journalCount = contService.findSearchJournalCount(school, beginTime, endTime,type);
		int scholarCount = contService.findSearchScholarCount(school, beginTime, endTime,type);
		List<Map<String,Object>> searchInfoList = contService.getAllSearchInfoCount(school,type,beginTime, endTime);
		int allJournalCount = 0;
		int allScholarCount = 0;
		if(searchInfoList != null && searchInfoList.size() > 0 && searchInfoList.get(0) != null) {
			allJournalCount = Integer.parseInt(searchInfoList.get(0).get("journalSearchNum").toString());
			allScholarCount =  Integer.parseInt(searchInfoList.get(0).get("scholarSearchNum").toString());
		}
		request.setAttribute("school", school);
		
		request.setAttribute("journalCount", journalCount);
		request.setAttribute("allJournalCount", allJournalCount);
		request.setAttribute("scholarCount", scholarCount);
		request.setAttribute("allScholarCount", allScholarCount);
		return "back/contentAnalysis/searchAnalysis";
	}
	/**
	 * 期刊
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/searchAnalysis/searchJournal" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult searchJournal(HttpServletRequest request) {
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		//String offset = request.getParameter("offsets");
		if(school ==null || "".equals(school)) {
            school = null;
        }
		//if(type == null || type.equals("")) type = "-1";
		List<Map<String,Object>> list = contService.findSearchJournal(school, beginTime, endTime,type,"1");
		String js = JsonUtil.obj2Json(list);
		return new AjaxResult(js);
	}
	/**
	 * 文章
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/searchAnalysis/searchScholar" }, method = { RequestMethod.POST })
	@ResponseBody
	public AjaxResult searchScholar(HttpServletRequest request) {
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		//String offset = request.getParameter("offsets");
		if(school ==null || "".equals(school)) {
            school = null;
        }
		//if(type == null || type.equals("")) type = "-1";
		List<Map<String,Object>> list = contService.findSearchScholar(school, beginTime, endTime,type,"1");
		String js = JsonUtil.obj2Json(list);
		return new AjaxResult(js);
	}
	
	@RequestMapping(value = { "/browseAnalysis" }, method = { RequestMethod.GET })
	public String browseAnalysis(String beginTime,String endTime,HttpServletRequest request){
		request.setAttribute("show",4);
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		Org org =(Org)request.getSession().getAttribute("org");
		String school =request.getParameter("school");
		String schoolName=request.getParameter("schoolName");
		if(StringUtils.isEmpty(school)) {
			 school= org.getFlag();
			 schoolName=org.getName();
			 if("wdkj".equals(school)) {
				school = null;
				schoolName="全部学校";
			} 
		}
		endTime=DateUtil.handleEndTime(endTime);
		if(school != null && !"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}

		List<Map<String,Object>> searchInfoList = contService.getAllSearchInfoCount(school,type,beginTime, endTime+ " 23:59:59");
		int journalCount = 0;
		int subjectCount = 0;
		int dbCount = 0;
		if(searchInfoList != null && searchInfoList.size() > 0 && searchInfoList.get(0) != null) {
			journalCount = Integer.parseInt(searchInfoList.get(0).get("journalNum").toString());
			subjectCount =  Integer.parseInt(searchInfoList.get(0).get("subjectNum").toString());
			dbCount =  Integer.parseInt(searchInfoList.get(0).get("dbNum").toString());
		}
		int journalTotal = contService.getJournalTotal(school, beginTime, endTime, type);
		int subjectTotal = contService.getSubjectTotal(school, beginTime, endTime, type);
		request.setAttribute("journalCount", journalCount);
		request.setAttribute("subjectCount", subjectCount);
		request.setAttribute("dbCount", dbCount);
		request.setAttribute("journalTotal", journalTotal);
		request.setAttribute("subjectTotal", subjectTotal);
		
		Map<String,Object> result = contService.getDbAnalysis(school, beginTime, endTime, type);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime.substring(0,10));
		request.setAttribute("school", school);
		request.setAttribute("schoolName", schoolName);
		request.setAttribute("result", result);
		return "back/contentAnalysis/browseAnalysis";
	}
	
	@RequestMapping(value={ "/browseAnalysis/journalImp"},method={ RequestMethod.POST})
	@ResponseBody
	public AjaxResult journalImp(HttpServletRequest request) {
		String school = request.getParameter("school");
		if("".equals(school)){
			school = null;
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String offset =request.getParameter("offset");
		String size =request.getParameter("size");
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		List<Map<String, Object>> result = contService.getJournalAnalysis(school, beginTime, endTime, type, offset, size);
		String js = JsonUtil.obj2Json(result);
		return new AjaxResult(js);
	}

	@RequestMapping(value={ "/browseAnalysis/subjectImp"},method={ RequestMethod.POST})
	@ResponseBody
	public AjaxResult subjectImp(HttpServletRequest request) {
		String school = request.getParameter("school");
		if("".equals(school)){
			school = null;
		}
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		String offset =request.getParameter("offset");
		String size =request.getParameter("size");
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		List<Map<String, Object>> result = contService.getSubjectAnalysis(school, beginTime, endTime, type, offset, size);
		String js = JsonUtil.obj2Json(result);
		return new AjaxResult(js);
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/browseAnalysis/download" }, method = { RequestMethod.GET })
	public void downLoad(HttpServletRequest request ,HttpServletResponse response){
		String school = request.getParameter("school");
		String schoolName = request.getParameter("schoolName");
		if(org.apache.commons.lang.StringUtils.isEmpty(schoolName) || "null".equals(schoolName)) {
			schoolName = "全部学校";
		}
		if("all".equals(school)) {
            school = null;
        }
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		String type = request.getParameter("type");//数据类型（原始数据，添加数据）
		if(StringUtils.isEmpty(type)) {
            type = "-1";
        }
		String content = request.getParameter("content");	
		List<Map<String,Object>> list = null;
		if("检索分析".equals(content)) {
			Pager pager = contService.findSearch(beginTime, endTime, type, "-1",null,"num_down");
			list = pager.getRows();
		} else if("检索-期刊关键词".equals(content)) {
			list = contService.findSearchJournal(school, beginTime, endTime,type,null);
		} else if("检索-文章关键词".equals(content)) {
			list = contService.findSearchScholar(school, beginTime, endTime,type,null);
		} else if("浏览期刊".equals(content)) {
			list = contService.getJournalAnalysis(school, beginTime, endTime, type, null, null);
		} else if("浏览学科".equals(content)) {
			list = contService.getSubjectAnalysis(school, beginTime, endTime, type, null, null);
		} else {//浏览学科体系
			Map<String,Object> mapList = contService.getDbAnalysis(school, beginTime, endTime, type);
			list = new ArrayList<Map<String,Object>>();
			list.add(mapList);
		}
		String fileName=  schoolName + content +"---" + beginTime + "-" + endTime + ".xls";//创建文件名
		String path = null;
		try {
	//		Map<String, Object> json = flowAnalysisService.findBrowseList(schoolNames,type,beginTime,endTime,types,schools);
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			path = realPath+ fileName;
			if("检索分析".equals(content)) {
				contService.creatAll(list, path);
			}else if(!"浏览学科体系".equals(content)) {
				contService.creat(list, path);
			} else {
				contService.creatDb(list.get(0), path);
			}
	//		flowAnalysisService.creat(json,path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
        try {
        	fileName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} 
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
	    }
	}
	
	/**
	 * 页面点击统计
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/pageClick" }, method = { RequestMethod.GET })
	public String pageClick(HttpServletRequest request){
		request.setAttribute("show",4);
		return "back/contentAnalysis/pageClick";
	}
	@RequestMapping(value = { "/pageClick/info" }, method = { RequestMethod.GET })
	public String pageClickInfo(HttpServletRequest request){
		String pageName = request.getParameter("pageName");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		if(beginTime == null) {
			beginTime = today(0);
		}
		if(endTime == null) {
			endTime = today(0);
		}
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("pageName", pageName);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime + " 23:59:59");
		List<Map<String, Object>> list = contService.pageClickInfo(params);
		request.setAttribute("list", list);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("pageName", pageName);
		request.setAttribute("day", request.getParameter("day"));
		if(list != null && list.size() !=0) {
		request.setAttribute("total", list.get(0).get("total"));
		} else {
			request.setAttribute("total", 0);
		}
		return "back/contentAnalysis/pageClickInfo";
	}
	/**
	 * 时间
	 * @param day
	 * @return
	 */
	public String today(int day) {
		Date date=new Date();//取时间
		 Calendar calendar = new GregorianCalendar();
		 calendar.setTime(date);
		 calendar.add(Calendar.DATE,day);//把日期往后增加一天.整数往后推,负数往前移动
		 date=calendar.getTime(); //这个时间就是日期往后推一天的结果 
		 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		 String dateString = formatter.format(date);
		 return dateString;
	}
	
	@RequestMapping(value = { "/deedAnalysis" }, method = { RequestMethod.GET })
	public String deedAnalysis(HttpServletRequest request){
		request.setAttribute("show",4);
//		String js = contService.findChickPage();
//		request.setAttribute("js", js);
		return "back/contentAnalysis/deedAnalysis";
	}
	
	@Autowired
	DownloadRecordManagerI downloadRecordManagerService;
	/**
	 * 获取下载记录列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/downloadRecord" }, method = { RequestMethod.GET })
	public String downloadRecord(HttpServletRequest request){
		request.setAttribute("show",4);
		Org org =(Org)request.getSession().getAttribute("org");
		String school= "zndx";
	/*	String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");*/
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		
		endTime=DateUtil.handleEndTime(endTime);
		if(!"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}
		
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		if(StringUtils.isEmpty(type)) {
            type = "-1";
        }
		String schoolName = request.getParameter("key");
		String sort = request.getParameter("sort");
		String offset = request.getParameter("offset");
		if(SimpleUtil.strIsNull(offset)) {
            offset = "0";
        }
		if(SimpleUtil.strIsNull(sort)) {
            sort = "count_down";
        }
		if(StringUtils.isEmpty(schoolName)) {
            schoolName = null;
        }
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		if("wdkj".equals(school) && StringUtils.isEmpty(request.getParameter("school"))) {
			Pager pager = downloadRecordManagerService.getAllDownloadList(beginTime, endTime, offset,schoolName,type,sort);
			request.setAttribute("pager", pager);
			request.setAttribute("key", schoolName);
			request.setAttribute("sort", sort);
			return "back/contentAnalysis/downloadRecordAll";
		}
		if(!StringUtils.isEmpty(request.getParameter("school"))){
			school= request.getParameter("school");
			if("all".equals(school)) {
				school = null;
			}
		}
		List<DownloadInfo> list = downloadRecordManagerService.getList(school,beginTime,endTime,type);
		int count = downloadRecordManagerService.getListCount(school, beginTime, endTime,type);
		int allCount = downloadRecordManagerService.getAllCount(school, beginTime, endTime,type);
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("allCount", allCount);
		request.setAttribute("school", school);
		request.setAttribute("offset", offset);
		return "back/contentAnalysis/downloadRecord";
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/downloadRecord/download" }, method = { RequestMethod.GET })
	public void downLoadRecord(HttpServletRequest request ,HttpServletResponse response){
		/*String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");*/
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		beginTime = DateUtil.handleBeginTime(beginTime);
		endTime=DateUtil.handleEndTime(endTime);
		String type = request.getParameter("type");//数据类型（原始数据，添加数据）
		List<Map<String,Object>> list = null;
		Pager pager = downloadRecordManagerService.getAllDownloadList(beginTime, endTime, "-1",null,type,"count_down");
		list = pager.getRows();
		
		String fileName= "全部学校文章下载统计---" + beginTime + "-" + endTime + ".xls";//创建文件名
		String path = null;
		try {
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			path = realPath+ fileName;
			downloadRecordManagerService.creatAlldownloadRecord(list, path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
	    
        try {
        	fileName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} 
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
	    }
	}
	
	/**
	 * 获取下载记录详细列表
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/downloadRecord/info" }, method = { RequestMethod.GET })
	public String downloadRecordInfo(HttpServletRequest request){
		request.setAttribute("show",4);
		String title = request.getParameter("title").replace("$034", "\"");
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		if(request.getParameter("school")!=null){
			school= request.getParameter("school");
		}
		if(SimpleUtil.strIsNull(school)) {
            school = null;
        }
		String type = (String) request.getSession().getAttribute("type");//数据类型（原始数据，添加数据）
		
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		endTime=DateUtil.handleEndTime(endTime);
		/*beginTime = DateUtil.handleBeginTime(beginTime);
		if(!school.equals("wdkj")) beginTime = beginTime.substring(0, 4) + "-01-01";*/
		if(!"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("school", school);
		request.setAttribute("title", title);
		
		List<DownloadInfo> list = downloadRecordManagerService.getInfoList(school,beginTime,endTime,title,type);
		int count = downloadRecordManagerService.getInfoListCount(school,beginTime,endTime,title,type);
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		return "back/contentAnalysis/downloadRecordInfo";
	}
	
	@Autowired
	private DocDeliveryManagerI docDeliveryService;
	/**
	 * 文献传递统计
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "/deliveryRecord" }, method = { RequestMethod.GET })
	public String deliveryRecord(HttpServletRequest request){
		request.setAttribute("show",4);
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		String sort = request.getParameter("sort");
		String email = request.getParameter("email");
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		endTime=DateUtil.handleEndTime(endTime);
		/*beginTime = DateUtil.handleBeginTime(beginTime);
		if(!school.equals("wdkj")) beginTime = beginTime.substring(0, 4) + "-01-01";*/
		if(!"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}
		
		String offset = request.getParameter("offset");
		String key = request.getParameter("key");
		String type = (String) request.getSession().getAttribute("type");
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		if(SimpleUtil.strIsNull(sort)) {
            offset = "0";
        }
		if(SimpleUtil.strIsNull(sort)) {
            sort = "num_down";
        }
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("offset", offset);
		request.setAttribute("sort", sort);
		request.setAttribute("key", key);
		if("wdkj".equals(school) && (StringUtils.isEmpty(request.getParameter("school")) || "all".equals(request.getParameter("school")))) {
			Pager pager = docDeliveryService.getDeliveryRecord(beginTime, endTime, offset,sort,key,type);
			request.setAttribute("pager", pager);
			request.setAttribute("school", school);
			return "back/contentAnalysis/deliveryRecordAll";
		}
		if(!StringUtils.isEmpty(request.getParameter("school"))){
			school= request.getParameter("school");
			request.setAttribute("school", school);
			if("all".equals(school)) {
				school = null;
			}
		}
		Pager pager = docDeliveryService.getDeliveryRecordByOrgFlag(email,school,beginTime, endTime, offset,sort,type);
		int allCount = docDeliveryService.getDeliveryRecordByOrgFlagAllCount(email,school, beginTime, endTime, offset,type);
		request.setAttribute("allCount", allCount);
		request.setAttribute("pager", pager);
		request.setAttribute("email", email);
		return "back/contentAnalysis/deliveryRecord";
	}
	
	/**
	 * 导出excel表数据
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/deliveryRecord/download" }, method = { RequestMethod.GET })
	public void downLoadDeliveryRecord(HttpServletRequest request ,HttpServletResponse response){
		Org org =(Org)request.getSession().getAttribute("org");
		String school= org.getFlag();
		String beginTime = request.getParameter("beginTime");
		String endTime = request.getParameter("endTime");
		endTime=DateUtil.handleEndTime(endTime);
		/*beginTime = DateUtil.handleBeginTime(beginTime);
		if(!school.equals("wdkj")) beginTime = beginTime.substring(0, 4) + "-01-01";*/
		if(!"wdkj".equals(school) && StringUtils.isEmpty(beginTime)) {
			beginTime = DateUtil.handleBeginTime(beginTime);
			beginTime = beginTime.substring(0, 4) + "-01-01";
		} else {
			beginTime = DateUtil.handleBeginTime(beginTime);
		}
		String type = request.getParameter("type");//数据类型（原始数据，添加数据）
		List<Map<String,Object>> list = null;
		Pager pager = docDeliveryService.getDeliveryRecord(beginTime, endTime, "-1","num_down",null,type);
		list = pager.getRows();
		
		String fileName= "全部学校文献传递统计---" + beginTime + "-" + endTime + ".xls";//创建文件名
		String path = null;
		try {
			String realPath = FileUtil.getSysUserHome(),dailyPath=FileUtil.getDailyPath();
			realPath+=dailyPath;
			FileUtil.createDir(new File(realPath));//创建目录
			path = realPath+ fileName;
			docDeliveryService.downloadRecord(list, path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BufferedInputStream bis = null;  
	    BufferedOutputStream bos = null; 
	    
        try {
        	fileName = new String(fileName.getBytes("GB2312"), "ISO_8859_1");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} 
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
	    }
	}
}
