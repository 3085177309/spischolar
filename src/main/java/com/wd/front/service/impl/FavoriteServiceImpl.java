package com.wd.front.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.FavoriteDaoI;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.Video;
import com.wd.comm.context.SystemContext;
import com.wd.front.service.FavoriteServiceI;
import com.wd.front.service.OperationException;

@Service("favoriteService")
public class FavoriteServiceImpl implements FavoriteServiceI{
	
	@Autowired
	private FavoriteDaoI favoriteDao;

	@Override
	public void delete(String id,String memberId) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("docId", id);
		params.put("memberId",memberId);
		favoriteDao.delete(params);
	}
	
	@Override
	public void update(String oldId,String memberId) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("oldId", oldId);
		params.put("memberId",memberId);
		favoriteDao.update(params);
	}

	@Override
	public void save(Favorite favorite) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("docId", favorite.getDocId());
		params.put("memberId",favorite.getMemberId());
		Favorite f = favoriteDao.getByDocId(params);
		if(f != null ){
			throw new OperationException("已经收藏该记录!");
		}
		favorite.setTime(new Date());
		favoriteDao.insert(favorite);
	}
	
	@Override
	public List<Favorite> findTopN(Integer top,Integer memberId,Integer type){
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("top", top);
		params.put("type", type);
		params.put("memberId",memberId);
		return favoriteDao.findToN(params);
	}

	@Override
	public Pager findPager(Integer memberId,Integer type) {
		Pager p=new Pager();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		params.put("type", type);
		int total=favoriteDao.findCount(params);
		p.setTotal(total);
		if(total>0){
			params.put("offset", SystemContext.getOffset());
			params.put("size", 10);
			p.setRows(favoriteDao.findList(params));
		}
		return p;
	}

	@Override
	public Favorite getByDocId(String docId,int memberId) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("memberId", memberId);
		params.put("docId", docId);
		return favoriteDao.getByDocId(params);
//		return null;
	}
	
	@Override
	public Video getVideo(String jguid) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("jguid", jguid);
		return favoriteDao.getVideo(params);
	}

}
