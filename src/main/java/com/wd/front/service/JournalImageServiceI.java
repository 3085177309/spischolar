package com.wd.front.service;

import com.wd.backend.model.JournalImage;

public interface JournalImageServiceI {
	/**
	 * 获取期刊图片
	 * @param jguid
	 * @return
	 */
	public JournalImage findImage(String jguid);
}
