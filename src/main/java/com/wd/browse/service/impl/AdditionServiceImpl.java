package com.wd.browse.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Page;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.browse.service.AdditionServiceI;
import com.wd.browse.task.BrowseAddTask;
import com.wd.comm.context.SystemContext;
import com.wd.thread.BrowseHandThread;
import com.wd.util.JsonUtil;

@Service("additionService")
public class AdditionServiceImpl implements AdditionServiceI{
	
	@Autowired
	private  AdditionDaoI additionDao;

	@Override
	public List<Map<String, Object>> getKeyWordList(String orgFlag,int systemId) {
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("school", orgFlag);
		params.put("systemId", systemId);
		int count = additionDao.getKeyWordCount(params);
		if(count > 500) {
			params.put("offset", 2000);
		} else {
			params.remove("school");
			params.put("offset", 2000);
		}
		return additionDao.getScholarKeyWordList(params);
	}

	@Override
	public int getScholarInfoCount(String batchId) {
		return additionDao.getScholarInfoCount(batchId);
	}

	@Override
	public Map<String, Object> getScholarInfo(String batchId, int offset) {
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("batchId", batchId);
		params.put("offset", offset);
		return additionDao.getScholarInfo(params);
	}
	
	@Autowired
	BrowseAddTask browseAddTask;
	
	/**
	 * 自动添加pv记录
	 * @return
	 */
	@Override
	public Map<String,Object>  getAddBrowseAutomatic(String orgFlag) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orgFlag", orgFlag);
		return additionDao.getAddBrowseAutomaticByFlag(params);
	}
	@Override
	public void insertAddBrowseAutomatic(Map<String, Object> params) {
		if(StringUtils.isEmpty((String)params.get("id"))) {
			additionDao.insertAddBrowseAutomatic(params);
			logBrowseAutomatic("添加", params,"数据自动添加");
		} else {
//			logBrowseAutomatic("修改前", params,"数据自动添加");
			additionDao.editAddBrowseAutomatic(params);
			logBrowseAutomatic("修改", params,"数据自动添加");
		}
	}
	/**
	 * 添加日志
	 * @param state
	 * @param params
	 */
	private void logBrowseAutomatic(String state,Map<String, Object> params,String type) {
		Map<String,Object> param = new HashMap<String, Object>();
		if("修改前".equals(state)) {
			params = additionDao.getAddBrowseAutomaticByFlag(params);
		}
		String content = JsonUtil.obj2Json(params);
		param.put("time", new Date());
		param.put("content", content);
		param.put("state", state);
		param.put("type", type);
		param.put("orgFlag", params.get("orgFlag"));
		param.put("username", (String)params.get("username"));
		additionDao.contentAnalysisLog(param);
	}
	
	/**
	 * 手动添加pv记录
	 * @return
	 */
	@Override
	public Pager getAddBrowseInfo(String orgFlag) {
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("offset", SystemContext.getOffset());
		params.put("size", SystemContext.getPageSize());
		List<Map<String,Object>> list = additionDao.getAddBrowseHand(params);
		int total = additionDao.getAddBrowseHandCount(params);
		Pager pager = new Pager();
		pager.setRows(list);
		pager.setTotal(total);
		return pager;
	}
	
	private ExecutorService fixedThreadPool = Executors.newFixedThreadPool(100);
	
	@Override
	public Integer insertAddBrowseHand(Map<String, Object> params){
		params.put("type", 0);
		additionDao.insertAddBrowseHand(params);
		return Integer.parseInt(params.get("id").toString());  
	}
	
	@Override
	public void browseHandStart(Integer browseHandId){
		fixedThreadPool.execute(new BrowseHandThread(this, browseHandId));
	}
	
	@Override
	public void browseHandStartThread(Integer browseHandId){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", 1);
		params.put("browseHandId", browseHandId);
		additionDao.updateAddBrowseHand(params);
		browseAddTask.executeHand(browseHandId);
	}
	
	@Override
    public Map<String,Object> getAddBrowseHandById(String browseHandId, Integer type) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("id", browseHandId);
		params.put("type", type);
		return additionDao.getAddBrowseHandById(params);
	}
	
	@Override
    public Pager getContentAnalysisLog(String orgFlag, String type) {
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("orgFlag", orgFlag);
		params.put("type", type);
		params.put("offset", SystemContext.getOffset());
		params.put("size", 10);
		List<Map<String,Object>> list = additionDao.getContentAnalysisLog(params);
		int total = additionDao.getContentAnalysisLogCount(params);
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < list.size(); i++) {
			Map<String,Object> json = list.get(i);
			String content = (String) json.get("content");
			Map<String,Object> resultMap = JsonUtil.json2Obj(content, Map.class);
			resultMap.put("time", json.get("time"));
			resultMap.put("username", json.get("username"));
			resultMap.put("state", json.get("state"));
			result.add(resultMap);
		}
		Pager pager = new Pager();
		pager.setRows(result);
		pager.setTotal(total);
		return pager;
	}
	

}
