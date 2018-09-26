package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.History;

public interface ContentAnalysisDaoI {
	
	public List<Map<String,Object>> getAllSearchInfoCount(Map<String,Object> params);
	/**
	 * 检索分析
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getSearch(Map<String,Object> params);
	/**
	 * 检索分析(所有学校)(有记录天数)
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getSearchDay(Map<String,Object> params);
	/**
	 * 期刊检索分析
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findSearchJournal(Map<String,Object> params);
	/**
	 * 期刊检索分析,数量(分页)
	 * @param params
	 * @return
	 */
	public int findSearchJournalCount(Map<String,Object> params);
	/**
	 * 期刊检索总数量
	 * @param params
	 * @return
	 */
	public int findAllSearchJournalCount(Map<String,Object> params);
	/**
	 * 文章检索分析
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> findSearchScholar(Map<String,Object> params);
	/**
	 *文章检索分析,数量(分页)
	 * @param params
	 * @return
	 */
	public int findSearchScholarCount(Map<String,Object> params);
	/**
	 *文章检索总数量
	 * @param params
	 * @return
	 */
	public int findAllSearchScholarCount(Map<String,Object> params);
	
	/**
	 * 浏览分析 期刊
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getJournalAnalysis(Map<String,Object> params);
	/**
	 * 浏览分析 期刊数量
	 * @param params
	 * @return
	 */
	public int getJournalTotal(Map<String,Object> params);
	/**
	 * 浏览分析  所有期刊数量
	 * @param params
	 * @return
	 */
	public int getAllJournalTotal(Map<String,Object> params);
	/**
	 * 浏览分析 学科数量(分页)
	 * @param params
	 * @return
	 */
	public int getSubjectTotal(Map<String,Object> params);
	/**
	 * 浏览分析 学科数量(所有)
	 * @param params
	 * @return
	 */
	public int getAllSubjectTotal(Map<String,Object> params);
	/**
	 * 浏览分析 学科
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getSubjectAnalysis(Map<String,Object> params);
	/**
	 * 浏览分析 学科体系
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getDbAnalysis(Map<String,Object> params);
	/**
	 *  页面点击统计（详情）
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getPageClickInfo(Map<String,Object> params);
	
	/**
	 * 内容分析
	 * @param history
	 */
	public void insertAnalysis(History history);
	
	/**
	 * 数据添加（获取元数据：查询关键词出现最多的）
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getMaxKeyWord(Map<String,Object> params);
	/**
	 * 数据添加(获取元数据：关键词月份出现频次)
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getByKeyWord(Map<String,Object> params);
}
