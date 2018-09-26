package com.wd.front.bo;

import java.util.Comparator;
import java.util.Map;

import com.wd.util.PinYinUtil;

public class MapComparator implements Comparator<Map<String, Object>>{

	@Override
	public int compare(Map<String, Object> o1, Map<String, Object> o2) {
		String oName1=(String)o1.get("discipline"),oName2=(String)o2.get("discipline");
		String py=PinYinUtil.getPingYin(oName1),
				py2=PinYinUtil.getPingYin(oName2);
		return py.compareTo(py2);
		
	}

}
