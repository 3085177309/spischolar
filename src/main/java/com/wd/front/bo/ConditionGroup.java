package com.wd.front.bo;

import org.apache.commons.lang.StringUtils;

public class ConditionGroup {
	
	/**
	 * 逻辑类型:0与，1或，2非
	 */
	private Short logic=0;
	
	/**域*/
	private String field;
	
	/**
	 * 值
	 */
	private String value;

	public Short getLogic() {
		return logic;
	}

	public void setLogic(Short logic) {
		this.logic = logic;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getValue() {
		if(value == null) {
			return value;
		} else {
			return value.replaceAll("'", "");
		}
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	public String toXML(boolean addQuote){
		StringBuilder xml = new StringBuilder();
		if(StringUtils.isEmpty(field)||StringUtils.isEmpty(value)){
			return null;
		}
		xml.append("<group>");
		xml.append("<logic>"+logic+"</logic>");
		xml.append("<field>"+field+"</field>");
		xml.append("<value>");
		if(addQuote){
			xml.append("\"");
			xml.append(value.replaceAll("%26", "&").replaceAll("&", "and").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			xml.append("\"");
		}else{
			xml.append(value.replaceAll("%26", "&").replaceAll("&", "and").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
		}
		xml.append("</value>");
		xml.append("</group>");
		return xml.toString();
	}

}
