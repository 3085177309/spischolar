package com.wd.util;

public class GetTitleScore {

	public static final int getScore(String title) {
		String o1FirstWord = title.toUpperCase().trim().replaceAll("\\pP|\\pS", "").split("[ ]+")[0];
		if (ChineseUtil.isChinese(o1FirstWord)) {
			if (o1FirstWord.length() > 1) {
				o1FirstWord = GetFirstLetter.cn2py(o1FirstWord.substring(0, 1)) + GetFirstLetter.cn2py(o1FirstWord.substring(1, 2));
			} else {
				o1FirstWord = GetFirstLetter.cn2py(o1FirstWord.substring(0, 1));
			}
		}
		String o1Score = "";
        char[] o1Arr = o1FirstWord.toUpperCase().toCharArray();
		if (o1Arr.length == 1) {
			o1Score = "" + (int) o1Arr[0] + "0000";
		} else if (o1Arr.length > 2) {
			o1Score = "" + (int) o1Arr[0] + "" + (int) o1Arr[1] + "" + (int) o1Arr[2];
		} else if (o1Arr.length > 1) {
			o1Score = "" + (int) o1Arr[0] + "" + (int) o1Arr[1] + "00";
		}
		return Integer.parseInt(o1Score);
	}
}
