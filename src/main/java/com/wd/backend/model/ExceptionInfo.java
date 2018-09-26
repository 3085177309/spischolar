package com.wd.backend.model;

import java.io.Serializable;
import java.util.Date;

public class ExceptionInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	/**
	 * 期刊名
	 */
	private String name;
	/**
	 * 期刊详细页地址
	 */
	private String url;
	/**
	 * 异常信息
	 */
	private String info;
	/**
	 * 访问时间
	 */
	private Date collectDate;
	/**
	 * 来源
	 */
	private String source;
	/**
	 * 原因分析
	 */
	private String remark;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Date getCollectDate() {
		return collectDate;
	}
	public void setCollectDate(Date collectDate) {
		this.collectDate = collectDate;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
