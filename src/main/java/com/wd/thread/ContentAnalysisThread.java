package com.wd.thread;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.wd.backend.model.History;
import com.wd.backend.model.Org;
import com.wd.backend.model.SystemLog;
import com.wd.backend.service.ContentAnalysisServiceI;
import com.wd.backend.service.MailService;
import com.wd.browse.service.AdditionServiceI;
import com.wd.front.service.SearchLogServiceI;

public class ContentAnalysisThread implements Runnable {
	
	public ContentAnalysisServiceI contentAnalysisService;
//	public List<Map<String,Object>> list;
//	public Org org;
//	public List<History> historyList;
//	public String[] keywords;
	public Map<String,Object> params;
	public String username;
	public ContentAnalysisThread(ContentAnalysisServiceI contentAnalysisService,Map<String,Object> params,String username) {
		this.contentAnalysisService = contentAnalysisService;
		this.params = params;
		this.username = username;
	}

	@Override
	public void run() {
//		contentAnalysisService.addContentAnalysisThread(params, username);
	}

}
