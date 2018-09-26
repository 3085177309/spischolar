package com.wd.backend.model;

/**
 * 敏感词
 * @author Shenfu
 *
 */
public class SensitiveWord {
	
	private Integer id;
	
	/**词汇内容*/
	private String words;
	
	/**添加机构*/
	private String orgFlag;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWords() {
		return words;
	}

	public void setWords(String words) {
		this.words = words;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

}
