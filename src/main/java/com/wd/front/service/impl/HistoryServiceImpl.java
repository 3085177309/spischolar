package com.wd.front.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.HistoryDaoI;
import com.wd.backend.model.History;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.HistoryServiceI;

@Service("historyService")
public class HistoryServiceImpl implements HistoryServiceI{
	
	@Autowired
	private HistoryDaoI historyDao;

	@Override
	public Pager findPage(Integer systemId,Integer memberId, Integer type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		params.put("systemId", systemId);
		int total=historyDao.findCount(params);
		Pager p=new Pager();
		p.setTotal(total);
		if(total>0){
			if(type == -10) { //如果是-10，则是将未登录用户的记录收藏到已登录用户中
				params.put("type", null);
			} else {
				if(type != 2) {
					params.put("offset", SystemContext.getOffset());
					params.put("size", 10);
				}
				params.put("systemType", type);
			}
			p.setRows(historyDao.findList(params));
		}
		return p;
	}

	@Override
	public void insert(History history) {
		//插入记录,异步的方式插入？
		historyDao.insert(history);
	}

	@Override
	public List<History> findTopN(Integer top, Integer systemId,Integer memberId, Integer type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("size", top);
		params.put("systemId", systemId);
		params.put("memberId", memberId);
		params.put("systemType", type);
		return historyDao.findTopN(params);
	}

	@Override
	public void deleteHistory(Integer id,Integer type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("systemType", type);
		if(type == 0) {
			params.put("memberId", id);
		} else {
			params.put("id", id);
		}
		historyDao.deleteHistory(params);
	}
	
	@Override
	public List<History> findListForSearch(Integer memberId, String keyword,String type) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		params.put("systemType", type);
		params.put("keyword", "%"+keyword+"%");
		params.put("val", keyword);
		List<History> list = historyDao.findListForSearch(params);
		return list;
	}
}
