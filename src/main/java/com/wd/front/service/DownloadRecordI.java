package com.wd.front.service;

import com.wd.backend.model.DownloadInfo;

public interface DownloadRecordI {
	
	public int saveOrUpdateDownloadRecord(String title,String url);
	
	public void insertDownloadRecordInfo(DownloadInfo info);

}
