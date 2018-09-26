package com.wd.backend.model;

public class Video {
	
	private int id;
	
	private String jguid;
	
	private String submissionSystem;
	
	private String time;
	
	private String abstracts;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getJguid() {
		return jguid;
	}

	public void setJguid(String jguid) {
		this.jguid = jguid;
	}

	

	public String getSubmissionSystem() {
		return submissionSystem;
	}

	public void setSubmissionSystem(String submissionSystem) {
		this.submissionSystem = submissionSystem;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getAbstracts() {
		return abstracts;
	}

	public void setAbstracts(String abstracts) {
		this.abstracts = abstracts;
	}

}
