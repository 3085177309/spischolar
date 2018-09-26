package com.wd.backend.model;

import java.io.Serializable;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.wd.util.DateUtil;
import com.wd.util.DelHtmlTag;
import com.wd.util.MD5Util;

/**
 * 文献传递
 * @author Shenfu
 *
 */
public class DocDelivery implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Long id;
	
	/**提交用户的邮箱*/
	private String email;
	
	/**文献标题*/
	private String title;
	
	/**文献地址*/
	private String url;
	
	/**访问用户所在的机构*/
	private String orgFlag;
	
	/**机构名称，冗余字段*/
	private String orgName;
	
	/**处理类型
	 * 0：表示未处理
	 * 1：表示已经处理并邮件回复
	 * 2：表示提交第三方处理
	 * 3：没有结果
	 */
	private Short processType=0;
	
	/**
	 * 负责处理的用户
	 */
	private String procesorName;
	
	/**负责处理的用户的IDd*/
	private Integer procesorId;
	
	/**添加日期*/
	private Date addDate;
	
	/**处理日期*/
	private Date processDate;
	
	/**
	 * 文件保存路径
	 */
	private String path;
	
	/**
	 * 用户ID
	 */
	private Integer memberId;
	
	/**
	 * 来源产品ID
	 */
	private Integer productId;
	
	private int  helpId;
	
	private Integer time;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		title = DelHtmlTag.delHTMLTag(title);
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOrgFlag() {
		return orgFlag;
	}

	public void setOrgFlag(String orgFlag) {
		this.orgFlag = orgFlag;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Short getProcessType() {
		return processType;
	}

	public void setProcessType(Short processType) {
		this.processType = processType;
	}

	public String getProcesorName() {
		return procesorName;
	}

	public void setProcesorName(String procesorName) {
		this.procesorName = procesorName;
	}

	public Integer getProcesorId() {
		return procesorId;
	}

	public void setProcesorId(Integer procesorId) {
		this.procesorId = procesorId;
	}

	public Date getAddDate() {
		return addDate;
	}

	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}

	public Date getProcessDate() {
		return processDate;
	}

	public void setProcessDate(Date processDate) {
		this.processDate = processDate;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public int getHelpId() {
		if(helpId == 1) {
			Date date = new Date();
			long l=date.getTime()-processDate.getTime();
			int time=(int) (l/1000);
			if(time > 900) {
				helpId = 0;
			}
		}
		return helpId;
	}

	public void setHelpId(int helpId) {
		this.helpId = helpId;
	}
	

	public Integer getTime() {
		return time;
	}

	public void setTime(Integer time) {
		this.time = time;
	}

	/**
	 * 生成一个ID,使用MD5编码标题和链接地址
	 * @return
	 */
	public String getDocId(){
		String id=title.replace("<b>", "").replace("</b>", "")+url;
		return MD5Util.getMD5(id.getBytes());
	}

	@Override
	public String toString() {
		return "DocDelivery{" +
				"id=" + id +
				", email='" + email + '\'' +
				", title='" + title + '\'' +
				", url='" + url + '\'' +
				", orgFlag='" + orgFlag + '\'' +
				", orgName='" + orgName + '\'' +
				", processType=" + processType +
				", procesorName='" + procesorName + '\'' +
				", procesorId=" + procesorId +
				", addDate=" + addDate +
				", processDate=" + processDate +
				", path='" + path + '\'' +
				", memberId=" + memberId +
				", productId=" + productId +
				", helpId=" + helpId +
				", time=" + time +
				'}';
	}
}
