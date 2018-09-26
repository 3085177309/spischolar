package com.wd.backend.model;

import java.util.Date;

/**
 * 单网页内容
 * @author Administrator
 *
 */
public class Page {
	
	private Integer id;
	
	/**标题*/
	private String title;
	
	/**内容*/
	private String content;
	
	/**简介*/
	private String intro;

	/**添加日期*/
	private Date addDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
