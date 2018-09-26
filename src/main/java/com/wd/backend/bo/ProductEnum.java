package com.wd.backend.bo;

/**
 * 产品类型
 * @author Administrator
 *
 */
public enum ProductEnum {
	/**
	 * 期刊导航
	 */
	JournalNav{
		@Override
		public int value() {
			return 1;
		}
		
		@Override
		public String text(){
			return "期刊导航";
		}
	},

	/**
	 * 轻学术发现
	 */
	AcademicDiscovery{
		@Override
		public int value() {
			return 2;
		}
		@Override
		public String text(){
			return "轻学术发现";
		}
	},
	/**
	 * 数据库导航
	 */
	DatabaseNav{
		@Override
		public int value() {
			return 3;
		}
		@Override
		public String text(){
			return "数据库导航";
		}
	},
	/**
	 * CSR核心论文库
	 */
	CSR{
		@Override
		public int value() {
			return 4;
		}
		@Override
		public String text(){
			return "CSR核心论文库";
		}
	}
	;
	
	public abstract int value();
	
	public abstract String text();

}
