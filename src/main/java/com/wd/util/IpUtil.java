package com.wd.util;

import java.math.BigInteger;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

/**
 * IP工具类
 * 
 * @author pan
 * 
 */
public class IpUtil {
	
	private static final Logger logger=Logger.getLogger(IpUtil.class);

	/**
	 * 获取登录用户IP地址
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {//Nginx
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		if ("0:0:0:0:0:0:0:1".equals(ip)) {
			ip = "127.0.0.1";
		}else if(ip.contains(",")){
			logger.info("使用了代理的IP:"+ip);
			String[] ips = ip.split(",");
			int i=0;
			while(i<ips.length){
				if (ips[i] != null && ips[i].length() != 0 && !"unknown".equalsIgnoreCase(ips[i])) {
					ip=ips[i];
					break;
				}
				i++;
			}
		}
		return ip;
	}

	/**
	 * 验证IP是否在范围内。
	 * 
	 * @param ip
	 *            子网
	 * @param mask
	 *            子网掩码
	 * @param clientIp
	 *            需要验证的IP
	 * @return
	 */
	/*public static boolean isInRange(String ip, int mask, String clientIp) {

		byte maskByte = Byte.parseByte(String.valueOf(mask));
		int intMask = ~((1 << (32 - maskByte)) - 1);
		long intIp = convertIp2Int(ip);
		long intClientIp = convertIp2Int(clientIp);
		return ((intIp & intMask) == (intClientIp & intMask));
	}*/

	/**
	 * 
	 * @param ips
	 *            格式：192.168.1.1---192.168.1.3;202.197.7.2---202.197.7.3
	 * @param clientIp
	 * @return 如果ips为空则返回false
	 */
	public static boolean isInRange(String ips, String clientIp) {
		if(clientIp != null && clientIp.contains(":")) {
			return isInRangeIpv6(ips, clientIp);
		} else {
			return isInRangeIpv4(ips, clientIp);
		}
		/*boolean inRange = false;
		if (SimpleUtil.strIsNull(ips)) {
			return inRange;
		}
		String[] ipArray = ips.replaceAll("\r\n", "").split(";");
		long intClientIp = convertIp2Int(clientIp);
		for (String string : ipArray) {
			String[] ipRange = string.split("---");
			if (ipRange.length == 2) {
				long start = convertIp2Int(ipRange[0]);
				long end = convertIp2Int(ipRange[1]);
				inRange |= isInner(intClientIp, start, end);
			}

		}
		return inRange;*/
	}

	public static boolean isInner(long userIp, long begin, long end) {
		if(begin<end){
			return (userIp >= begin) && (userIp <= end);
		}else{
			return (userIp >= end) && (userIp <= begin);
		}
	}
	
	/**
	 * 
	 * @param ipv4
	 *            格式：192.168.1.1---192.168.1.3;202.197.7.2---202.197.7.3
	 * @param clientIp
	 * @return 如果ips为空则返回false
	 */
	public static boolean isInRangeIpv4(String ips, String clientIp) {
		boolean inRange = false;
		if (SimpleUtil.strIsNull(ips)) {
			return inRange;
		}
		String[] ipArray = ips.replaceAll("\r\n", "").split(";");
		long intClientIp = convertIp2Int(clientIp);
		for (String string : ipArray) {
			if(!string.contains(":")) {
				String[] ipRange = string.split("---");
				if (ipRange.length == 2) {
					long start = convertIp2Int(ipRange[0]);
					long end = convertIp2Int(ipRange[1]);
					inRange |= isInner(intClientIp, start, end);
				}
			}
		}
		return inRange;
	}

	public static long convertIp2Int(String ipaddress) {
		final String[] ipNums = ipaddress.split("\\.");  
	    return (Long.parseLong(ipNums[0]) << 24)  
	            + (Long.parseLong(ipNums[1]) << 16)  
	            + (Long.parseLong(ipNums[2]) << 8)  
	            + (Long.parseLong(ipNums[3]));  
	}
	
	
	/**
	 * 
	 * @param ipv6
	 *            格式：0000:0000:0000:0000:0000:0000:0000:0000---ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff;202.197.7.2---202.197.7.3
	 * @param clientIp
	 * @return 如果ips为空则返回false
	 */
	public static boolean isInRangeIpv6(String ips, String clientIp) {
		boolean inRange1 = false, inRange2 = false;
		if (SimpleUtil.strIsNull(ips)) {
			return inRange1 & inRange2;
		}
		String[] ipArray = ips.replaceAll("\r\n", "").split(";");
		long[] intClientIp = convertIpv6Int(clientIp);
		for (String string : ipArray) {
			if(string.contains(":")) {
				String[] ipRange = string.split("---");
				if (ipRange.length == 2) {
					long[] start = convertIpv6Int(ipRange[0]);
					long[] end = convertIpv6Int(ipRange[1]);
					inRange1 |= isInner(intClientIp[0], start[0], end[0]);
					inRange2 |= isInner(intClientIp[1], start[1], end[1]);
				}
			}
			
		}
		return inRange1 & inRange2;
	}
	/**
	 * ipv6
	 * @param ipaddress
	 * @return
	 */
	public static long[] convertIpv6Int(String ipaddress) {
		final String[] ipNums = ipaddress.split("\\:"); 
		long ip1 = (Long.parseLong(new BigInteger(ipNums[0], 16).toString()) << 64) 
				+ (Long.parseLong(new BigInteger(ipNums[1], 16).toString()) << 32)  
	            + (Long.parseLong(new BigInteger(ipNums[2], 16).toString()) << 16)  
	            + (Long.parseLong(new BigInteger(ipNums[3], 16).toString()));
		long ip2 = (Long.parseLong(new BigInteger(ipNums[4], 16).toString()) << 64) 
				+ (Long.parseLong(new BigInteger(ipNums[5], 16).toString()) << 32)  
	            + (Long.parseLong(new BigInteger(ipNums[6], 16).toString()) << 16)  
	            + (Long.parseLong(new BigInteger(ipNums[7], 16).toString()));
	    return new long[]{ip1,ip2};  
	}

}
