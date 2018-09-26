package com.wd.backend.model;

import java.util.Date;
import java.util.List;

/**
 * 系统更新日志
 * @author Shenfu
 *
 */
public class UpdateLog {
	
	private Integer id;
	
	private String title;
	
	private String content;
	
	private Date addTime;
	
	/**查阅次数*/
	private Integer times=0;
	
	/**点赞次数*/
	private Integer praise=0;
	
	/**是否显示*/
	private Short isShow =(short)0;
	
	
	/** 新加字段
	 * 摘要*/
	private String logAbstract;
	/**上线时间*/
	private String releases;
	/**责任人*/
	private String person;
	/**标签*/
	private String lable;
	
	private List lables;
	
	public List getLables() {
		return lables;
	}

	public void setLables(List lables) {
		this.lables = lables;
	}

	private int type;
	/**附件路径*/
	private String path;
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
		this.name = path.substring(path.lastIndexOf("/")+1, path.length());
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getLogAbstract() {
		return logAbstract;
	}

	public void setLogAbstract(String logAbstract) {
		this.logAbstract = logAbstract;
	}

	public String getReleases() {
		return releases;
	}

	public void setReleases(String releases) {
		this.releases = releases;
	}

	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}

	public String getLable() {
		return lable;
	}

	public void setLable(String lable) {
		this.lable = lable;
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

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getTimes() {
		return times;
	}

	public void setTimes(Integer times) {
		this.times = times;
	}

	public Integer getPraise() {
		return praise;
	}

	public void setPraise(Integer praise) {
		this.praise = praise;
	}

	public Short getIsShow() {
		return isShow;
	}

	public void setIsShow(Short isShow) {
		this.isShow = isShow;
	}

}
