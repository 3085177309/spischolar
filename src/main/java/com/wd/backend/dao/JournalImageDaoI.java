package com.wd.backend.dao;

import com.wd.backend.model.JournalImage;

public interface JournalImageDaoI {
	/**
	 * 获得期刊图片
	 * @param jguid
	 * @return
	 */
	public JournalImage findImage(String jguid);
}
