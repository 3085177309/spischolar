package com.wd.backend.bo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;

import com.wd.backend.model.LinkRule;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.comm.Comm;

public class OrgBO extends Org implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 机构的所有连接规则 <br/>
	 * key为数据id，value为规则列表
	 */
	private transient Map<Integer, List<LinkRule>> dbRules;
	/**
	 * 新增ip范围
	 */
	public static final int add_ip_range = 0;
	/**
	 * 删除ip范围
	 */
	public static final int delete_ip_range = 1;

	/**
	 * ip范围操作类型(0、新增ip范围，1、删除ip范围)
	 */
	private Integer ipOptType;

	/**
	 * 发布根目录
	 */
	private String deployRootPath;
	
	/**
	 * 购买的产品
	 */
	private List<Product> productList;

	public OrgBO() {
	}
	
	public String getProductStr(){
		if(productList==null||productList.size()==0){
			return null;
		}
		String str="";
		for(Product p:productList){
			str+=","+p.getProductName();
		}
		return str.substring(1);
	}

	public OrgBO(Org org) {
		BeanUtils.copyProperties(org, this);
	}

	public Integer getIpOptType() {
		return ipOptType;
	}

	public void setIpOptType(Integer ipOptType) {
		this.ipOptType = ipOptType;
	}

	public String getDeployRootPath() {
		return deployRootPath;
	}

	public void setDeployRootPath(String deployRootPath) {
		this.deployRootPath = deployRootPath;
	}

	public Map<Integer, List<LinkRule>> getDbRules() {
		return dbRules;
	}

	public void setDbRules(Map<Integer, List<LinkRule>> dbRules) {
		this.dbRules = dbRules;
	}
	
	public String[] getIpsArr(){
		if(!StringUtils.isEmpty(this.getIpRanges())){
			return this.getIpRanges().split(";");
		}else{
			return new String[]{};
		}
	}
	
	/**
	 * 获取模板路径
	 * @return
	 */
	public String getSiteFlag(){
		if(StringUtils.isEmpty(getTemplate())){
			return Comm.DEFAULT_TEMP_NAME;
		}else{
			return getTemplate();
		}
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}


	@Override
	public String toString() {
		return "OrgBO{" +
				"dbRules=" + dbRules +
				", ipOptType=" + ipOptType +
				", deployRootPath='" + deployRootPath + '\'' +
				", productList=" + productList +
				'}';
	}
}
