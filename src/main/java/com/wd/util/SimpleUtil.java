package com.wd.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 常用代码的提取，如非空验证的代码
 * 
 * @author Administrator
 * 
 */
public class SimpleUtil {

	private static final Pattern p1 = Pattern.compile("<font [^>]+>");
	private static final Pattern p2 = Pattern.compile("</font>");

	private static final Set<String> orgFeaturesSet = new HashSet<String>();

	static {
		orgFeaturesSet.add("公司");
		orgFeaturesSet.add("集团");
		orgFeaturesSet.add("血站");
		orgFeaturesSet.add("中心");
		orgFeaturesSet.add("大学");
		orgFeaturesSet.add("学院");
		orgFeaturesSet.add("研究所");
		orgFeaturesSet.add("实验室");
		orgFeaturesSet.add("研究院");
		orgFeaturesSet.add("总局");
		orgFeaturesSet.add("委员会");
		// 报纸机构
		orgFeaturesSet.add("时报");
		orgFeaturesSet.add("日报");
		orgFeaturesSet.add("周报");
		orgFeaturesSet.add("晚报");
		orgFeaturesSet.add("晨报");
		// 图书机构
		orgFeaturesSet.add("出版社");
	}

	/**
	 * 
	 * @param str
	 *            邮箱
	 * @return 如果是符合邮箱格式的字符串,返回<b>true</b>,否则为<b>false</b>
	 */
	public static boolean isEmail(String str) {
		String regex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
		return match(regex, str);
	}

	/**
	 * 
	 * @param ip
	 * @return
	 */
	public static boolean isIp(String ip) {
		String regex = "\\b((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\.((?!\\d\\d\\d)\\d+|1\\d\\d|2[0-4]\\d|25[0-5])\\b";
		String reSpaceCheck = "([0-9a-fA-F]{1,4}:){7,7}([0-9a-fA-F]{1,4})";
		boolean a = match(reSpaceCheck, ip);
		return match(regex, ip) || match(reSpaceCheck, ip);
	}

	/**
	 * 
	 * @param str
	 *            网址
	 * @return 如果是符合网址格式的字符串,返回<b>true</b>,否则为<b>false</b>
	 */
	public static boolean isHomepage(String str) {
		String regex = "http://(([a-zA-z0-9]|-){1,}\\.){1,}[a-zA-z0-9]{1,}-*";
		return match(regex, str);
	}

	/**
	 * 
	 * @param regex
	 *            正则表达式字符串
	 * @param str
	 *            要匹配的字符串
	 * @return 如果str 符合 regex的正则表达式格式,返回true, 否则返回 false;
	 */
	public static boolean match(String regex, String str) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}

	public static final boolean isOrg(String text) {
		boolean isOrg = false;
		if (text.length() > 2) {
			for (String orgFeature : orgFeaturesSet) {
				if (text.contains(orgFeature)) {
					isOrg = true;
				}
			}
		}
		return isOrg;
	}

	/**
	 * 截取指定长度的文本
	 * 
	 * @param text
	 *            原始文本内容
	 * @param maxLen
	 *            允许的最大文本长度
	 * @return
	 */
	public static final String substring(String text, int maxLen) {
		String tmp = text.replaceAll("<font [^>]+>", "").replaceAll("</font>", "");
		tmp = tmp.substring(0, maxLen > text.length() ? text.length() : maxLen);

		Matcher m = p1.matcher(text);
		List<Integer> startPosList = new ArrayList<Integer>();
		// 记录每个高亮标签开始的位置
		while (m.find()) {
			startPosList.add(m.start());
		}
		List<Integer> endPosList = new ArrayList<Integer>();
		// 记录每个高亮标签结束的位置
		m = p2.matcher(text);
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

	/**
	 * 获取关键词(keyword)在源句子(srcText)中出现的次数
	 * 
	 * @param srcText
	 * @param keyword
	 *            关键词
	 * @return
	 */
	public static int findStrCount(String srcText, String keyword) {
		int count = 0;
		Pattern p = Pattern.compile(keyword);
		Matcher m = p.matcher(srcText);
		while (m.find()) {
			count++;
		}
		return count;
	}

	public static boolean stringObjNotNull(Object str) {
		if (null == str) {
			return false;
		}
		if ("".equals(str.toString().trim())) {
			return false;
		}
		return true;
	}

	public static boolean strIsNull(String testStr) {

		if (null == testStr || "".equals(testStr.trim())) {
			return true;
		}
		return false;
	}

	public static boolean strNotNull(String testStr) {

		if (null == testStr || "".equals(testStr.trim())) {
			return false;
		}
		return true;
	}

	public static boolean collNotNull(Collection<?> testColl) {

		if (null == testColl || testColl.isEmpty()) {
			return false;
		}
		return true;
	}

	public static boolean collIsNull(Collection<?> testColl) {

		if (null == testColl || testColl.isEmpty()) {
			return true;
		}
		return false;
	}

	public static boolean mapIsNull(Map<?, ?> testMap) {

		if (null == testMap || testMap.isEmpty()) {
            return true;
        }
		return false;
	}

	public static boolean mapNotNull(Map<?, ?> testMap) {

		if (null == testMap || testMap.isEmpty()) {
			return false;
		}
		return true;
	}

	public static <T> boolean arrayNotNull(T[] testArray) {

		if (null == testArray || testArray.length == 0) {
			return false;
		}
		return true;
	}

	public static <T> boolean arrayIsNull(T[] testArray) {

		if (null == testArray || testArray.length == 0) {
			return true;
		}
		return false;
	}

	public static String symbolReplace(String content) {
		if (null != content) {
			// 将引号替换成&quot;
			content = content.replaceAll("\"", "&quot;");
		}
		return content;
	}

	public static void createDir(String flag) {
		File dir = new File(FileUtil.getUploadRootPath() + File.separator + flag);
		// 创建站点文件夹
		dir.mkdirs();
		// 在站点文件夹创建三个子文件夹(在用模版、可选模版、模版压缩包)
		File tmp = new File(dir, "在用模版");
		tmp.mkdir();
		tmp = new File(dir, "可选模版");
		tmp.mkdir();
		tmp = new File(dir, "模版压缩包");
		tmp.mkdir();
	}

	public static void deleteDir(String siteFlag) {
		String parentPath = FileUtil.getUploadRootPath();
		FileUtil.deleteDir(new File(parentPath + File.separator + siteFlag));
	}

	private static Random random = new Random();

	public static String autoCreateAccount() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		return dateFormat.format(new Date()) + random.nextInt(10) + random.nextInt(10) + random.nextInt(10);
	}

	public static String autoCreateActiveCode() {
		return UUID.randomUUID().toString();
	}

	/**
	 * 获取文件列表
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param dirName
	 */
	public static String loadFileList(String orgFlag, String siteFlag, String dirName) {
		String dirPath = FileUtil.getUploadRootPath() + File.separator + orgFlag + File.separator + siteFlag + File.separator + dirName + File.separator;
		File file = new File(dirPath);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("[");
		if (file.isDirectory()) {
			File[] fileArr = file.listFiles();
			for (int i = 0; i < fileArr.length; i++) {
				File f = fileArr[i];
				if (null != f) {
					if (f.isDirectory()) {
						stringBuilder.append("{\"name\":\"" + f.getName() + "\",\"orgFlag\":\"" + orgFlag + "\",\"siteFlag\":\"" + siteFlag
								+ "\",\"loadAgain\":true,\"isParent\":true,\"isCustomeDir\":true}");
					} else {
						int pos = f.getName().lastIndexOf('.');
						// 获取后缀名
						String hzName = f.getName().substring(pos + 1);
						String icon = "resources/images/tree_icons/";
						if ("html".equals(hzName) || "htm".equals(hzName) || "xhtml".equals(hzName)) {
							icon += "html.png";
						} else if ("css".equals(hzName)) {
							icon += "css.png";
						} else if ("zip".equals(hzName)) {
							icon += "zip.png";
						} else if ("js".equals(hzName)) {
							icon += "js.png";
						} else {
							icon += "other.png";
						}
						stringBuilder.append("{\"name\":\"" + f.getName() + "\",\"orgFlag\":\"" + orgFlag + "\",\"siteFlag\":\"" + siteFlag + "\",\"icon\":\"" + icon + "\"}");
					}
					if (i != fileArr.length - 1) {
						stringBuilder.append(",");
					}
				}
			}
		}
		stringBuilder.append("]");
		return stringBuilder.toString();
	}

}
