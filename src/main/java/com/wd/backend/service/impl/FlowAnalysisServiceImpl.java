package com.wd.backend.service.impl;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;
import org.apache.log4j.Logger;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.wd.backend.controller.FlowAnalysisController;
import com.wd.backend.dao.BrowseDaoI;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.model.VisitLog;
import com.wd.backend.module.es.BrowseSearchI;
import com.wd.backend.service.FlowAnalysisServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.util.CollectionsUtil;
import com.wd.util.JsonUtil;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

@Service("flowAnalysisService")
public class FlowAnalysisServiceImpl implements FlowAnalysisServiceI {
	private static final Logger log=Logger.getLogger(FlowAnalysisController.class);
	@Autowired
	private BrowseDaoI browseDao;
	
	@Autowired
	private MemberDaoI memberDao;
	@Autowired
	private OrgDaoI orgDao;
	
	@Autowired
	private BrowseSearchI browseSearch;
	
	@Override
	public List<Map<String, Object>> visite(String school, String type) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		Date date=new Date();//取时间
		Calendar cal = new GregorianCalendar();
		for(int i =0; i <= 5 ; i++) {
			cal.setTime(date);
			String endTime = null;
			String beginTime = null;
			if(i == 0) {//今天
				beginTime = df.format(cal.getTime());
			} else if(i == 1) {//昨天
				cal.add(Calendar.DATE, -1);
				endTime = df.format(cal.getTime());
				beginTime = endTime;
			} else if(i == 2) {//一周
				cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); //获取本周一的日期
				beginTime = df.format(cal.getTime());
			} else if(i == 3) {//一月
				cal.set(Calendar.DATE, cal.getActualMinimum(Calendar.DATE)); 
				beginTime = df.format(cal.getTime());
			} else if(i==4) {
				
			} 
			Map<String, Object> map = browseSearch.indexInfo(school, type, beginTime, endTime,i);
			list.add(map);
		}
		return list;
	}
	/**
	 * flowQuery图表数据
	 * @param compareSchoolName
	 * @param type
	 * @param beginTime
	 * @param endTime
	 * @param types
	 * @param compareSchool
	 * @param day
	 * @return
	 * @throws ParseException
	 */
	@Override
	public String flowQueryMapList(String[] compareSchoolName,String[] compareSchool, String type,String beginTime, String endTime,String[] types, int day) throws ParseException {
		List listValue = new ArrayList();  
		for(int i=0;i<compareSchool.length;i++) {
			Map<String, Object> map = browseSearch.flowQueryInfo(beginTime,endTime,compareSchool[i],day,types,type);
			if(compareSchool.length >1 && i==0) {
				listValue.add(map.get("dataList"));
				listValue.add(compareSchoolName);
			} else if(compareSchool.length == 1){
				listValue.add(map.get("dataList"));
				listValue.add(types);
			}
			for(int j=0;j<types.length;j++) {
				listValue.add(map.get(types[j]));
			}
			
		}
		String js = JsonUtil.obj2Json(listValue);
		return js;
	}
	/**
	 * flowQuery表格table数据
	 * @param school
	 * @param schoolName
	 * @param beginTime
	 * @param endTime
	 * @param sort
	 */
	@Override
	public List<Map<String, Object>> flowQueryTableList(String[] school,
			String[] schoolName, String beginTime, String endTime, final String sort,String type) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(int i=0;i<school.length;i++) {
			Map<String, Object> map = browseSearch.indexInfo(school[i], type, beginTime, endTime, 1);
			map.put("school", schoolName[i]);
			list.add(map);
			list = CollectionsUtil.sort(list, sort);
		}
		return list;
	}
	
	/**
	 * flowQuery导出数据
	 * @param compareSchoolName
	 * @param type
	 * @param beginTime
	 * @param endTime
	 * @param types
	 * @param compareSchool
	 * @param day
	 * @return
	 * @throws ParseException
	 */
	@Override
	public Map<String, Object> downloadFlowQuery(String[] compareSchoolName,
			String type, String beginTime, String endTime, String[] types,
			String[] compareSchool, int day) throws ParseException {
		
		Map<String, Object> maps = new LinkedMap();
		
		if(compareSchool.length == 1) {
			Map<String, Object> map = browseSearch.flowQueryInfo(beginTime,endTime,compareSchool[0],day,types,type);
			maps.put("dataList", map.get("dataList"));
			maps.put("types", types);
			for(int i=0;i<types.length;i++) {
				maps.put(types[i], map.get(types[i]));
			}
		} else {
			for(int i=0;i<compareSchool.length;i++) {
				Map<String, Object> map = browseSearch.flowQueryInfo(beginTime,endTime,compareSchool[i],day,types,type);
				if(i==0) {
					maps.put("dataList", map.get("dataList"));
					maps.put("types", compareSchoolName);
				}
				if(!map.containsKey("total")) {
					maps.put(compareSchool[i], map.get(types[0]));
				}
			}
		}
		return maps;
	}
	/**
	 * 访问历史列表
	 * @param school
	 * @param val
	 * @param ip
	 * @param refererUrl
	 * @return
	 */
	@Override
	public List<Map<String, Object>> visitHistory(String school, String val,String ip,String refererUrl,String type) {
		List<Map<String, Object>> list =browseSearch.visitHistoryInfo(school,val,ip,refererUrl,type);
		for(int i=0;i<list.size();i++) {
			Map<String, Object> map = list.get(i);
			int memberType =(int) map.get("memberType");
			if(memberType == 1 && map.containsKey("memberId")) {
				browseSearch.visitHistoryInfoById((Integer)map.get("memberId"), (String)map.get("beginTime"),map);
			} else {
				map.put("rate", 1);
				map.put("lastVisitTime", null);
			}
		}
		return list;
	}
	
	/**
	 * 创建excel表并保存
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void creat(Map<String, Object> json, String path) throws Exception {
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);
		String[] types = (String[]) json.get("types");
		List<String> dataList = (List<String>) json.get("dataList");
		List<String> pvList = (List<String>) json.get("浏览量（PV）");
		List<String> uvList = (List<String>) json.get("访客数（UV）");
		List<String> ipList = (List<String>) json.get("IP数");
		List<String> avgTimeList = (List<String>) json.get("平均访问时长");
		List<String> heightList = (List<String>) json.get("平均访问页数");
		List<String> jumpList = (List<String>) json.get("跳出率");
		int n = 0;
		for (Map.Entry<String, Object> entry : json.entrySet()) {
			if("types".equals(entry.getKey())) {
				/**	String[] typess = (String[]) entry.getValue();
				for(int i=0;i<types.length;i++) {
					Label label1 = new Label(i+1,0,types[i]);
					sheet.addCell(label1);
				}*/
			} else {
				String school = entry.getKey();
				List<Double> list = (List<Double>) entry.getValue();
				Label label = new Label(n,0,school);
				sheet.addCell(label);
				for(int i=0; i< list.size();i++) {
					Label label1 = new Label(n,i+1,list.get(i)+"");
					sheet.addCell(label1);
				}
				n++;
			}
		}
		book.write();
		book.close();
	}
	/**
	 * 创建excel表并保存（导出历史）
	 * @throws Exception
	 */
	@Override
    public void creatHistory(String school, String type, String beginTime, String endTime, String path) throws Exception {
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);
		Label label1 = new Label(0,0,"序号");
		Label label2 = new Label(1,0,"学校");
		Label label3 = new Label(2,0,"ip");
		Label label4 = new Label(3,0,"time");
		Label label5 = new Label(4,0,"url");
		sheet.addCell(label1);
		sheet.addCell(label2);
		sheet.addCell(label3);
		sheet.addCell(label4);
		sheet.addCell(label5);
		int num = 1;
		SearchResponse response =browseSearch.getvisitHistoryInfoScrollId(school,beginTime,endTime,type);
		SearchHits ite = response.getHits();
		do {
			String scrollId = response.getScrollId();
			Map<String,Object> result = null;
			for (SearchHit hit : ite) {
				Map<String, Object> map = hit.getSource();
				String schoolName = map.get("schoolName").toString();
				String ip = map.get("ip").toString();
				String lastTime = map.get("lastTime").toString();
				List<Map<String, Object>> chickpageList = (List<Map<String, Object>>) map.get("chickPageList");
				for (Map<String, Object> chickpage : chickpageList) {
					String url = chickpage.get("url").toString();
					Label label11 = new Label(0,num,num+"");
					Label label12 = new Label(1,num,schoolName);
					Label label13 = new Label(2,num,ip);
					Label label14 = new Label(3,num,lastTime);
					Label label15 = new Label(4,num,url);
					sheet.addCell(label11);
					sheet.addCell(label12);
					sheet.addCell(label13);
					sheet.addCell(label14);
					sheet.addCell(label15);
					num++;
					if(num >= 1048576) {
                        break; //Excel最大行数
                    }
				}
			}
			ite = browseSearch.getvisitHistoryInfo(scrollId);
		} while(ite.getHits().length > 0);
		book.write();
		book.close();
	}
	

	/**
	 * 查询访问报告。访问异常
	 * @return
	 */
	@Override
    public List<VisitLog> findVisitLog(String name, String remark) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		if(remark != null) {
			params.put("remark", "%"+remark+"%");
		}
		if(name != null) {
			params.put("name", "%"+name+"%");
			params.put("val", name);
		} else {
			params.put("name", name);
		}
		return browseDao.findVisitLog(params);
	}
	/**
	 * 查询访问报告总数
	 * @return
	 */
	@Override
    public int findVisitLogCount(String name, String remark) {
		Map<String,Object> params=new HashMap<String,Object>();
		if(remark != null) {
			params.put("remark", "%"+remark+"%");
		}
		if(name != null) {
			params.put("name", "%"+name+"%");
		} else {
			params.put("name", name);
		}
		return browseDao.findVisitLogCount(params);
	}
	
	/**
	 * 原始日均PV(数据管理 自动添加数据)
	 * @param orgFlag
	 * @param type
	 * @return
	 */
	@Override
    public Map<String, Object> avgPV(String orgFlag, String beginTime, String endTime) {
		if(StringUtils.isEmpty(orgFlag)) {
			orgFlag = "all";
		}
		Map<String, Object> map = browseSearch.indexInfo(orgFlag, "0", beginTime, endTime,6);
		return map;
	}
	
	
	
	
	
}
