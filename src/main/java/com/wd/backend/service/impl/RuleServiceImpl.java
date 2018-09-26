package com.wd.backend.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import com.wd.backend.bo.Pager;
import com.wd.backend.dao.DatabaseDaoI;
import com.wd.backend.dao.LinkRuleDaoI;
import com.wd.backend.model.Database;
import com.wd.backend.model.LinkRule;
import com.wd.backend.service.RuleServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.util.SimpleUtil;

//@Service("ruleService")
public class RuleServiceImpl implements RuleServiceI {

	@Autowired
	private DatabaseDaoI databaseDao;
	@Autowired
	private LinkRuleDaoI linkRuleDao;

	@Override
	public Pager searchDbList(String key) {
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("key", key);
		int total = databaseDao.getCount(params);
		pager.setTotal(total);
		if (total > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<Database> databaseList = databaseDao.findList(params);
			pager.setRows(databaseList);
		}
		return pager;
	}

	@Override
	public Database searchDbDetail(Integer dbId) {
		return databaseDao.findById(dbId);
	}

	@Override
	public Pager searchRuleList(Integer orgId, Integer dbId) {
		Map<String, Object> params = new HashMap<String, Object>(3);
		params.put("orgId", orgId);
		params.put("dbId", dbId);
		Pager pager = new Pager();
		int total = linkRuleDao.getOrgRuleCount(params);
		pager.setTotal(total);
		if (total > 0) {
			params.put("size", SystemContext.getPageSize());
			params.put("offset", SystemContext.getOffset());
			List<LinkRule> linkRuleList = linkRuleDao.findOrgRuleByPager(params);
			pager.setRows(linkRuleList);
		}
		return pager;
	}

	@Override
	public void add(LinkRule linkRule) throws SystemException {
		if (SimpleUtil.strIsNull(linkRule.getName())) {
			throw new SystemException("规则名不能为空!");
		}
		if (SimpleUtil.strIsNull(linkRule.getLinkRule())) {
			throw new SystemException("规则不能为空!");
		}
		linkRuleDao.insert(linkRule);
	}

	@Override
	public void edit(LinkRule linkRule) throws SystemException {
		if (SimpleUtil.strIsNull(linkRule.getName())) {
			throw new SystemException("规则名不能为空!");
		}
		if (SimpleUtil.strIsNull(linkRule.getLinkRule())) {
			throw new SystemException("规则不能为空!");
		}
		linkRuleDao.update(linkRule);
	}

	@Override
	public void del(Integer ruleId) {
		linkRuleDao.del(ruleId);
	}

	@Override
	public LinkRule searchRuleDetail(Integer ruleId) {
		return linkRuleDao.findById(ruleId);
	}

}
