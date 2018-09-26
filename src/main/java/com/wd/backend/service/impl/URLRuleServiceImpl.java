package com.wd.backend.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.URLRuleDaoI;
import com.wd.backend.model.URLRule;
import com.wd.backend.service.URLRuleServiceI;
import com.wd.comm.context.SystemContext;

@Service("uRLRuleService")
public class URLRuleServiceImpl implements URLRuleServiceI{
	
	@Autowired
	private URLRuleDaoI ruleDao;

	@Override
	public void add(URLRule rule) {
		ruleDao.insert(rule);
	}

	@Override
	public URLRule detail(Integer id) {
		return ruleDao.findById(id);
	}

	@Override
	public Pager searchPage(String orgFlag) {
		Map<String,Object> params=new HashMap<String,Object>();
		Pager pager=new Pager();
		params.put("orgFlag", orgFlag);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		pager.setTotal(ruleDao.findCount(orgFlag));
		pager.setRows(ruleDao.findPager(params));
		return pager;
	}

	@Override
	public List<URLRule> findAll(String orgFlag) {
		return ruleDao.findByOrg(orgFlag);
	}

	@Override
	public void edit(URLRule rule) {
		ruleDao.update(rule);
	}

	@Override
	public void delete(Integer id) {
		ruleDao.delete(id);
	}

}
