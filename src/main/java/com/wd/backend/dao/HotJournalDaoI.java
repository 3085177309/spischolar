package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.backend.model.HotJournal;

public interface HotJournalDaoI {

	/**
	 * 查找热门期刊
	 * 
	 * @param params
	 * @return
	 */
	List<HotJournal> findByDocId(Map<String, Object> params);

	/**
	 * 插入
	 * 
	 * @param hotJournal
	 */
	void insert(HotJournal hotJournal);

	/**
	 * 更新点击量
	 * 
	 * @param hotJournal
	 */
	void update(HotJournal hotJournal);

	/**
	 * 查找最多点击量期刊
	 * 
	 * @param params
	 * @return
	 */
	List<HotJournal> findHotJouranls(Map<String, Object> params);

}
