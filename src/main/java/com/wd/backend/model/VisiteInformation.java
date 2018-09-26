package com.wd.backend.model;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

public class VisiteInformation {
	
	private float pv;
	
	private float uv;
	
	private float ip;
	
	private float avgPage;
	
	private float avgTime;
	
	private String school;
	
	private String refererUrl;
	
	private String jump = "0";
	
	private String refOrg;
	
	private String province;
	
	private String avgTimeString ="00:00:00";

	public String getAvgTimeString() {
		return avgTimeString;
	}

	public void setAvgTimeString(long ms) {
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		String hms = formatter.format(ms*1000-8*3600*1000);
		this.avgTimeString = hms;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getJump() {
		return jump;
	}

	public void setJump(String jump) {
		DecimalFormat df = new DecimalFormat("0.00");
		this.jump = df.format(Double.parseDouble(jump));
	}

	public String getRefOrg() {
		return refOrg;
	}

	public void setRefOrg(String refOrg) {
		this.refOrg = refOrg;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getRefererUrl() {
		return refererUrl;
	}

	public void setRefererUrl(String refererUrl) {
		this.refererUrl = refererUrl;
	}

	public Float getPv() {
		return pv;
	}

	public void setPv(float pv) {
		BigDecimal   b  =   new BigDecimal(pv);  
		pv   =  b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();  
		this.pv = pv;
	}

	public Float getUv() {
		return uv;
	}

	public void setUv(float uv) {
		BigDecimal   b  =   new BigDecimal(uv);  
		uv   =  b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();  
		this.uv = uv;
	}

	public Float getIp() {
		return ip;
	}

	public void setIp(float ip) {
		BigDecimal   b  =   new BigDecimal(ip);  
		ip   =  b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();  
		this.ip = ip;
	}

	public Float getAvgPage() {
		return avgPage;
	}

	public void setAvgPage(float avgPage) {
		BigDecimal   b  =   new BigDecimal(avgPage);  
		avgPage   =  b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();  
		this.avgPage = avgPage;
	}

	public Float getAvgTime() {
		return avgTime;
	}

	public void setAvgTime(float avgTime) {
		BigDecimal   b  =   new BigDecimal(avgTime);  
		avgTime   =  b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		setAvgTimeString((long) avgTime);
		this.avgTime = avgTime;
	}

	
	

}
