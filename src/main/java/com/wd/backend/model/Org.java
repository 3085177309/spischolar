package com.wd.backend.model;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.wd.util.PinYinUtil;

/**
 * 机构模型
 * 
 * <pre>
 * 	约束：
 * 		1、id 唯一，自增长
 * 		2、flag 唯一，非空，不可修改
 * 		3、ipRanges 唯一，不可与其它ip范围有交集,第一个ip范围必须为最新的ip范围
 * 			ipRanges 格式：多个ip范围使用';'号分割,startIp---endIp表示一个ip范围
 * 			e.g 
 * 				192.168.1.1---192.168.1.3;202.197.77.2---202.197.77.10
 * 		4、name 非空
 * 		5、canNav 1、表示可使用期刊导航 2、表示不可使用
 * </pre>
 * 
 * @author pan
 * 
 */
public class Org implements Comparable<Org>{

	private Integer id;
	private String flag;
	private String ipRanges = "";
	private String name;
	private String remark;
	private Date registerDate;
	/**机构模板地址*/
	private String template;
	/**
	 * 机构用户是否能使用期刊导航(1、表示可使用期刊导航 2、表示不可使用)
	 */
	private int canNav;
	
	/**联系人*/
	private String contactPerson;
	
	/**联系方式*/
	private String contact;
	
	/**邮箱*/
	private String email;
	
	/**
	 * 购买的产品名称
	 */
	private String products;
	
	/**
	 *学院 
	 */
	private transient List<Department> list;
	
	/**
	 * 省
	 */
	private String province;
	
	/**
	 * 市
	 */
	private String city;
	
	/**
	 * 是否开放资源优先 1：开发  0：不开放
	 */
	private String zyyx;
	
	/**
	 * 中科院JCR数据年份 2013;2014;2015
	 */
	private String jcryear;
	
	private transient List<Powers> powers;
	private transient List<Quota> quotas;
	
	private int deliveryCount;//学校自定义     游客文献传递数量
	
	private int userDeliveryCount;//学校自定义     用户文献传递数量
	
	private Map<String,Object> browse;//自动增加数据

	/**
	 * 文献传递QQ群IDKEY
	 */
	private String qunwpa;
	
	public List<Powers> getPowers() {
		return powers;
	}

	public void setPowers(List<Powers> powers) {
		this.powers = powers;
	}

	public List<Quota> getQuotas() {
		return quotas;
	}

	public void setQuotas(List<Quota> quotas) {
		this.quotas = quotas;
	}

	public List<Department> getList() {
		return list;
	}

	public void setList(List<Department> list) {
		this.list = list;
	}

	public Org() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIpRanges() {
		return ipRanges;
	}

	public void setIpRanges(String ipRanges) {
		if (null != ipRanges) {
            ipRanges = ipRanges.trim();
        }
		this.ipRanges = ipRanges;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if (null != name) {
            name = name.trim();
        }
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		if (null != name) {
            name = name.trim();
        }
		this.remark = remark;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		if (null != flag) {
			flag = flag.trim();
		}
		this.flag = flag;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public int getCanNav() {
		return canNav;
	}

	public void setCanNav(int canNav) {
		this.canNav = canNav;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProducts() {
		return products;
	}

	public void setProducts(String products) {
		this.products = products;
	}
	
	
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getZyyx() {
		return zyyx;
	}

	public void setZyyx(String zyyx) {
		this.zyyx = zyyx;
	}

	public String getJcryear() {
		return jcryear;
	}

	public void setJcryear(String jcryear) {
		this.jcryear = jcryear;
	}

	public int getDeliveryCount() {
		return deliveryCount;
	}

	public void setDeliveryCount(int deliveryCount) {
		this.deliveryCount = deliveryCount;
	}

	public int getUserDeliveryCount() {
		return userDeliveryCount;
	}

	public void setUserDeliveryCount(int userDeliveryCount) {
		this.userDeliveryCount = userDeliveryCount;
	}

	@Override
	public int compareTo(Org o) {
		String oName1=this.getName(),oName2=o.getName();
		oName1=oName1.replaceAll("重", "虫");
		oName2=oName2.replaceAll("重", "虫");
		oName1=oName1.replaceAll("长", "常");
		oName2=oName2.replaceAll("长", "常");
		String py=PinYinUtil.getPingYin(oName1),
				py2=PinYinUtil.getPingYin(oName2);
		return py.compareTo(py2);
	}

	public Map<String, Object> getBrowse() {
		return browse;
	}

	public void setBrowse(Map<String, Object> browse) {
		this.browse = browse;
	}

	public String getQunwpa() {
		return qunwpa;
	}

	public void setQunwpa(String qunwpa) {
		this.qunwpa = qunwpa;
	}
}
