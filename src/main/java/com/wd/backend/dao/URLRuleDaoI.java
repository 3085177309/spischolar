package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.URLRule;

public interface URLRuleDaoI {
	
	public void insert(URLRule rule);
	
	public URLRule findById(Integer id);
	
	public void delete(Integer id);
	
	public void update(URLRule rule);
	
	public List<URLRule> findPager(Map<String,Object> params);
	
	public int findCount(String orgFlag);
	
	public List<URLRule> findByOrg(String orgFlag);
	
	public void deleteByOrg(String orgFlag);

}
