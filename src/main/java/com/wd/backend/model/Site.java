package com.wd.backend.model;

import java.util.Date;

/**
 * 站点模型
 * 
 * <pre>
 * 	约束：
 * 		1、flag 非空，orgId+flag唯一
 * 		2、name 非空
 * 		3、orgId 外键
 * 		4、orgFlag 非空与机构表的数据对应
 * </pre>
 * 
 * @author Administrator
 * 
 */
public class Site {

	private Integer id;
	/**
	 * 站点标识
	 */
	private String flag;
	/**
	 * 站点名
	 */
	private String name;
	/**
	 * 当前模版目录
	 */
	private String template;

	/**
	 * 站点所属机构
	 */
	private Integer orgId;
	/**
	 * 站点创建时间
	 */
	private Date createDate;

	/**
	 * 机构标识
	 */
	private String orgFlag;

	public Site() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		if (null != flag) {
            flag = flag.trim();
        }
		this.flag = flag;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (null != name) {
            name = name.trim();
        }
		this.name = name;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		if (null != template) {
            template = template.trim();
        }
		this.template = template;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		if (null != orgFlag) {
            orgFlag = orgFlag.trim();
        }
		this.orgFlag = orgFlag;
	}
}
