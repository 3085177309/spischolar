package com.wd.service.impl;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jws.WebParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.wd.backend.dao.AuthorityDatabaseDaoI;
import com.wd.backend.dao.CategorydataDaoI;
import com.wd.backend.dao.DisciplineSystemDaoI;
import com.wd.backend.model.Categorydata;
import com.wd.backend.model.JournalUrl;
import com.wd.comm.context.SystemContext;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.bo.UniqueList;
import com.wd.front.context.SearchServiceContext;
import com.wd.front.service.DetailServiceI;
import com.wd.front.service.JournalLinkServiceI;
import com.wd.front.service.SearchApiServiceI;
import com.wd.front.service.SearchServiceI;
import com.wd.service.WSSearchService;
import com.wd.service.connect.SearchConnectI;
import com.wd.util.JsonUtil;
import com.wd.util.SpringContextUtil;

/**
 * 期刊查询接口实现
 * @author Shenfu
 *
 */
public class WSSearchServiceImpl implements WSSearchService{
	
	@Autowired
	private SearchServiceContext searchServiceContext;
	
	@Autowired
	private JournalLinkServiceI journalLinkService;
	
	@Autowired
	private DetailServiceI detailService;
	
	@Autowired
	private SearchApiServiceI searchAPIService;
	
	@Value("${cloud_server_adress}")
	private String cloudServerAdress;
	
	@Override
	public String searchById(String id) {
		String url = cloudServerAdress + "/search-server/detail/" + id;
		String result=searchAPIService.searchBywfw(url,new SearchCondition());
		return result;
	}
	
	@Override
	public String searchMore(String requestParam) {
		try{
			SearchServiceI searchService = searchServiceContext.findSearchServiceImpl("journal_search");
			Element root=parseParam(requestParam);
			//检索
			long start = System.currentTimeMillis();
			
			SearchResult searchResult = null;
			List<Categorydata> list = null;
			//moreVal
			String moreVal = "";
			Node fieldNode = root.selectSingleNode("/params/moreVal");
			if (null != fieldNode) {
				moreVal = fieldNode.getText().trim();
			}
			String[] val= moreVal.split(";");
			List<SearchResult> resultList = new ArrayList<SearchResult>();
			for (int j=0;j<val.length;j++) {
				SearchCondition condition = new SearchCondition();
				condition.setValue(val[j]);
				condition.setField("all");
				condition.setSort(0);
//				searchResult = searchService.search(condition);
				
				String url = cloudServerAdress + "/search-server/search/list";
				String result = searchAPIService.searchBywfw(url,condition);
				searchResult = JsonUtil.json2Obj(result, SearchResult.class);
				
				if(searchResult.getDatas().size() == 1) {//如果只有一条数据，就去数据库获取详细信息
					list = searchService.find(condition.getValue());
					List<Categorydata> list1 = new ArrayList<Categorydata>();
					List<Categorydata> list2 = new ArrayList<Categorydata>();
					for(int i = 0; i<list.size(); i++) {
						if(list.get(i).getCategorySystem().contains("中科院JCR")) {
							list2.add(list.get(i));
						} else {
							list1.add(list.get(i));
						}
					}
					searchResult.setInfo(list1);
					searchResult.setZkyInfo(list2);
				}
				searchResult.setDatas(null);
				resultList.add(searchResult);
			}
			String result=JsonUtil.obj2Json(resultList);
			long end = System.currentTimeMillis();
			System.out.println(end -start);
			System.out.println(result);
			return result;
		} catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public String search(@WebParam(name = "param") String requestParam){
		try{
			SearchServiceI searchService = searchServiceContext.findSearchServiceImpl("journal_search");
			Element root=parseParam(requestParam);
			//检索
			long start = System.currentTimeMillis();
			SearchCondition condition = buildCondition(root);
			SearchResult searchResult = null;
			List<Categorydata> list = null;
			if("id".equals(condition.getField())) {
				searchResult = new SearchResult();
				list = searchService.find(condition.getValue());
				if(list.size() != 0) {
					List<Categorydata> list1 = new ArrayList<Categorydata>();
					List<Categorydata> list2 = new ArrayList<Categorydata>();
					for(int i = 0; i<list.size(); i++) {
						if(list.get(i).getCategorySystem().contains("中科院JCR")) {
							list2.add(list.get(i));
						} else {
							list1.add(list.get(i));
						}
					}
					searchResult.setInfo(list1);
					searchResult.setZkyInfo(list2);
				}
			} else {
//				searchResult = searchService.search(condition);
				String url = cloudServerAdress + "/search-server/search/list";
				String result = searchAPIService.searchBywfw(url,condition);
				searchResult = JsonUtil.json2Obj(result, SearchResult.class);
				
				List<Map<String,Object>> listDatas=searchResult.getDatas();
				List<Map<String,Object>> datasList = new ArrayList<Map<String,Object>>();
				for(Map<String,Object> mapDatas : listDatas){
					String jGuid = (String) mapDatas.get("_id");
					JournalUrl mainLink = journalLinkService.searchMainLink(jGuid);
					if(mainLink!=null){
						mapDatas.put("mainLink", mainLink.getTitleUrl());
					}else{
						mapDatas.put("mainLink","");
					}
					if(mapDatas.containsKey("issn")) {
						String issn = mapDatas.get("issn").toString();
						if(issn.length()>9) {
							issn = issn.substring(0,9);
							mapDatas.put("issn", issn);
						}
					}
					datasList.add(mapDatas);
				}
				searchResult.setDatas(datasList);
				
				if(searchResult.getDatas().size() == 1) {//如果只有一条数据，就去数据库获取详细信息
					list = searchService.find(condition.getValue());
					List<Categorydata> list1 = new ArrayList<Categorydata>();
					List<Categorydata> list2 = new ArrayList<Categorydata>();
					for(int i = 0; i<list.size(); i++) {
						if(list.get(i).getCategorySystem().contains("中科院JCR")) {
							list2.add(list.get(i));
						} else {
							list1.add(list.get(i));
						}
					}
					searchResult.setInfo(list1);
					searchResult.setZkyInfo(list2);
				}
			}
			
			long end = System.currentTimeMillis();
			searchResult.setTime(end-start);
			String result=JSONObject.fromObject(searchResult).toString();
			return result;
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public String articleSearch(String requestParam) {
		try{
			SearchConnectI searchForWebService = (SearchConnectI) SpringContextUtil.getBean("searchConnect");
			return searchForWebService.executeSearch(requestParam);
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 解析查询请求
	 * @param requestParam
	 * @return
	 * @throws DocumentException
	 */
	private Element parseParam(String requestParam)throws DocumentException{
		SAXReader saxReader = new SAXReader();
		Document document = saxReader.read(new StringReader(requestParam));
		Element root = document.getRootElement();
		return root;
	}
	
	/**
	 * 构建查询请求
	 * @param node
	 * @return
	 */
	//shouLuSubjects_3_1_SCI-E^2013^ACOUSTICS
	//partition_3_1_SCI-E^2013^ACOUSTICS^1
	private String buildSubjectCdt(Node node){
		String name=getStringByPath(node,"name"),value=getStringByPath(node,"value"),
				year=getStringByPath(node,"year"),partition=getStringByPath(node,"partition");
		String queryCdt="";
		if(StringUtils.isEmpty(name)){
			return queryCdt;
		}
		if(StringUtils.isEmpty(partition)){
			queryCdt="shouLuSubjects_4_1_"+name;
			if(!StringUtils.isEmpty(year)){
				queryCdt+="^"+year;
			}
			if(!StringUtils.isEmpty(value)){
				queryCdt+="^"+value;
			}
		}else{
			queryCdt="partition_4_1_"+name;
			if(!StringUtils.isEmpty(year)){
				queryCdt+="^"+year;
			}
			if(!StringUtils.isEmpty(value)){
				queryCdt+="^"+value;
			}
			if(!StringUtils.isEmpty(partition)){
				queryCdt+="^"+partition;
			}
		}
		return queryCdt;
	}
	
	/**
	 * 构建查询请求
	 * @param root
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private SearchCondition buildCondition(Element root) {
		SearchCondition condition=new SearchCondition();
		UniqueList queryCdt=new UniqueList();
		UniqueList filterCdt=new UniqueList();
		//Subject
		List subjectNodes = root.selectNodes("/params/subjects/subject");
		for(int i=0;i<subjectNodes.size();i++){
			Node subjectNode=(Node)subjectNodes.get(i);
			String subjectCdt=buildSubjectCdt(subjectNode);
			if(!StringUtils.isEmpty(subjectCdt)){
				queryCdt.add(subjectCdt);
			}
		}
		
		//Field
		String field = "all";
		Node fieldNode = root.selectSingleNode("/params/field");
		if (null != fieldNode) {
			field = fieldNode.getText().trim();
		}
		condition.setField(field);
		//Value
		String value=null;
		Node valueNode=root.selectSingleNode("/params/value");
		if(null!=valueNode){
			value=valueNode.getText().trim();
		}
		condition.setValue(value);
		//shoulu 收录
		Node shouluNode=root.selectSingleNode("/params/shoulu");
		String shoulu=getString(shouluNode);
		if(!StringUtils.isEmpty(shoulu)){
			String[] items=shoulu.split(";");
			for(String str:items){
				filterCdt.add("auDB_3_1_"+str);
			}
		}
		
		//Sort
		Node sortNode=root.selectSingleNode("/params/order");
		Integer sort=getInt(sortNode,0);
		condition.setSort(sort);
		
		Node yearNode=root.selectSingleNode("/params/year");
		Integer year=getInt(yearNode,0);
		condition.setDetailYear(year);
		
		Node orderValueNode=root.selectSingleNode("/params/orderValue");
		if(null!=orderValueNode){
			String orderValue=orderValueNode.getText().trim();
			condition.setSortField(orderValue);
		}
		
		//Lang
		Node langNode=root.selectSingleNode("/params/lang");
		Integer lang=getInt(langNode,0);
		if(lang>0){
			queryCdt.add("lan_3_1_"+lang);
		}
		
		//letter
		Node letterNode=root.selectSingleNode("/params/firstLetter");
		String letter=getString(letterNode);
		if(!StringUtils.isEmpty(letter)){
			queryCdt.add("firstLetter_3_1_"+letter.toLowerCase());
		}
		
		//isoa  --?
		Node oaNode=root.selectSingleNode("/params/isoa");
		Integer isoa=getInt(oaNode,-1);
		if(isoa==1){
			filterCdt.add("oa_3_1_1");
		}
		
		//Size
		Node sizeNode=root.selectSingleNode("/params/size");
		Integer size=getInt(sizeNode,25);
		SystemContext.setPageSize(size);
		
		//Offset
		Node offsetNode=root.selectSingleNode("/params/offset");
		Integer offset=getInt(offsetNode,0);
		SystemContext.setOffset(offset);
		
		Node idNode=root.selectSingleNode("/params/id");
		if(null!=idNode){
			String idValue=idNode.getText().trim();
			condition.setId(idValue);
		}
		
		
		condition.setFilterCdt(filterCdt);
		condition.setQueryCdt(queryCdt);
		return condition;
	}
	
	private static Integer getInt(final Node node,int defaultValue){
		if(node!=null){
			String value=node.getText();
			if(!StringUtils.isEmpty(value)&&value.trim().matches("\\d+")){
				return Integer.parseInt(value.trim());
			}
		}
		return defaultValue;
	}
	
	private static String getString(final Node node){
		return getString(node,null);
	}
	
	private static String getStringByPath(final Node node,String path){
		Node subNode=node.selectSingleNode(path);
		return getString(subNode,null);
	}
	
	private static String getString(final Node node,String defaultValue){
		if(node!=null){
			String value=node.getText();
			return value.trim();
		}
		return defaultValue;
	}
	
	@Autowired
	private AuthorityDatabaseDaoI authorityDatabaseDao;
	
	@Autowired
	private CategorydataDaoI categorydataDao;

	@Override
	public String getSystems() {
		try{
			return JSONArray.fromObject(authorityDatabaseDao.findAll()).toString();
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	@Autowired
	private DisciplineSystemDaoI disciplineSystemDao;

	@Override
	public String getSubjects(String requestParam) {
		try{
			Map<String,Object> params=new HashMap<String,Object>();
			Element root=parseParam(requestParam);
			Node nameNode=root.selectSingleNode("/params/name");
			String name=getString(nameNode);
			params.put("authoDB", name);
			Node yearNode=root.selectSingleNode("/params/year");
			String year=getString(yearNode);
			params.put("year", year);
			return JSONArray.fromObject(disciplineSystemDao.findByYear(params)).toString();
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}

	@Override
	public String getLinks(String flag) {
		List<JournalUrl> list = journalLinkService.searchDbLinks(flag);
		JournalUrl mainLink = journalLinkService.searchMainLink(flag);
		Map<String,Object> links=new HashMap<String,Object>();
		links.put("homepage", mainLink);
		links.put("urls", list);
		return JSONObject.fromObject(links).toString();
	}

	
	@Override
	public String searchForZHY(@WebParam(name = "param") String requestParam){
		try{
			SearchServiceI searchService = searchServiceContext.findSearchServiceImpl("journal_search");
			Element roots=parseParam(requestParam);
			//检索
			long start = System.currentTimeMillis();
			List<Element> datas = roots.elements("params");
			Map<String,Object> map = new HashMap<String, Object>();
			for(Element data : datas) {
				List<String> resultList = new ArrayList<String>();
				Element root=parseParam(data.asXML());
				SearchCondition condition = buildCondition(root);
				String value = condition.getValue();
				//获取最新的issn
				String newIssn = categorydataDao.findNewISSN(value);
				if(newIssn != null) {
					condition.setValue(newIssn);
				}
				SystemContext.setPageSize(1);//只取一条
				SearchResult searchResult = null;
//				searchResult = searchService.search(condition);
				String url = cloudServerAdress + "/search-server/search/list";
				String result = searchAPIService.searchBywfw(url,condition);
				searchResult = JsonUtil.json2Obj(result, SearchResult.class);
				
				
				
				List<Map<String,Object>> listDatas=searchResult.getDatas();
				if(listDatas == null || listDatas.size() == 0) {
                    continue;
                }
				Map<String,Object> dataMap = listDatas.get(0);
				if(dataMap != null && dataMap.containsKey("shouLu")) {
					List<Map<String,Object>> shoulu = (List<Map<String, Object>>) dataMap.get("shouLu");
					for (Map<String, Object> shouluMap : shoulu) {
						String authorityDatabase = shouluMap.get("authorityDatabase").toString();
						if("SCI-E".equals(authorityDatabase) || "中科院JCR分区(小类)".equals(authorityDatabase) || "中科院JCR分区(大类)".equals(authorityDatabase)){
							List<Map<String,Object>> detailList = (List<Map<String, Object>>) shouluMap.get("detailList");
							for (Map<String, Object> detailMap : detailList) {
								String detail = detailMap.get("detail").toString();
								resultList.add(detail);
							}
						}
					}
					String issn = "" , title = "";
					if(dataMap.containsKey("issn")) {
                        issn = dataMap.get("issn").toString();
                    }
					if(dataMap.containsKey("docTitle")) {
                        title = dataMap.get("docTitle").toString();
                    }
					//注condition.getValue()如果是issn，会替换成最新的issn（jbase更名记录）
					if(condition.getValue().equals(issn) || condition.getValue().toLowerCase().equals(title.toLowerCase())) {
						map.put(value, resultList);//必须返回传递的issn不能返回最新的issn
					}
				}
			}
			long end = System.currentTimeMillis();
			System.out.println(end-start);
			String result=JSONObject.fromObject(map).toString();
			return result;
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
	
	@Override
	public String find(String requestParam) {
		try{
			SearchServiceI searchService = searchServiceContext.findSearchServiceImpl("journal_search");
			Element root=parseParam(requestParam);
			//检索
			long start = System.currentTimeMillis();
			
			SearchResult searchResult = null;
			List<Categorydata> list = null;
			//moreVal
			String moreVal = "";
			Node fieldNode = root.selectSingleNode("/params/moreVal");
			if (null != fieldNode) {
				moreVal = fieldNode.getText().trim();
			}
			String[] val= moreVal.split(";");
			List<SearchResult> resultList = new ArrayList<SearchResult>();
			for (int j=0;j<val.length;j++) {
				list = searchService.find(val[j]);
				List<Categorydata> list1 = new ArrayList<Categorydata>();
				List<Categorydata> list2 = new ArrayList<Categorydata>();
				for(int i = 0; i<list.size(); i++) {
					if(list.get(i).getCategorySystem().contains("中科院JCR")) {
						list2.add(list.get(i));
					} else {
						list1.add(list.get(i));
					}
				}
				searchResult.setInfo(list1);
				searchResult.setZkyInfo(list2);
				resultList.add(searchResult);
			}
			String result=JsonUtil.obj2Json(resultList);
			long end = System.currentTimeMillis();
			System.out.println(end -start);
			System.out.println(result);
			return result;
		} catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	
}
