package com.wd.backend.model;

public class Database {

	private Integer id;
	private String cnName;
	private String enName;
	private String descDB;
	private String url;
	private String kmUrl;

	public Database() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCnName() {
		return cnName;
	}

	public void setCnName(String cnName) {
		this.cnName = cnName;
	}

	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getKmUrl() {
		return kmUrl;
	}

	public void setKmUrl(String kmUrl) {
		this.kmUrl = kmUrl;
	}

	public String getDescDB() {
		return descDB;
	}

	public void setDescDB(String descDB) {
		this.descDB = descDB;
	}

}
