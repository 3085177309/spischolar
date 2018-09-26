package com.wd.backend.model;

import org.apache.commons.lang.StringUtils;

/**
 * 学科体系模型
 * 
 * @author pan
 * 
 */
public class DisciplineSystem {

	private int id;
	private String authorityDatabase;
	private String discipline;
	private int year;

	/**
	 * 排序方式
	 */
	private Integer sort;

	private String rangeYear;
	/**
	 * 学科的中文翻译
	 */
	private String name;
	
	/**
	 * 学科
	 */
	private String subjectName;

	public DisciplineSystem() {
	}

	public DisciplineSystem(String discipline) {
		this.discipline = discipline;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAuthorityDatabase() {
		return authorityDatabase;
	}

	public void setAuthorityDatabase(String authorityDatabase) {
		if (null != authorityDatabase) {
            authorityDatabase = authorityDatabase.trim();
        }
		this.authorityDatabase = authorityDatabase;
	}

	public String getDiscipline() {
		return discipline;
	}

	public void setDiscipline(String discipline) {
		if (null != discipline) {
            discipline = discipline.trim();
        }
		this.discipline = discipline;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getRangeYear() {
		return rangeYear;
	}

	public void setRangeYear(String rangeYear) {
		this.rangeYear = rangeYear;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public int hashCode() {
		if(!StringUtils.isEmpty(name)){
			return name.hashCode();
		}
		return super.hashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		} else {
			DisciplineSystem tmp = (DisciplineSystem) obj;
			if (tmp.getDiscipline().equals(this.getName())) {
				return true;
			} else {
				return false;
			}
		}
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
}
