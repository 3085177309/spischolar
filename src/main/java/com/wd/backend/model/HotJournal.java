package com.wd.backend.model;

public class HotJournal {

	private Integer id;

	private String docId;
	private String image;
	private String orgName;
	private Integer clickCount;
	private Integer detailYear;
	private String orgFlag;
	private String docTitle;
	private String discipline;
	private String authorityDB;

	public HotJournal() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Integer getClickCount() {
		return clickCount;
	}

	public void setClickCount(Integer clickCount) {
		this.clickCount = clickCount;
	}

	public Integer getDetailYear() {
		return detailYear;
	}

	public void setDetailYear(Integer detailYear) {
		this.detailYear = detailYear;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public String getDocTitle() {
		return docTitle;
	}

	public void setDocTitle(String docTitle) {
		this.docTitle = docTitle;
	}

	public String getDiscipline() {
		return discipline;
	}

	public void setDiscipline(String discipline) {
		this.discipline = discipline;
	}

	public String getAuthorityDB() {
		return authorityDB;
	}

	public void setAuthorityDB(String authorityDB) {
		this.authorityDB = authorityDB;
	}
}
