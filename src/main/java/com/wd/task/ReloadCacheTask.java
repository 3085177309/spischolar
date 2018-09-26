package com.wd.task;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.wd.exeception.SystemException;
import com.wd.front.module.cache.CacheModuleI;

/**
 * 缓存重加载任务
 * 
 * @author pan
 * 
 */
@Component("reloadCacheTask")
public class ReloadCacheTask {
	
	private static final Logger log=Logger.getLogger(ReloadCacheTask.class);

	@Autowired
	private CacheModuleI cacheModule;

	public void execute() {
		try {
			// 重加载全局缓存
			cacheModule.reloadOverallSituationCache();
			// 重加载机构缓存
			cacheModule.reloadAllOrgCache();
			System.out.println(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date())+" >>>>>>>>>缓存重加载完毕...");
		} catch (SystemException e) {
			e.printStackTrace();
		}
	}
}
