package com.wd.backend.model;

import java.util.Date;

/**
 * 系统公告
 * @author Shenfu
 *
 */
public class News {
	
	private Integer id;
	
	private String title;
	
	private String content;
	
	/**查阅次数*/
	private Integer times=0;
	
	/**评价次数*/
	private Integer praise=0;
	
	/**添加时间*/
	private Date addTime;
	
	/**是否显示*/
	private Short isShow=(short)0;
	/**栏目*/
	private Integer type;
	
	private String publishers;

	public String getPublishers() {
		return publishers;
	}

	public void setPublishers(String publishers) {
		this.publishers = publishers;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getTimes() {
		return times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Short getIsShow() {
		return isShow;
	}

	public void setIsShow(Short isShow) {
		this.isShow = isShow;
	}

	public Integer getPraise() {
		return praise;
	}

	public void setPraise(Integer praise) {
		this.praise = praise;
	}

}
