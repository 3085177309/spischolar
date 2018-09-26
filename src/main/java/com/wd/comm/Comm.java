package com.wd.comm;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Comm {
	
	public static final String Mobile = "mobiles/";

	/**
	 * 高亮后缀名
	 */
	public static final String highlight_field_name_suffix = "_highlight";

	public static final String DEFAULT_INDEX = "journal";
	
	public static final String BROWSE_INDEX = "browse";
	
	public static final String WOS_INDEX = "wos_source";

	public static final String LAN_SPLIT = "#&#&#";

	public static final List<String> subjectNO = Arrays.asList("北大核心", "EI", "CSSCI","ESI");

	public static final List<String> eval = Arrays.asList("SJR", "Eigenfactor", "中科院JCR分区(小类)", "中科院JCR分区(大类)", "SCI-E", "SSCI", "A&HCI", "CSCD");

	public static final List<String> isShouLu = Arrays.asList("SCI-E", "SSCI", "SJR", "CSCD", "CSSCI", "北大核心");

	public static Map<String, String> isEval = new HashMap<String, String>();
	static {
		isEval.put("SCI-E", "JCR影响因子");
		isEval.put("SSCI", "JCR影响因子");
		isEval.put("中科院JCR分区(小类)", "中科院JCR分区(小类)");
		isEval.put("中科院JCR分区(大类)", "中科院JCR分区(大类)");
		isEval.put("SJR", "SJR");
		isEval.put("CSCD", "CSCD影响因子");
		isEval.put("Eigenfactor", "Eigenfactor");
	}

	public static final List<String> jcrType = Arrays.asList("中科院JCR分区(大类)", "中科院JCR分区(小类)");
	
	public static final List<String> journalSubject = Arrays.asList("SCI-E", "SSCI", "ESI", "SCOPUS", "CSCD", "CSSCI", "北大核心", "中科院JCR分区(大类)", "中科院JCR分区(小类)", "Eigenfactor");
	
	public static final List<Integer> visitPage = Arrays.asList(10, 20, 30, 50, 70, 100, 200, 250);
	/**
	 * 机构信息保存在Session中的名称
	 */
	public static final String ORG_SESSION_NAME ="login_org";
	
	public static final String USER_SESSION_NAME="login_user";
	
	public static final String ORG_FLAG_NAME="org_flag";
	
	public static final String SITE_FLAG_NAME="site_flag";
	
	public static final String DEFAULT_TEMP_NAME="qkdh";
	
	/**前台用户登录Session Name */
	public static final String MEMBER_SESSION_NAME="front_member";
	
	public static final String DOC_SESSION_CACHE="doc_session";


	/**
	 * 排序字段缓存键
	 */
	public static final String sort_field_cache_key = "sort_field_cache_key";
	/**
	 * 权威数据库分区缓存键
	 */
	public static final String authority_db_partition_cache_key = "authority_db_partition_cache_key";

	/**
	 * 学科缓存键
	 */
	public static final String discipline_system_subject_cache_key = "discipline_system_subject_cache_key";

	/**
	 * 权威数据库缓存
	 */
	public static final String all_authority_db_cache_key = "all_authority_db_cache_key";
	/**
	 * 权威数据库最新学科体系缓存
	 */
	public static final String authority_db_new_discipline_system_cache_key = "authority_db_new_discipline_system_cache_key";
	/**
	 * 权威数据库所有收录年
	 */
	public static final String authority_db_all_year_cache_key = "authority_db_all_year_cache_key";
	/**
	 * 所有学科
	 */
	public static final String all_discipline_cache_key = "all_discipline_cache_key";
	/**
	 * 机构信息缓存键
	 */
	public static final String org_cache_key = "org_cache_key";
	/**
	 * 增加数据缓存键
	 */
	public static final String browse_cache_key = "browse_cache_key";

	public static final String ORG_PRODUCT_LIST_KEY_PREFIX="org_product_list_";

}
