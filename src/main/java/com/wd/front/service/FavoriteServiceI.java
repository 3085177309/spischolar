package com.wd.front.service;

import java.util.List;

import com.wd.backend.bo.Pager;
import com.wd.backend.model.Favorite;
import com.wd.backend.model.Video;

public interface FavoriteServiceI {
	
	public void delete(String id,String memberId);
	/**
	 * 登录后将登录前的收藏收藏到登录后的用户中
	 * 
	 * @param oldId
	 * @param memberId
	 */
	public void update(String oldId,String memberId);
	
	public void save(Favorite favorite);
	
	public Pager findPager(Integer memberId,Integer type);
	
	public List<Favorite> findTopN(Integer top,Integer memberId,Integer type);
	
	public Favorite getByDocId(String docId,int memberId);
	
	/**
	 * 查询投稿视频
	 * @param jguid
	 * @return
	 */
	public Video getVideo(String jguid);

}
