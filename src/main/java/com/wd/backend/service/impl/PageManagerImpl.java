package com.wd.backend.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.PageDaoI;
import com.wd.backend.model.Page;
import com.wd.backend.service.PageManagerI;
import com.wd.comm.context.SystemContext;

@Service("pageManager")
public class PageManagerImpl implements PageManagerI{
	
	@Autowired
	private PageDaoI pageDao;

	@Override
	public Pager findByPager() {
		Pager p =new  Pager();
		Map<String,Object> params=new HashMap<String,Object>();
		int total=pageDao.findCount(params);
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(pageDao.findList(params));
		}
		return p;
	}

	@Override
	public Page get(Integer id) {
		return pageDao.get(id);
	}

	@Override
	public void delete(Integer id) {
		pageDao.delete(id);
	}

	@Override
	public void add(Page page) {
		page.setAddDate(new Date());
		pageDao.insert(page);
	}

	@Override
	public void edit(Page page) {
		page.setAddDate(new Date());
		pageDao.update(page);
	}

}
