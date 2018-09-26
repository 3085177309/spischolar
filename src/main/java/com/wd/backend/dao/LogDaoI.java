package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.SystemLog;

public interface LogDaoI {

	public void insert(SystemLog systemLog);

	/**
	 * 查询机构当前检索条件的最近访问记录
	 * 
	 * @param param
	 * @return
	 */
	public SystemLog findSearchLog(Map<String, Object> param);

	/**
	 * 获取期刊详细页打开总次数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getDetailOpenCount(Map<String, Object> params);

	/**
	 * 获取期刊检索总次数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalSearchCount(Map<String, Object> params);

	/**
	 * 获取文档检索总次数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getDocSearchCount(Map<String, Object> params);

	/**
	 * 获取期刊关键词检索日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalWordLog(Map<String, Object> params);

	/**
	 * 获取期刊关键词日志总数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalWordLogCount(Map<String, Object> params);

	/**
	 * 获取期刊issn检索总次数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalIssnLogCount(Map<String, Object> params);

	/**
	 * 获取期刊issn检索日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalIssnLog(Map<String, Object> params);

	/**
	 * 获取体系检索数量
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalSysLogCount(Map<String, Object> params);

	/**
	 * 获取体系检索日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalSysLog(Map<String, Object> params);

	/**
	 * 获取体系学科检索总数量
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalSysSubjLogCount(Map<String, Object> params);

	/**
	 * 获取体系学科日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalSysSubjLog(Map<String, Object> params);

	/**
	 * 获取详细查询总日志量
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalDetailLogCount(Map<String, Object> params);

	/**
	 * 获取期刊详细查询日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalDetailLog(Map<String, Object> params);

	/**
	 * 期刊主页打开日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findJournalMainLinkLog(Map<String, Object> params);

	/**
	 * 获取期刊主页总打开数
	 * 
	 * @param params
	 * @return
	 */
	public Integer getJournalMainLinkLogCount(Map<String, Object> params);

	/**
	 * 获取文章标题的检索数量
	 * 
	 * @param params
	 * @return
	 */
	public Integer getDocTitleLogCount(Map<String, Object> params);

	/**
	 * 获取文档标题搜索的日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findDocTitleLog(Map<String, Object> params);

	/**
	 * 打开文档主页的总数量
	 * 
	 * @param params
	 * @return
	 */
	public Integer getDocLinkLogCount(Map<String, Object> params);

	/**
	 * 文档打开日志
	 * 
	 * @param params
	 * @return
	 */
	public List<SystemLog> findDocLinkLog(Map<String, Object> params);
}
