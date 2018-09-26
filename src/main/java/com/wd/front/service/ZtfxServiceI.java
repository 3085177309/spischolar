package com.wd.front.service;

import com.wd.front.bo.DocForKeyword;

import java.util.List;

public interface ZtfxServiceI {

	/**
	 * 期刊的主题频次
	 * @param startYear
	 * @param endYear
	 * @return
	 */
	public String getZtpc(String id,int startYear,int endYear);
	
	/**
	 * 期刊的发文趋势
	 * @param startYear
	 * @param endYear
	 * @return
	 */
	public String getFwqs(String id,int startYear,int endYear);
	
	/**
	 * 期刊的突发主题
	 * @param startYear
	 * @param endYear
	 * @return
	 */
	public String getTfzt(String id,int startYear,int endYear);
	

	public String getMoreFwqsForKey(String keyword,int startYear,int endYear);
	/**
	 * 获取关键字的发文期刊
	 * @param keyword
	 * @return
	 */
	public String getFwqk(String keyword);
	
	/**
	 * 检查是否存在主题分析数据
	 * @param jguid
	 * @return
	 */
	public boolean checkZtfxExists(String jguid);

	/**
	 * 获取热门主题词
	 * @param queryName
	 * @return
	 */
	public List<String> hotKeywords(String queryName);
	/**
	 * 查看期刊关键字所有的文章
	 * @param journal
	 * @param keyword
	 * @return
	 */
	public List<DocForKeyword> getDocForKeyword(String journal, String keyword);

}
