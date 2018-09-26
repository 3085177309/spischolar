package com.wd.front.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.PageDaoI;
import com.wd.backend.model.Page;
import com.wd.front.service.PageServiceI;

@Service("pageService")
public class PageServiceImpl implements PageServiceI{
	
	@Autowired
	private PageDaoI pageDao;

	@Override
	public Page get(Integer id) {
		return pageDao.get(id);
	}

}
