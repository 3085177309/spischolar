package com.wd.front.module.tag;

import java.util.List;
import java.util.Map;

public class ShouLuInfoSortUtil {
	public Map<String, Object> doc;
	public List<String> isShouLu;
	public List<String> subjectNO;
	public List<String> eval;

	public ShouLuInfoSortUtil(List<String> isShouLu, List<String> subjectNO, List<String> eval) {
		this.isShouLu = isShouLu;
		this.subjectNO = subjectNO;
		this.eval = eval;
	}
}