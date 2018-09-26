package com.wd.backend.service;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Page;

public interface PageManagerI {
	
	public Pager findByPager();
	
	public Page get(Integer id);
	
	public void delete(Integer id);
	
	public void add(Page page);
	
	public void edit(Page page);

}
