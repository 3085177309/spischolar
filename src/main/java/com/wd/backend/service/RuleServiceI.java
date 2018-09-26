package com.wd.backend.service;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Database;
import com.wd.backend.model.LinkRule;
import com.wd.exeception.SystemException;

public interface RuleServiceI {

	/**
	 * 查找数据库列表
	 * 
	 * @param key
	 *            如果为空，则表示查找所有
	 * @return
	 */
	Pager searchDbList(String key);

	/**
	 * 查找数据库详细信息
	 * 
	 * @param dbId
	 * @return
	 */
	Database searchDbDetail(Integer dbId);

	/**
	 * 查找数据库的规则列表
	 * 
	 * @param dbId
	 * @return
	 */
	Pager searchRuleList(Integer orgId, Integer dbId);

	/**
	 * 添加连接规则
	 * 
	 * @param linkRule
	 */
	void add(LinkRule linkRule) throws SystemException;

	/**
	 * 编辑数据库连接规则
	 * 
	 * @param linkRule
	 */
	void edit(LinkRule linkRule) throws SystemException;

	/**
	 * 规则删除
	 * 
	 * @param ruleId
	 */
	void del(Integer ruleId);

	/**
	 * 查找规则详细信息
	 * 
	 * @param ruleId
	 * @return
	 */
	LinkRule searchRuleDetail(Integer ruleId);

}
