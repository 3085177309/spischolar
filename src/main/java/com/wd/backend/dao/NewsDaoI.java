package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.News;

public interface NewsDaoI {
	
	public void insert(News news);
	
	public void delete(Integer id);
	
	public void update(News news);
	
	public void updateTimes(Integer id);
	
	public void increPraise(Integer id);
	
	public News get(Integer id);
	
	public Integer findCount(Map<String,Object> params);
	
	public List<News> findPager(Map<String,Object> params);
	
	public List<News> findTopN(Integer top);
	
	/**获取上一条记录的ID*/
	public News next(Integer id);
	
	/**获取下一条记录的ID*/
	public News prev(Integer id);
	
	public void verify(Map<String,Object> params);

}
