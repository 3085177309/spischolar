package com.wd.backend.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 订购的产品
 * @author Administrator
 *
 */
public class Product implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;

	private Integer orgId;

	private String orgFlag;

	private String orgName;

	private String productName;

	private Integer productId;

	private Date startDate;

	private Date endDate;
	/**
	 * 是否单独购买
	 */
	private boolean single;



	/**
	 * 状态 1：购买，2试用,0:停用
	 */
	private Short status;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrgId() {
		return orgId;
	}

	public void setOrgId(Integer orgId) {
		this.orgId = orgId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public boolean isSingle() {
		return single;
	}

	public void setSingle(boolean single) {
		this.single = single;
	}
}
