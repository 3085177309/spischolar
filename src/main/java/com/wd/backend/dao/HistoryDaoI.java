package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.ExceptionInfo;
import com.wd.backend.model.History;

public interface HistoryDaoI {
	
	public Integer findCount(Map<String,Object> params);
	
	public List<History> findList(Map<String,Object> params);
	
	public List<History> findTopN(Map<String,Object> params);
	
	/**
	 * 检索框历史记录
	 * @param params
	 * @return
	 */
	public List<History> findListForSearch(Map<String,Object> params);
	
	/**
	 * 插入历史记录
	 * @param history
	 */
	public void insert(History history);
	/**
	 * 内容分析
	 * @param history
	 */
	/*public void insertAnalysis(History history);*/
	
	/**
	 * 手动添加数据（内容分析）
	 * @param history
	 */
	/*public void insertAnalysisAdd(History history);*/
	/**
	 * 删除历史
	 * @param history
	 */
	public void deleteHistory(Map<String,Object> params);
	
	/**
	 * 查找一条记录
	 * @param params
	 * @return
	 */
	public History findOne(Map<String,Object> params);
	/**
	 * 插入期刊文章最新无结果异常信息
	 * @param info
	 */
	public void insertException(ExceptionInfo info);

}
