package com.wd.util;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
/**
 * 防采集逻辑
 * @author Administrator
 *
 */
public class Acquisition {
	
	public static boolean acquisition(HttpServletRequest req,String map) {
		
		Calendar c = Calendar.getInstance();
		int minute = c.get(Calendar.MINUTE); 
		int second = c.get(Calendar.SECOND); 
		int time = minute*60 + second;
//		Map<Integer, Integer> appMap = new HashMap<Integer, Integer>();
		Map appMap = (Map) req.getSession().getAttribute(map);
		if(appMap == null) {
			appMap = new HashMap();
		}
		
		if(appMap.size() >= 10) {
			int oldTime = (int) appMap.get(1);
			if((time - oldTime) <= 60 && (time - oldTime) > 0) {
//				appMap.clear();
				req.getSession().setAttribute(map,appMap);
				return false;
			} else {
				for(int i= 1; i < 10; i++) {
					appMap.put(i, appMap.get(i+1));
				}
				appMap.put(10, time);
			}
		} else {
			appMap.put(appMap.size() + 1, time);
		}
		req.getSession().setAttribute(map,appMap);
		return true;
		
	}

}
