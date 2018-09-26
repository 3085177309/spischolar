package com.wd.front.bo;

import java.util.Calendar;
import java.util.List;
import org.apache.commons.lang.StringUtils;

import com.wd.comm.context.SystemContext;

public class Condition {

	/**
	 * 检索词位置,title:标题，any:任何位置
	 */
	private String field;
	/**检索语句*/
	private String val;
	/**刊物*/
	private String journal;
	private String other;
	/**年份范围*/
	private Integer start_y;
	private Integer end_y;
	/**
	 * 包含引用
	 */
	private Integer vis = 1;//默认包含
	
	/**检索类型，如文章检索，相关文献检索，施引文献检索，版本检索*/
	private String type;
	/**
	 * 包含专利
	 */
	private Integer sdt = 1;//默认包含
	/**
	 * 1、包含中文（简体和繁体） 2、只包含简体中文
	 */
	private String webPageType;
	/**
	 * 1、表示按时间排序
	 */
	private Integer sort;
	
	//
	/**文档类型*/
	private String fileType;
	
	private List<ConditionGroup> groups;
	
	/**来源网站筛选*/
	private List<String> sites;
	
	/**
	 * 检索类型 
	 * 0：模糊检索
	 * 1：精确检索
	 */
	private Integer queryType=0;
	
	/**
	 * 是否开放获取优先
	 */
	private Integer oaFirst=0;
	
	private String userAgent;
	
	private String cookie;
	
	private String token;
	
	private String batchId;
	
	/**
	 * 0：谷歌检索  1：必应检索
	 */
	private int source;
	
//	private boolean patent = false;
//	private boolean quote = false;
	private boolean patent = true;
	private boolean quote = true;
	private int offset = 0;
	private int size = 10;

	public Condition() {
	}
	
	/**
	 * 年份交换，start_y要求小于end_y
	 */
	public void swapYear(){
		if(start_y==null||end_y==null){
			return ;
		}
		int a = start_y,b=end_y;
		this.setEnd_y(Math.max(a, b));
		this.setStart_y(Math.min(a, b));
	}
	
	@Override
    public String toString(){
		String str="";
		if(sites!=null){
			for(String site:sites){
				str+=site;
			}
		}
		if(groups!=null){
			for(ConditionGroup group:groups ){
				str+=group.toString();
			}
		}
		return field+val+oaFirst+offset+size+journal+other+start_y+end_y+sort+patent+quote+webPageType+type+fileType+str;
	}
	
	public String toXML(){
		boolean addQuote=false;
		if(queryType==1){
			addQuote=true;
		}
		StringBuilder xml = new StringBuilder();
		xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xml.append("<condition>");
		if(!StringUtils.isEmpty(journal)){
			if(addQuote){
				xml.append("<journal>\"" + journal.replaceAll("%26", "&").replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "\"</journal>");
			}else{
				xml.append("<journal>" + journal.replaceAll("%26", "&").replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</journal>");
			}
		}
		if(!StringUtils.isEmpty(field)){
			xml.append("<field>" + field.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</field>");
		}
		if(!StringUtils.isEmpty(type)){
			xml.append("<type>" + type.replaceAll("<", "&lt;").replaceAll(">", "&gt;") + "</type>");
		}
		if(!StringUtils.isEmpty(fileType)){
			xml.append("<filetype>"+fileType+"</filetype>");
		}
		if(sites!=null&&sites.size()>0){
			xml.append("<sites>");
			for(String site:sites){
				xml.append("<site>"+site+"</site>");
			}
			xml.append("</sites>");
		}
		if(groups!=null&&groups.size()>0){
			xml.append("<fields>");
			for(ConditionGroup group:groups){
				String field=group.toXML(addQuote);
				if(field!=null){
					xml.append(field);
				}
			}
			xml.append("</fields>");
		}
		if(!StringUtils.isEmpty(val)){
			String value= null;
			if(!val.contains("url=")) {
				value=val.replaceAll("%26", "&").replaceAll("&", "and").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}else {
				value = val.replaceAll("&", "&amp;");
			}
			if(oaFirst!=null &&oaFirst==1){
				xml.append("<val>" + value+" filetype:pdf"  + "</val>");
			}else{
				xml.append("<val>" + value  + "</val>");
			}
		}else{
			if(oaFirst!=null && oaFirst==1){
				xml.append("<val>filetype:pdf</val>");
			}
		}
		xml.append("<offset>" + SystemContext.getOffset() + "</offset>");
		xml.append("<size>" + SystemContext.getPageSize() + "</size>");
		this.offset = SystemContext.getOffset();
		this.size = SystemContext.getPageSize();
		if (null != other) {
			xml.append("<other>" + other.replaceAll("&", "&amp;") + "</other>");
		}
		if (null != start_y) {
			xml.append("<startYear>" + start_y + "</startYear>");
		}
		if (null != end_y) {
			xml.append("<endYear>" + end_y + "</endYear>");
		}
		if (null != sort) {
			xml.append("<sort>").append(sort).append("</sort>");
		}
		if (null != vis) {
			xml.append("<quote>").append(vis).append("</quote>");
		}
		if (null != sdt) {
			xml.append("<patent>").append(sdt).append("</patent>");
		}
		if (!StringUtils.isEmpty(webPageType)) {
			xml.append("<webPageType>").append(webPageType).append("</webPageType>");
		}
		if(!StringUtils.isEmpty(userAgent)){
			xml.append("<agent>").append(userAgent).append("</agent>");
		}
		if(!StringUtils.isEmpty(cookie)){
			xml.append("<cookie>").append(cookie).append("</cookie>");
		}
		if(!StringUtils.isEmpty(token)){
			xml.append("<token>").append(token).append("</token>");
		}
		xml.append("<source>").append(source).append("</source>");
		xml.append("</condition>");
		return xml.toString();
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getVal() {
		if(val == null) {
			return val;
		} else {
			return val.replaceAll("'", "");
		}
	}
	
	public String getValForGoogle() {
		String value ="";
		if(val == null) {
			value = "";
		} else {
			value = val.replaceAll("'", "");
		}
		if(oaFirst!=null &&oaFirst==1) {
			value = val+" filetype:pdf";
		}
		return value;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getJournal() {
		//if(journal == null) {
			return journal;
		/*} else {
			return journal.replaceAll("\"", "");
		}*/
	}

	public void setJournal(String journal) {
		this.journal = journal;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public Integer getStart_y() {
		return start_y;
	}

	/**
	 * 设置开始年
	 * @param start_y
	 */
	public void setStart_y(Integer start_y) {
		if(start_y==null){
			return;
		}
		int y = Math.abs(start_y);
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int tmp = year - 2000;
		if (y <= tmp) {
			this.start_y=2000 + y;
		} else if (y > tmp && y < 100) {
			this.start_y=1900 + y;
		}
		this.start_y = start_y;
	}

	public Integer getEnd_y() {
		return end_y;
	}

	public void setEnd_y(Integer end_y) {
		if(end_y==null){
			return ;
		}
		int y = Math.abs(end_y);
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int tmp = year - 2000;
		if (y <= tmp) {
			this.end_y=2000 + y;
		} else if (y > tmp && y < 100) {
			this.end_y=1900 + y;
		}
		this.end_y = end_y;
	}

	public Integer getVis() {
		return vis;
	}

	public void setVis(Integer vis) {
		this.vis = vis;
	}

	public Integer getSdt() {
		return sdt;
	}

	public void setSdt(Integer sdt) {
		this.sdt = sdt;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getWebPageType() {
		return webPageType;
	}

	public void setWebPageType(String webPageType) {
		this.webPageType = webPageType;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<String> getSites() {
		return sites;
	}

	public void setSites(List<String> sites) {
		this.sites = sites;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public List<ConditionGroup> getGroups() {
		return groups;
	}

	public void setGroups(List<ConditionGroup> groups) {
		this.groups = groups;
	}

	public Integer getQueryType() {
		return queryType;
	}

	public void setQueryType(Integer queryType) {
		this.queryType = queryType;
	}

	public Integer getOaFirst() {
		return oaFirst;
	}

	public void setOaFirst(Integer oaFirst) {
		this.oaFirst = oaFirst;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getCookie() {
		return cookie;
	}

	public void setCookie(String cookie) {
		this.cookie = cookie;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getBatchId() {
		return batchId;
	}

	public void setBatchId(String batchId) {
		this.batchId = batchId;
	}

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public boolean isPatent() {
		return patent;
	}

	public void setPatent(boolean patent) {
		this.patent = patent;
	}

	public boolean isQuote() {
		return quote;
	}

	public void setQuote(boolean quote) {
		this.quote = quote;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}
	
}
