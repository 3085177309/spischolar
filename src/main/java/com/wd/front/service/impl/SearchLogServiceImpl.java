package com.wd.front.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.ContentAnalysisDaoI;
import com.wd.backend.dao.HistoryDaoI;
import com.wd.backend.dao.HotDaoI;
import com.wd.backend.dao.LogDaoI;
import com.wd.backend.model.ExceptionInfo;
import com.wd.backend.model.History;
import com.wd.backend.model.Hot;
import com.wd.backend.model.SystemLog;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.SearchLogServiceI;
import com.wd.thread.SearchLogThread;

@Service("searchLogService")
public class SearchLogServiceImpl implements SearchLogServiceI {

	@Autowired
	private LogDaoI logDao;
	
	@Autowired
	private HotDaoI hotDao;
	
	@Autowired
	private HistoryDaoI historyDao;
	
	@Autowired
	private ContentAnalysisDaoI contDao;

	@Override
	public void addSearchLog(SystemLog log) {
		// 记录检索日志
		/*
		if (SimpleUtil.strNotNull(log.getValue())) {
			// 记录新检索日志
			log.setDate(new Date());
			logDao.insert(log);
		} else if (SimpleUtil.strNotNull(log.getSys()) && SimpleUtil.strNotNull(log.getSysSubj())) {
			// 记录学科体系检索日志
			log.setDate(new Date());
			SystemLog sysLog = new SystemLog();
			BeanUtils.copyProperties(log, sysLog);
			sysLog.setField("sys");
			sysLog.setValue(log.getSys());
			logDao.insert(sysLog);

			log.setField("sysSub");
			log.setValue(log.getSys() + "-->" + log.getSysSubj());
			logDao.insert(log);
		}*/
		logDao.insert(log);
	}
	
	private ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);

	@Override
	public void addAsynSearchLog(SystemLog log) {
		fixedThreadPool.execute(new SearchLogThread(this, log));
	}
	
	@Override
	public void addSysLog(SystemLog log) {
		SystemLog sysLog = new SystemLog();
		BeanUtils.copyProperties(log, sysLog);
		sysLog.setField("sys");
		sysLog.setValue(log.getSys());
		this.addSearchLog(sysLog);

		SystemLog sysSubjLog = new SystemLog();
		BeanUtils.copyProperties(log, sysSubjLog);
		sysSubjLog.setField("sysSub");
		sysSubjLog.setValue(log.getSysSubj());
		this.addSearchLog(sysSubjLog);
	}

	@Override
	public Map<String, Integer> searchOverview(String orgFlag, String siteFlag, Integer time) {
		Map<String, Integer> result = new HashMap<String, Integer>(3);

		Map<String, Object> params = new HashMap<String, Object>(3);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		// 获取期刊详细页打开总次数
		Integer detailOpenCount = logDao.getDetailOpenCount(params);
		result.put("detailOpenCount", detailOpenCount);

		// 获取期刊检索总次数
		Integer journalSearchCount = logDao.getJournalSearchCount(params);
		result.put("journalSearchCount", journalSearchCount);

		// 获取文章检索总次数
		Integer docSearchCount = logDao.getDocSearchCount(params);
		result.put("docSearchCount", docSearchCount);

		return result;
	}

	@Override
	public Pager searchJournalWordLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(5);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalWordLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalWordLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchIssnLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(3);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalIssnLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalIssnLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchSysLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalSysLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalSysLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchSysSubjLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalSysSubjLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalSysSubjLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchDetailLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalDetailLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalDetailLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchJournalMainLinkLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getJournalMainLinkLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findJournalMainLinkLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchDocTitleLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getDocTitleLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findDocTitleLog(params);
			pager.setRows(logs);
		}

		return pager;
	}

	@Override
	public Pager searchDocHomePageLog(String orgFlag, String siteFlag, Integer time) {
		Pager pager = new Pager();

		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("siteFlag", siteFlag);
		params.put("date", time);
		params.put("size", 10);
		params.put("offset", SystemContext.getOffset());
		Integer count = logDao.getDocLinkLogCount(params);
		pager.setTotal(count);

		if (count > 0) {
			List<SystemLog> logs = logDao.findDocLinkLog(params);
			pager.setRows(logs);
		}

		return pager;
	}



	
	public static class HotLogThread implements Runnable{
		
		private SearchLogServiceI service;
		
		private Hot hot;
		
		private static final Object empty=new Object();
		
		public HotLogThread(SearchLogServiceI service ,Hot hot){
			this.service=service;
			this.hot=hot;
		}

		@Override
		public void run() {
			synchronized (empty) {
				service.saveHotLog(hot);
			}
		}
		
	}
	
	public static class HistoryThread implements Runnable{
		
		private SearchLogServiceI service;
		
		private History history;
		
		private static final Object empty=new Object();
		
		public HistoryThread(SearchLogServiceI service ,History history){
			this.service=service;
			this.history=history;
		}

		@Override
		public void run() {
			synchronized (empty) {
				service.addHistory(history);
			}
		}
		
	}

	@Override
	public void addAsynHotLog(String orgFlag,String title, String flag) {
		Hot hot=new Hot(orgFlag,title,flag);
		fixedThreadPool.execute(new HotLogThread(this, hot));
	}

	@Override
	public void addAsynHotLog(String orgFlag,String keyword) {
		Hot hot=new Hot(orgFlag,keyword);
		fixedThreadPool.execute(new HotLogThread(this, hot));
	}

	@Override
	public void saveHotLog(Hot log) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("title", log.getTitle());
		params.put("orgFlag", log.getOrgFlag());
		params.put("type", log.getType());
		Hot hot=hotDao.getByTitle(params);
		if(hot==null){
			hotDao.insert(log);
		}else{
			hot.setCounts(hot.getCounts()+1);
			hotDao.update(hot);
		}
	}

	@Override
	public void addHistory(History history) {
		Map<String,Object> params=new HashMap<String,Object>();
		History record=null;
		if(StringUtils.isNotBlank(history.getBatchId())){//如果
			if(history.getSystemType()==1){//检索,检索只记录一次
				params.put("batchId", history.getBatchId());
				params.put("type", 1);
				record=historyDao.findOne(params);
			}else{//查看，根据标题和地址进行判断
				params.put("batchId", history.getBatchId());
				params.put("url", history.getUrl());
				record=historyDao.findOne(params);
			}
		}
		if(history.getTime() == null) {
			history.setTime(new Date());
		}
		if(history.getMethod() != null && "search".equals(history.getMethod())) {
			historyDao.insert(history);
		}
		//historyDao.insertAnalysis(history);
		contDao.insertAnalysis(history);
	}

	@Override
	public void addAsynHistory(History history) {
		fixedThreadPool.execute(new HistoryThread(this, history));
	}

	@Override
	public void insertException(ExceptionInfo info) {
		historyDao.insertException(info);
	}
}
