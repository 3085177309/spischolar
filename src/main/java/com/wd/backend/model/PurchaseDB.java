package com.wd.backend.model;

/**
 * 购买的数据库
 * @author Shenfu
 *
 */
public class PurchaseDB {
	
	private Integer id;
	
	/**资源名*/
	private String dbName;
	
	/**URL地址*/
	private String url;
	
	/**排序*/
	private Integer orderNum;
	
	/**
	 * 是否显示 1表示显示，0表示不显示
	 */
	private Short showDB=(short)0;
	
	/**
	 * 机构标识
	 */
	private String orgFlag;
	/**
	 * 机构名称
	 */
	private String org;
	
	private Short dbType =(short)1;

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public Short getShowDB() {
		return showDB;
	}

	public void setShowDB(Short showDB) {
		this.showDB = showDB;
	}

	public Short getDbType() {
		return dbType;
	}

	public void setDbType(Short dbType) {
		this.dbType = dbType;
	}

}
