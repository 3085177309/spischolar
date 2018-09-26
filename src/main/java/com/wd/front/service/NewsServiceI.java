package com.wd.front.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.News;

public interface NewsServiceI {
	
	public List<News> findToN(Integer top);
	
	public Pager findPager();
	
	public void addReadTimes(Integer id);
	
	public void addPraiseTimes(Integer id);
	
	public News detail(Integer id);
	
	public News prev(Integer id);
	
	public News next(Integer id);

}
