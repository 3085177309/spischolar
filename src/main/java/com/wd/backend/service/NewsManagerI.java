package com.wd.backend.service;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.News;

public interface NewsManagerI {
	
	public void add(News news);
	
	public News detail(Integer id);
	
	public void update(News news);
	
	public Pager search(String key,String type);
	
	public void delete(Integer id);
	
	public void verify(Integer id,Integer isShow);

}
