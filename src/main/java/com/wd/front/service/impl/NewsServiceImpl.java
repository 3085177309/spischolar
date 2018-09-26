package com.wd.front.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.NewsDaoI;
import com.wd.backend.model.News;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.NewsServiceI;

@Service("newsService")
public class NewsServiceImpl implements NewsServiceI{
	
	@Autowired
	private NewsDaoI newsDao;

	@Override
	public List<News> findToN(Integer top) {
		return newsDao.findTopN(top);
	}

	@Override
	public Pager findPager() {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("isShow", true);
		int total=newsDao.findCount(params);
		Pager p=new Pager();
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			p.setRows(newsDao.findPager(params));
		}
		return p;
	}

	@Override
	public void addReadTimes(Integer id) {
		newsDao.updateTimes(id);
	}

	@Override
	public News detail(Integer id) {
		return newsDao.get(id);
	}

	@Override
	public News prev(Integer id) {
		return newsDao.prev(id);
	}

	@Override
	public News next(Integer id) {
		return newsDao.next(id);
	}

	@Override
	public void addPraiseTimes(Integer id) {
		newsDao.increPraise(id);
	}

}
