package com.wd.browse.dao;

import java.util.List;
import java.util.Map;


public interface AdditionDaoI {
	
	public int getKeyWordCount(Map<String, Object> params);
//	
//	public Map<String,Object> getScholarKeyWord(Map<String, Object> params);
	/**
	 * 根据学校获取关键词
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getScholarKeyWordList(Map<String, Object> params);
	
	public int getScholarInfoCount(String batchId);
	
	public Map<String,Object> getScholarInfo(Map<String, Object> params);
	
	//public List<Map<String,Object>> getAddBrowse();
	
	/**
	 * 获取数据添加列表(自动添加)
	 * @param params
	 * @return
	 */
	public Map<String,Object> getAddBrowseAutomaticByFlag(Map<String, Object> params);
/*	public Map<String,Object> getAddBrowseAutomatic(String orgFlag);*/
	public void insertAddBrowseAutomatic(Map<String, Object> params);
	public void editAddBrowseAutomatic(Map<String, Object> params);
	public void contentAnalysisLog(Map<String, Object> params);
	/**
	 * 获取数据添加列表(手动添加)
	 * @return
	 */
	public List<Map<String,Object>>  getAddBrowseHand(Map<String, Object> params);
	public Integer getAddBrowseHandCount(Map<String, Object> params);
	public int insertAddBrowseHand(Map<String, Object> params);
	/**
	 * 修改BrowseHand（手动添加）type0--->type1
	 * @param params
	 * @return
	 */
	public void updateAddBrowseHand(Map<String, Object> params);
	
	public Map<String,Object> getAddBrowseHandById(Map<String, Object> params);
	
	/**
	 * 获取数据管理日志
	 * @param params
	 * @return
	 */
	public List<Map<String,Object>> getContentAnalysisLog(Map<String, Object> params);
	public Integer getContentAnalysisLogCount(Map<String, Object> params);
	
	
	public void insertCount(Map<String, Object> params);

}
