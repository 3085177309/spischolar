package com.wd.backend.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.NewsDaoI;
import com.wd.backend.model.News;
import com.wd.backend.service.NewsManagerI;
import com.wd.comm.context.SystemContext;

@Service("newsManager")
public class NewsManagerImpl implements NewsManagerI{
	
	@Autowired
	private NewsDaoI newsDao;

	@Override
	public void add(News news) {
		news.setAddTime(new Date());
		news.setTimes(0);
		newsDao.insert(news);
	}

	@Override
	public News detail(Integer id) {
		return newsDao.get(id);
	}

	@Override
	public void update(News news) {
		newsDao.update(news);
	}

	@Override
	public Pager search(String key,String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		if(!StringUtils.isEmpty(key)){
			params.put("key", "%"+key+"%");
		}
		if(!StringUtils.isEmpty(type)) {
			params.put("type", type);
		}
		Integer count=newsDao.findCount(params);
		Pager pager=new Pager();
		pager.setTotal(count);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		pager.setRows(newsDao.findPager(params));
		return pager;
	}

	@Override
	public void delete(Integer id) {
		newsDao.delete(id);
	}

	@Override
	public void verify(Integer id, Integer isShow) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("id", id);
		params.put("isShow", isShow);
		newsDao.verify(params);
	}

}
