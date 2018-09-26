package com.wd.backend.dao;

import java.util.List;

import com.wd.backend.model.JournalUrl;

public interface JournalUrlDaoI {

	/**
	 * 获取数据库链接,is_main等于1的都是数据库地址，其他的都是主页地址
	 * 
	 * @param journalFlag
	 * @return
	 */
	public List<JournalUrl> findDbLink(String journalFlag);

	/**
	 * 查找主页链接
	 * 
	 * @param journalFlag
	 * @return
	 */
	public JournalUrl findMainLink(String journalFlag);
}
