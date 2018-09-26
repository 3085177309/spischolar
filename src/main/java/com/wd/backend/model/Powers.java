package com.wd.backend.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Powers implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	/**
	 * 栏目名称
	 */
	private String columnName;
	/**
	 * 父id
	 */
	private int pid;
	/**
	 * 连接
	 */
	private String url;
	/**
	 * 权限连接
	 */
	private String permissionUrl;
	/**
	 * 机构list
	 */
	private List<Org> org;
	
	private List<Powers> nodes = new ArrayList<Powers>();
	
	
	public List<Powers> getNodes() {
		return nodes;
	}
	public void setNodes(List<Powers> nodes) {
		this.nodes = nodes;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public List<Org> getOrg() {
		return org;
	}
	public void setOrg(List<Org> org) {
		this.org = org;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPermissionUrl() {
		return permissionUrl;
	}
	public void setPermissionUrl(String permissionUrl) {
		this.permissionUrl = permissionUrl;
	}
	
}
