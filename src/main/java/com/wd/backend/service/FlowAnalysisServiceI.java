package com.wd.backend.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.VisitLog;
import com.wd.backend.model.VisiteInformation;

/**
 * 流量分析
 * @author 杨帅菲
 *
 */

public interface FlowAnalysisServiceI {
	
	/**
	 * 根据时间查询访问概况（后台首页信息）
	 * @param school
	 * @param type
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	public List<Map<String, Object>> visite(String school,String type);
	
	/**
	 * flowQuery表格table数据
	 * @param school
	 * @param schoolName
	 * @param beginTime
	 * @param endTime
	 * @param sort
	 */
	public List<Map<String, Object>> flowQueryTableList(String[] school,
			String[] schoolName, String beginTime, String endTime, final String sort,String type) ;
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
	public String flowQueryMapList(String[] compareSchoolName,String[] compareSchool, String type,String beginTime, String endTime,String[] types, int day) throws ParseException;
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
	public Map<String, Object> downloadFlowQuery(String[] compareSchoolName,
			String type, String beginTime, String endTime, String[] types,
			String[] compareSchool, int day) throws ParseException;
	
	
	/**
	 * 创建excel表并保存
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void creat(Map<String, Object> json, String path) throws Exception;
	
	public void creatHistory(String school,String type, String beginTime, String endTime, String path) throws Exception;
	/**
	 * 访问历史列表
	 * @param school
	 * @param val
	 * @param ip
	 * @param refererUrl
	 * @return
	 */
	public List<Map<String, Object>> visitHistory(String school, String val,String ip,String refererUrl,String type);
	
	
	public Map<String, Object> avgPV(String orgFlag,String beginTime,String endTime);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 查询访问报告。访问异常
	 * @return
	 */
	public List<VisitLog> findVisitLog(String name,String remark);
	/**
	 * 查询访问报告总数
	 * @return
	 */
	public int findVisitLogCount(String name,String remark);
	
	
}
