package com.wd.backend.model;

/**
 * 热门检索
 * @author Administrator
 *
 */
public class Hot {
	
	public Hot(){}
	
	public Hot(String orgFlag,String title){
		this.orgFlag=orgFlag;
		this.title=title;
		this.type=1;
	}
	
	public Hot(String orgFlag,String title,String flag){
		this.orgFlag=orgFlag;
		this.title=title;
		this.flag=flag;
		this.type=0;
	}
	
	private Integer id;
	
	/**
	 * 期刊标题或检索词
	 */
	private String title;
	
	/**
	 * 期刊ID
	 */
	private String flag;
	
	/**机构*/
	private String orgFlag;
	
	private Integer counts=1;
	
	public static final Short TYPE_JOURNAL=0;
	
	public static final Short TYPE_KEYWORD=1;
	
	/**
	 * 类型：
	 * 0为热门期刊
	 * 1位热门检索
	 */
	private Short type;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Integer getCounts() {
		return counts;
	}

	public void setCounts(Integer counts) {
		this.counts = counts;
	}

	public Short getType() {
		return type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

}
