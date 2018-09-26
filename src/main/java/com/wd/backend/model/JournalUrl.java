package com.wd.backend.model;

import java.io.Serializable;

public class JournalUrl implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String titleId;
	private String titleUrl;
	private String dbName;
	/**
	 * -1表示主页连接
	 * 1表示数据库连接
	 */
	private Integer isMain;

	public JournalUrl() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitleId() {
		return titleId;
	}

	public void setTitleId(String titleId) {
		this.titleId = titleId;
	}

	public String getTitleUrl() {
		return titleUrl;
	}

	public void setTitleUrl(String titleUrl) {
		this.titleUrl = titleUrl;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public Integer getIsMain() {
		return isMain;
	}

	public void setIsMain(Integer isMain) {
		this.isMain = isMain;
	}
}
