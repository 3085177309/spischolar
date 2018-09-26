package com.wd.backend.model;

/**
 * 学科模型
 * @author pan
 *
 */
public class Discipline {

	private int id;
	private String flag;

	public Discipline() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		if (null != flag) {
            flag = flag.trim();
        }
		this.flag = flag;
	}
}
