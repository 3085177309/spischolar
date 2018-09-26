package com.wd.backend.module.es;

import java.util.List;
import java.util.Map;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.search.SearchHits;

public interface BrowseSearchI {
	
	
	public Map<String, Object> indexInfo(String school, String type,String beginTime,String endTime,int day);
	
	
	/**
	 * 浏览查询:获取用户浏览信息
	 * @param beginTime
	 * @param endTime
	 * @param school
	 * @param day
	 * @param types
	 * @return
	 */
	public Map<String, Object> flowQueryInfo(String beginTime, String endTime,String school,int day,String[] types,String type) ;
	
	
	/**
	 * VisitHistory获取详细浏览记录历史
	 * @return
	 */
	public List<Map<String, Object>> visitHistoryInfo(String school, String val,String ip,String refererUrl,String type) ;
	/**
	 * 导出详细浏览记录历史
	 * @return
	 */
	public SearchResponse getvisitHistoryInfoScrollId(String school, String beginTime, String endTime,String type) ;
	public SearchHits getvisitHistoryInfo(String scrollId);
	
	/**
	 * 计算VisitHistory当天访问频次和上一次访问时间
	 * @param memberId
	 * @param time
	 * @param data
	 */
	public void visitHistoryInfoById(int memberId,String time,Map<String, Object> data) ;
	
	
	/**
	 * 如果是comefrom（学校详细，必须有学校）filed：refererUrl
	 * 如果是comefrom（学校列表）filed：schoolFlag
	 * findRegion地域分布table表（必须有学校）filed：schoolProvince
	 * @param types
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param filed
	 * @return
	 */
	public List<Map<String, Object>> visitLan(String[] types,String school,String beginTime,String endTime,String filed,int offset,int size,int memberType,String sort,String type) ;
	
	
	/**
	 * 留存用户计算
	 * @param beginTime
	 * @param endTime
	 * @param school
	 * @param day
	 * @param memberType
	 * @return
	 */
	public Map<String, Map<String, Long>> keep(String beginTime, String endTime,String school,int day,int memberType,String type) ;
	
	public List<Map<String,Object>> visitPage(String beginTime, String endTime,String school,String type);
	
}
