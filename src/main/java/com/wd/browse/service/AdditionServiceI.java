package com.wd.browse.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;

public interface AdditionServiceI {
	/**
	 * 获取关键词数量
	 * @param orgFlag
	 * @param systemId
	 * @return
	 */
//	public int getKeyWordCount(String orgFlag,int systemId);
	/**
	 * 随机获取关键词
	 * @param orgFlag
	 * @param systemId
	 * @param offset
	 * @return
	 */
//	public Map<String,Object> getKeyWord(String orgFlag,int systemId,int offset);
	public List<Map<String, Object>> getKeyWordList(String orgFlag,int systemId);
	
	/**
	 * 关键词的文章详细数量
	 * @param batchId
	 * @return
	 */
	public int getScholarInfoCount(String batchId);
	/**
	 * 关键词的文章详细标题
	 * @param batchId
	 * @param offset
	 * @return
	 */
	public Map<String,Object> getScholarInfo(String batchId,int offset);
	
	/**
	 * 自动添加pv记录
	 * @return
	 */
	public Map<String,Object>  getAddBrowseAutomatic(String orgFlag);
	
	public void insertAddBrowseAutomatic(Map<String, Object> params);
	/**
	 * 新线程启动
	 * @param params
	 */
	public Integer insertAddBrowseHand(Map<String, Object> params);
	
	public void browseHandStart(Integer browseHandId);
	public void browseHandStartThread(Integer browseHandId);
	/**
	 * 根据browseHandId获取添加记录
	 * @param browseHandId
	 * @return
	 */
	public Map<String,Object> getAddBrowseHandById(String browseHandId,Integer type);
	/**
	 * 手动添加pv记录
	 * @return
	 */
	public Pager getAddBrowseInfo(String orgFlag);
	/**
	 * 获取日志
	 * @param orgFlag
	 * @param type
	 * @return
	 */
	public Pager getContentAnalysisLog(String orgFlag,String type);
	
	

}
