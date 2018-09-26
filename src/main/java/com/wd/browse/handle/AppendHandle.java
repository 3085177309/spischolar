package com.wd.browse.handle;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.wd.backend.dao.ContentAnalysisDaoI;
import com.wd.backend.dao.HistoryDaoI;
import com.wd.backend.model.History;
import com.wd.browse.service.AdditionServiceI;
import com.wd.browse.service.ESSearchService;
import com.wd.browse.util.KeywordQueue;
import com.wd.browse.util.MathRandomUtil;
import com.wd.front.bo.SearchResult;
import com.wd.util.DateUtil;
import com.wd.util.MD5Util;

@Component
@Scope("prototype")
public class AppendHandle {
	
	@Autowired
	public ESSearchService searchService;
	
	@Autowired
	public AdditionServiceI additionService;
	
	@Autowired
	private HistoryDaoI historyDao;
	
	@Autowired
	private ContentAnalysisDaoI contDao;
	
	@Autowired
	KeywordQueue keywordQueue;
	
	public static String orgFlag;
	public static int memberId;
	/**文章关键词*/
	String scholarKeyWord = null;
	/**文章链接*/
	String scholarUrl = null;
	/**文章搜索页码*/
	int scholarOffset = 0;
	
	/**期刊浏览关键词*/
	String journalKeyWordC = null;
	/**期刊浏览链接*/
	String journalUrlC = null;
	/**期刊浏览搜索页码*/
	int journalOffsetC = 0;
	/**期刊学科体系*/
	String db = null;
	
	/**期刊检索关键词*/
	String journalKeyWord = null;
	/**期刊检索链接*/
	String journalUrl = null;
	/**期刊检索搜索页码*/
	int journalOffset = 0;
	/**期刊详细页面的期刊代码*/
	String jguid = null;
	/**期刊详细页面的期刊标题*/
	String journal = null;
	
	
	String[] urls = {".*/scholar",".*/journal",".*/scholar/list.*",     ".*/scholar/redirect.*",".*/scholar/journalList.*",    ".*/journal/category/list.*",".*/journal/search/list.*",".*/journal/detail.*"      ,".*/user/profile",".*/user/applyLogin",".*/user/security",".*/user/history.*",".*/user/dilivery.*",".*/user/favorite.*",".*/journal/subject/[1-6]/1/.*",".*/journal/subject/[1-6]/8/.*",".*/journal/subject/[1-6]/10/.*",".*/journal/subject/[1-6]/9/.*",".*/journal/subject/[1-6]/4/.*",".*/journal/subject/[1-6]/6/.*",".*/journal/subject/[1-6]/7/.*",".*/journal/subject/[1-6]/2/.*",".*/journal/subject/[1-6]/3/.*",".*/journal/subject/[1-6]/5/.*"};
	String[] page = {"蛛网学术搜索首页","学术期刊指南首页","蛛网学术搜索结果列表",   "学术文章详情","期刊最新文章",    "学术期刊指南浏览列表","学术期刊指南检索列表","期刊详细页面"        ,"个人基本信息","校外登录申请","重置密码","检索历史","查看文献传递记录","查看收藏记录","学科分类:SCI-E","学科分类:SSCI","学科分类:ESI","学科分类:SCOPUS","学科分类:CSCD","学科分类:CSSCI","学科分类:北大核心","学科分类:中科院JCR分区(大类)","学科分类:中科院JCR分区(小类)","学科分类:Eigenfactor"};
		
	
	public Map<String, Object> preHandle(Map<String, Object> map,String url,int time) {
		Map<String, Object> nextMap = new HashMap<String, Object>();
		String beginTime = map.get("beginTime").toString();
		String lastTime = DateUtil.getEndTime(beginTime, time);
		map.put("url", url);
		map.put("time", time);
		map.put("lastTime", lastTime);
		nextMap.put("previousPage", url);
		nextMap.put("beginTime", lastTime);
		for(int j=urls.length; j > 0; j--) {//&& !previousUrl.contains("/journal/subject/")
			if(url.matches(urls[j-1])) {
				String pageName = page[j-1];
				map.put("pageName", pageName);
				break;
			}
		}
		return nextMap;
		
	}
	
	/**
	 * 首页 ok
	 * @param map
	 * @return
	 */
	public Map<String, Object> homePage(Map<String, Object> map)  throws Exception {
		String url = "http://www.spischolar.com/";
		int time = (int) map.get("time");
//		time = (time>8)? (int)(Math.random()*8)+1 : time;
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/")) {
			rate[13] = 0.15;
		} else {
			rate[0] = 0.05;
			rate[13] = 0.1;
		}
		rate[1] = 0.05;
		rate[2] = 0.1;
		rate[3] = 0.3;
		rate[7] = 0.35;
		rate[10] = 0.02;
		rate[11] = 0.02;
		rate[12] = 0.01;
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	/**
	 * 文章首页 ok
	 * @param map
	 * @return
	 */
	public Map<String, Object> scholarPage(Map<String, Object> map)  throws Exception {
		String url = "http://www.spischolar.com/scholar";
		int time = (int) map.get("time");
//		time = (time>15)? (int)(Math.random()*15)+1 : time;
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[0] = 0.03; 
		rate[2] = 0.03; 
		rate[3] = 0.9;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	/**
	 * 期刊首页 ok
	 * @param map
	 * @return
	 */
	public Map<String, Object> journalPage(Map<String, Object> map)  throws Exception {
		String url = "http://www.spischolar.com/journal";
		int time = (int) map.get("time");
//		time =  (int)(Math.random()*2);
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[5] = 1;
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * 文章列表
	 * @param map
	 * @return
	 */
	public Map<String, Object> scholarListPage(Map<String, Object> map)  throws Exception {
		String pattern = "&offset=\\d+";
		if(scholarKeyWord != null && ((int) (Math.random()*10) < 8)) {
			//如果关键词不为空，百分之十的概率重新获取关键词
			scholarOffset = scholarOffset + 20;
			if(scholarUrl.contains("offset")) {
				scholarUrl = scholarUrl.replaceAll(pattern, "&offset="+scholarOffset);
			} else {
				scholarUrl = scholarUrl + "&offset=" + scholarOffset;
			}
		} else {//去数据库随机获取关键词
			Map<String,Object> list = keywordQueue.getScholarKeyWord();
			scholarKeyWord = list.get("keyword").toString();
			scholarUrl = "http://www.spischolar.com/scholar/list?"+list.get("url").toString().replace(pattern, "");
			scholarOffset = 0;
		}
		int time = (int) map.get("time");
//		time =  time + (int) (Math.random()*5);
		Map<String, Object> nextMap = preHandle(map,scholarUrl,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		String previousPage = map.get("previousPage").toString();
		//if(previousPage != null && previousPage.matches(".*spischolar.com/scholar")) {
			rate[0] = 0.01;
			rate[1] = 0.01;
			rate[2] = 0.02;
			rate[3] = 0.2;
			rate[4] = 0.6;
			rate[7] = 0.12;
			rate[10] = 0.01;
			rate[11] = 0.01;
			rate[12] = 0.01;
			rate[13] = 0.01;
		//} else 
		if(previousPage != null && previousPage.matches(".*spischolar.com/scholar/list.*")) {
			//连续两次列表页时，下次进详细概率增加
			rate[3] = 0.15;
//			rate[4] = 0.67;
			rate[4] = 0.75;
			rate[7] = 0.10;
		}
		addHistory(scholarKeyWord, scholarUrl.replace("http://www.spischolar.com/scholar/list?", ""), MD5Util.getMD5(scholarKeyWord.getBytes()), 1, map.get("beginTime").toString(), "search", 2,null);
		map.put("keyword", scholarKeyWord);
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 3 && type != 4) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	
	
	
	/**
	 * 文章详细
	 * @param map
	 * @return
	 */
	public Map<String, Object> scholarRedirectPage(Map<String, Object> map)  throws Exception {
		String batchId = null;
		if(scholarKeyWord != null) {
			batchId = MD5Util.getMD5(scholarKeyWord.getBytes());
		}
		String keyId = null; 	//获取文章详细
		String redirectUrl = "";
		String keyWord = scholarKeyWord;
		int count = additionService.getScholarInfoCount(batchId);
		if(count > 0) {
			Map<String,Object> list = additionService.getScholarInfo(batchId, (int) (Math.random()*count));
			redirectUrl = list.get("url").toString();
			keyWord = list.get("keyword").toString();
			keyId = MD5Util.getMD5(keyWord.getBytes());
		}
		String url = "http://www.spischolar.com/scholar/redirect/"+ keyId +"?batchId=" + batchId;
		int time = (int) map.get("time");				//随机访问时长
//		time =  time + (int) (Math.random()*25);
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[0] = 0.01;
		rate[1] = 0.05;
		rate[2] = 0.05;
		rate[3] = 0.25;
		rate[4] = 0.5;
		rate[7] = 0.1;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/scholar/redirect/.*")) {
			//如果连续两次进入文章详细，下次进文章详细概率下降
			rate[3] = 0.3;
			rate[4] = 0.45;
		}
		//获取文章详细标题keyWord需处理
		addHistory(keyWord, redirectUrl, batchId, 2, map.get("beginTime").toString(), "search", 2,null);
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 3 && type != 4) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	/**
	 * 学科分类         //年份需要处理
	 * @param map
	 * @return
	 */
	public Map<String, Object> journalSubjectPage(Map<String, Object> map)  throws Exception {
//		journalKeyWordC = null;//清空journalKeyWord
		String url = "http://www.spischolar.com/journal/subject/1/1/2015";     //年份需要处理
		int time = (int) map.get("time");
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/journal/subject/.*")) {
			int subjectName = (int) (Math.random()*6)+1;
			int subject = (int) (Math.random()*10)+1;
			url = "http://www.spischolar.com/journal/subject/"+ subjectName +"/"+subject+"/2015";
			rate[6] = 0.55;
			rate[5] = 0.2;
		} else {
			rate[6] = 0.45;
			rate[5] = 0.3;
		}
		Map<String, Object> nextMap = preHandle(map,url,time);
		rate[0] = 0.06;
		rate[1] = 0.05;
		rate[7] = 0.1;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 5) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	
	List<Map<String,Object>> journalList;
	/**
	 * 
	 * 学术期刊指南  浏览列表 ok   
	 * @param map
	 * @return
	 */
	public Map<String, Object> journalCategoryPage(Map<String, Object> map)  throws Exception {
		int time = (int) map.get("time");
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/journal/subject/.*")) {
			Map<String,Object> data =searchService.getSubject(previousPage);
			journalUrlC = data.get("url").toString();
			journalKeyWordC = data.get("name").toString();
			db = data.get("db").toString();
			journalOffsetC = 0;
		} else if(!StringUtils.isEmpty(journalUrlC)) {
			journalUrlC = journalUrlC.replace(journalOffsetC+"", (journalOffsetC+ 25)+"");
			journalOffsetC = journalOffsetC + 25;
		} else {
			Map<String,Object> data =searchService.getSubject("www.spischolar.com/journal/subject/1/1/2016");
			journalUrlC = data.get("url").toString();
			journalKeyWordC = data.get("name").toString();
			db = data.get("db").toString();
			journalOffsetC = 0;
		}
		Map<String, Object> nextMap = preHandle(map,journalUrlC,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[8] = 0.55;
		rate[7] = 0.06;
		rate[0] = 0.04;
		rate[6] = 0.2;
    	rate[2] = 0.05;
    	rate[1] = 0.03;
    	rate[3] = 0.03;
    	rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
		SearchResult journalMap = searchService.categoryJournal(journalUrlC);
		journalList = journalMap.getDatas();
		if(journalMap.getTotal()<=25) { //如果没有下一页
			rate[6] = 0;
			rate[2] = 0.25;
		}
		addHistory(journalKeyWordC, journalUrlC.replace("http://www.spischolar.com/journal/category/LIST?", ""), null, 1, map.get("beginTime").toString(), "category", 1,db);
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 6 && type != 8) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * 学术期刊指南  检索列表  
	 * @param map
	 * @return
	 */
	public Map<String, Object> journalSearchPage(Map<String, Object> map)  throws Exception {
		String pattern = "&offset=\\d+";
		if(journalKeyWord != null && ((int) (Math.random()*10) < 8)) {
			//如果关键词不为空，百分之十的概率重新获取关键词
			journalOffset = journalOffset + 20;
			if(journalUrl.contains("offset")) {
				journalUrl = journalUrl.replaceAll(pattern, "&offset="+journalOffset);
			} else {
				journalUrl = journalUrl + "&offset="+journalOffset;
			}
		} else {//去数据库随机获取关键词
			Map<String,Object> list = keywordQueue.getJournalKeyWord();
			journalKeyWord = list.get("keyword").toString();
			journalUrl = "http://spischolar.com/journal/search/list?"+list.get("url").toString().replace(pattern, "");
			journalOffset=0;
		}
		int time = (int) map.get("time");
		Map<String, Object> nextMap = preHandle(map,journalUrl,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[8] = 0.5;
		rate[7] = 0.25;
		rate[3] = 0.12;
		rate[2] = 0.05;
		rate[1] = 0.02;
		rate[0] = 0.02;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
		SearchResult journalMap = searchService.searchJournal(journalKeyWord);
		journalList = journalMap.getDatas();
		if(journalMap.getTotal()<=25) {//如果没有下一页
			rate[7] = 0;
			rate[8] = 0.65;
			rate[3] = 0.22;
		}
		addHistory(journalKeyWord, journalUrl.replace("http://spischolar.com/journal/search/list?", ""), null, 1, map.get("beginTime").toString(), "search", 1,null);
		map.put("keyword", journalKeyWord);
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 7 && type != 8) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * 期刊详细
	 * @param map
	 * @return
	 */
	public Map<String, Object> journalDetailPage(Map<String, Object> map)  throws Exception {
		Map<String, Object> journalMap = new HashMap<String, Object>();
		if(journalList != null && journalList.size() > 0) {
			journalMap = journalList.get((int) (Math.random()*journalList.size()));
			jguid = journalMap.get("_id").toString();
			journal = journalMap.get("docTitle").toString();
		}
		if(jguid == null) {
//			throw new Exception();
		}
		String url = "http://www.spischolar.com/journal/detail/" + jguid + "?batchId=";
		if(journalKeyWord != null) {
			url = url + MD5Util.getMD5(journalKeyWord.getBytes());
		} else if(journalUrl != null){
			String subject = journalUrl.substring(journalUrl.indexOf("&subject=") + 9);
			subject = subject.substring(0,subject.indexOf("&"));
			url = url + MD5Util.getMD5(subject.getBytes());
		}
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/journal/search/list.*")) {
			url = url + "&search=search";
		}
		int time = (int) map.get("time");
//		int time = (int) map.get("time") + (int) (Math.random()*15);
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[0] = 0.01;
		rate[1] = 0.05;
		rate[2] = 0.1;
		//rate[7] = 0.57;//期刊列表（需要分情况）
		if(journalKeyWord != null) {
			rate[7] = 0.57;//期刊列表（需要分情况）
		} else {
			rate[6] = 0.57;//期刊列表（需要分情况）
		}
		rate[9] = 0.28;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
		addHistory(journalKeyWord, jguid, null, 2, map.get("beginTime").toString(), null, 1,null);
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		if(type != 6 && type != 7 && type != 8) {
			clear();
		}
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * 期刊最新文章
	 * @param map
	 * @return
	 */
	public Map<String, Object> scholarJournalListPage(Map<String, Object> map)  throws Exception {
		String url = "http: //www.spischolar.com/scholar/journalList?journal=\""+ journal +"\"&oaFirst=0&sort=0&start_y=2016&end_y=2017&_id=" + jguid;
		int time = (int) map.get("time");
//		time =  time + (int) (Math.random()*15);
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[8] = 0.25;
		rate[4] = 0.2;
		if(journalKeyWord != null) {
			rate[7] = 0.17;//期刊列表（需要分情况）
		} else {
			rate[6] = 0.17;//期刊列表（需要分情况）
		}
		rate[9] = 0.11;
		rate[3] = 0.07;
		rate[0] = 0.05;
		rate[2] = 0.06;
		rate[1] = 0.05;
		rate[10] = 0.01;
		rate[11] = 0.01;
		rate[12] = 0.01;
		rate[13] = 0.01;
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * user
	 * @param map
	 * @return
	 */
	public Map<String, Object> userDiliveryPage(Map<String, Object> map,String url)  throws Exception {
		int time = (int) map.get("time");
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[10] = 0.05;
		rate[11] = 0.1;
		rate[12] = 0.1;
		rate[13] = 0.1;
		rate[0] = 0.25;
		rate[1] = 0.15;
    	rate[2] = 0.25;
//		nextMap.put("rates", rate);
    	int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * user
	 * @param map
	 * @return
	 */
	public Map<String, Object> userHistoryPage(Map<String, Object> map,String url)  throws Exception {
		int time = (int) map.get("time");
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[7] = 0.2;
		rate[3] = 0.2;
		rate[10] = 0.1;
		rate[12] = 0.1;
		rate[13] = 0.1;
		rate[11] = 0.05;
		rate[0] = 0.1;
		rate[1] = 0.07;
    	rate[2] = 0.08;
//		nextMap.put("rates", rate);
    	int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * user
	 * @param map
	 * @return
	 */
	public Map<String, Object> userFavoritePage(Map<String, Object> map,String url)  throws Exception {
		int time = (int) map.get("time");
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		String previousPage = map.get("previousPage").toString();
		if(previousPage != null && previousPage.matches(".*spischolar.com/user/favorite.*")) {
			rate[8] = 0.35;
			rate[12] = 0.1;
			rate[10] = 0.1;
			rate[11] = 0.1;
			rate[13] = 0.1;
			rate[0] = 0.1;
			rate[2] = 0.1;
			rate[1] = 0.05;
		} else {
			rate[4] = 0.2;//好像不会进
			rate[12] = 0.25;
			rate[1] = 0.1;
			rate[2] = 0.15;
			rate[0] = 0.15;
			rate[13] = 0.05;
			rate[10] = 0.05;
			rate[11] = 0.05;
		}
//		nextMap.put("rates", rate);
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	/**
	 * user账号管理
	 * @param map
	 * @return
	 */
	public Map<String, Object> userPage(Map<String, Object> map,String url)  throws Exception {
		int time = (int) map.get("time");
		Map<String, Object> nextMap = preHandle(map,url,time);
		double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
		rate[10] = 0.03;
		rate[11] = 0.04;
		rate[12] = 0.02;
		rate[0] = 0.2;
		rate[2] = 0.2;
		rate[1] = 0.1;
		if(url != null && url.matches(".*spischolar.com/user/profile.*")) {
			rate[15] = 0.01;
			rate[16] = 0.4;
		} else if(url != null && url.matches(".*spischolar.com/user/security.*")){
			rate[13] = 0.01;
			rate[16] = 0.4;
		} else {
			rate[0] = 0.14;
			rate[2] = 0.3;
			rate[1] = 0.2;
			rate[13] = 0.05;
			rate[15] = 0.01;
			rate[10] = 0.1;
			rate[11] = 0.1;
			rate[12] = 0.1;
		}
//		nextMap.put("rates", rate);
		
		int type = MathRandomUtil.percentageRandom(rate);
		nextMap.put("type", type);
		return nextMap;
	}
	
	
	private void addHistory(String keyword,String url,String batchId,Integer type, String time,String method,int systemId,String db){
		History h=new History();
		h.setMethod(method);
		if(keyword == null) {
			return ;
		} else {
			h.setKeyword(keyword);
		}
		h.setUrl(url);
		h.setBatchId(batchId);
		h.setSystemType(type);
		h.setType(1);
		h.setTime(DateUtil.toDate(time));
		h.setSystemId(systemId);
		h.setOrgFlag(orgFlag);
		h.setDb(db);
		h.setMemberId(memberId);
		contDao.insertAnalysis(h);
	}
	
	public void clear() {
		scholarKeyWord = null;
		scholarUrl = null;
		scholarOffset = 0;
		journalKeyWordC = null;
		journalUrlC = null;
		journalOffsetC = 0;
		db = null;
		journalKeyWord = null;
		journalUrl = null;
		journalOffset = 0;
		jguid = null;
		journal = null;
	}

}
