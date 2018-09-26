package com.wd.backend.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.Pager;
import com.wd.backend.dao.SystemManageDaoI;
import com.wd.backend.model.Org;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Quota;
import com.wd.backend.service.SystemManageServiceI;
import com.wd.comm.context.SystemContext;
import com.wd.util.JsonUtil;

@Service("SystemManageService")
public class SystemManageServiceImpl implements SystemManageServiceI {
	@Autowired
	private SystemManageDaoI sysDao;

	@Override
	public Powers getPowersList() {
		Powers powers = recursiveTree(1);
		//String result = JsonUtil.obj2Json(recursiveTree(1));
		return powers;
	}
	
	/**
	* 递归算法解析成树形结构
	*
	* @return
	* @author jiqinlin
	*/
	public Powers recursiveTree(int id) {
		//根据cid获取节点对象(SELECT * FROM tb_tree t WHERE t.cid=?)
		Powers node = sysDao.getTreeNodeById(id);
		//查询cid下的所有子节点(SELECT * FROM tb_tree t WHERE t.pid=?)
		List<Powers> childTreeNodes = sysDao.getTreeNodeByPid(id); 
		List<Org> orgList = sysDao.getOrgBycid(id);
		node.setOrg(orgList);
		//遍历子节点
		for(Powers child : childTreeNodes){
			Powers n = recursiveTree(child.getId()); //递归
			node.getNodes().add(n);
		}
		return node;
	}

	@Override
	public void insertPermission(String id, String parentid, String flags) {
		Map<String,Object> params = new HashMap<String,Object>();
		int cid = Integer.parseInt(id),pid = Integer.parseInt(parentid);
		String[] flagArray = flags.split(",");
		String flag="";
		int count=0;
		for(int i=0;i<flagArray.length;i++){
			flag=flagArray[i];
			//插入一级栏目权限
			params.put("cid", 1);
			params.put("flag", flag);
			count = sysDao.getCount(params);
			if(count==0){
				sysDao.insert(params);
			}
			//插入一级栏目权限
			params.put("cid", pid);
			count = sysDao.getCount(params);
			if(count==0){
				sysDao.insert(params);
			}
			//插入选择的栏目权限
			params.put("cid", cid);
			count = sysDao.getCount(params);
			if(count==0){
				sysDao.insert(params);
			}
			//有下级栏目的 添加学校，那么它的所有下级栏目也要添加
			if(pid==1){
				List<Powers> list = sysDao.getTreeNodeByPid(cid); 
				if(list!=null&&list.size()>0){
					for(Powers power:list){
						params.put("cid", power.getId());
						count = sysDao.getCount(params);
						if(count==0){
							sysDao.insert(params);
						}
					}
				}
			}else{
				params.put("pid", pid);
				if(sysDao.getChildCount(pid)==sysDao.getInsertCount(params)){
					params.put("cid", pid);
					sysDao.insert(params);
				}
			}
		}
	}

	@Override
	public void deletePermission(String id, String parentid, String flag) {
		Map<String,Object> params = new HashMap<String,Object>();
		if(parentid==null && id==null) {
			params.put("flag", flag);
			sysDao.delete(params);
			return ;
		}
		int cid = Integer.parseInt(id),pid = Integer.parseInt(parentid);
		params.put("cid", cid);
		params.put("flag", flag);
		sysDao.delete(params);
		if(pid==1){
			List<Powers> list = sysDao.getTreeNodeByPid(cid); 
			if(list!=null&&list.size()>0){
				for(Powers power:list){
					params.put("cid", power.getId());
					sysDao.delete(params);
				}
			}
		}else{
			params.put("pid", pid);
			int total = sysDao.getTotalByPid(params);
			if(total == 0){
				params.put("cid", pid);
				sysDao.delete(params);
			}
		}
	}

	@Override
	public Map<String,Object> getPowersListByOrg(int id,String name) {
		Map<String,Object> resultmap = new HashMap<String,Object>();
		List<Map<String,Object>> list = sysDao.getDetailByName(name);
		String flag="",schoolName="",columnName="",province="",nextProvince="",orgId="";
		int total=0;
		List<Map<String,Object>> powerList = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> columnList = new ArrayList<Map<String,Object>>();
		Map<String,Object> columnMap =null;
		List<Org> orList =  null;List<Org> orgs = null;
		if(list!=null && list.size()>0){
			for(Map<String,Object> map:list){
				if(map.get("orgId")!=null){
					orgId = map.get("orgId").toString();
				}
				if(map.get("flag")!=null){
					flag = map.get("flag").toString();
				}
				if(map.get("schoolName")!=null){
					schoolName = map.get("schoolName").toString();
				}
				if(map.get("columnName")!=null){
					columnName = map.get("columnName").toString();
				}
				if(map.get("province")!=null){
					province = map.get("province").toString();
				} else {
					province = " ";
				}
				//判断用户查询的是学校
				if(!"".equals(schoolName)&&!"".equals(flag)&&schoolName.contains(name)){
					int size =0;
					Map<String,Object> powMap = new HashMap<String,Object>();
					Powers power = recursiveTree(id,flag);
					powMap.put("schoolName", schoolName);
					powMap.put("flag", flag);
					powMap.put("power", power);
					total = sysDao.getTotal(flag);
					powMap.put("total", total);
					//得到权限一样的学校集合
					List<Integer> integerList = sysDao.getPowersIds(flag);
					List<Org> orgList = sysDao.getPermissionOrg();
					List<Org> resultOrgList = new ArrayList<Org>();
					if(orgList!=null&&orgList.size()>0){
						List<Integer> integerList2=new ArrayList<Integer>();
						for(Org org:orgList){
							integerList2=sysDao.getPowersIds(org.getFlag());
							if(compare(integerList,integerList2)&&!org.getFlag().equals(flag)){
								resultOrgList.add(org);
								size++;
							}
						}
					}
					powMap.put("orgs", resultOrgList);
					powerList.add(powMap);
					resultmap.put("column", null);
					resultmap.put("size",size);
				}
			
				//判断用户查询的是栏目
				if(!"".equals(columnName)&&!"".equals(flag)&&columnName.contains(name)){
					if(!nextProvince.equals(province)||"".equals(province)){
						columnMap = new HashMap<String,Object>();
						orList =  new ArrayList<Org>();
						columnList.add(columnMap);
					}
					columnMap.put("columnName", columnName);
					columnMap.put("id", Integer.parseInt(map.get("cid").toString()));
					columnMap.put("pid", Integer.parseInt(map.get("pid").toString()));
					columnMap.put("province", province);
					Org og = new Org();
					og.setId(Integer.parseInt(orgId));
					og.setFlag(flag);
					og.setName(schoolName);
					og.setProvince(province);
					orList.add(og);
					columnMap.put("orglist", orList);
					nextProvince=province;
				}
			}
		}else{
			//没有查询到结果
			orgs =  sysDao.getOrgByName(name);
		}
		resultmap.put("schools", powerList);
		resultmap.put("columnList", columnList);
		resultmap.put("orgs", orgs);
		return resultmap;
	}
	
	public Powers recursiveTree(int id,String flag) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("id", id);params.put("flag", flag);
		Powers node = sysDao.getTreeNode(params);
		//查询cid下的所有子节点(SELECT * FROM tb_tree t WHERE t.pid=?)
		List<Powers> childTreeNodes = sysDao.getTreeNodeByOrg(params); 
		//遍历子节点
		for(Powers child : childTreeNodes){
			Powers n = recursiveTree(child.getId(),flag); //递归
			node.getNodes().add(n);
		}
		return node;
	}
	/**
	 * 比较两个list
	 * @param a
	 * @param b
	 * @return
	 */
	public static <T extends Comparable<T>> boolean compare(List<T> a, List<T> b) {
	    if(a.size() != b.size()) {
            return false;
        }
	    Collections.sort(a);
	    Collections.sort(b);
	    for(int i=0;i<a.size();i++){
	        if(!a.get(i).equals(b.get(i))) {
                return false;
            }
	    }
	    return true;
	}
	/**
	 * 新建学校添加权限
	 * @param ids
	 */
	@Override
	public void insertNewPermission(String ids, String flag) {
		String[] idArray=ids.split(";");
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("cid", 1);
		params.put("flag", flag);
		sysDao.insert(params);
		String cid="";
		for(int i=0;i<idArray.length;i++){
			cid=idArray[i];
			params.put("cid", Integer.parseInt(cid));
			sysDao.insert(params);
		}
		
	}

	@Override
	public void mappedPermission(String cids, String flags) {
		String[] idArray=cids.split(",");
		String[] flagArray=flags.split(",");
		Map<String,Object> params = new HashMap<String,Object>();
		for(int i=0;i<flagArray.length;i++){
			String flag=flagArray[i];
			params.put("cid", null);
			params.put("flag", flagArray[i]);
			sysDao.delete(params);
			//插入一级栏目权限
			params.put("cid", 1);
			params.put("flag", flag);
			int count = sysDao.getCount(params);
			if(count==0){
				sysDao.insert(params);
			}
			for(int j=0;j<idArray.length;j++){
				params.put("cid", Integer.parseInt(idArray[j]));
				sysDao.insert(params);
			}
		}
	}

	
	/**
	 * 流量指标
	 */
	@Override
	public List<Quota> getAllQuota() {
		return sysDao.getAll();
	}

	@Override
	public Pager getOrgQuotas() {
		Pager pager = new Pager();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("offset", SystemContext.getOffset());
		params.put("size", 20);
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> list = sysDao.getOrgQuota(params);
		int total = sysDao.getQuotaTotal();
		if(total>0){
			String flag="",schoolName="",orgId="";
			List<Quota> quotaList = new ArrayList<Quota>();
			for(Map<String, Object> map:list){
				Map<String,Object> quotaMap =new HashMap<String,Object>();
				if(map.get("orgId")!=null){
					orgId = map.get("orgId").toString();
				}
				if(map.get("flag")!=null){
					flag = map.get("flag").toString();
					quotaList = sysDao.getQuotaByOrg(flag);
				}
				if(map.get("schoolName")!=null){
					schoolName = map.get("schoolName").toString();
				}
				quotaMap.put("orgId", orgId);
				quotaMap.put("flag", flag);
				quotaMap.put("schoolName", schoolName);
				quotaMap.put("quotaList", quotaList);
				resultList.add(quotaMap);
			}
		}
		pager.setTotal(total);
		pager.setRows(resultList);
		return pager;
	}

	@Override
	public void addQuota(String qids, String flag, String type) {
		Map<String,Object> params = new HashMap<String,Object>();
		if("1".equals(type)){
			String[] idArray=qids.split(";");
			sysDao.deleteQuotaBySchool(flag);
			for(String qid : idArray){
				if(!"".equals(qid)) {
					params.put("qid", Integer.parseInt(qid));
					params.put("flag", flag);
					
					sysDao.insertQuota(params);
				}
			}
		}else if("2".equals(type)){
			String[] flagArray=flag.split(";");
			for(String fla : flagArray){
				params.put("qid", Integer.parseInt(qids));
				params.put("flag", fla);
				sysDao.insertQuota(params);
			}
		}
	}

	@Override
	public void delQuota(String id) {
		if(id!=null&&!"".equals(id)){
			sysDao.deleteQuota(Integer.parseInt(id));
		}
	}

	@Override
	public Map<String, Object> getschoolQuotaByName(String name) {
		Map<String,Object> resultMap =new HashMap<String,Object>();
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		List<Map<String,Object>> quoList = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> list = sysDao.getSchoolQuoByName(name);
		List<Org> orgs = null;
		if(list!=null && list.size()>0){
		String flag="",schoolName="",quotaName="",province="",nextProvince=" ",orgId="";
		List<Quota> quotaList = new ArrayList<Quota>();
		Map<String,Object> quoMap =null;
		List<Org> orList =  null;
		for(Map<String, Object> map : list){
			Map<String,Object> quotaMap =new HashMap<String,Object>();
			if(map.get("orgId")!=null){
				orgId = map.get("orgId").toString();
			}
			if(map.get("flag")!=null){
				flag = map.get("flag").toString();
			}
			if(map.get("schoolName")!=null){
				schoolName = map.get("schoolName").toString();
			}
			if(map.get("quotaName")!=null){
				quotaName = map.get("quotaName").toString();
			}
			if(map.get("province")!=null){
				province = map.get("province").toString();
			}
			//判断用户查询的是学校
			if(!"".equals(schoolName)&&!"".equals(flag)&&schoolName.contains(name)){
				quotaList = sysDao.getQuotaByOrg(flag);
				quotaMap.put("orgId", orgId);
				quotaMap.put("flag", flag);
				quotaMap.put("schoolName", schoolName);
				quotaMap.put("quotaList", quotaList);
				resultList.add(quotaMap);
			}
			//判断用户查询的是指标
			if(!"".equals(quotaName)&&!"".equals(flag)&&quotaName.contains(name)){
				quoMap = new HashMap<String,Object>();
				if(!nextProvince.equals(province)){
					quoList.add(quoMap);
					orList =  new ArrayList<Org>();
				}
				
				quoMap.put("quotaName", quotaName);
				quoMap.put("qid", Integer.parseInt(map.get("qid").toString()));
				quoMap.put("province", province);
				Org og = new Org();
				og.setId(Integer.parseInt(orgId));
				og.setRemark(map.get("id").toString());
				og.setFlag(flag);
				og.setName(schoolName);
				og.setProvince(province);
				orList.add(og);
				quoMap.put("orglist", orList);
				nextProvince=province;
			}
		}
		}else{
			orgs =  sysDao.getOrgByName(name);
		}
		resultMap.put("schoolQuotaList", resultList);
		resultMap.put("quoList", quoList);
		resultMap.put("orgs", orgs);
		return resultMap;
	}
}
