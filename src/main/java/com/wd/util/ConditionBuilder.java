package com.wd.util;

import org.apache.commons.lang.StringUtils;

import com.wd.front.bo.Condition;
import com.wd.front.bo.ConditionGroup;

public class ConditionBuilder {
	
	/**
	 * 将Condition转换成一个查询的Value
	 * @param condition
	 * @return
	 */
	public static String unBuiler(Condition condition){
		String keywords="",cdtStr="";
		if(!StringUtils.isEmpty(condition.getVal())){
			keywords=condition.getVal();
		}
		if(condition.getGroups()!=null&&condition.getGroups().size()>0){
			String field,value,prefix;
			for(ConditionGroup group:condition.getGroups()){
				field=group.getField();
				value=group.getValue();
				switch(group.getLogic()){
				case 1:
					prefix=" OR ";
					break;
				case 2:
					prefix=" -";
					break;
				default:
					prefix=" ";
					break;
				}
				if(!StringUtils.isEmpty(value)){
					if("author".equals(field)){
						value=prefix+"author:"+value;
						cdtStr+=value;
					}else if("keyword".equals(field)){
						value=prefix+value;
						keywords+=value;
					}else if("title".equals(field)){
						value=prefix+"intitle:"+value;
						cdtStr+=value;
					}
				}
			}
		}
		if(!StringUtils.isEmpty(keywords)){
			cdtStr=keywords+" "+cdtStr;
		}
		return StringUtils.trim(cdtStr);
	}
	
	public static String unBuilerHistory(Condition condition){
		String keywords="",cdtStr="";
		if(!StringUtils.isEmpty(condition.getVal())){
			keywords=condition.getVal();
		}
		if(!StringUtils.isEmpty(condition.getFileType())){
			cdtStr+="文档类型:"+condition.getFileType()+" ";
		}
		if(!StringUtils.isEmpty(condition.getJournal())){
			cdtStr+="出版物:"+condition.getJournal()+" ";
		}
		if(condition.getStart_y()!=null){
			if(condition.getEnd_y()!=null){
				cdtStr+="时间:"+condition.getStart_y()+"-"+condition.getEnd_y()+" ";	
			}else{
				cdtStr+="时间:"+condition.getStart_y()+"-现在 ";
			}
		}
		if(condition.getSites()!=null&&condition.getSites().size()>0){
			for(String site:condition.getSites()){
				cdtStr+="site:"+site+" ";
			}
		}
		if(condition.getGroups()!=null&&condition.getGroups().size()>0){
			String field,value,prefix;
			for(ConditionGroup group:condition.getGroups()){
				field=group.getField();
				value=group.getValue();
				switch(group.getLogic()){
				case 1:
					prefix=" OR ";
					break;
				case 2:
					prefix=" -";
					break;
				default:
					prefix=" ";
					break;
				}
				if(!StringUtils.isEmpty(value)){
					if("author".equals(field)){
						value=prefix+"author:"+value;
						cdtStr+=value;
					}else if("keyword".equals(field)){
						value=prefix+value;
						keywords+=value;
					}else if("title".equals(field)){
						value=prefix+"intitle:"+value;
						cdtStr+=value;
					}
				}
			}
		}
		if(!StringUtils.isEmpty(keywords)){
			cdtStr=keywords+" "+cdtStr;
		}
		return StringUtils.trim(cdtStr);
	}
	
	public static Condition builer(String val){
		return null;
	}

}
