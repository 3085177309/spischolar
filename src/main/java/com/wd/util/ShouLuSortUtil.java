package com.wd.util;

import java.util.Collection;
import java.util.Comparator;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import com.wd.front.bo.SysOB;

public class ShouLuSortUtil {

	public static LinkedHashMap<String, Map<Integer, Set<SysOB>>> sortShouLu(List<Map<String, Object>> shouluList, Map<String, Integer> authorityDbMap, Collection<String> scope) {
		LinkedHashMap<String, Map<Integer, Set<SysOB>>> shouluMap = new LinkedHashMap<String, Map<Integer, Set<SysOB>>>();
		Set<String> allShouLuSet = new HashSet<String>();
		// 获取该刊的所有收录
		for (Map<String, Object> shouLuMap : shouluList) {
			// 获取一个体系的所有年的收录
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> mutilYearShouLu = (List<Map<String, Object>>) shouLuMap.get("detailList");
			if (SimpleUtil.collNotNull(mutilYearShouLu)) {
				for (Map<String, Object> singleYearShouLu : mutilYearShouLu) {
					String detail = (String) singleYearShouLu.get("detail");
					if (SimpleUtil.strNotNull(detail)) {
						allShouLuSet.add(detail);
					}
				}
			}
		}
		Set<String> sortSysSet = authorityDbMap.keySet();// 获取已排序的所有体系
		if (!allShouLuSet.isEmpty()) {
			for (String sys : sortSysSet) {
				for (String shouLu : allShouLuSet) {
					if (!scope.contains(sys)) {
						continue;
					}
					if (shouLu.toUpperCase().startsWith(sys.toUpperCase() + "^")) {
						// 获取收录的学科
						String[] mutilSubj = shouLu.split(";");
						for (String singleSubj : mutilSubj) {
							String[] subjInfo = singleSubj.split("\\^");
							if (subjInfo.length > 2) {
								// 获取体系名
								String db = subjInfo[0];
								if (!scope.contains(db)) {
									continue;
								}
								Integer year = null;
								try {
									year = Integer.parseInt(subjInfo[1]);
								} catch (NumberFormatException e) {
									continue;
								}
								String subject = subjInfo[2];
								Integer partition = null;
								if (subjInfo.length >= 4) {
									try {
										partition = Integer.parseInt(subjInfo[3]);
									} catch (NumberFormatException e) {
									}
								}
								String eval = null;
								if (subjInfo.length >= 5 && SimpleUtil.strNotNull(subjInfo[4])) {
									eval = subjInfo[4];
								}
								Map<Integer, Set<SysOB>> yearShouluMap = shouluMap.get(db);
								if (null == yearShouluMap) {
									yearShouluMap = new TreeMap<Integer, Set<SysOB>>(new Comparator<Integer>() {

										@Override
										public int compare(Integer o1, Integer o2) {
											if (o1 > o2) {
												return -1;
											} else if (o1 < o2) {
												return 1;
											}
											return 0;
										}

									});
									shouluMap.put(db, yearShouluMap);
								}
								Set<SysOB> subjectSet = yearShouluMap.get(year);
								if (null == subjectSet) {
									subjectSet = new TreeSet<SysOB>(new Comparator<SysOB>() {
										@Override
										public int compare(SysOB o1, SysOB o2) {
											if (null == o1 || SimpleUtil.strIsNull(o1.getSubject())) {
												return -1;
											}
											if (null == o2 || SimpleUtil.strIsNull(o2.getSubject())) {
												return 1;
											}
											String subA = o1.getSubject().toLowerCase();
											String subB = o2.getSubject().toLowerCase();
											int len = Math.min(subA.length(), subB.length());
											for (int i = 0; i < len; i++) {
												int t_a = subA.charAt(i);
												int t_b = subB.charAt(i);
												if (t_a > t_b) {
													return 1;
												} else if (t_a < t_b) {
													return -1;
												}
											}
											return 1;
										}
									});
									yearShouluMap.put(year, subjectSet);
								}
								subjectSet.add(new SysOB(year, subject, partition, eval));
							}
						}
					}
				}
			}
		}
		return shouluMap;
	}
}
