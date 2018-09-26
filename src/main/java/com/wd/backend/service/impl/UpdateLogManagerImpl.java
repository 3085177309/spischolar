package com.wd.backend.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.UpdateLogDaoI;
import com.wd.backend.model.UpdateLog;
import com.wd.backend.service.UpdateLogManagerI;
import com.wd.comm.context.SystemContext;

@Service("updateLogManager")
public class UpdateLogManagerImpl implements UpdateLogManagerI{
	
	@Autowired
	private UpdateLogDaoI updateLogDao;

	@Override
	public void add(UpdateLog log) {
		log.setAddTime(new Date());
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:MM:ss");
		if(log.getReleases() == null) {
			log.setReleases(df.format(new Date()));
		}
		updateLogDao.insert(log);
	}

	@Override
	public UpdateLog detail(Integer id) {
		return updateLogDao.get(id);
	}

	@Override
	public void delete(Integer id) {
		updateLogDao.delete(id);
	}

	@Override
	public void edit(UpdateLog log) {
		updateLogDao.update(log);
	}
	/**
	 * 查询日志
	 */
	@Override
	public Pager search(String key,int type) {
		Map<String,Object> params=new HashMap<String,Object>();
		if(!StringUtils.isEmpty(key)){
			params.put("key", "%"+key+"%");
		}
		params.put("type",type);
		Integer count=updateLogDao.findCount(params);
		Pager pager=new Pager();
		pager.setTotal(count);
		if(count>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			pager.setRows(updateLogDao.findPager(params));
		}
		return pager;
	}

	@Override
	public void updateView(UpdateLog log) {
		this.updateLogDao.updateView(log);
	}
	
	@Override
    public List<Map<Object, Object>> getLable() {
		return updateLogDao.getLable();
	}
	
	@Override
    public void insertLable(String[] lables) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		if(lables == null) {
            return;
        }
		for(int i=0; i<lables.length;i++) {
			Map<String,Object> params=new HashMap<String,Object>();
			params.put("type", (Integer.parseInt(lables[i].substring(lables[i].length()-1))+1));
			params.put("name", lables[i].substring(0, lables[i].length()-1));
			list.add(params);
		}
		updateLogDao.insertLable(list);
	}

}
