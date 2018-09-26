package com.wd.front.service;

import java.util.List;

import com.wd.backend.model.BrowseCount;
import com.wd.backend.model.ChickPage;

/**
 * 访客浏览数据
 * @author 杨帅菲
 *
 */
public interface BrowseServiceI {
	/**
	 * 用户一次完整访问的信息
	 * @param browseCount
	 * @return
	 */
	public void insertPageNum(BrowseCount browseCount);
	/**
	 * 用户一次完整访问的访问行为信息
	 * @param chickPage
	 * @return
	 */
	public void insertChickPage(ChickPage chickPage);
	
	public List<BrowseCount> findRefOrg();

}
