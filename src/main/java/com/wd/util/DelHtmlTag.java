package com.wd.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DelHtmlTag {
	/**
	 * 过滤标签
	 * @param htmlStr
	 * @return
	 */
	public static String delHTMLTag(String htmlStr){ 
		String regEx_html="<[^>]+>"; //定义HTML标签的正则表达式 
       	Pattern p_html=Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE); 
        Matcher m_html=p_html.matcher(htmlStr); 
        htmlStr=m_html.replaceAll(""); //过滤html标签 
        return htmlStr.trim(); //返回文本字符串 
    } 

}
