package com.wd.front.service;

import java.util.List;

import com.wd.backend.model.JournalUrl;

public interface JournalLinkServiceI {

	/**
	 * 获取数据库链接地址
	 * 
	 * @param journalFlag
	 * @return
	 */
	public List<JournalUrl> searchDbLinks(String journalFlag);

	/**
	 * 获取期刊主页链接地址
	 * 
	 * @param journalFlag
	 * @return
	 */
	public JournalUrl searchMainLink(String journalFlag);
}
