package com.wd.util;

import java.util.concurrent.locks.ReadWriteLock;

import org.apache.ibatis.cache.Cache;
import org.mybatis.caches.oscache.OSCache;
import org.springframework.util.DigestUtils;

/**
 * 对OSCache的包装，实现对保存缓存时的Key值的修改，将Key值修改为一个Md5码
 * OSCache是一个final 类，无法实现继承。
 * 1.继承自Cache类需要提供一个读写锁，直接调用OSCache的相关实现是否会造成并发问题？是否要提供一个新的读写锁
 * 2.可以考虑到:调用getObject时需要使用读锁，而调用putObject和removeObject时需要使用到写锁
 * 使用如下方式调用时，应该安全的:
 * <pre>
 * 	OSCacheUtil util=new OSCacheUtil();
 * 	ReadWriteLock rwlock=util.getReadWriteLock()
 * 	rwlock.readLock.lock();
 * 	try{
 * 		util.getObject(key);
 * 	}finally{
 * 		rwlock.readLock.unlock();
 * 	}
 * </pre>
 * @author Shenfu
 *
 */
public final class OSCacheUtil implements Cache{
	
	private final OSCache cache;
	
	public OSCacheUtil(final String id){
		cache=new OSCache(id);
	}
	
	private String getKey(final Object key){
		return DigestUtils.md5DigestAsHex(key.toString().getBytes());
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public String getId() {
		return cache.getId();
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public int getSize() {
		return cache.getSize();
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public void putObject(final Object key, final Object value) {
		String keyStr=getKey(key);
		cache.putObject(keyStr, value);
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public Object getObject(final Object key) {
		String keyStr=getKey(key);
		return cache.getObject(keyStr);
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public Object removeObject(final Object key) {
		String keyStr=getKey(key);
		return cache.removeObject(keyStr);
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public void clear() {
		cache.clear();
	}

	/**
     * {@inheritDoc}
     */
	@Override
	public ReadWriteLock getReadWriteLock() {
		return cache.getReadWriteLock();
	}
	
	 /**
     * {@inheritDoc}
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if ((obj instanceof Cache)) {
           return cache.equals(obj);
        }
        if(obj instanceof OSCacheUtil){
        	return cache.equals(((OSCacheUtil) obj).cache);
        }
        return false;
    }


    /**
     * {@inheritDoc}
     */
    @Override
    public String toString() {
        return cache.toString();
    }

}
