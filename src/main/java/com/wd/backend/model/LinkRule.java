package com.wd.backend.model;

/**
 * 连接规则模型
 * <pre>
 * 	约束：
 * 		1、name 规则名非空
 * 		2、rule 真实规则，非空
 * </pre>
 * @author pan
 *
 */
public class LinkRule {

	private Integer id;
	/**
	 * 规则名
	 */
	private String name;
	/**
	 * 真实规则
	 */
	private String rule;
	private String linkRule;
	/**
	 * 所属机构
	 */
	private Integer orgId;
	/**
	 * 所属数据库
	 */
	private Integer dbId;
	private Integer isUse;

	public LinkRule() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public String getLinkRule() {
		return linkRule;
	}

	public void setLinkRule(String linkRule) {
		this.linkRule = linkRule;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public Integer getDbId() {
		return dbId;
	}

	public void setDbId(Integer dbId) {
		this.dbId = dbId;
	}

	public Integer getIsUse() {
		return isUse;
	}

	public void setIsUse(Integer isUse) {
		this.isUse = isUse;
	}
}
