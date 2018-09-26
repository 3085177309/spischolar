package com.wd.front.module.cache.impl;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;

import com.wd.comm.Comm;
import com.wd.util.LoginUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.oscache.base.NeedsRefreshException;
import com.wd.backend.bo.OrgBO;
import com.wd.backend.dao.AuthorityDatabaseDaoI;
import com.wd.backend.dao.DisciplineDaoI;
import com.wd.backend.dao.DisciplineSystemDaoI;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.PersonDaoI;
import com.wd.backend.dao.ProductDaoI;
import com.wd.backend.dao.SortFieldDaoI;
import com.wd.backend.dao.SystemManageDaoI;
import com.wd.backend.model.AuthorityDatabase;
import com.wd.backend.model.Discipline;
import com.wd.backend.model.DisciplineSystem;
import com.wd.backend.model.JournalSystemSubject;
import com.wd.backend.model.LinkRule;
import com.wd.backend.model.Org;
import com.wd.backend.model.Powers;
import com.wd.backend.model.Product;
import com.wd.backend.model.Quota;
import com.wd.backend.model.SortField;
import com.wd.browse.dao.AdditionDaoI;
import com.wd.exeception.SystemException;
import com.wd.front.bo.BaseCache;
import com.wd.front.bo.SearchCondition;
import com.wd.front.bo.SearchResult;
import com.wd.front.context.SearchServiceContext;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;
import com.wd.front.service.SearchServiceI;
import com.wd.util.ChineseUtil;
import com.wd.util.GetFirstLetter;
import com.wd.util.IpUtil;

public class CacheModuleImpl implements CacheModuleI {
	
	private static final Logger log=Logger.getLogger(CacheModuleImpl.class);

	@Autowired
	private PersonDaoI personDao;
	
	private OrgDaoI orgDao;
	private DisciplineSystemDaoI disciplineSystemDao;
	private AuthorityDatabaseDaoI authorityDatabaseDao;
	private DisciplineDaoI disciplineDao;
	private SortFieldDaoI sortFieldDao;
	private SystemManageDaoI sysDao;
	@Autowired
	private AdditionDaoI additionDao;
	
	@Resource
	private ProductDaoI productDao;
	
	@Autowired
	private OrgInfoServiceI orgInfoService;
	
	@Autowired
	private SearchServiceContext searchServiceContext;


	// 机构信息缓存(机构信息)
	private BaseCache orgCache;
	// 全局缓存（排序字段，权威数据库分区信息,权威数据库的最新学科体系，权威数据库所有收录年,所有的学科）
	private BaseCache overallSituationCache;
	// 增加数据缓存信息
	private BaseCache browseCache;

	public CacheModuleImpl() {
		InputStream inputStream = CacheModuleImpl.class.getClassLoader().getResourceAsStream("oscache.properties");
		Properties prop = new Properties();
		if (null == inputStream) {
			throw new RuntimeException("获取获取oscache.properties文件的输入流");
		}
		try {
			prop.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		}
		int cacheTime = 60 * 60 * 23 + 60 * 57;
		orgCache = new BaseCache("org", cacheTime, prop);
		overallSituationCache = new BaseCache("overallSituation", cacheTime, prop);
		browseCache = new BaseCache("browse", cacheTime, prop);
	}

	public void initCache() throws SystemException {
		// 从数据库中加载所有机构信息到缓存
		addAllOrgInfo2Cache();
		// 将权威数据库信息加载到缓存
		addAuthorityDatabase2Cache();
		// 从数据库中加载学科体系到缓存
		addDisciplineSystem2Cache();
		// 添加所有排序字段
		addSortField();
		// 修改所有用户状态
		updateUserLogin();
/*		addBrowseInfoCache();*/
		System.out.println("缓存初始化完毕...");
	}

	/**
	 * 添加所有排序字段
	 */
	private void addSortField() {
		List<SortField> sortFieldList = sortFieldDao.findAll();

		Set<String> sortFieldSet = new HashSet<String>();
		for (SortField sortField : sortFieldList) {
			String field = sortField.getFields();
			sortFieldSet.add(field);
		}
		// 将结果放入缓存
		overallSituationCache.put(Comm.sort_field_cache_key, sortFieldSet);
	}

	/**
	 * 加载权威数据库信息到缓存
	 */
	private void addAuthorityDatabase2Cache() {
		log.info("加载权威数据库信息...");
		List<AuthorityDatabase> authorityDatabaseList = authorityDatabaseDao.findAll();
		// 缓存分区信息
		overallSituationCache.put(Comm.authority_db_partition_cache_key, authorityDatabaseList);
		
		//期刊首页左侧subject
		List<JournalSystemSubject> subjectNameList = disciplineSystemDao.findAllSubjectName();
		List<JournalSystemSubject> subjectList = new ArrayList<JournalSystemSubject>();
		for(int i=0;i<subjectNameList.size();i++) {
			JournalSystemSubject subject = new JournalSystemSubject();
			String subjectName = subjectNameList.get(i).getName();
			int id = subjectNameList.get(i).getId();
			subject.setName(subjectName);
			subject.setId(id);
			List<AuthorityDatabase> authorityList = new ArrayList<AuthorityDatabase>();
			for(int j=0;j<authorityDatabaseList.size();j++) {
				AuthorityDatabase authorityDatabase = new AuthorityDatabase();
				String dbSystem = authorityDatabaseList.get(j).getFlag();
				if("EI".equals(dbSystem)) {
                    continue;
                }
				String dbYear = authorityDatabaseList.get(j).getLastYear();
//				SearchCondition condition =new SearchCondition();
//				condition.setSearchComponentFlag("subject_search");
//				condition.addQueryCdt("scSName_3_1_"+subjectName);
//				condition.addQueryCdt("scDB_3_1_"+dbSystem);
//				condition.addQueryCdt("scYear_3_1_"+dbYear);
//				SearchServiceI searchService = searchServiceContext.findSearchServiceImpl(condition.getSearchComponentFlag());
//				SearchResult result=searchService.search(condition);
				String[] dbs = {"SCI-E","中科院JCR分区(小类)","中科院JCR分区(大类)","CSCD","Eigenfactor","CSSCI","北大核心","SSCI","SCOPUS","ESI"};
				for(int k=0; k< dbs.length;k++) {
					if(dbs[k].equals(dbSystem)) {
                        dbSystem = (k+1)+"";
                    }
				}
//				if(result.getDatas().size() > 0) {
//					authorityDatabase.setHasContent(true);
//					String url= "journal/subject/"+id+"/"+dbSystem+"/"+dbYear;
//					if(subject.getUrl() == null) {
//                        subject.setUrl(url);
//                    }
//				}
				authorityDatabase.setHasContent(true);
				String url= "journal/subject/"+id+"/"+dbSystem+"/"+dbYear;
				if(subject.getUrl() == null) {
                    subject.setUrl(url);
                }
				authorityDatabase.setFlag(dbSystem);
				authorityList.add(authorityDatabase);
				subject.setList(authorityList);
			}
			subjectList.add(subject);
		}
		overallSituationCache.put(Comm.discipline_system_subject_cache_key,subjectList);

		Map<String, Integer> authorityDbMap = new LinkedHashMap<String, Integer>();
		for (AuthorityDatabase authorityDatabase : authorityDatabaseList) {
			authorityDbMap.put(authorityDatabase.getFlag(), authorityDatabase.getId());
		}
		// 缓存权威数据库信息
		overallSituationCache.put(Comm.all_authority_db_cache_key, authorityDbMap);
	}

	/**
	 * 从数据库中加载学科体系到缓存（掉用此方法之前，全局缓存中一定要有权威数据库分区缓存，
	 * 也就是指addAuthorityDatabase2Cache方法必须先于该方法被调用）
	 * 
	 * @throws SystemException
	 */
	@SuppressWarnings("unchecked")
	private void addDisciplineSystem2Cache() throws SystemException {
		// 从缓存中获取所有权威数据库
		List<AuthorityDatabase> authorityDatabaseList;
		try {
			authorityDatabaseList = (List<AuthorityDatabase>) overallSituationCache.get(Comm.authority_db_partition_cache_key);
		} catch (NeedsRefreshException e) {
			throw new SystemException("从缓存中获取权威数据库分区信息失败", e);
		}

		// 最新学科体系列表
		List<DisciplineSystem> newDisciplineSystemList = disciplineSystemDao.findLast();
		Map<String, Integer> map = this.findAllAuthorityDbFromCache();
		Set<String> keySet = map.keySet();
		// 权威数据库的最新学科体系
		Map<String, Set<DisciplineSystem>> authorityDbDisciplineSystemMap = new LinkedHashMap<String, Set<DisciplineSystem>>();
		for (String db : keySet) {
			Set<DisciplineSystem> disciplineSystem = findDisciplineSystem(newDisciplineSystemList, db);
			authorityDbDisciplineSystemMap.put(db, disciplineSystem);
		}
		// 缓存权威数据库最新学科体系
		overallSituationCache.put(Comm.authority_db_new_discipline_system_cache_key, authorityDbDisciplineSystemMap);

		// 权威数据库的所有收录年
		List<DisciplineSystem> shouLuYearList = disciplineSystemDao.findAllYear();

		// 按权威数据库分类存储权威数据库的所有收录年(key为权威数据库)
		Map<String, Set<DisciplineSystem>> dbAllYearMap = new LinkedHashMap<String, Set<DisciplineSystem>>();
		for (AuthorityDatabase authorityDatabase : authorityDatabaseList) {
			String db = authorityDatabase.getFlag().trim();
			Set<DisciplineSystem> allYear = dbAllYearMap.get(db);
			if (null == allYear) {
				allYear = new TreeSet<DisciplineSystem>(new Comparator<DisciplineSystem>() {

					@Override
					public int compare(DisciplineSystem o1, DisciplineSystem o2) {
						if (o1.getYear() > o2.getYear()) {
							return -1;
						} else if (o1.getYear() < o2.getYear()) {
							return 1;
						}
						return 0;
					}
				});
				dbAllYearMap.put(db, allYear);
			}
			for (DisciplineSystem disciplineSystem : shouLuYearList) {
				if (disciplineSystem.getAuthorityDatabase().trim().equals(db)) {
					allYear.add(disciplineSystem);
				}
			}
		}
		// 缓存权威数据库所有收录年
		overallSituationCache.put(Comm.authority_db_all_year_cache_key, dbAllYearMap);

		List<Discipline> disciplineList = disciplineDao.findAll();
		Map<String, Integer> disciplineMap = new HashMap<String, Integer>();
		for (Discipline discipline : disciplineList) {
			disciplineMap.put(discipline.getFlag(), discipline.getId());
		}
		overallSituationCache.put(Comm.all_discipline_cache_key, disciplineMap);
	}

	private Set<DisciplineSystem> findDisciplineSystem(List<DisciplineSystem> newDisciplineSystemList, String dis) {
		Set<DisciplineSystem> disciplineSystemSet = new TreeSet<DisciplineSystem>(new Comparator<DisciplineSystem>() {

			@Override
			public int compare(DisciplineSystem o1, DisciplineSystem o2) {
				if (ChineseUtil.isChinese(o1.getDiscipline())) {
					String o1Letter = GetFirstLetter.cn2py(o1.getDiscipline());
					String o2Letter = GetFirstLetter.cn2py(o2.getDiscipline());
					int o1Val = o1Letter.toCharArray()[0];
					int o2Val = o2Letter.toCharArray()[0];
					if (o1Val > o2Val) {
						return 1;
					} else {
						return -1;
					}
				} else {
					String o1FirstWord = o1.getDiscipline().split("[ ]+")[0];
					String o2FirstWord = o2.getDiscipline().split("[ ]+")[0];
					int o1SortVal = o1FirstWord.length() > 2 ? o1FirstWord.toCharArray()[0] + o1FirstWord.toCharArray()[0] : o1FirstWord.toCharArray()[0];
					int o2SortVal = o2FirstWord.length() > 2 ? o1FirstWord.toCharArray()[0] + o1FirstWord.toCharArray()[0] : o1FirstWord.toCharArray()[0];
					if (o1SortVal > o2SortVal) {
						return -1;
					} else {
						return 1;
					}
				}
			}
		});
		for (DisciplineSystem disSys : newDisciplineSystemList) {
			if (null == disSys.getAuthorityDatabase()) {
				continue;
			}
			if (disSys.getAuthorityDatabase().toUpperCase().equals(dis.toUpperCase())) {
				disciplineSystemSet.add(disSys);
			}
		}
		return disciplineSystemSet;
	}

	/**
	 * 从数据库中加载所有机构信息到缓存
	 */
	private void addAllOrgInfo2Cache() {
		List<Org> orgList = orgDao.findAll();
		log.info("加载机构缓存,加载机构个数:"+orgList.size());
		Set<Integer> orgIdSet = new HashSet<Integer>();
		for (Org org : orgList) {
			OrgBO orgBO = new OrgBO();
			List<Powers> powers = sysDao.getPermissionByOrgId(org.getId());
			List<Quota> quotas = sysDao.getQuotaByOrgId(org.getId());
			BeanUtils.copyProperties(org, orgBO);
			orgBO.setPowers(powers);
			orgBO.setQuotas(quotas);
			orgIdSet.add(org.getId());
			// 将每个机构信息单独放入缓存中(这么做是为了单独重加载机构缓存)
			orgCache.put(Comm.org_cache_key + org.getId(), orgBO);
		}
		// 将所有的机构id放入缓存中(这么做是为了能够一次将所有机构都取出来)
		orgCache.put(Comm.org_cache_key + "_all_org_id", orgIdSet);
	}
	/**
	 * 从数据库加载数据添加信息
	 */
/*	public void addBrowseInfoCache() {
		log.info("加载增加数据缓存！");
		List<Map<String,Object>> list = additionDao.getAddBrowse();
		Set<String> orgFlagSet = new HashSet<String>();
		for(int i=0;i<list.size();i++) {
			Map<String,Object> map = list.get(i);
			browseCache.put(browse_cache_key + map.get("orgFlag").toString(), map);
			orgFlagSet.add(map.get("orgFlag").toString());
		}
		browseCache.put(browse_cache_key + "_all_org_flag", orgFlagSet);
	}
	public Map<String,Object> getBrowseInfoCache(String orgFlag) {
		Map<String, Object> map = null;
		try {
			Set<String> orgFlagSet =(Set<String>) browseCache.get(browse_cache_key + "_all_org_flag");
			if(!orgFlagSet.contains(orgFlag)) {
				return null;
			}
		} catch (NeedsRefreshException e1) {
			e1.printStackTrace();
		}
		try {
			map =  (Map<String, Object>) browseCache.get(browse_cache_key + orgFlag);
		} catch (NeedsRefreshException e) {
			e.printStackTrace();
			this.addBrowseInfoCache();
		}
		return map;
	}*/

	@Override
	public void reloadAllOrgCache() {
		// 清空所有机构缓存
		orgCache.removeAll();
		// 重加载所有机构缓存
		this.addAllOrgInfo2Cache();
	}
	
	@Override
	public void reloadOrgCache(Integer orgId) {
		assert orgId!=null;
		log.info("重新加载机构缓存!");
		// 删除被缓存的对象
		orgCache.remove(Comm.org_cache_key + orgId);
		Org org = orgDao.findById(orgId);
		if (null != org) {
			// 将新的机构信息重新放入缓存
			OrgBO orgBO = new OrgBO();
			List<Powers> powers = sysDao.getPermissionByOrgId(org.getId());
			List<Quota> quotas = sysDao.getQuotaByOrgId(org.getId());
			BeanUtils.copyProperties(org, orgBO);
			orgBO.setPowers(powers);
			orgBO.setQuotas(quotas);
			Map<Integer, List<LinkRule>> dbLinkRules = new HashMap<Integer, List<LinkRule>>();
			orgBO.setDbRules(dbLinkRules);
			orgCache.put(Comm.org_cache_key + orgId, orgBO);
		}
		//更新订购的产品信息
		List<Product> products=orgInfoService.findProductListByOrg(org.getFlag());
		putOrgProductList(org.getFlag(),products);
	}

	@Override
	public void reloadOverallSituationCache() throws SystemException {
		// 清空全局缓存中的所有数据，然后重加载
		overallSituationCache.removeAll();
		// 将权威数据库信息加载到缓存
		addAuthorityDatabase2Cache();
		// 从数据库中加载学科体系到缓存
		addDisciplineSystem2Cache();
		// 添加所有排序字段
		addSortField();
		//用户校外登陆权限认证
		updatePermission();
	}
	public void updatePermission(){
		System.out.print("用户校外登陆权限时限认证");
		personDao.updatePermission();
	}

	@Override
	public OrgBO findOrgByIpFromCache(String ip) throws SystemException {
		OrgBO orgBO = null;
		Set<Integer> orgIdSet = null;
		for (int i = 0; i < 3; i++) {
			try {
				orgIdSet = (Set<Integer>) this.orgCache.get(Comm.org_cache_key + "_all_org_id");
				break;
			} catch (NeedsRefreshException e) {
				this.reloadAllOrgCache();
			}
		}
		if (null != orgIdSet) {
			for (Integer orgId : orgIdSet) {
				for (int i = 0; i < 3; i++) {
					try {
						OrgBO org = (OrgBO) this.orgCache.get(Comm.org_cache_key + orgId);
						if (null != org) {
							if (IpUtil.isInRange(org.getIpRanges(), ip)) {
								return org;
							} else {
								break;
							}
						}
					} catch (NeedsRefreshException e) {
						this.reloadAllOrgCache();
					}
				}
			}
		}
		return orgBO;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Set<DisciplineSystem>> loadDisciplineSystemFromCache() throws SystemException {
		Map<String, Set<DisciplineSystem>> map = null;
		for (int i = 0; i < 3; i++) {
			try {
				map = (Map<String, Set<DisciplineSystem>>) overallSituationCache.get(Comm.authority_db_new_discipline_system_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Set<DisciplineSystem>> findDbAllYearFromCache() throws SystemException {
		Map<String, Set<DisciplineSystem>> map = null;
		for (int i = 0; i < 3; i++) {
			try {
				map = (Map<String, Set<DisciplineSystem>>) overallSituationCache.get(Comm.authority_db_all_year_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<AuthorityDatabase> findDbPartitionFromCache() throws SystemException {
		List<AuthorityDatabase> list = null;
		for (int i = 0; i < 3; i++) {
			try {
				list = (List<AuthorityDatabase>) overallSituationCache.get(Comm.authority_db_partition_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return list;
	}
	
	/**
	 * 期刊首页左侧subjectName
	 * @return
	 * @throws SystemException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<JournalSystemSubject> findSubjectPartitionFromCache() throws SystemException {
		List<JournalSystemSubject> list = null;
		for (int i = 0; i < 3; i++) {
			try {
				list = (List<JournalSystemSubject>) overallSituationCache.get(Comm.discipline_system_subject_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return list;
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Integer> findAllDisciplineFromCache() throws SystemException {
		Map<String, Integer> map = null;
		for (int i = 0; i < 3; i++) {
			try {
				map = (Map<String, Integer>) overallSituationCache.get(Comm.all_discipline_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Integer> findAllAuthorityDbFromCache() throws SystemException {
		Map<String, Integer> map = null;
		for (int i = 0; i < 3; i++) {
			try {
				map = (Map<String, Integer>) overallSituationCache.get(Comm.all_authority_db_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Set<String> findAllSortFieldByTypeFromCache(String type) throws SystemException {
		Set<String> set = null;
		for (int i = 0; i < 3; i++) {
			try {
				set = (Set<String>) overallSituationCache.get(Comm.sort_field_cache_key);
				break;
			} catch (NeedsRefreshException e) {
				this.reloadOverallSituationCache();
			}
		}
		return set;
	}

	public void setOrgCache(BaseCache orgCache) {
		this.orgCache = orgCache;
	}

	public void setOverallSituationCache(BaseCache overallSituationCache) {
		this.overallSituationCache = overallSituationCache;
	}

	public void setOrgDao(OrgDaoI orgDao) {
		this.orgDao = orgDao;
	}

	public void setDisciplineSystemDao(DisciplineSystemDaoI disciplineSystemDao) {
		this.disciplineSystemDao = disciplineSystemDao;
	}

	public void setAuthorityDatabaseDao(AuthorityDatabaseDaoI authorityDatabaseDao) {
		this.authorityDatabaseDao = authorityDatabaseDao;
	}

	public void setDisciplineDao(DisciplineDaoI disciplineDao) {
		this.disciplineDao = disciplineDao;
	}

	public void setSortFieldDao(SortFieldDaoI sortFieldDao) {
		this.sortFieldDao = sortFieldDao;
	}

	public void setSysDao(SystemManageDaoI sysDao) {
		this.sysDao = sysDao;
	}

	@Override
	public void putOrgProductList(String orgFlag, List<Product> products) {
		String key=Comm.ORG_PRODUCT_LIST_KEY_PREFIX+orgFlag;
		orgCache.put(key, products);
	}

	@Override
	public List<Product> getOrgProductList(String orgFlag) {
		String key=Comm.ORG_PRODUCT_LIST_KEY_PREFIX+orgFlag;
		try{
			return (List<Product>)orgCache.get(key);
		}catch(Exception e){
			log.error("获取缓存失败!");
		}
		return null;
	}

	@Override
	public void reloadOrgProductCache(String orgFlag) {
		assert !StringUtils.isEmpty(orgFlag);
		String key=Comm.ORG_PRODUCT_LIST_KEY_PREFIX+orgFlag;
		orgCache.remove(key);
		orgCache.put(key, productDao.findCurrentByOrg(orgFlag));
	}

	@Override
	public List<Powers> findPowersByOrgIdFromCache(int orgId)
			throws SystemException {
		List<Powers> powers =null;
		try {
			OrgBO org = (OrgBO) this.orgCache.get(Comm.org_cache_key + orgId);
			powers = org.getPowers();
		} catch (NeedsRefreshException e) {
			this.reloadAllOrgCache();
		}
		return powers;
	}

	@Override
	public List<Quota> findQuotaByOrgIdFromCache(int orgId)
			throws SystemException {
		List<Quota> quotas =null;
		try {
			OrgBO org = (OrgBO) this.orgCache.get(Comm.org_cache_key + orgId);
			quotas= org.getQuotas();
		} catch (NeedsRefreshException e) {
			this.reloadAllOrgCache();
		}
		return quotas;
	}
	
	private void updateUserLogin() {
		Map<String, Object> params = new HashMap<String, Object>();
		
		personDao.updateAllStatus();
	}

	public PersonDaoI getPersonDao() {
		return personDao;
	}

	public void setPersonDao(PersonDaoI personDao) {
		this.personDao = personDao;
	}

	public void setAdditionDao(AdditionDaoI additionDao) {
		this.additionDao = additionDao;
	}

	public void setBrowseCache(BaseCache browseCache) {
		this.browseCache = browseCache;
	}

}
