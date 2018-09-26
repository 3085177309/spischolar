package com.wd.backend.model;

public class SortField {

	private Integer id;
	/**
	 * 1、表示学科序号 2、表示评价值
	 */
	private Integer type;
	/**
	 * 排序字段，后面这个s并不是表示有多个值，而只是因为field是数据库的保留字，所以加个s区别一下
	 */
	private String fields;

	public SortField() {
	}

	public SortField(int type, String field) {
		this.type = type;
		this.fields = field;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * 1、表示学科序号 2、表示评价值
	 * @return
	 */
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getFields() {
		return fields;
	}

	public void setFields(String fields) {
		this.fields = fields;
	}
}
