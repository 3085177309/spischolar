package com.wd.browse.task;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.BrowseDaoI;
import com.wd.backend.dao.ContentAnalysisDaoI;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.model.History;
import com.wd.backend.model.Org;
import com.wd.backend.service.MailService;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.browse.handle.AppendHandle;
import com.wd.browse.service.AdditionServiceI;
import com.wd.browse.util.KeywordQueue;
import com.wd.browse.util.MathRandomUtil;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.UserServiceI;
import com.wd.util.BrowseInfoUtil;
import com.wd.util.DateUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SpringContextUtil;

/**
 * 自动添加数据
 * @author Administrator
 *
 */
@Service("browseAddTask")
public class BrowseAddTask {
	
	private static final Logger log=Logger.getLogger(BrowseAddTask.class);
	
	@Autowired
	public AppendHandle appendHandle;

	@Autowired
	private OrgDaoI orgDao;
	@Autowired
	private MemberDaoI memberDao;
	
	@Autowired
	private AdditionDaoI additionDao;
	
	@Autowired
	private BrowseInfoUtil browseInfoUtil;
	
	@Autowired
	private ContentAnalysisDaoI contDao;

	@Autowired
	public AdditionServiceI additionService;
	
	@Autowired
	KeywordQueue keywordQueue;
	
	/**
	 * 定时添加数据（数据【自动】添加）
	 */
	public void execute() {
		try {
			Thread.sleep(120*1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		List<Org> list = orgDao.findAll();
		for(int i=0;i<list.size();i++) {
			Org org = list.get(i);
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orgFlag", org.getFlag());
			Map<String,Object> map = additionDao.getAddBrowseAutomaticByFlag(params);
			if(map != null) {
				map.put("province", org.getProvince());
				int pvTotal =getPvTotal(map);
				map.put("pv", pvTotal);
				params.put("pv", pvTotal);
				List<Map<String,Object>> scholarKeyWordList = additionService.getKeyWordList(org.getFlag(),2);
				List<Map<String,Object>> journalKeyWordList = additionService.getKeyWordList(org.getFlag(),1);
				keywordQueue.setScholarKeyWordList(scholarKeyWordList);
				keywordQueue.setJournalKeyWordList(journalKeyWordList);
				
				additionDao.insertCount(params);
				analysis(map,null);
				log.info("自动添加数据：" + params.get("orgFlag") + " 处理完毕");
			}
		}
	}
	
	/**
	 * 启动数据【手动】添加
	 */
	public void executeHand(int browseHandId) {
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("browseHandId", browseHandId);
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(param);
		Map<Integer,Object> scholarJournal = new HashMap<Integer, Object>();
		for (Map<String, Object> map : list) {
			String content = (String) map.get("content");
			String orgFlag = (String) map.get("orgFlag");
			Map<String,Object> resultMap = JsonUtil.json2Obj(content, Map.class);
			Integer journalType = (Integer) resultMap.get("journalType");
			resultMap.put("orgFlag", orgFlag);
			//将journalType和type对应（type是getUrl方法里的，代表一个页面）
			if(journalType == 4) {
                journalType = 6;
            }
			if(journalType == 2) {
                journalType = 7;
            }
			if(journalType == 1) {
                journalType = 8;
            }
			List<Map<String, Object>>  journalTypeList = (List<Map<String, Object>>) scholarJournal.get(journalType);
			if(journalTypeList == null) {
                journalTypeList = new ArrayList<Map<String,Object>>();
            }
			journalTypeList.add(resultMap);
			scholarJournal.put(journalType, journalTypeList);
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", browseHandId);
		Map<String,Object> map = additionDao.getAddBrowseHandById(params);
		if(map != null) {
			map.put("province", "湖南");
			analysis(map,scholarJournal);
		}
	}
	
	/**
	 * 分析（数据【自动】添加）
	 */
	public void analysis(Map<String,Object> map,Map<Integer,Object> scholarJournal) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("orgFlag", map.get("orgFlag"));
		params.put("orgName", map.get("orgName"));
		params.put("province",  map.get("province"));
		params.put("timeRatio", map.get("timeRatio"));
		params.put("newOld", map.get("newOld"));
		if(map.containsKey("beginTime") && map.containsKey("endTime")) {
			params.put("beginTime", map.get("beginTime"));
			params.put("endTime", map.get("endTime"));
		}
		int pvTotal = (int) map.get("pv");							//当天pv总数
		String pageRatio = null;
		if(map.containsKey("pageRatio")) {  //一次访问页面数量概率
			pageRatio = map.get("pageRatio").toString();
		}
		
		List<Integer> pageNumList = new ArrayList<Integer>();
		while(pvTotal > 0) {
			int pageNum = getPageNum(pageRatio);						//根据（一次）访问页面数量概率计算本次的pageNum
			if(pvTotal < pageNum) { 									//如果pv总数小于pageNum  表示数据添加即将完毕
				pageNum = pvTotal;
			}
			pageNumList.add(pageNum);
			pvTotal = pvTotal - pageNum;
		}
		Integer avgTime = (Integer) map.get("avgTime");						//平均访问时长
		float allTime = avgTime * pageNumList.size();
		
		for (int i = 0; i < pageNumList.size(); i++) {
			Integer pageNum = pageNumList.get(i);
			float pageTime = allTime/(int) map.get("pv")*pageNum;
			try {
				appendHandle.clear(); //清除上次数据记录
				if(scholarJournal == null) {					//自动添加数据
					browseInfo(pageNum, params,false,null,pageTime);	//pageNum为20实际只产生19条数据
				} else {										//手动添加数据
					browseInfoHand(pageNum, params,scholarJournal,pageTime);
				}
			} catch (Exception e) {
				i--;
				e.printStackTrace();
			}
		}
		
	}
	
	/**
	 * 生成browseInfo信息
	 * @throws Exception 
	 */
	public int browseInfo(int pageNum,Map<String,Object> params,boolean creatNew,Map<String, Object> chickPage,float pageTime) throws Exception {
		params.put("offset", (int) (Math.random()*1000));
		Map<String, Object> data = getBrowseInfo(params, creatNew, chickPage);

		AppendHandle.orgFlag = params.get("orgFlag").toString();
		AppendHandle.memberId = (int) data.get("memberId");
		List<Integer> timeList = MathRandomUtil.spiltRedPackets((int)pageTime,pageNum);

		List<Map<String, Object>> list = (List<Map<String, Object>>) data.get("chickPageList");
		for(int i=0; i<pageNum; i++) {
			list.get(i).put("time", timeList.get(i));
			Map<String, Object> map = getUrl(list.get(i));//下一页
			if(pageNum != 1 && i < pageNum - 1) {
				list.add(map);
			}
			data.put("lastTime", list.get(i).get("lastTime"));
			int type = (int) map.get("type");
			if(type == 13 || type == 14 ||type == 15 ||type == 16) {
                data.put("register", true);
            }
		}
		data.put("pageNum", list.size());
		log.info("pageNum:" + pageNum + "  list.size():" +list.size());
		int time = DateUtil.getTimeNum(data.get("lastTime").toString(), data.get("beginTime").toString());
		data.put("time", time);
//		try {
			BrowseInfoUtil.insert(data);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		int memberId = (int) data.get("memberId");
		return memberId;
	}
	
	/**
	 * 生成browseInfo信息
	 * @throws Exception 
	 */
	public int browseInfoHand(int pageNum,Map<String,Object> params,Map<Integer,Object> scholarJournal,float pageTime) throws Exception {
		//获取要添加的期刊文章查询信息
		params.put("offset", (int) (Math.random()*1000));
		//创建一个会话
		Map<String, Object> data = getBrowseInfo(params, true, null);
		int memberId = (int) data.get("memberId");
		AppendHandle.orgFlag = params.get("orgFlag").toString();
		AppendHandle.memberId = memberId;
		//创建浏览记录
		List<Map<String, Object>> chickPageList = new ArrayList<Map<String,Object>>();
		//每页访问时间
		List<Integer> timeList = MathRandomUtil.spiltRedPackets((int)pageTime,pageNum);
		String beginTime = (String) data.get("beginTime");			//浏览页面开始时间
		String previousPage = "首页";
		double[] rate = {0.75,0,0,0.25};
		int journalType = MathRandomUtil.percentageRandom(rate);
		for (int i = pageNum; i > 0; i--) {
			Map<String, Object> chickPage = new HashMap<String, Object>();
			chickPage.put("beginTime", beginTime);
			Integer time = timeList.get(i-1); 						//浏览页面时长
			chickPage.put("time", time);
			chickPage.put("previousPage", previousPage);
			if(scholarJournal != null && !scholarJournal.isEmpty()) {								//优先跑需要添加的文章期刊数据
				journalType = getUrlByHand(scholarJournal, chickPage, journalType,memberId);
				if(!chickPage.containsKey("url")) {
					System.out.println(chickPage);
					chickPage.put("type", journalType);
					Map<String, Object> nextMap = getUrl(chickPage);
					journalType = (int) nextMap.get("type");
				} else {
					chickPage.put("lastTime", DateUtil.getEndTime(beginTime, time));
				}
			} else {													//全部跑非文章期刊数据
				if(journalType == 3 || journalType == 4 || journalType== 5 || journalType== 6|| journalType == 7 || journalType ==8 || journalType==9) {
					rate = new double[]{0.1,0.1,0.1,0,0,0,0,0,0,0,0.1,0.1,0.1,0.1,0.1,0.1,0.1};
					journalType = MathRandomUtil.percentageRandom(rate);
				}
				chickPage.put("type", journalType);
				Map<String, Object> nextMap = getUrl(chickPage);
				journalType = (int) nextMap.get("type");
			}
			chickPageList.add(chickPage);
			beginTime = (String) chickPage.get("lastTime");
			previousPage = (String) chickPage.get("url");
			data.put("lastTime", chickPage.get("lastTime"));
		}
		data.put("chickPageList", chickPageList);
		data.put("pageNum", chickPageList.size());
		log.info("pageNum:" + pageNum + "  list.size():" +chickPageList.size());
//		try {
			int time = DateUtil.getTimeNum(data.get("lastTime").toString(), data.get("beginTime").toString());
			if(DateUtil.getTimeNum(params.get("endTime").toString().substring(0,10)+" 23:59:59", "2017-01-02 00:01:02") < 0) {
				log.info("制造数据时出现结束时间超出范围的，忽略跳过！");
				throw new Exception();
			}
			data.put("time", time);
			BrowseInfoUtil.insert(data);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return memberId;
	}
	
	/**
	 * 得到下一步的URL
	 */
	public Map<String, Object> getUrl(Map<String, Object> map) throws Exception {
		int type = (int) map.remove("type");
		String url = null;
		double[] rate = new double[16];
		Map<String, Object> nextMap = new HashMap<String, Object>();
		switch(type){
        default:
        	nextMap = appendHandle.homePage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 1: //文章
        	nextMap = appendHandle.scholarPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
        	break;
        case 2://期刊
        	nextMap = appendHandle.journalPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 3: //文章搜索列表
        	nextMap = appendHandle.scholarListPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 4: //文章详细
        	nextMap = appendHandle.scholarRedirectPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 5: //学科分类
        	nextMap = appendHandle.journalSubjectPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 6: //学术期刊指南  浏览列表
        	nextMap = appendHandle.journalCategoryPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
        	break;
        case 7: //学术期刊指南  检索列表
        	nextMap = appendHandle.journalSearchPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 8: //期刊详细
        	nextMap = appendHandle.journalDetailPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 9: //期刊最新文章
        	nextMap = appendHandle.scholarJournalListPage(map);
//        	rate =  (double[]) nextMap.remove("rates");
        	break;
        case 10: //文献传递
        	url = "http://www.spischolar.com/user/dilivery";
        	nextMap = appendHandle.userDiliveryPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 11: //检索历史
        	url = "http://www.spischolar.com/user/history";
        	nextMap = appendHandle.userHistoryPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 12: //我的收藏
        	url = "http://www.spischolar.com/user/favorite";
        	nextMap = appendHandle.userFavoritePage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 13: //基本信息
        	url = "http://www.spischolar.com/user/profile";
        	nextMap = appendHandle.userPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 14: //头像设置
        	url = "http://www.spischolar.com/user/avatar";
        	nextMap = appendHandle.userPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 15: //账户安全
        	url = "http://www.spischolar.com/user/security";
        	nextMap = appendHandle.userPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
        case 16: //校外登陆申请
        	url = "http://www.spischolar.com/user/applyLogin";
        	nextMap = appendHandle.userPage(map,url);
//        	rate =  (double[]) nextMap.remove("rates");
            break;
		}
//		type = MathRandomUtil.percentageRandom(rate);
//		nextMap.put("type", type);
		return nextMap;
	}
	
	@Autowired
	private BrowseDaoI browseDao;
	
	/**
	 * 创建BrowseInfo
	 * @param params
	 * @param creatNew
	 * @return
	 */
	public Map<String,Object> getBrowseInfo(Map<String,Object> params,boolean creatNew,Map<String, Object> chickPage) {
		Map<String,Object> browseInfoMap = null;
		if(!creatNew) {
			browseInfoMap = browseDao.findBrowse(params);
		}
		if(browseInfoMap == null) {  //创建一次访问的基本信息
			browseInfoMap = new HashMap<String, Object>();
			browseInfoMap.put("refererUrl", "http://www.spischolar.com");
			browseInfoMap.put("refererOrg", "直接访问");
			browseInfoMap.put("userBrowser", "谷歌");
			browseInfoMap.put("win", "WinNT");
		}
		getMemberInfo(browseInfoMap, params);
		browseInfoMap.put("register", false);
		browseInfoMap.put("schoolFlag", params.get("orgFlag").toString());
		browseInfoMap.put("schoolName", params.get("orgName").toString());
		browseInfoMap.put("schoolProvince", params.get("province").toString());
		int newOld = (int) params.get("newOld");
		int memberType = MathRandomUtil.percentageRandomByString(newOld + "," + (100-newOld));
		browseInfoMap.put("memberType", memberType);//新老客户比例（未计算）
		
		String beginTime = null;
		if(params.containsKey("beginTime") && params.containsKey("endTime")) {
			beginTime = DateUtil.randomDate(params.get("beginTime").toString().substring(0,10)+" 00:00:00", params.get("endTime").toString().substring(0,10)+" 23:59:59");
		} else if(!params.containsKey("timeRatio") && params.containsKey("beginTime")) {
			beginTime = params.get("beginTime").toString();
		} /*else {
			String timeRatio = params.get("timeRatio").toString();
			int time = MathRandomUtil.percentageRandomByString(timeRatio);//根据概率得到第几点钟
			beginTime = DateUtil.randomDate(time);	
		}*/
		if(params.containsKey("timeRatio")) {
			String timeRatio = params.get("timeRatio").toString();
			int time = MathRandomUtil.percentageRandomByString(timeRatio);//根据概率得到第几点钟
			String hourTime = DateUtil.randomDate(time);
			if(beginTime != null) {
				beginTime = beginTime.substring(0, 10) + hourTime.substring(10, hourTime.length());
			} else {
				beginTime = hourTime;
			}
		}
		
		List<Map<String, Object>> list = chickPageList(browseInfoMap.get("refererUrl").toString(),beginTime,chickPage);
		browseInfoMap.put("chickPageList", list);
		browseInfoMap.put("beginTime", beginTime);
		browseInfoMap.put("type", 1);
		return browseInfoMap;
	}
	/**
	 * 创建chickPageList
	 */
	public List<Map<String, Object>> chickPageList(String refererUrl,String beginTime,Map<String, Object> chickPage) {
		Map<String, Object> fristPage = new HashMap<String, Object>();//第一页
		double[] rate = {0.75,0,0,0.25};
		int type = MathRandomUtil.percentageRandom(rate);
		fristPage.put("previousPage", refererUrl);
		fristPage.put("type", type);
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		if(chickPage != null) {
			fristPage.put("beginTime", chickPage.get("lastTime"));
			list.add(chickPage);
		} else {
			fristPage.put("beginTime", beginTime);
		}
		list.add(fristPage);
		return list;
	}
	
	
	/**
	 * 自动添加数据计算随机pv值
	 * @param map
	 * @return
	 */
	public int getPvTotal(Map<String,Object> map) {
		int pvTotal = 0;							//当天pv总数
		float pvRatio = (float) map.get("pvRatio");
		int minPv = (int) map.get("minPv");
		int maxPv = (int) map.get("maxPv");
		String monthRatio = map.get("monthRatio").toString();
		String[] monthRatios = monthRatio.split(",");
		int month = DateUtil.getNowMonth()-1;
		if(Integer.parseInt(monthRatios[month]) != 100) {
			pvTotal = MathRandomUtil.randomRange(maxPv, minPv);
			pvTotal = pvTotal*Integer.parseInt(monthRatios[month])/100;
			return pvTotal;
		}
		if(pvRatio > Math.random()) { 				//波动概率(在基本范围到)
			int minPvWave = (int) map.get("minPvWave");
			int maxPvWave = (int) map.get("maxPvWave");
			if(Math.random() > 0.5) {				//波动最大
				pvTotal = MathRandomUtil.randomRange(maxPvWave, maxPv);
			} else {								//波动最小
				pvTotal = MathRandomUtil.randomRange(minPv, minPvWave);
			}
		} else {
			pvTotal = MathRandomUtil.randomRange(maxPv, minPv);
		}
		return pvTotal;
	}
	/**
	 * 本次添加数据的pageNum数
	 * @param pageRatio
	 * @return
	 */
	public int getPageNum(String pageRatio) {
		if(pageRatio == null) {
			pageRatio = "0,25,50,25";
		}
		int pageTypeNum = MathRandomUtil.percentageRandomByString(pageRatio);//得到第pageTypeNum级页面
		return getPageNum(pageTypeNum);
	}
	/**
	 * 得到一次访问的具体页数
	 * @param pageTypeNum
	 * @return
	 */
	public int getPageNum(int pageTypeNum) {
		int pageNum=0;
		switch (pageTypeNum) {
		case 0:
			pageNum = 1;
			break;
		case 1:
			pageNum = MathRandomUtil.randomRange(10, 2);
			break;
		case 2:
			pageNum = MathRandomUtil.randomRange(20, 11);
			break;
		default:
			pageNum = MathRandomUtil.randomRange(30, 21);
			break;
		}
		return pageNum;
	}
	
	/**
	 * 获取memberId和ip
	 * @param browseInfoMap
	 */
	public void getMemberInfo(Map<String,Object> browseInfoMap,Map<String,Object> params) {
		List<Map<String,Object>> memberList = memberDao.findTourist(params);
		if(memberList != null && memberList.size()>0) {
			Map<String,Object> touristMap = memberList.get((int) (Math.random()*memberList.size()));
			browseInfoMap.put("memberId", touristMap.get("id"));
			browseInfoMap.put("ip", touristMap.get("ip"));
		} else {
			browseInfoMap.put("memberId", 0);
			browseInfoMap.put("ip", "192.168.1.1");
		}
	}
	
	//页面详细没有记录《浏览学科体系》，直接算作《学术期刊指南首页》
	String[] journalPage = {"学术期刊指南首页","期刊详细页面","学术期刊指南检索列表","蛛网学术搜索结果列表","学术期刊指南浏览列表","学科分类"};
	
	//journal不为0
	public int getUrlByHand(Map<Integer,Object> scholarJournal,Map<String, Object> chickPage,Integer journalType,int memberId) {
		if(scholarJournal.containsKey(journalType)) {
		} else {
			for (Integer key : scholarJournal.keySet()) {
				journalType = key;
			}
		}
		int journalTypeKey = journalType;
		List<Map<String, Object>>  journalTypeList = (List<Map<String, Object>>) scholarJournal.get(journalType);
		History history = new History();
		for (Map<String, Object> resultMap : journalTypeList) {
			String orgFlag = (String) resultMap.get("orgFlag");
			String keyword = (String) resultMap.get("keyword");
			String url = (String) resultMap.get("url");
			String pageName = (String) resultMap.get("pageName");
			Integer num = Integer.parseInt(resultMap.get("num").toString());
			if(num > 0) {
				chickPage.put("keyword", keyword);
				chickPage.put("url", url);
				chickPage.put("pageName", pageName);
				num--;
				resultMap.put("num", num);
				double[] rate = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
				if(journalType == 3) {
					rate[3] = 0.45;
					rate[4] = 0.45;
					rate[7] = 0.10;
					history.setSystemId(2);
					history.setSystemType(1);
				} else if(journalType == 5) {
					rate[5] = 0.3;
					rate[6] = 0.45;
					rate[7] = 0.25;
					history.setSystemId(1);
					history.setSystemType(1);
					history.setMethod("category");
					history.setDb(keyword);  
				} else if(journalType == 6) {
					rate[5] = 0.05;
					rate[6] = 0.25;
					rate[8] = 0.55;
					rate[7] = 0.05;
			    	rate[3] = 0.1;
			    	history.setSystemId(1);
					history.setSystemType(1);
					history.setMethod("category");
				} else if(journalType == 7) {
					rate[5] = 0.1;
					rate[7] = 0.25;
					rate[8] = 0.55;
			    	rate[3] = 0.1;
			    	history.setSystemId(1);
					history.setSystemType(1);
					history.setMethod("search");
				} else if(journalType == 8) {
					rate[0] = 0.05;
					rate[3] = 0.02;
					rate[5] = 0.1;
					rate[7] = 0.25;
					rate[8] = 0.3;
			    	rate[9] = 0.28;
			    	history.setSystemId(1);
					history.setSystemType(2);
				}
				journalType= MathRandomUtil.percentageRandom(rate);
				history.setTime(DateUtil.toDate(chickPage.get("beginTime").toString()));
				history.setUrl(url);
				history.setKeyword(keyword);
				history.setOrgFlag(orgFlag);
				history.setType(1);
				history.setMemberId(memberId);
				contDao.insertAnalysis(history);
//				break;
			}
			if(num <=0 ) {
				journalTypeList.remove(resultMap);
			}
			if(journalTypeList.size() == 0) {
				scholarJournal.remove(journalTypeKey);
			}
			break;
		}
		if(scholarJournal.containsKey(journalType)) {
			return journalType;
		} else {
			for (Integer key : scholarJournal.keySet()) {
				journalType = key;
			}
		}
		return journalType;
	}
	
}
