package com.wd.backend.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.History;
import com.wd.backend.model.Org;


public interface ContentAnalysisServiceI {
	
	/**
	 * 首页
	 * @return
	 */
	public List<Map<String,Object>> getAllSearchInfoCount(String school,String type,String beginTime,String endTime);
	
	public Pager findSearch(String beginTime,String endTime,String type, String offset,String key,String sort);

	/**
	 * 期刊检索分析
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findSearchJournal(String school,String beginTime,String endTime,String type,String offset);
	/**
	 * 期刊检索分析分页
	 * @return
	 */
	public int findSearchJournalCount(String school,String beginTime,String endTime,String type);
	
	/**
	 * 文章检索分析
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findSearchScholar(String school,String beginTime,String endTime,String type, String offset);
	/**
	 * 文章检索分析分页
	 * @return
	 */
	public int findSearchScholarCount(String school,String beginTime,String endTime,String type);
	/**
	 * 文章检索总数量
	 * @return
	 */
	/*public int findAllSearchScholarCount(String school,String beginTime,String endTime,String type);*/
	
	/**
	 * 浏览分析   期刊
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @param offset
	 * @param size
	 * @return
	 */
	public List<Map<String,Object>> getJournalAnalysis(String school,String beginTime,String endTime,String type,String offset,String size);
	/**
	 * 浏览分析   根据条件查询期刊总记录数(分页)
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public int getJournalTotal(String school,String beginTime,String endTime,String type);
	/**
	 * 浏览分析   根据条件查询期刊总记录数(浏览分析  所有期刊数量)
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public int getAllJournalTotal(String school,String beginTime,String endTime,String type);
	/**
	 * 浏览分析   根据条件查询学科总记录数(分页)
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public int getSubjectTotal(String school,String beginTime,String endTime,String type);
	/**
	 * 浏览分析   根据条件查询学科总记录数
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public int getAllSubjectTotal(String school,String beginTime,String endTime,String type);
	/**
	 * 浏览分析  学科
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @param offset
	 * @param size
	 * @return
	 */
	public List<Map<String,Object>> getSubjectAnalysis(String school,String beginTime,String endTime,String type,String offset,String size);
	/**
	 * 浏览分析  学科学科体系
	 * @param school
	 * @param beginTime
	 * @param endTime
	 * @param type
	 * @return
	 */
	public Map<String,Object> getDbAnalysis(String school,String beginTime,String endTime,String type);

	/**
	 * 创建excel表并保存(所有检索分析（根据学校）)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void creatAll(List<Map<String,Object>> list, String path) throws Exception;
	/**
	 * 创建excel表并保存(!浏览学科体系)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void creat(List<Map<String,Object>> list, String path) throws Exception;
	/**
	 * 创建excel表并保存(浏览学科体系)
	 * @param json
	 * @param path
	 * @throws Exception
	 */
	public void creatDb(Map<String,Object> json, String path) throws Exception;
	
	/**
	 * 页面点击统计（详情）
	 * @return
	 */
	public List<Map<String, Object>> pageClickInfo(Map<String,Object> params);
	
	
	/**
	 * 数据添加功能（获取原始数据）
	 * @return
	 */
	public List<Map<String,Object>> getJournalKeyWord(String orgFlag,String beginTime,String endTime,
			int type,String journalType,String size);
	
	/**
	 * 数据添加功能（增加数据）
	 * @param list
	 */
	public void addContentAnalysis(Map<String,Object> params,String username);
//	public void addContentAnalysisThread(Map<String,Object> params,String username);
	/**
	 * 数据添加日志
	 * @return
	 */
	public Map<String,Object> getLog(String orgFlag,String keyword);
	public Pager getLogList(String orgFlag,String journalType);
	/*public String findChickPage();*/
}
