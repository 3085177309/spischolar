package com.wd.front.service;

/**
 * 缓存服务
 * @author Administrator
 *
 */
public interface CacheServiceI {
	
	public void put(String key,Object value);
	
	public Object get(String key) throws ExpireException;

}
