package com.wd.front.service;

import java.util.List;
import java.util.Map;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.ExceptionInfo;
import com.wd.backend.model.History;
import com.wd.backend.model.Hot;
import com.wd.backend.model.SystemLog;

public interface SearchLogServiceI {
	
	/**
	 * 添加历史记录
	 * @param history
	 */
	public void addHistory(History history);
	
	public void addAsynHistory(History history);

	/**
	 * 添加日志
	 * 
	 * @param log
	 */
	public void addSearchLog(SystemLog log);

	/**
	 * 添加体系日志
	 * 
	 * @param log
	 */
	public void addSysLog(SystemLog log);
	
	/**
	 * 异步添加日志记录
	 * @param log
	 */
	public void addAsynSearchLog(SystemLog log);
	
	/**
	 * 异步添加热门检索信息
	 */
	public void addAsynHotLog(String orgFlag,String title,String flag);
	
	public void addAsynHotLog(String orgFlag,String keyword);
	
	public void saveHotLog(Hot log);


	/**
	 * 查看检索日志概览信息
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Map<String, Integer> searchOverview(String orgFlag, String siteFlag, Integer time);

	/**
	 * 期刊检索关键词日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchJournalWordLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 期刊issn检索日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchIssnLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 体系检索日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchSysLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 体系-学科检索日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchSysSubjLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 查看(期刊详细)日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time 
	 * @return
	 */
	public Pager searchDetailLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 期刊主页连接查看日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchJournalMainLinkLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 文档标题检索日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchDocTitleLog(String orgFlag, String siteFlag, Integer time);

	/**
	 * 文档标题主页日志
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param time
	 * @return
	 */
	public Pager searchDocHomePageLog(String orgFlag, String siteFlag, Integer time);
	
	/**
	 * 插入期刊文章最新无结果异常信息
	 * @param info
	 */
	public void insertException(ExceptionInfo info);

}
