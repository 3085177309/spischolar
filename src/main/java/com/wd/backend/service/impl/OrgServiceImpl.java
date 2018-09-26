package com.wd.backend.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.cxf.common.util.StringUtils;
import org.apache.oro.text.regex.StringSubstitution;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.Pager;
import com.wd.backend.dao.MemberDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.dao.ProductDaoI;
import com.wd.backend.dao.PurchaseDBDaoI;
import com.wd.backend.dao.SiteDaoI;
import com.wd.backend.dao.URLRuleDaoI;
import com.wd.backend.model.Department;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.backend.service.OrgServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.exeception.SystemException;
import com.wd.util.ChineseUtil;
import com.wd.util.IpUtil;
import com.wd.util.SimpleUtil;

@Service("orgService")
public class OrgServiceImpl implements OrgServiceI {

	@Autowired
	private OrgDaoI orgDao;
	@Autowired
	private SiteDaoI siteDao;
	@Autowired
	private PersonDaoI personDao;
	@Autowired
	private ProductDaoI productDao;
	@Autowired
	private PurchaseDBDaoI purchaseDBDao;
	@Autowired
	private URLRuleDaoI urlRuleDao;

	private static final Pattern P1 = Pattern.compile("\\s+");
	@Override
	public void add(OrgBO org) throws SystemException {
		if (SimpleUtil.strIsNull(org.getFlag())) {
			throw new SystemException("机构标识不能为空!");
		}
		if (ChineseUtil.isChinese(org.getFlag())) {
			throw new SystemException("机构标识不能中文!");
		}
		if (P1.matcher(org.getFlag()).find()) {
			throw new SystemException("机构标识不能包含空格!");
		}
		Integer flagExists = orgDao.findExistsFlag(org.getFlag());
		if (null != flagExists) {
			throw new SystemException("机构标识重复!");
		}
		if (SimpleUtil.strIsNull(org.getName())) {
			throw new SystemException("机构名不能为空!");
		}
		validateIpRange(org);
		Org model = new Org();
		BeanUtils.copyProperties(org, model);
		try {
			model.setProducts(org.getProductStr());
			model.setRegisterDate(new Date());
			orgDao.insert(model);
			org.setId(model.getId());
			List<Product> products=org.getProductList();
			if(products==null||products.size()==0){
				throw new SystemException("需要选择购买或试用的产品!");
			}
			for(Product p:products){
				p.setOrgId(model.getId());
				p.setOrgFlag(model.getFlag());
				p.setOrgName(model.getName());
			}
			productDao.insertBatch(products);
		} catch (RuntimeException e) {
			throw new SystemException("机构信息录入异常!", e, true);
		}
	}

	@Override
	public OrgBO detail(Integer orgId) {
		Org model = orgDao.findById(orgId);
		List<Product> products=productDao.findByOrg(model.getFlag());
		OrgBO org = null;
		if (null != model) {
			org = new OrgBO();
			BeanUtils.copyProperties(model, org);
		}
		org.setProductList(products);
		return org;
	}

	@Override
	public void delete(Integer orgId) {
		Org org = orgDao.findById(orgId);
		if (null == org){
			return;
		}
		// 删除机构所有站点
		siteDao.deleteByOrg(org.getId());
		//删除用户
		personDao.deleteByOrg(org.getId());
		//删除机构
		orgDao.delete(orgId);
		//删除订购的产品列表
		productDao.deleteByOrg(org.getId());
		//删除订购的数据库
		purchaseDBDao.deleteByOrg(org.getFlag());
		//删除对应的URL规则
		urlRuleDao.deleteByOrg(org.getFlag());
	}

	@Override
	public Pager searchPager(String key,String status) {
		Calendar calendar = Calendar.getInstance(); //得到日历
		calendar.setTime(new Date());//把当前时间赋给日历
		calendar.add(Calendar.DAY_OF_MONTH, -1);  //设置为前一天
		
		Pager pager = new Pager();
		Map<String, Object> params = new HashMap<String, Object>();
		if(!StringUtils.isEmpty(status)&&!"5".equals(status)&&!"3".equals(status)){
			params.put("status", Integer.parseInt(status));
		}else if("3".equals(status)){
			params.put("endDate", 3);
		}
		//ip查询
		if(!StringUtils.isEmpty(key)&&SimpleUtil.isIp(key)){
			List<Org> orgs=orgDao.findAll();
			List<OrgBO> orgboList = new ArrayList<OrgBO>();
			for(Org org:orgs){
				if(IpUtil.isInRange(org.getIpRanges(), key)){
					List<Product> products=productDao.findByOrg(org.getFlag());
					OrgBO orgbo = null;
					if (null != org) {
						orgbo = new OrgBO();
						BeanUtils.copyProperties(org, orgbo);
					}
					orgbo.setProductList(products);
					orgboList.add(orgbo);
				}
			}
			pager.setRows(orgboList);
			pager.setTotal(orgboList.size());
			return pager;
		}
		if(!StringUtils.isEmpty(key)){
			params.put("key", '%'+key+'%');
		}
		int total = orgDao.findCountBy(params);
		if (total > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<OrgBO> orgboList = new ArrayList<OrgBO>();
			List<Org> orgList = orgDao.findPager(params);
			OrgBO orgbo = null;
			List<Product> products=null;
			if(StringUtils.isEmpty(status) || "5".equals(status)){//为空或者状态为全部
				for(Org org:orgList){
					products=productDao.findByOrg(org.getFlag());
					for(Product pro:products){
						if(pro.getEndDate().getTime()<calendar.getTime().getTime()){
							pro.setStatus((short) 3);
						}
					}
					if (null != org) {
						orgbo = new OrgBO();
						BeanUtils.copyProperties(org, orgbo);
					}
					orgbo.setProductList(products);
					orgboList.add(orgbo);
				}
			}else if("3".equals(status)){
				//过期状态 ,计算符合条件的总数据量，以作为页码使用
				//params.remove("offset");//产品查询不要分页
				for(Org org:orgList){
					List<Product> productsNew= new ArrayList<Product>();
					//params.put("orgId", org.getId());
					products=productDao.findByOrg(org.getFlag());
					if(products!=null && products.size()>0){
						for(Product pro:products){
							if(pro.getEndDate().getTime()<calendar.getTime().getTime()){
								pro.setStatus((short) 3);
								productsNew.add(pro);
							}
						}
						if (null != org) {
							orgbo = new OrgBO();
							BeanUtils.copyProperties(org, orgbo);
						}
						orgbo.setProductList(productsNew);
						orgboList.add(orgbo);
					}
				}
			}else{
				//params.remove("offset");//产品查询不要分页
				for(Org org:orgList){
					List<Product> productsNew= new ArrayList<Product>();
					//params.put("orgId", org.getId());
					products=productDao.findByOrg(org.getFlag());
					if(products!=null && products.size()>0){
						for(Product pro:products){
							if(pro.getEndDate().getTime()>=System.currentTimeMillis() && status.equals(pro.getStatus().toString())){
								productsNew.add(pro);
							}
						}
						if (null != org) {
							orgbo = new OrgBO();
							BeanUtils.copyProperties(org, orgbo);
						}
						orgbo.setProductList(productsNew);
						orgboList.add(orgbo);
					}
				}
			}
				pager.setRows(orgboList);
				pager.setTotal(total);
		}
		return pager;
	}
	
	@Override
	public Pager searchPager(String key,Integer product) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("productId", product);
		if(!StringUtils.isEmpty(key)){
			params.put("orgName", key);
		}
		Pager pager = new Pager();
		int total = productDao.findCount(params);
		pager.setTotal(total);
		if (total > 0) {
			params.put("offset", SystemContext.getOffset());
			params.put("size", SystemContext.getPageSize());
			List<Product> orgList = productDao.findPager(params);
			pager.setRows(orgList);
		}

		return pager;
	}

	@Override
	public void edit(OrgBO org,String flag) throws SystemException {
		if (SimpleUtil.strIsNull(org.getName())) {
			throw new SystemException("机构名不能为空!");
		}
		validateIpRange(org);
		Org model = new Org();
		org.setProducts(org.getProductStr());
		BeanUtils.copyProperties(org, model);
		int updateCount = orgDao.update(model);
		if (0 == updateCount) {
			throw new SystemException("机构信息更新失败!");
		}
		//如果后台登录的公司帐号，则执行修改购买产品信息
		if("wdkj".equals(flag)){
			List<Product> products=org.getProductList();
			if(products==null||products.size()==0){
				throw new SystemException("需要选择购买或试用的产品!");
			}
			for(Product p:products){
				p.setOrgId(model.getId());
				p.setOrgFlag(model.getFlag());
				p.setOrgName(model.getName());
			}
			try{
				productDao.deleteByOrg(model.getId());//删除之前的
				productDao.insertBatch(products);
			}catch(Exception e){
				throw new SystemException("机构信息更新失败!");
			}
		}
	}
	
	private List<String> getIpRanges(Integer orgId){
		if(orgId!=null){
			return orgDao.findAllIpRangesWithoutCur(orgId);
		}else{
			return orgDao.findAllIpRanges();
		}
	}
	
	private boolean checkIpInRanges(String ip,List<String> ipRangesList){
		for (String tmp : ipRangesList) {
			if (IpUtil.isInRange(tmp,ip)){
				return true;
			}
		}
		return false;
	}
	/*
	public void validateIp(OrgBO org)throws SystemException{
		List<String> ipRangesList=getIpRanges(org.getId());

		for(int k=0;k<ipRangesList.size();k++) {
			String ipRanges = ipRangesList.get(k);
			String ipRangeArr[] = ipRanges.split(";");
			for (int i = 0; i < ipRangeArr.length; i++) {
				String ipRange = ipRangeArr[i].trim();
				String tmpArr[] = ipRange.split("---");
				if (tmpArr.length != 2) {
					throw new SystemException("ip范围异常!");
				}
				tmpArr[0] = tmpArr[0].trim();
				if (!SimpleUtil.isIp(tmpArr[0])) {
					throw new SystemException("ip格式异常!");
				}
				tmpArr[1] = tmpArr[1].trim();
				if (!SimpleUtil.isIp(tmpArr[1])) {
					throw new SystemException("ip格式异常!");
				}
				// 验证当前ip范围是否和本机构的已有ip范围冲突
				// 是否需要在当前已有ip范围中验证当前新增的ip范围
			//	if (needValidateInOld(org, ipRangeArr, i)) {
					for (int j = 1; j < ipRangeArr.length; j++) {
						if(i == j) {
							continue;
						}
						if (IpUtil.isInRange(ipRangeArr[j], tmpArr[0])) {
							System.out.println(ipRangeArr[j] + "与" +tmpArr[0]+"该ip范围在其他机构已定义!");
							continue;
							//throw new SystemException(tmpArr[0]+"该ip范围已定义!");
						}
						if (IpUtil.isInRange(ipRangeArr[j], tmpArr[1])) {
							System.out.println(ipRangeArr[j] + "与" +tmpArr[1]+"该ip范围在其他机构已定义!");
							continue;
							//throw new SystemException(tmpArr[1]+"该ip范围已定义!");
						}
						String[] tmpArr1 = ipRangeArr[j].split("---");
						String ipRangeArr1 = tmpArr[0]+"---" + tmpArr[1];
						if (IpUtil.isInRange(ipRangeArr1, tmpArr1[0])) {
							System.out.println(ipRangeArr1 + "与" +tmpArr1[0]+"该ip范围在其他机构已定义!");
							continue;
							//throw new SystemException(tmpArr1[0]+"该ip范围已定义!");
						}
						if (IpUtil.isInRange(ipRangeArr1, tmpArr1[1])) {
							System.out.println(ipRangeArr1 + "与" +tmpArr1[1]+"该ip范围在其他机构已定义!");
							continue;
							//throw new SystemException(tmpArr1[1]+"该ip范围已定义!");
						}
					}
		//		}
				// 验证当前ip范围是否和其他机构的ip范围冲突
					int tt =0;
				for (String tmp : ipRangesList) {
					if(tt == k) continue;
					if (IpUtil.isInRange(tmp, tmpArr[0])) {
						System.out.println(tmp + "与"+tmpArr[0]+"该ip范围在其他机构已定义!");
						continue;
						//throw new SystemException(tmpArr[0]+"该ip范围在其他机构已定义!");
					}
					if (IpUtil.isInRange(tmp, tmpArr[1])) {
						System.out.println(tmp + "与"+tmpArr[1]+"该ip范围在其他机构已定义!");
						continue;
						//throw new SystemException(tmpArr[1]+"该ip范围在其他机构已定义!");
					}
					tt++;
				}
			}
		}
	}*/
	
	/**
	 * 验证IP是否合法
	 * @param org
	 * @throws SystemException
	 */
	@Override
    public void validateIpRange(OrgBO org) throws SystemException{
		List<String> ipRangesList=getIpRanges(org.getId());

		String ipRanges = org.getIpRanges();
        String[] ipRangeArr = ipRanges.split(";");
		for (int i = 0; i < ipRangeArr.length; i++) {
			String ipRange = ipRangeArr[i].trim();
            String[] tmpArr = ipRange.split("---");
			if (tmpArr.length != 2) {
				throw new SystemException("ip范围异常!");
			}
			tmpArr[0] = tmpArr[0].trim();
			if (!SimpleUtil.isIp(tmpArr[0])) {
				throw new SystemException("ip格式异常!");
			}
			tmpArr[1] = tmpArr[1].trim();
			if (!SimpleUtil.isIp(tmpArr[1])) {
				throw new SystemException("ip格式异常!");
			}
			// 验证当前ip范围是否和本机构的已有ip范围冲突
			// 是否需要在当前已有ip范围中验证当前新增的ip范围
		//	if (needValidateInOld(org, ipRangeArr, i)) {
				for (int j = 1; j < ipRangeArr.length; j++) {
					if(i == j) {
						continue;
					}
					if (IpUtil.isInRange(ipRangeArr[j], tmpArr[0])) {
						throw new SystemException(tmpArr[0]+"该ip范围已定义!");
					}
					if (IpUtil.isInRange(ipRangeArr[j], tmpArr[1])) {
						throw new SystemException(tmpArr[1]+"该ip范围已定义!");
					}
					String[] tmpArr1 = ipRangeArr[j].split("---");
					String ipRangeArr1 = tmpArr[0]+"---" + tmpArr[1];
					if (IpUtil.isInRange(ipRangeArr1, tmpArr1[0])) {
						System.out.print("该ip范围已定义!");
						throw new SystemException(tmpArr1[0]+"该ip范围已定义!");
					}
					if (IpUtil.isInRange(ipRangeArr1, tmpArr1[1])) {
						System.out.print("该ip范围已定义!");
						throw new SystemException(tmpArr1[1]+"该ip范围已定义!");
					}
				}
	//		}
			// 验证当前ip范围是否和其他机构的ip范围冲突
			for (String tmp : ipRangesList) {
				if (IpUtil.isInRange(tmp, tmpArr[0])) {
					throw new SystemException(tmpArr[0]+"该ip范围在其他机构已定义!");
				}
				if (IpUtil.isInRange(tmp, tmpArr[1])) {
					throw new SystemException(tmpArr[1]+"该ip范围在其他机构已定义!");
				}
			}
		}
	}
	
	@Override
	public void editIpRange(OrgBO org) throws SystemException {
		Org model = new Org();
		if (SimpleUtil.strIsNull(org.getIpRanges())) {
			BeanUtils.copyProperties(org, model);
			orgDao.updateIpRanges(model);
			return;
		}

		validateIpRange(org);
		BeanUtils.copyProperties(org, model);
		orgDao.updateIpRanges(model);
	}

	/**
	 * 是否需要在当前已有ip范围中验证当前新增的ip范围
	 * 
	 * @param org
	 * @param ipRangeArr
	 * @param i
	 * @return
	 */
	private boolean needValidateInOld(OrgBO org, String[] ipRangeArr, int i) {
		return (0 == i) && (org.getIpOptType() == OrgBO.add_ip_range) && ipRangeArr.length > 1;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Boolean findExistsFlag(String flag) {
		Integer flagExists = orgDao.findExistsFlag(flag);
		if(null!=flagExists && flagExists>0){
			return true;
		}
		return false;
	}

	@Override
	public Boolean findOrgNameExist(String orgName) {
		Integer nameExists=orgDao.findOrgNameExist(orgName);
		if(null!=nameExists && nameExists>0){
			return true;
		}
		return false;
	}

	@Override
	public Boolean findIpRangesExist(Integer orgId,String startIp, String endIp) {
		List<String> ipRangesList=getIpRanges(orgId);
		if(checkIpInRanges(startIp,ipRangesList)||checkIpInRanges(endIp,ipRangesList)){//IP地址方位重叠
			return true;
		}
		return false;
	}

	@Override
	public OrgBO findOrgByFlag(String flag) {
		Org org=orgDao.findByFlag(flag);
		List<Product> products=productDao.findByOrg(flag);
		OrgBO bo=new OrgBO();
		BeanUtils.copyProperties(org, bo);
		bo.setProductList(products);
		return bo;
	}
	/**
	 * 根据学校查询学院
	 */
	@Override
	public List<Department> findDepBySchool(int schoolId){
		List<Department> list = orgDao.findDepartments(schoolId);
		String schoolFlag = orgDao.findById(schoolId).getFlag();
		
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("schoolFlag", schoolFlag);
		List<Map<String,Object>> countList = personDao.findCount(params);
		for(int i=0; i<list.size(); i++) {
			String departmentName = list.get(i).getDepartmentName().trim();
			for(int j=0;j<countList.size();j++) {
				int count = Integer.parseInt(countList.get(j).get("COUNT").toString());
				if(countList.get(j).containsKey("department")) {
					if(departmentName.equals(countList.get(j).get("department").toString().trim())) {
						list.get(i).setNumber(list.get(i).getNumber()+count);
					} else if("其他".equals(departmentName)) {
						list.get(i).setNumber(list.get(i).getNumber()+count);
					}
				} else if ("其他".equals(departmentName)) {
					list.get(i).setNumber(list.get(i).getNumber()+count);
				}
			}
		}
		return list;
	}
	/**
	 * 添加学院
	 * @throws SystemException 
	 */
	@Override
	public void addDep(InputStream input,int schoolId,String departmentName,String flag) throws SystemException{
		Workbook book = null;
		if(flag == null) {
			Department department = new Department();
			department.setDepartmentName(departmentName);
			department.setSchoolId(schoolId);
			if(SimpleUtil.strIsNull(departmentName)) {
                return;
            }
			orgDao.addDept(department);
		} else {
			try {
				book = Workbook.getWorkbook(input);
				if(book!=null) {
					// 获得第一个工作表对象
					Sheet sheet = book.getSheet(0);
					for (int i = 1; i < sheet.getRows(); i++) {
						Department department = new Department();
						department.setDepartmentName(sheet.getCell(1,i).getContents());
						department.setSchoolId(Integer.parseInt(sheet.getCell(2,i).getContents()));
						orgDao.addDept(department);
					}
					
					book.close();
				}
			} catch (Exception e) {
				throw new SystemException("文本格式内容不正确！");
			}
		}/**
		try {
			book = Workbook.getWorkbook(file.getInputStream());
			if(book!=null) {
				// 获得第一个工作表对象
				Sheet sheet = book.getSheet(0);
				for (int i = 1; i < sheet.getRows(); i++) {
					Department department = new Department();
					department.setDepartmentName(sheet.getCell(1,i).getContents());
					department.setSchoolId(Integer.parseInt(sheet.getCell(2,i).getContents()));
					orgDao.addDept(department);
				}
				
				book.close();
			} else {
				Department department = new Department();
				department.setDepartmentName(departmentName);
				department.setSchoolId(schoolId);
				if(SimpleUtil.strIsNull(departmentName)) return;
				orgDao.addDept(department);
			}
		} catch (Exception e) {
			throw new SystemException("文本格式内容不正确！");
		}*/
	}
	
	@Override
	public void deleteDepartment(int id) {
		orgDao.deleteDepartment(id);
	}
	
	@Override
	public void updateDepartment(String departmentName,int id) {
		Department department = new Department();
		department.setDepartmentId(id);
		department.setDepartmentName(departmentName);
		orgDao.updateDepartment(department);
		personDao.updateUserDepartment(department);
	}
}
