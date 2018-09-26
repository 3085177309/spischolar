package com.wd.backend.model;

/**
 * 院系
 * @author Administrator
 *
 */
public class College {
	
	private Integer id;
	
	private String name;
	
	private String orgFlag;
	
	/**优先级*/
	private Short priority;

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

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public Short getPriority() {
		return priority;
	}

	public void setPriority(Short priority) {
		this.priority = priority;
	}

}
