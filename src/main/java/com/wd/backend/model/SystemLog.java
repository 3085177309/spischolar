package com.wd.backend.model;

import java.util.Date;

/**
 * 系统日志
 * 
 * @author pan
 * 
 */
public class SystemLog {

	private Integer id;
	/**
	 * 访问的ip
	 */
	private String ip;
	/**
	 * 机构标识
	 */
	private String orgFlag;
	/**
	 * 站点标识
	 */
	private String siteFlag;
	/**
	 * 所属机构
	 */
	private String orgName;
	/**
	 * 日志记录时间
	 */
	private Date date;
	/**
	 * 检索值
	 */
	private String value;
	/**
	 * 检索字段
	 */
	private String field;
	/**
	 * 1、表示期刊检索日志 2、表示文章检索日志
	 */
	private int type;

	private String sys;
	private String sysSubj;

	/**
	 * 检索次数
	 */
	private int count;

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getSys() {
		return sys;
	}

	public void setSys(String sys) {
		this.sys = sys;
	}

	public String getSysSubj() {
		return sysSubj;
	}

	public void setSysSubj(String sysSubj) {
		this.sysSubj = sysSubj;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getSiteFlag() {
		return siteFlag;
	}

	public void setSiteFlag(String siteFlag) {
		this.siteFlag = siteFlag;
	}
}
