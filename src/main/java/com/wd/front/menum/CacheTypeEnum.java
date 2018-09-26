package com.wd.front.menum;

/**
 * 缓存类型
 * 
 * @author pan
 * 
 */
public enum CacheTypeEnum {

	/**
	 * 检索缓存
	 */
	search_cache {
		@Override
		public String value() {
			return "0";
		}
	},
	/**
	 * 分面缓存
	 */
	facet_cache {
		@Override
		public String value() {
			return "1";
		}
	};

	public abstract String value();
}
