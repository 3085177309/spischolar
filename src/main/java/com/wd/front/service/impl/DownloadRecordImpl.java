package com.wd.front.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.dao.DownloadRecordDaoI;
import com.wd.backend.model.Download;
import com.wd.backend.model.DownloadInfo;
import com.wd.front.service.DownloadRecordI;

@Service("downloadRecordService")
public class DownloadRecordImpl implements DownloadRecordI{
	
	@Autowired
	DownloadRecordDaoI downloadRecordDao;
	
	/**
	 * 根据标题URL查找下载信息
	 */
	@Override
	public int saveOrUpdateDownloadRecord(String title,String url) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("title", title);
		params.put("url", url);
		Download download = downloadRecordDao.findDownloadRecord(params);
		//如果已经存在，就num++；不然就添加
		if(download != null) {
			params = new HashMap<String, Object>();
			params.put("num", download.getNum()+1);
			params.put("id", download.getId());
			downloadRecordDao.updateDownloadRecord(params);
			return download.getId();
		} else {
			download = new Download();
			download.setNum(1);
			download.setTitle(title);
			download.setUrl(url);
			return downloadRecordDao.insertDownloadRecord(download);
		}
	}
	/**
	 * 添加详细
	 */
	@Override
	public void insertDownloadRecordInfo(DownloadInfo info) {
		downloadRecordDao.insertDownloadRecordInfo(info);
		
	}

}
