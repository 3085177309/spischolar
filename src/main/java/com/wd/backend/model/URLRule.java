package com.wd.backend.model;

/**
 * URL替换规则
 * @author Shenfu
 *
 */
public class URLRule {
	
	/**ID*/
	private Integer id;
	
	/**资源名称*/
	private String name;
	
	/**Google学术地址*/
	private String gsUrl;
	
	/**替换成本地的地址*/
	private String localUrl;
	
	/**机构标识*/
	private String orgFlag;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGsUrl() {
		return gsUrl;
	}

	public void setGsUrl(String gsUrl) {
		this.gsUrl = gsUrl;
	}

	public String getLocalUrl() {
		return localUrl;
	}

	public void setLocalUrl(String localUrl) {
		this.localUrl = localUrl;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
