package com.wd.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SubstringUtil {
	private static final Pattern P1 = Pattern.compile("<font [^>]+>");
	private static final Pattern P2 = Pattern.compile("</font>");
	/**
	 * 
	 * @param text
	 *            不包含高亮信息的文本
	 * @param maxLen
	 * @return
	 */
	public static final String substring(String text, int maxLen) {
		if (text.length() > maxLen) {
			return text.substring(0, maxLen);
		} else {
			return text;
		}
	}

	/**
	 * 截取指定长度的文本
	 * 
	 * @param text
	 *            包含高亮信息的文本
	 * @param maxLen
	 *            允许的最大文本长度
	 * @return
	 */
	public static final String highlightSubstring(String text, int maxLen) {
		String tmp = text.replaceAll("<font [^>]+>", "").replaceAll("</font>", "");
		if (tmp.length() <= maxLen) {
			return text;
		} else {
			tmp = tmp.substring(0, maxLen);
		}
		Matcher m = P1.matcher(text);
		List<Integer> startPosList = new ArrayList<Integer>();
		// 记录每个高亮标签开始的位置
		while (m.find()) {
			startPosList.add(m.start());
		}
		List<Integer> endPosList = new ArrayList<Integer>();
		// 记录每个高亮标签结束的位置
		m = P2.matcher(text);
		while (m.find()) {
			endPosList.add(m.start());
		}
		StringBuilder stringBuilder = new StringBuilder(tmp);
		// 还原高亮标签
		for (int i = 0; i < startPosList.size(); i++) {
			if (startPosList.get(i) > tmp.length()) {
				break;
			}
			stringBuilder.insert(startPosList.get(i), "<font class='highlight'>");
			stringBuilder.insert(endPosList.get(i), "</font>");
		}
		return stringBuilder.toString();
	}
}
