package com.wd.front.module.tag;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.wd.util.IpUtil;

public class Functions {
	
	private static final Logger log=Logger.getLogger(Functions.class);
	
	/**
	 * 大于0表示已经过期，等于零，表示即将过期，小于0表示正常
	 * @param dateTo
	 * @return
	 */
	public static Integer compareDate(Date dateTo){
		Calendar current=Calendar.getInstance(),lastDate=Calendar.getInstance();
		lastDate.setTime(dateTo);
		if(current.compareTo(lastDate)>0){
			return 1;
		}
		int yearCurrent=current.get(Calendar.YEAR),yearLast=lastDate.get(Calendar.YEAR);
		if(yearCurrent==yearLast){
			int monthCurrent=current.get(Calendar.MONTH),monthLast=lastDate.get(Calendar.MONTH);
			if(monthCurrent-monthLast<=3){
				return 0;
			}
		}
		return -1;
	}
	
	public static String encodeURI(String value){
		try {
			return URLEncoder.encode(value, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage(), e);
		}
		return value;
	}
	
	/**
	 * 查找IP段
	 * @param ips
	 * @param ip
	 * @return
	 */
	public static String findIpRanges(String ips,String ip){
		if (StringUtils.isEmpty(ips)) {
			return "";
		}
		String[] ipArray = ips.replaceAll("\r\n", "").split(";");
		long intIp = IpUtil.convertIp2Int(ip);
		for (String string : ipArray) {
			String[] ipRange = string.split("---");
			if (ipRange.length == 2) {
				long start = IpUtil.convertIp2Int(ipRange[0]);
				long end = IpUtil.convertIp2Int(ipRange[1]);
				if(IpUtil.isInner(intIp,start,end)){
					return string;
				}
			}
		}
		return "";
	}
	
	/**
	 * 格式化年，将2014-2015这种格式的年份转换为2015
	 * @param year
	 * @return
	 */
	public static String formatYear(String year){
		if(StringUtils.isEmpty(year)){
			return "";
		}
		if(year.contains("-")){
			String[] items=year.split("-");
			return items[1];
		}else{
			return year;
		}
	}
	
	public static String getField(String cdt){
		if(StringUtils.isNotBlank(cdt)){
			int pos=cdt.indexOf("_");
			if(pos==-1){
				return null;
			}
			return cdt.substring(0, pos);
		}
		return null;
	}
	
	public static String getValue(String cdt){
		if(StringUtils.isNotBlank(cdt)){
			int pos=cdt.lastIndexOf("_");
			if(pos==-1){
				return null;
			}
			return cdt.substring(pos+1);
		}
		return null;
	}

}
