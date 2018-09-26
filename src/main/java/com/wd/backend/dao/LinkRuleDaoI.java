package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.LinkRule;

public interface LinkRuleDaoI {

	/**
	 * 查找机构所有启用的链接规则
	 * 
	 * @param orgId
	 * @return
	 */
	public List<LinkRule> findUsedRuleByOrg(Integer orgId);

	/**
	 * 分页方式或机构规则列表
	 * 
	 * @param params
	 * @return
	 */
	public List<LinkRule> findOrgRuleByPager(Map<String, Object> params);

	/**
	 * 获取机构下规则的总数量
	 * 
	 * @param orgId
	 * @return
	 */
	public int getOrgRuleCount(Map<String, Object> params);

	public void insert(LinkRule linkRule);

	public void update(LinkRule linkRule);

	public void del(Integer ruleId);

	/**
	 * 按id查找
	 * 
	 * @param ruleId
	 * @return
	 */
	public LinkRule findById(Integer ruleId);

	/**
	 * 按机构删除连接规则
	 * 
	 * @param id
	 */
	public void deleteByOrg(Integer orgId);
}
