package com.wd.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.UniqueList;

/**
 * 用于生成系统的url
 * 
 * @author pan
 * 
 */
public class SystemLinkUtil {

	private static List<String> subjectNO = Arrays.asList("北大核心", "EI", "CSSCI");
	private static List<String> eval = Arrays.asList("SJR", "EIGENFACTOR", "中科院JCR分区(小类)", "中科院JCR分区(大类)", "SCI-E", "SSCI", "A&HCI", "CSCD");

	/**
	 * 构建排序条件
	 * 
	 * @param sys
	 *            体系名
	 * @param authorityDbMap
	 *            体系集合
	 * @param subject
	 *            学科名
	 * @param disciplineMap
	 *            学科集合
	 * @param year
	 *            年
	 * @return
	 */
	public static String buildSortCondition(String sys, Map<String, Integer> authorityDbMap, String subject, Map<String, Integer> disciplineMap, Integer year) {
		String sortCdt = "";
		String sortField = "";
		if (null != authorityDbMap && null != disciplineMap) {
			Integer dbId = authorityDbMap.get(sys);
			Integer subjectId = disciplineMap.get(subject);
			if (null != dbId && null != subjectId && null != year) {
				sortField = dbId + "|" + subjectId + "|" + year;
			}
		}
		if (SimpleUtil.strIsNull(sortField)) {
			return "";
		}
		if (subjectNO.contains(sys.toUpperCase())) {
			// 按学科序号排序
			sortCdt += "&sort=8&sortField=" + sortField + "&effectSort=8";
		} else if (eval.contains(sys.toUpperCase())) {
			// 按评价值排序
			sortCdt += "&sort=7&sortField=" + sortField + "&effectSort=7";
		}
		return sortCdt;
	}

	public static String buildSubjectUrl(String siteFlag, String sys, String subject, Integer year) {
		try {
			return "list?" + "authorityDb=" + URLEncoder.encode(sys, "UTF-8") + "&subject=" + URLEncoder.encode(subject, "UTF-8")
					+ "&queryCdt=shouLuSubjects_3_1_" + URLEncoder.encode(sys.replaceAll(",", "%320"), "UTF-8") + "%5E" + year + "%5E" + URLEncoder.encode(subject.replaceAll(",", "%320"), "UTF-8")
					+ "&detailYear=" + year + "&viewStyle=list";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String buildPartitionUrl(String siteFlag, String sys, String subject, Integer year, Integer partition) {
		try {
			return "list?" + "authorityDb=" + URLEncoder.encode(sys, "UTF-8") + "&subject=" + URLEncoder.encode(subject, "UTF-8") + "&queryCdt=partition_3_1_"
					+ URLEncoder.encode(sys.replaceAll(",", "%320"), "UTF-8") + "%5E" + year + "%5E" + URLEncoder.encode(subject.replaceAll(",", "%320"), "UTF-8") + "%5E" + partition + "&partition="
					+ partition + "&viewStyle=list&detailYear=" + year;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static String buildOldCdt(SearchCondition searchCondition) {
		StringBuilder oldCdt = new StringBuilder();
		try {
			if (null != searchCondition) {
				// 添加检索字段、检索值
				if (SimpleUtil.strNotNull(searchCondition.getField())) {
					oldCdt.append("&field=").append(URLEncoder.encode(searchCondition.getField(), "UTF-8"));
				}
				if (SimpleUtil.strNotNull(searchCondition.getValue())) {
					oldCdt.append("&value=").append(URLEncoder.encode(searchCondition.getValue(), "UTF-8"));
				}
				// 添加数据展现方式
				if (SimpleUtil.strNotNull(searchCondition.getViewStyle())) {
					oldCdt.append("&viewStyle=").append(searchCondition.getViewStyle());
				}
				// 添加过滤条件
				UniqueList uniqueList = searchCondition.getFilterCdt();
				for (String condition : uniqueList) {
					oldCdt.append("&filterCdt=").append(URLEncoder.encode(condition, "UTF-8"));
				}
				// 添加查询条件
				uniqueList = searchCondition.getQueryCdt();
				for (String condition : uniqueList) {
					oldCdt.append("&queryCdt=").append(URLEncoder.encode(condition, "UTF-8"));
				}
			}
		} catch (Exception e) {
		}

		return oldCdt.toString();
	}
}
