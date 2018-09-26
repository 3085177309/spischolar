package com.wd.backend.model;

import java.util.Date;

import com.wd.util.DelHtmlTag;

/**
 * 检索历史
 * @author Administrator
 *
 */
public class History {
	
	private String id;
	
	/**检索关键词/标题 */
	private String keyword;
	
	/**地址,如果是期刊的话就是期刊的ID*/
	private String url;
	
	/**检索时间*/
	private Date time;
	
	/**检索批次ID*/
	private String batchId;
	
	/** 1 期刊导航，2学术发现*/
	private Integer systemId;
	
	/**
	 * 1搜索，2查看
	 */
	private Integer systemType;
	
	private Integer memberId;
	
	private String orgFlag;
	/**学科体系 */
	private String db;
	/**区分期刊检索，浏览 */
	private String method;
	
	private Integer type;

	public String getDb() {
		return db;
	}

	public void setDb(String db) {
		this.db = db;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		keyword = DelHtmlTag.delHTMLTag(keyword);
		this.keyword = keyword;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public Integer getSystemId() {
		return systemId;
	}

	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}

	public Integer getSystemType() {
		return systemType;
	}

	public void setSystemType(Integer systemType) {
		this.systemType = systemType;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}
