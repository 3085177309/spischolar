package com.wd.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

public class CollectionsUtil {
	
	
	public static List<Map<String, Object>> sort(List<Map<String, Object>> dataList,final String sort) {
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(int i=0;i<dataList.size();i++) {
			list.add(dataList.get(i));
			Collections.sort(list,new Comparator<Map<String, Object>>(){
	            @Override
                public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
	            	int sortOrder =0;
	            	Double val0 = Double.parseDouble(arg0.get(sort.replace("_down", "").replace("_up", "")).toString());
	        		Double val1 = Double.parseDouble(arg1.get(sort.replace("_down", "").replace("_up", "")).toString());
	        		sortOrder = val0.compareTo(val1);
	            	if(sort.contains("up")) {//升
	            		return sortOrder;
	            	} else if(sort.contains("down")) {//降
	            		if(sortOrder == -1) {
		            		return 1;
		            	} else if(sortOrder == 1){
		            		return -1;
		            	} else {
		            		return 0;
		            	}
	            	}
					return sortOrder;
	            }
		    });
		}
		return list;
	}

}
