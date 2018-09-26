package com.wd.front.bo;

public class SysOB {

	/**
	 * 权威数据库
	 */
	private String db;
	/**
	 * 年
	 */
	private Integer year;
	/**
	 * 学科
	 */
	private String subject;
	/**
	 * 分区
	 */
	private Integer partition;
	/**
	 * 评价值
	 */
	private String eval;

	public SysOB() {
	}

	public SysOB(Integer year, String subject, Integer partition, String eval) {
		super();
		this.year = year;
		this.subject = subject;
		this.partition = partition;
		this.eval = eval;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Integer getPartition() {
		return partition;
	}

	public void setPartition(Integer partition) {
		this.partition = partition;
	}

	public String getEval() {
		return eval;
	}

	public void setEval(String eval) {
		this.eval = eval;
	}

	public String getDb() {
		return db;
	}

	public void setDb(String db) {
		this.db = db;
	}
}
