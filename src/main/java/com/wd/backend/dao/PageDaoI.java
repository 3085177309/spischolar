package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Page;

public interface PageDaoI {
	
	public void insert(Page page);
	
	public void update(Page page);
	
	public void delete(Integer id);
	
	public Page get(Integer id);
	
	public Integer findCount(Map<String,Object> params);
	
	public List<Page> findList(Map<String,Object> params);

}
