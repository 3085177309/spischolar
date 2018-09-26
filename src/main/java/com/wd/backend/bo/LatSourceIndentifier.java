package com.wd.backend.bo;

import java.io.Serializable;

/**
 * 
 * @author spancer.ray
 * 
 */
public class LatSourceIndentifier implements Serializable {

	private static final long serialVersionUID = -8759524147547399397L;
	private int source;
	private String param;
	private String extParam;

	public LatSourceIndentifier() {
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getExtParam() {
		return extParam;
	}

	public void setExtParam(String extParam) {
		this.extParam = extParam;
	}
}
