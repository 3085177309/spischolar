package com.wd.front.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.UpdateLogDaoI;
import com.wd.backend.model.UpdateLog;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.UpdateLogServiceI;

@Service("updateLogService")
public class UpdateLogServiceImpl implements UpdateLogServiceI{
	
	@Autowired
	private UpdateLogDaoI updateLogDao;

	@Override
	public Pager findPager() {
		Pager p=new Pager();
		Map<String,Object> params=new HashMap<String,Object>();
		int total=updateLogDao.findCount(params);
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(updateLogDao.findPager(params));
		}
		return p;
	}

	@Override
	public void addReadTimes(Integer id) {
		updateLogDao.increTimes(id);
	}

	@Override
	public void addPriceTimes(Integer id) {
		updateLogDao.increPraise(id);
	}

	@Override
	public UpdateLog detail(Integer id) {
		return updateLogDao.get(id);
	}

	@Override
	public UpdateLog prev(Integer id) {
		return updateLogDao.prev(id);
	}

	@Override
	public UpdateLog next(Integer id) {
		return updateLogDao.next(id);
	}

}
