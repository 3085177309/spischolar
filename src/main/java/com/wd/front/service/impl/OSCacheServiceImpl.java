package com.wd.front.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.opensymphony.oscache.base.NeedsRefreshException;
import com.wd.front.bo.BaseCache;
import com.wd.front.module.cache.impl.CacheModuleImpl;
import com.wd.front.service.CacheServiceI;
import com.wd.front.service.ExpireException;

public class OSCacheServiceImpl implements CacheServiceI{
	
	private BaseCache cache;
	
	public OSCacheServiceImpl(){
		InputStream inputStream = CacheModuleImpl.class.getClassLoader().getResourceAsStream("oscache.properties");
		Properties prop = new Properties();
		if (null == inputStream) {
			throw new RuntimeException("获取oscache.properties文件的输入流");
		}
		try {
			prop.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		int cacheTime = 60 * 60 * 23 + 60 * 57;
		cache = new BaseCache("jnav", cacheTime, prop);
	}

	@Override
	public void put(String key, Object value) {
		cache.put(key, value);
	}

	@Override
	public Object get(String key) throws ExpireException {
		try {
			return cache.get(key);
		} catch (NeedsRefreshException e) {
			throw new ExpireException("缓存过期!",e);
		}
	}

}
