package com.wd.backend.model;

import java.util.List;

/**
 * 
 * @author Administrator
 *
 */
public class JournalSystemSubject {
	
	private int id;
	
	private String name;
	
	private List<AuthorityDatabase> list;
	
	private String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<AuthorityDatabase> getList() {
		return list;
	}

	public void setList(List<AuthorityDatabase> list) {
		this.list = list;
	}

}
