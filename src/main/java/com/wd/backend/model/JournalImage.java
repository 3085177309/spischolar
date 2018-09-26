package com.wd.backend.model;

import java.io.Serializable;

public class JournalImage implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String jguid;
	private byte[] logo;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getJguid() {
		return jguid;
	}
	public void setJguid(String jguid) {
		this.jguid = jguid;
	}
	public byte[] getLogo() {
		return logo;
	}
	public void setLogo(byte[] logo) {
		this.logo = logo;
	}
	
}
