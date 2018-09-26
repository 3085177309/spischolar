package com.wd.front.service.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.BrowseDaoI;
import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.ChickPage;
import com.wd.front.interceptor.LoginInterceptor;
import com.wd.front.listener.SessionListener;
import com.wd.front.service.BrowseServiceI;

@Service("browseService")
public class BrowseServiceImpl implements BrowseServiceI {
	private static final Logger logger=Logger.getLogger(BrowseServiceImpl.class);
	@Autowired
	private BrowseDaoI browseDao;
	
	@Override
	public void insertPageNum(BrowseCount browseCount) {
		browseDao.insertPageNum(browseCount);
	}

	@Override
	public void insertChickPage(ChickPage chickPage) {
		try {
			logger.info("insertChickPage");
			browseDao.insertChickPage(chickPage);
		} catch(Exception e) {
			logger.info(e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public List<BrowseCount> findRefOrg() {
		return browseDao.findRefOrg();
	}
	
}
