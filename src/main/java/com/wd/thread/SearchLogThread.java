package com.wd.thread;

import com.wd.backend.model.SystemLog;
import com.wd.front.service.SearchLogServiceI;

public class SearchLogThread implements Runnable {

	private SearchLogServiceI logService;
	private SystemLog log;

	public SearchLogThread(SearchLogServiceI logService, SystemLog log) {
		this.logService = logService;
		this.log = log;
	}

	@Override
	public void run() {
		logService.addSearchLog(log);
	}

}
