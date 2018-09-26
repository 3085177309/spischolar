package com.wd.backend.service.impl;

import java.io.File;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.BrowseDaoI;
import com.wd.backend.dao.ContentAnalysisDaoI;
import com.wd.backend.dao.HistoryDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.model.ChickPage;
import com.wd.backend.model.History;
import com.wd.backend.model.Org;
import com.wd.backend.service.ContentAnalysisServiceI;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.browse.task.BrowseAddTask;
import com.wd.comm.Comm;
import com.wd.comm.context.SystemContext;
import com.wd.thread.BrowseHandThread;
import com.wd.thread.ContentAnalysisThread;
import com.wd.util.CollectionsUtil;
import com.wd.util.DateUtil;
import com.wd.util.JsonUtil;
@Service("contentAnalysisService")
public class ContentAnalysisServiceImpl implements ContentAnalysisServiceI {
	
	@Autowired
	private ContentAnalysisDaoI contDao;
	
	@Autowired
	private OrgDaoI orgDao;
	
	@Autowired
	private HistoryDaoI historyDao;
	
	@Autowired
	private  AdditionDaoI additionDao;

	@Autowired
	BrowseAddTask browseAddTask;
	
	
	@Override
	public List<Map<String, Object>> getAllSearchInfoCount(String school,String type,String beginTime,String endTime) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("type", Integer.parseInt(type));
		params.put("beginTime", beginTime);
		params.put("endTime", endTime);
		return contDao.getAllSearchInfoCount(params);
	}
	
	@Override
	public Pager findSearch(String beginTime,String endTime,String type, String offset,String key,String sort) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("type", Integer.parseInt(type));
		params.put("beginTime", beginTime);
		/*params.put("endTime", endTime + " 23:59:59");*/
		params.put("endTime", endTime);
		params.put("key", key);
		//取数据
		List<Map<String,Object>> list= contDao.getSearch(params);
		List<Map<String,Object>> dayNumList = contDao.getSearchDay(params);
		int total = list.size();
		for(int i=0;i<list.size();i++) {
			Map<String,Object> journalMap = list.get(i);
			String num = (String) journalMap.get("num").toString();
			String flag = (String) journalMap.get("flag");
			long dayNum=0;
			for(int j=0;j<dayNumList.size();j++) {
				if(dayNumList.get(j).get("orgFlag").equals(flag)) {
					dayNum = (Long) dayNumList.get(j).get("dayNum");
					break;
				}
			}
			float avg = (float) Float.parseFloat(num)/(float)dayNum;
			avg = (float)(Math.round(avg*100))/100;
			journalMap.put("avgPage", avg);
		}
		list = CollectionsUtil.sort(list, sort);
		//分页
		int offsets = 0;
		if(StringUtils.isNotEmpty(offset)) {
            offsets = Integer.parseInt(offset);
        }
		int size = SystemContext.getPageSize();
		if(offsets == -1) {
			list = list.subList(0, list.size());
		} else if(list.size() < offsets) {
			list = new ArrayList<Map<String,Object>>();
		} else if(list.size() > (offsets+size)) {
			list = list.subList(offsets, (offsets+size));
		} else {
			list = list.subList(offsets, list.size());
		}
		/*else {
			if(offsets == -1) {
				offsets =0;
			}
			list = list.subList(offsets, list.size());
		}*/
		Pager page = new Pager();
		page.setRows(list);
		page.setTotal(total);
		return page;
	}
	/**
	 * 期刊检索分析
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String,Object>> findSearchJournal(String school,String beginTime,String endTime,String type, String offset) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("endTime", endTime + " 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		if(offset != null) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
		}
		return contDao.findSearchJournal(params);
	}
	/**
	 * 期刊检索分析分页
	 * @return
	 */
	@Override
    public int findSearchJournalCount(String school, String beginTime, String endTime, String type){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("endTime", endTime + " 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		return contDao.findSearchJournalCount(params);
	}
	
	/**
	 * 文章检索分析
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String,Object>> findSearchScholar(String school,String beginTime,String endTime,String type, String offset) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("endTime", endTime + " 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		if(offset != null) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
		}
		return contDao.findSearchScholar(params);
	}
	/**
	 * 文章检索分析分页
	 * @return
	 */
	@Override
    public int findSearchScholarCount(String school, String beginTime, String endTime, String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("endTime", endTime + " 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		return contDao.findSearchScholarCount(params);
	}

	@Override
	public List<Map<String, Object>> getJournalAnalysis(String school,
			String beginTime, String endTime, String type,String offset,String size) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> params=new HashMap<String,Object>();
		if("".equals(school)){
			params.put("school", null);
		}else{
			params.put("school", school);
		}
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		if(offset != null) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
		}
		List<Map<String, Object>> list = contDao.getJournalAnalysis(params);
		DecimalFormat df = new DecimalFormat("0.00%");
		String num = "0"; 
		String total = "1";
		String percent = "";
		for(Map<String, Object> map:list){
			Map<String, Object> resultMap = new HashMap<String, Object>();
			num = map.get("num").toString();
			total = map.get("total").toString();
			percent = df.format(Double.parseDouble(num)/Double.parseDouble(total));
			resultMap.put("num", num);resultMap.put("percent", percent);
			resultMap.put("keyword", map.get("keyword"));
			resultList.add(resultMap);
		}
		return resultList;
	}

	@Override
	public int getJournalTotal(String school, String beginTime, String endTime,
			String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		int total = contDao.getJournalTotal(params);
		return total;
	}
	
	@Override
	public int getAllJournalTotal(String school, String beginTime, String endTime,
			String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		int total = contDao.getAllJournalTotal(params);
		return total;
	}

	@Override
	public int getSubjectTotal(String school, String beginTime, String endTime,
			String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		int total = contDao.getSubjectTotal(params);
		return total;
	}
	@Override
	public int getAllSubjectTotal(String school, String beginTime, String endTime,
			String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", school);
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		int total = contDao.getAllSubjectTotal(params);
		return total;
	}

	@Override
	public List<Map<String, Object>> getSubjectAnalysis(String school,
			String beginTime, String endTime, String type, String offset,
			String size) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> params=new HashMap<String,Object>();
		if("".equals(school)){
			params.put("school", null);
		}else{
			params.put("school", school);
		}
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		if(offset != null) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
		}
		List<Map<String, Object>> list = contDao.getSubjectAnalysis(params);
		DecimalFormat df = new DecimalFormat("0.00%");
		String num = "0"; 
		String total = "1";
		String percent = "";
		for(Map<String, Object> map:list){
			Map<String, Object> resultMap = new HashMap<String, Object>();
			num = map.get("num").toString();
			total = map.get("total").toString();
			percent = df.format(Double.parseDouble(num)/Double.parseDouble(total));
			resultMap.put("num", num);resultMap.put("percent", percent);
			resultMap.put("keyword", map.get("keyword"));
			resultList.add(resultMap);
		}
		return resultList;
	}
	@Override
	public Map<String, Object> getDbAnalysis(String school, String beginTime,
			String endTime, String type) {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		Map<String,Object> params=new HashMap<String,Object>();
		if("".equals(school)){
			params.put("school", null);
		}else{
			params.put("school", school);
		}
		params.put("beginTime", beginTime);
		/*params.put("beginTime", beginTime+" 00:00:00");
		params.put("endTime", endTime+" 23:59:59");*/
		params.put("endTime", endTime);
		params.put("type", Integer.parseInt(type));
		List<Map<String, Object>> list = contDao.getDbAnalysis(params);
		String[] db = {"SCI-E","SSCI","ESI","SCOPUS","CSCD","CSSCI","北大核心","中科院JCR分区(大类)","中科院JCR分区(小类)","Eigenfactor","EI"};
		String[] data = new String[11];
		String dbName="";
		for(Map<String, Object> map:list){
			dbName = map.get("db").toString();
			if("SCI-E".equals(dbName)){
				data[0]=map.get("num").toString();
			}
			if("SSCI".equals(dbName)){
				data[1]=map.get("num").toString();
			}
			if("ESI".equals(dbName)){
				data[2]=map.get("num").toString();
			}
			if("SCOPUS".equals(dbName)){
				data[3]=map.get("num").toString();
			}
			if("CSCD".equals(dbName)){
				data[4]=map.get("num").toString();
			}
			if("CSSCI".equals(dbName)){
				data[5]=map.get("num").toString();
			}
			if("北大核心".equals(dbName)){
				data[6]=map.get("num").toString();
			}
			if("中科院JCR分区(大类)".equals(dbName)){
				data[7]=map.get("num").toString();
			}
			if("中科院JCR分区(小类)".equals(dbName)){
				data[8]=map.get("num").toString();
			}
			if("Eigenfactor".equals(dbName)){
				data[9]=map.get("num").toString();
			}
			if("EI".equals(dbName)){
				data[10]=map.get("num").toString();
			}
		}
		int[] datas = new int[11];
		for(int i=0;i<data.length; i++){
			if(data[i]==null){
				datas[i]=0;
			} else {
				datas[i]= Integer.parseInt(data[i]);
			}
		}
		resultMap.put("db", JSONArray.fromObject(db).toString());
		resultMap.put("data", JSONArray.fromObject(datas).toString());
		return resultMap;
	}
	
	/**
	 * 创建excel表并保存(所有检索分析（根据学校）)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void creatAll(List<Map<String,Object>> list, String path) throws Exception {
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);         
		Label label0 = new Label(0,0,"序号");
		Label label1 = new Label(1,0,"学校");
		Label label2 = new Label(2,0,"总检索次数");
		Label label3 = new Label(3,0,"检索期刊（次）");
		Label label4 = new Label(4,0,"检索文章（次）");
		Label label5 = new Label(5,0,"检索量/日");
		sheet.addCell(label0);
		sheet.addCell(label1);
		sheet.addCell(label2);
		sheet.addCell(label3);
		sheet.addCell(label4);
		sheet.addCell(label5);
		for(int i=0 ; i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			Label label10 = new Label(0,i+1, (i+1)+"");
			Label label11 = new Label(1,i+1,(String) map.get("school"));
			Label label12 = new Label(2,i+1, map.get("num")+"");
			Label label13 = new Label(3,i+1, map.get("journalSearchNum")+"");
			Label label14 = new Label(4,i+1, map.get("scholarSearchNum")+"");
			Label label15 = new Label(5,i+1, map.get("avgPage")+"");
			sheet.addCell(label10);
			sheet.addCell(label11);
			sheet.addCell(label12);
			sheet.addCell(label13);
			sheet.addCell(label14);
			sheet.addCell(label15);
		}
		book.write();
		book.close();
	}
	
	/**
	 * 创建excel表并保存(!浏览学科体系)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void creat(List<Map<String,Object>> list, String path) throws Exception {
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);         
		Label label0 = new Label(0,0,"序号");
		Label label1 = new Label(1,0,"关键词");
		Label label2 = new Label(2,0,"次数");
		Label label3 = new Label(3,0,"所占百分比");
		sheet.addCell(label0);
		sheet.addCell(label1);
		sheet.addCell(label2);
		sheet.addCell(label3);
		for(int i=0 ; i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			Label label10 = new Label(0,i+1, (i+1)+"");
			Label label11 = new Label(1,i+1,(String) map.get("keyword"));
			Label label12 = new Label(2,i+1, map.get("num")+"");
			Label label13 = new Label(3,i+1, map.get("percent")+"");
			sheet.addCell(label10);
			sheet.addCell(label11);
			sheet.addCell(label12);
			sheet.addCell(label13);
		}
		book.write();
		book.close();
	}
	/**
	 * 创建excel表并保存(浏览学科体系)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	@Override
    public void creatDb(Map<String,Object> json, String path) throws Exception {
		File file = new File(path);
		WritableWorkbook book = Workbook.createWorkbook(file);
		WritableSheet sheet = book.createSheet("第一个", 0);         
		String type = (String) json.get("db");
		String[] types = type.replaceAll("\"", "").replace("[", "").replace("]", "").split(",");
		String datas = (String) json.get("data");
		String[] data = datas.replace("[", "").replace("]", "").split(",");
		Label label0 = new Label(0,0,"学科体系");
		Label label11 = new Label(0,1,"浏览量");
		sheet.addCell(label0);
		sheet.addCell(label11);
		for(int i=0; i< types.length;i++) {             //得到这些数据应该放在第几列
			Label label1 = new Label(i+1,0,types[i]);
			Label label2 = new Label(i+1,1,data[i]);
			sheet.addCell(label1);
			sheet.addCell(label2);
		}
		book.write();
		book.close();
	}
	
	/**
	 * 页面点击统计（详情）
	 * @return
	 */
	@Override
    public List<Map<String, Object>> pageClickInfo(Map<String,Object> params) {
		List<Map<String, Object>> list = contDao.getPageClickInfo(params);
		return list;
	}
	
	/**
	 * 数据添加功能（获取原始数据）
	 * @return
	 */
	@Override
	public List<Map<String,Object>> getJournalKeyWord(String orgFlag,String beginTime,String endTime,
			int type,String journalType,String size) {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("school", orgFlag);
		params.put("beginTime", beginTime);
		params.put("endTime", endTime +" 23:59:59");
		params.put("journalType", journalType);
		params.put("size", Integer.parseInt(size));
		List<Map<String,Object>> list = contDao.getMaxKeyWord(params);
		Map<String,Object> subjectMap = new HashMap<String, Object>();
		
		int otherNum = 0,otherAddNum = 0;
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			String keyword = map.get("keyword").toString();
			if(i >= Integer.parseInt(size)) {
				otherNum += Integer.parseInt(map.get("num").toString());
				otherAddNum +=  Integer.parseInt(map.get("addNum").toString());
			} else {
				params.put("keyword", keyword);
				List<Map<String,Object>> timeList = contDao.getByKeyWord(params);
				map.put("timeList", timeList);
				result.add(map);
			}
			subjectMap.put(keyword, "1");
		}
		if(Integer.parseInt(journalType) == 5) {			//浏览学科体系  没有（其他）
			for (String subject : Comm.journalSubject) {
				if(!subjectMap.containsKey(subject)) {
					Map<String,Object> map = new HashMap<String, Object>();
					map.put("keyword", subject);
					map.put("timeList", 0);
					map.put("addNum", 0);
					map.put("num", 0);
					result.add(map);
				}
			}
		} else if(list.size() > Integer.parseInt(size)){
			Map<String,Object> otherMap = new HashMap<String, Object>();		//其它
			otherMap.put("keyword", "其他");
			otherMap.put("num", otherNum);
			otherMap.put("addNum", otherAddNum);
			result.add(otherMap);
		}
		return result;
	}
	
	private ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);
	/**
	 * 数据添加功能（增加数据）
	 * @param list
	 */
	@Override
	public void addContentAnalysis(Map<String,Object> param,String username) {
		String orgFlag =param.get("orgFlag").toString();
		String orgName =param.get("orgName").toString();
		String browseHandId =param.get("browseHandId").toString();
		String[] keywords = (String[]) param.get("keywords");
		String[] addNum = (String[]) param.get("addNum");
		String[] urls = (String[]) param.get("urls");
		Integer journalType = Integer.parseInt(param.get("journalType").toString());
		for(int i=0;i<keywords.length;i++) {
			Map<String,Object> params = new HashMap<String, Object>();
			String num = addNum[i];
			params.put("keyword", keywords[i]);
			params.put("num", num);
//			params.put("browseHandId", browseHandId);
			params.put("beginTime", param.get("beginTime"));
			params.put("endTime", param.get("endTime"));
			params.put("journalType", journalType);
			if(journalType == 1) {
				params.put("url", "http://www.spischolar.com/journal/detail/" + urls[i]);
				params.put("pageName", "期刊详细");
			} else if(journalType == 2) {
				params.put("url", "http://www.spischolar.com/journal/search/list?" + urls[i]);
				params.put("pageName", "学术期刊指南  检索列表");
			} else if(journalType == 3) {
				params.put("url", "http://www.spischolar.com/scholar/list?" + urls[i]);
				params.put("pageName", "文章搜索列表");
			} else if(journalType == 4) {
				params.put("url", "http://www.spischolar.com/journal/category/list?" + urls[i]);
				params.put("pageName", "学术期刊指南  浏览列表");
			} else if(journalType == 5) {
				params.put("url", "http://www.spischolar.com/journal/category/list?queryCdt=shouLuSubjects_3_1_SCI-E%5E2016%5EAGRICULTURAL%25310ECONOMICS%25310%26%25310POLICY&viewStyle=list&authorityDb=SCI-E&subject=AGRICULTURAL+ECONOMICS+%26+POLICY&sort=11&detailYear=2016"
						.replaceAll("SCI-E", keywords[i]));
				params.put("pageName", "学科分类");
			}
			if(StringUtils.isNotEmpty(num)) {
				logBrowseAutomatic("添加", params, "期刊文章统计",orgFlag,orgName,username,browseHandId);
			}
		}
	}
//	@Override
//	public void addContentAnalysisThread(Map<String,Object> param,String username) {
//		String orgFlag =param.get("orgFlag").toString();
//		Org org = orgDao.findByFlag(orgFlag);
//		//先添加日志
//		String[] keywords = (String[]) param.get("keywords");
//		String[] addNum = (String[]) param.get("addNum");
//		String[] urls = (String[]) param.get("urls");
//		String beginTime =param.get("beginTime").toString();
//		String endTime = param.get("endTime").toString();
//		Integer journalType = Integer.parseInt(param.get("journalType").toString()) ;
//		for(int i=0;i<keywords.length;i++) {
//			Map<String,Object> params = new HashMap<String, Object>();
//			String num = addNum[i];
//			params.put("keyword", keywords[i]);
//			params.put("num", num);
//			params.put("url", urls[i]);
//			params.put("beginTime", beginTime);
//			params.put("endTime", endTime);
//			params.put("journalType", journalType);
//			if(journalType == 1) {
//				params.put("pageName", "期刊详细");
//			} else if(journalType == 2) {
//				params.put("pageName", "学术期刊指南  检索列表");
//			} else if(journalType == 3) {
//				params.put("pageName", "文章搜索列表");
//			} else if(journalType == 4) {
//				params.put("pageName", "学术期刊指南  浏览列表");
//			} else if(journalType == 5) {
//				params.put("pageName", "学科分类");
//			}
//			if(StringUtils.isNotEmpty(num)) {
//				logBrowseAutomatic("添加", params, "期刊文章统计",org.getFlag(),username);
//			}
//		}
//	/*	List<Map<String,Object>> list = chickPageList(param);
//		List<History> historyList = historyList(param);
//		for(int i=0;i<list.size();i++) {
//			Map<String,Object> chickPage = list.get(i);
//			History history = historyList.get(i);
//			Map<String,Object> params = new HashMap<String, Object>();
//			params.put("orgFlag", org.getFlag());
//			params.put("orgName", org.getName());
//			params.put("province", org.getProvince());
//			params.put("beginTime", chickPage.get("beginTime").toString());
//			int pageNum = browseAddTask.getPageNum("0.6,0.4,0,0,0,0,0,0");
//			try {
//				int memberId = browseAddTask.browseInfo(pageNum, params, true, chickPage);
//				history.setMemberId(memberId);
//				contDao.insertAnalysis(history);
//			} catch (Exception e) {
//				i--;
//				e.printStackTrace();
//			}
//		}*/
//	}
	
	private List<Map<String,Object>> chickPageList(Map<String,Object> params) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		String beginTime =params.get("beginTime").toString();
		String endTime = params.get("endTime").toString();
		String journalType = params.get("journalType").toString();
		String[] keywords = (String[]) params.get("keywords");
		String[] addNum = (String[]) params.get("addNum");
		String[] urls = (String[]) params.get("urls");
		for(int i=0;i<addNum.length;i++) {
			String num = addNum[i];
			if(!StringUtils.isEmpty(num)) {
				String keyword = keywords[i];
				String url = urls[i];
				for(int j=0;j<Integer.parseInt(num);j++) {
					String pageName;
					switch (journalType) {
					case "1":
						url = "http://www.spischolar.com/journal/detail/"+url;
						pageName = "期刊详细页面";
						break;
					case "2":
						url = "http://spischolar.com/journal/search/list"+url;
						pageName = "学术期刊指南检索列表";
						break;
					case "3":
						url = "http://www.spischolar.com/scholar/list?"+url;
						pageName = "蛛网学术搜索结果列表";
						break;
					case "4":
						url = "http://spischolar.com/journal/category/list?"+url;
						pageName = "学术期刊指南浏览列表";
						break;
					case "5":
						url = "http://spischolar.com/journal/category/list?"+url;
						pageName = "学术期刊指南浏览列表";
						break;
					default:	url = "";	pageName = "";	break;
					}
					//chickPage的开始时间
					String begin_time = DateUtil.randomDate(beginTime+" 00:00:00", endTime+" 23:59:59");
					int time = (int)(Math.random()*15)+1 ;
					String lastTime = DateUtil.getEndTime(begin_time, time);
					Map<String,Object> chickPage = new HashMap<String, Object>();
					chickPage.put("keyWord", keyword);
					chickPage.put("url", url);
					chickPage.put("pageName", pageName);
					chickPage.put("beginTime", begin_time);
					chickPage.put("previousPage", "http://www.spischolar.com");
					chickPage.put("lastTime", lastTime);
					chickPage.put("time", time);
					list.add(chickPage);
				}
			} 
		}
		return list;
	}
	private List<History> historyList(Map<String,Object> params) {
		List<History> historyList = new ArrayList<History>();
		String orgFlag =params.get("orgFlag").toString();
		String beginTime =params.get("beginTime").toString();
		String endTime = params.get("endTime").toString();
		String journalType = params.get("journalType").toString();
		String[] keywords = (String[]) params.get("keywords");
		String[] addNum = (String[]) params.get("addNum");
		String[] urls = (String[]) params.get("urls");
		for(int i=0;i<addNum.length;i++) {
			String num = addNum[i];
			if(!StringUtils.isEmpty(num)) {
				String keyword = keywords[i];
				String url = urls[i];
				for(int j=0;j<Integer.parseInt(num);j++) {
					//chickPage的开始时间
					String begin_time = DateUtil.randomDate(beginTime+" 00:00:00", endTime+" 23:59:59");
					History history = new History();
					history.setUrl(url);
					history.setKeyword(keyword);
					history.setOrgFlag(orgFlag);
					history.setType(1);
					if("1".equals(journalType)) {
						history.setSystemId(1);
						history.setSystemType(2);
					} else if("2".equals(journalType)){
						history.setSystemId(1);
						history.setSystemType(1);
						history.setMethod("search");
					} else if("3".equals(journalType)){
						history.setSystemId(2);
						history.setSystemType(1);
					} else if("4".equals(journalType)){
						history.setSystemId(1);
						history.setSystemType(1);
						history.setMethod("category");
					} else if("5".equals(journalType)){
						history.setSystemId(1);
						history.setSystemType(1);
						history.setMethod("category");
						history.setDb(keyword);  
					}
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					try {
						history.setTime(format.parse(begin_time));
					} catch (ParseException e) {
						e.printStackTrace();
					}
					historyList.add(history);
				}
			}
		}
		return historyList;
	}
	
	/**
	 * 添加日志
	 * @param state
	 * @param params
	 */
	private void logBrowseAutomatic(String state,Map<String,Object> params,String type,String orgFlag,String orgName,String username,String browseHandId) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("browseHandId", browseHandId);
		param.put("time", new Date());
		String content = JsonUtil.obj2Json(params);
		param.put("content", content);
		param.put("state", state);
		param.put("type", type);
		param.put("orgFlag", orgFlag);
		param.put("orgName", orgName);
		param.put("username", username);
		additionDao.contentAnalysisLog(param);
	}
	@Override
	public Map<String,Object> getLog(String orgFlag,String keyword) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("type", "期刊文章统计");
		param.put("orgFlag", orgFlag);
		param.put("keyword", "%"+keyword+"%");
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(param);
		if(list != null && list.size()>0) {
			return list.get(0);
		}
		return null;
	}
	@Override
	public Pager getLogList(String orgFlag,String journalType) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("type", "期刊文章统计");
		param.put("orgFlag", orgFlag);
//		param.put("journalType", "%journalType\":\""+journalType+"%");
		param.put("journalType", "%journalType\":"+journalType+"%");
		param.put("offset", SystemContext.getOffset());
		param.put("size", SystemContext.getPageSize());
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(param);
		int total = additionDao.getContentAnalysisLogCount(param);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < list.size(); i++) {
			Map<String,Object> json = list.get(i);
			String content = (String) json.get("content");
			Map<String,Object> resultMap = JsonUtil.json2Obj(content, Map.class);
			resultMap.put("time", json.get("time"));
			resultMap.put("username", json.get("username"));
			resultMap.put("browseHandId", json.get("browseHandId"));
			result.add(resultMap);
		}
		Pager pager = new Pager();
		pager.setRows(result);
		pager.setTotal(total);
		return pager;
	}
	
	
	
	
	 
}
