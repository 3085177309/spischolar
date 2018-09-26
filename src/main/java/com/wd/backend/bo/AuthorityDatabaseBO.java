package com.wd.backend.bo;

import com.wd.backend.model.AuthorityDatabase;

public class AuthorityDatabaseBO extends AuthorityDatabase {

	/**
	 * 收录年
	 */
	private Integer year;

	public AuthorityDatabaseBO() {
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	@Override
	public String toString() {
		return super.toString() + "AuthorityDatabaseBO{" +
				"year=" + year +
				'}';
	}
}
