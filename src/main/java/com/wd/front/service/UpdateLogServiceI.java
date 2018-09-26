package com.wd.front.service;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.UpdateLog;

public interface UpdateLogServiceI {
	
	public Pager findPager();
	
	public void addReadTimes(Integer id);
	
	public void addPriceTimes(Integer id);
	
	public UpdateLog detail(Integer id);
	
	public UpdateLog prev(Integer id);
	
	public UpdateLog next(Integer id);

}
