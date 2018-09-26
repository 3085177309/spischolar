package com.wd.backend.bo;

public class TemplateFileInfo {

	/**
	 * 机构标识
	 */
	private String orgFlag;
	/**
	 * 站点标识
	 */
	private String siteFlag;
	/**
	 * 模版根目录名
	 */
	private String templateFlag;
	/**
	 * 文件名
	 */
	private String fileName;
	/**
	 * 文件内容
	 */
	private String content;

	public TemplateFileInfo() {
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public String getSiteFlag() {
		return siteFlag;
	}

	public void setSiteFlag(String siteFlag) {
		this.siteFlag = siteFlag;
	}

	public String getTemplateFlag() {
		return templateFlag;
	}

	public void setTemplateFlag(String templateFlag) {
		this.templateFlag = templateFlag;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
