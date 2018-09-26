package com.wd.front.bo;

import java.util.HashMap;
import java.util.Map;

/**
 * 权威收录
 * 
 * @author Administrator
 * 
 */
public class AuthorityIncluded {

	/**
	 * 收录的顶级学科信息
	 * 
	 * <pre>
	 * key为：cscd,sci,cscd-e这类数据 
	 * value为：key为学科编码,value为学科中文名
	 * </pre>
	 */
	private Map<String, HashMap<String, String>> topDiscipline = new HashMap<String, HashMap<String, String>>();
	/**
	 * 最近进行统计收录的年
	 * 
	 * <pre>
	 * key为：cscd,sci,cscd-e这类数据
	 * value为：key为学科编码,value为学科中文名
	 * </pre>
	 */
	private Map<String, Integer> lastIncludeYear = new HashMap<String, Integer>();

	public AuthorityIncluded() {
	}

	public Map<String, HashMap<String, String>> getTopDiscipline() {
		return topDiscipline;
	}

	public void setTopDiscipline(Map<String, HashMap<String, String>> topDiscipline) {
		this.topDiscipline = topDiscipline;
	}

	public Map<String, Integer> getLastIncludeYear() {
		return lastIncludeYear;
	}

	public void setLastIncludeYear(Map<String, Integer> lastIncludeYear) {
		this.lastIncludeYear = lastIncludeYear;
	}
}
