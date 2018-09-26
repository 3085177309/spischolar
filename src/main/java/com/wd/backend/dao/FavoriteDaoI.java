package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.Favorite;
import com.wd.backend.model.Video;

public interface FavoriteDaoI {
	
	public void insert(Favorite favorite);
	
	public void delete(Map<String,Object> params);
	/**
	 * 登录后将登录前的收藏收藏到登录后的用户中
	 * @param params
	 */
	public void update(Map<String,Object> params);
	
	public Favorite getByDocId(Map<String,Object> params);
	
	public Integer findCount(Map<String,Object> params);
	
	public List<Favorite> findList(Map<String,Object> params);
	
	public List<Favorite> findToN(Map<String,Object> params);
	
	/**
	 * 查询投稿视频文件
	 * @param jguid
	 * @return
	 */
	public Video getVideo(Map<String,Object> params);

}
