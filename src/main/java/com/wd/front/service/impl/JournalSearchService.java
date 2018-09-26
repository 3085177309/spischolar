package com.wd.front.service.impl;

import java.text.DecimalFormat;
import java.util.*;

import org.elasticsearch.action.search.MultiSearchRequestBuilder;
import org.elasticsearch.action.search.MultiSearchResponse;
import org.elasticsearch.action.search.MultiSearchResponse.Item;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.CategorydataDaoI;
import com.wd.backend.model.AuthorityDatabase;
import com.wd.backend.model.Categorydata;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.bo.SysOB;
import com.wd.front.context.FacetBuilderStrategyContext;
import com.wd.front.context.FilterStrategyContext;
import com.wd.front.context.QueryStrategyContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.SearchServiceI;
import com.wd.util.AuthorityDbUtil;
import com.wd.util.ClientUtil;
import com.wd.util.JournalResultConvertUtil;
import com.wd.util.SearchRequestUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.SpringContextUtil;
import com.wd.util.SystemLinkUtil;

/**
 * 期刊列表查询
 * 
 * @author pan
 * 
 */
@Service("journalSearchService")
public class JournalSearchService implements SearchServiceI {

	@Autowired
	private QueryStrategyContext queryStrategyContext;
	@Autowired
	private FilterStrategyContext filterStrategyContext;
	@Autowired
	private FacetBuilderStrategyContext facetBuilderStrategyContext;

	//@Autowired
	private CacheModuleI cacheModule;
	
	@Autowired
	private CategorydataDaoI categorydataDao;

	@Override
	@SuppressWarnings("unchecked")
	public SearchResult search(SearchCondition searchCondition) {
		
		SearchResult searchResult = new SearchResult();

		boolean executeMain = false;
		MultiSearchRequestBuilder multiSearchRequestBuilder = ClientUtil.getClient().prepareMultiSearch();
		if (!"disciplineName".equals(searchCondition.getField())) {
			// 主查询
			SearchRequestBuilder mainSearchRequest = SearchRequestUtil.buildSearchRequest(true, searchCondition, queryStrategyContext, filterStrategyContext, facetBuilderStrategyContext,
					Collections.EMPTY_LIST, false);
			multiSearchRequestBuilder.add(mainSearchRequest);
			executeMain = true;
		}

		boolean executeFacet = false;
		// 学科体系统计
		if (!"title".equals(searchCondition.getField()) && !"issn".equals(searchCondition.getField()) && searchCondition.getValue().length() > 1) {
			SearchCondition disciplineSystemFacetSearchCondition = new SearchCondition();
			disciplineSystemFacetSearchCondition.setDocType(10);
			disciplineSystemFacetSearchCondition.setField("disciplineSystemDiscipline");
			disciplineSystemFacetSearchCondition.setValue(searchCondition.getValue());
			// 只统计最近年
			disciplineSystemFacetSearchCondition.getQueryCdt().add("isNew_3_1_" + 1);
			//if ("disciplineName".equals(searchCondition.getField())) {
			SystemContext.setFacatSize(200);
			//}
			SearchRequestBuilder disciplineSystemFacetSearchRequest = SearchRequestUtil.buildSearchRequest(true, disciplineSystemFacetSearchCondition, queryStrategyContext, filterStrategyContext,
					facetBuilderStrategyContext, Arrays.asList("dbYearDiscipline"), true);
			multiSearchRequestBuilder.add(disciplineSystemFacetSearchRequest);
			if ("disciplineName".equals(searchCondition.getField())) {
				SystemContext.removeFacatSize();
			}
			executeFacet = true;
		}

		if (!executeFacet && !executeMain) {
			return searchResult;
		}
		// 执行mutilSearch
		MultiSearchResponse multiSearchResponse = multiSearchRequestBuilder.execute().actionGet();

		Item[] itemArr = multiSearchResponse.getResponses();

		// 转换主查询结果
		List<Map<String, Object>> docList = null;
		if (executeMain) {
			docList = JournalResultConvertUtil.convertDocList(itemArr[0].getResponse());
			searchResult.setDatas(docList);
			searchResult.setTotal(itemArr[0].getResponse().getHits().getTotalHits());
		}

		// 转换学科体系统计分面
		if (executeFacet) {
			Map<String, Map<String, String>> facetMap = JournalResultConvertUtil.convertFacet(itemArr[itemArr.length == 2 ? 1 : 0].getResponse());
			searchResult.setFacetDatas(facetMap);
			String subject = subject(searchCondition,facetMap);
			searchResult.setSubject(subject);
		}

		if (null != searchCondition.getLimit() && searchResult.getTotal() > 50) {
			// 限制总结果数
			searchResult.setTotal(50);
		}

		return searchResult;
	}
	
	/**
	 * 相关学科
	 * @param condition
	 * @param facetMap
	 * @return
	 */
	public String subject(SearchCondition condition,Map<String, Map<String, String>> facetMap) {
		StringBuilder stringBuilder = new StringBuilder();
		List<AuthorityDatabase> allDbPartitionList = null;
		Map<String, Integer> authorityDbMap = null;
		cacheModule = SpringContextUtil.getBean(CacheModuleI.class);
		try {
			authorityDbMap = cacheModule.findAllAuthorityDbFromCache();
			allDbPartitionList = cacheModule.findDbPartitionFromCache();
		} catch (SystemException e1) {
			e1.printStackTrace();
		}
		Map<String, String> map = facetMap.get("dbYearDiscipline");
		if (SimpleUtil.mapIsNull(map)) {
			return null;
		}
		//String zkyFlag= facetMap.get("zky").get("zky");
		Set<String> valueSet = map.keySet();
		Map<String, Set<SysOB>> shouLuMap = new HashMap<String, Set<SysOB>>();
		for (String value : valueSet) {
            String[] arr = value.split("\\|");
			if (arr.length >= 4) {
				SysOB systemBO = new SysOB();
				systemBO.setSubject(arr[3]);
				//为了区分 购买和试用 的用户是否有使用中科院JCR“最新”数据的权限 zkyFlag=1：购买，其他没权限 (检索列表页--相关学科)其他地方都在jsp页面上控制
				if(("中科院JCR分区(大类)".equals(arr[0])||"中科院JCR分区(小类)".equals(arr[0]))){
					systemBO.setYear(2016);
				}else{
					try {
						systemBO.setYear(Integer.parseInt(arr[2]));
					} catch (NumberFormatException e) {
						continue;
					}
				}
				String key = arr[0] + "(" + systemBO.getYear() + ")";
				Set<SysOB> subjSet = shouLuMap.get(key);
				if (null == subjSet) {
					subjSet = new TreeSet<SysOB>(new Comparator<SysOB>() {

						@Override
						public int compare(SysOB o1, SysOB o2) {
							if (null == o1 || SimpleUtil.strIsNull(o1.getSubject())) {
								return -1;
							}
							if (null == o2 || SimpleUtil.strIsNull(o2.getSubject())) {
								return 1;
							}
							String subA = o1.getSubject().toLowerCase();
							String subB = o2.getSubject().toLowerCase();
							int len = Math.min(subA.length(), subB.length());
							for (int i = 0; i < len; i++) {
								int t_a = subA.charAt(i);
								int t_b = subB.charAt(i);
								if (t_a > t_b) {
									return 1;
								} else if (t_a < t_b) {
									return -1;
								}
							}
							return 1;
						}
					});
					shouLuMap.put(key, subjSet);
				}
				subjSet.add(systemBO);
			}
		}
		if (SimpleUtil.mapNotNull(authorityDbMap) && SimpleUtil.mapNotNull(shouLuMap)) {
			// 获取已排序的学科体系列表
			Set<String> sysSet = authorityDbMap.keySet();
			for (String sys : sysSet) {
				Set<Map.Entry<String, Set<SysOB>>> entrySet = shouLuMap.entrySet();
				for (Map.Entry<String, Set<SysOB>> entry : entrySet) {
					if (entry.getKey().startsWith(sys + "(")) {
						Set<SysOB> subjSet = shouLuMap.get(entry.getKey());
						if (subjSet.isEmpty()) {
							continue;
						}
						stringBuilder.append("<p>");
						stringBuilder.append("<span>" + entry.getKey() + " : </span>");
						Iterator<SysOB> iter = subjSet.iterator();
						while (iter.hasNext()) {
							SysOB subj = iter.next();
							String sortCdt = "&sort=11"; //SystemLinkUtil.buildSortCondition(sys, authorityDbMap, subj.getSubject(), disciplineMap, subj.getYear());
							String url = SystemLinkUtil.buildSubjectUrl("qkdh", sys, subj.getSubject(), subj.getYear()) + sortCdt;
							stringBuilder.append("<a href=\"" + url + "\">" + subj.getSubject() + "</a>");
							AuthorityDatabase authorityDatabase = AuthorityDbUtil.findPartition(allDbPartitionList, sys);
							if (null != authorityDatabase) {
								String allPartition = authorityDatabase.getAllPartition();
								if (SimpleUtil.strNotNull(allPartition)) {
									stringBuilder.append("&nbsp;&nbsp;");
									String[] partitionArr = allPartition.split(";");
									for (int i = 0; i < partitionArr.length; i++) {
										String par = partitionArr[i];
										try {
											String partitionUrl = SystemLinkUtil.buildPartitionUrl("qkdh", sys, subj.getSubject(), subj.getYear(), Integer.parseInt(par));
											stringBuilder.append("<a href=\"" + partitionUrl + "\">" + authorityDatabase.getPrefix() + par + authorityDatabase.getSuffix() + "</a>");
											if (i != partitionArr.length - 1) {
												stringBuilder.append("&nbsp;&nbsp;");
											} else {
												stringBuilder.append("<br/>");
											}
										} catch (NumberFormatException e) {
										}
									}
								} else {
									stringBuilder.append("<br/>");
								}
							}
						}
						stringBuilder.append("</p>");
					}
				}
			}
			stringBuilder.append("</div>");
		}
		return stringBuilder.toString();
	}
	
	/**
	 * 去数据库获取云空间接口所需数据
	 * @param value
	 * @return
	 */
	@Override
    public List<Categorydata> find(String value) {
		
		List<Categorydata> list = categorydataDao.find(value);
		List<Categorydata> resultList = new ArrayList<>();
		for(int i = 0; i < list.size(); i++) {
			int result = categorydataDao.findNewYear(list.get(i).getCategorySystem());
			if(result != Integer.parseInt(list.get(i).getYear())) {
                continue;
            }

			Map<String,Object> params=new HashMap<String,Object>();
			params.put("category", list.get(i).getCategory());
			params.put("year", list.get(i).getYear());
			params.put("categorySystem", list.get(i).getCategorySystem());
			int allCount = categorydataDao.findAllCount(params);
			params.put("value", list.get(i).getValue());
			int count = categorydataDao.findCount(params);
			String order = count + "/" + allCount;
			
			DecimalFormat fnum = new DecimalFormat("##0.00"); //保留两位小数
			float avgTc = ((float)count/(float)allCount);
			if(avgTc < 0.01) {
				avgTc = 0.01f;
			}
			String percent =fnum.format(avgTc);             //保留两位小数
			
			if(list.get(i).getCategorySystem().contains("大类")) {
				list.get(i).setCategory(list.get(i).getCategory()+"(大类)");
			} else if(list.get(i).getCategorySystem().contains("小类")) {
				list.get(i).setCategory(list.get(i).getCategory()+"(小类)");
			}
			list.get(i).setOrder(order);
			list.get(i).setPercent(percent+"%");
			resultList.add(list.get(i));
		}
		return resultList;
	}
	
}
