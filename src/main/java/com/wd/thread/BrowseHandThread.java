package com.wd.thread;

import java.util.Map;

import com.wd.browse.service.AdditionServiceI;
/**
 * 手动添加数据线程
 * @author Administrator
 *
 */
public class BrowseHandThread implements Runnable {

	public AdditionServiceI additionService;
	private Integer browseHandId;

	public BrowseHandThread(AdditionServiceI additionService,Integer browseHandId) {
		this.additionService = additionService;
		this.browseHandId = browseHandId;
		
	}

	@Override
	public void run() {
		additionService.browseHandStartThread(browseHandId);
	}

}
