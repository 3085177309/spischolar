package com.wd.backend.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wd.backend.bo.SiteBO;
import com.wd.backend.bo.TemplateFileInfo;
import com.wd.backend.dao.OrgDaoI;
import com.wd.backend.dao.SiteDaoI;
import com.wd.backend.model.Org;
import com.wd.backend.model.Site;
import com.wd.backend.service.SiteServiceI;
import com.wd.exeception.SystemException;
import com.wd.util.ChineseUtil;
import com.wd.util.FileUtil;
import com.wd.util.SimpleUtil;

@Service("siteService")
public class SiteServiceImpl implements SiteServiceI {

	@Autowired
	private SiteDaoI siteDao;
	@Autowired
	private OrgDaoI orgDao;

	private static final Pattern P1 = Pattern.compile("\\s+");

	@Override
	public Site detail(Integer siteId) {
		return siteDao.findById(siteId);
	}

	@Override
	public void undeploy(Integer siteId, String deployDir) throws SystemException {
		Site site = siteDao.findById(siteId);
		if (null == site) {
			throw new SystemException("未能获取到站点信息，请刷新站点列表!");
		}
		deployDir = deployDir + site.getOrgFlag() + File.separator + site.getFlag() + File.separator;
		// 删除以前发布
		File deployDirObj = new File(deployDir);
		FileUtil.deleteDir(deployDirObj);
	}

	@Override
	public void deploy(Integer siteId, String deployDir) throws SystemException {
		Site site = siteDao.findById(siteId);
		if (null == site) {
			throw new SystemException("未能获取到站点信息，请刷新站点列表!");
		}
		if (SimpleUtil.strIsNull(site.getTemplate())) {
			throw new SystemException("请先设置站点模版根目录!");
		}
		String templateDir = FileUtil.getUploadRootPath() + site.getOrgFlag() + File.separator + site.getFlag() + File.separator + site.getTemplate() + File.separator;
		if (!new File(templateDir).exists()) {
			throw new SystemException("模版文件夹不存在!");
		}
		deployDir = deployDir + site.getOrgFlag() + File.separator + site.getFlag() + File.separator;
		// 删除以前发布
		File deployDirObj = new File(deployDir);
		FileUtil.deleteDir(deployDirObj);
		// 创建新的发布目录
		deployDirObj.mkdirs();
		try {
			FileUtil.copyDirectiory(templateDir, deployDir);
		} catch (IOException e) {
			throw new SystemException("站点发布异常!");
		}
	}

	@Override
	public String searchSiteList(Integer orgId) {
		List<Site> siteList = siteDao.findOrgSites(orgId);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("[");
		// 转换ztree json
		for (int i = 0; i < siteList.size(); i++) {
			Site site = siteList.get(i);
			stringBuilder.append("{");
			stringBuilder.append("\"name\":\"").append(site.getName()).append("\",");
			stringBuilder.append("\"siteFlag\":\"").append(site.getFlag()).append("\",");
			stringBuilder.append("\"isParent\":true,");
			stringBuilder.append("\"siteId\":" + site.getId() + ",");
			stringBuilder.append("\"orgFlag\":\"" + site.getOrgFlag() + "\",");
			stringBuilder.append("\"orgId\":\"" + site.getOrgId() + "\",");
			stringBuilder.append("\"children\":[");
			File templateDir = new File(FileUtil.getUploadRootPath() + site.getOrgFlag() + File.separator + site.getFlag() + File.separator);
			File[] dirArr = templateDir.listFiles();
			if (null != dirArr && dirArr.length > 0) {
				for (int j = 0; j < dirArr.length; j++) {
					if (null == dirArr[j]) {
                        continue;
                    }
					stringBuilder.append("{\"name\":\"" + dirArr[j].getName() + "\",\"tempateDir\":true,\"isParent\":true,\"orgFlag\":\"" + site.getOrgFlag() + "\",\"siteFlag\":\"" + site.getFlag()
							+ "\",\"siteId\":\"" + site.getId() + "\"");
					if (dirArr[j].isDirectory()) {
						File[] tpFiles = dirArr[j].listFiles();
						stringBuilder.append(",\"children\":[");
						for (int k = 0; k < tpFiles.length; k++) {
							if (null == tpFiles[k] || tpFiles[k].isDirectory()) {
								continue;
							}
							stringBuilder.append("{\"name\":\"" + tpFiles[k].getName() + "\",\"isTemplatePage\":true,\"templateDir\":\"" + dirArr[j].getName() + "\",\"orgFlag\":\""
									+ site.getOrgFlag() + "\",\"siteFlag\":\"" + site.getFlag() + "\",\"siteId\":\"" + site.getId() + "\"}");
							if (k != tpFiles.length - 1) {
								stringBuilder.append(",");
							}
						}
						stringBuilder.append("]");
					}
					stringBuilder.append("}");
					if (j != dirArr.length - 1) {
						stringBuilder.append(",");
					}
				}
			}
			stringBuilder.append("]");
			stringBuilder.append("}");
			if (i != siteList.size() - 1) {
				stringBuilder.append(",");
			}
		}
		stringBuilder.append("]");
		return stringBuilder.toString();
	}

	@Override
	public String loadFileContent(TemplateFileInfo templateFileInfo) throws SystemException {
		try {
			return FileUtil.loadFileContent(templateFileInfo.getOrgFlag() + File.separator + templateFileInfo.getSiteFlag() + File.separator + templateFileInfo.getTemplateFlag() + File.separator
					+ templateFileInfo.getFileName());
		} catch (FileNotFoundException e) {
			return "文件不存在，请尝试刷新文件目录!";
		} catch (IOException e) {
			return "无法获取文件内容!";
		}
	}

	@Override
	public void saveFileContent(TemplateFileInfo fileInfo) throws SystemException {
		FileUtil.writeContent(fileInfo);
	}

	@Override
	public void add(SiteBO site) throws SystemException {
		String siteFlag = site.getFlag();
		Integer orgId = site.getOrgId();
		if (SimpleUtil.strIsNull(site.getName())) {
			throw new SystemException("站点名不能为空!");
		}
		if (SimpleUtil.strIsNull(siteFlag)) {
			throw new SystemException("站点标识不能为空!");
		}
		if (ChineseUtil.isChinese(siteFlag)) {
			throw new SystemException("站点标识不能中文!");
		}
		if (P1.matcher(siteFlag).find()) {
			throw new SystemException("站点标识不能包含空格!");
		}

		Org org = orgDao.findById(orgId);
		if (null == org) {
			throw new SystemException("无法获取站点所属机构信息!");
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("flag", siteFlag);
		params.put("orgId", site.getOrgId());
		Integer orgSiteFlagExists = siteDao.findOrgFlagExists(params);
		if (null != orgSiteFlagExists) {
			throw new SystemException("机构标识[" + siteFlag + "]已存在!");
		}
		Site model = new Site();
		BeanUtils.copyProperties(site, model);
		model.setOrgFlag(org.getFlag());
		model.setCreateDate(new Date());
		model.setTemplate("");
		try {
			siteDao.insert(model);
			// 新建站点文件夹
			new File(FileUtil.getUploadRootPath() + org.getFlag() + File.separator + site.getFlag() + File.separator).mkdir();
		} catch (RuntimeException e) {
			throw new SystemException("站点信息插入异常!");
		}
	}

	@Override
	public void del(Integer siteId, String deployPath) {
		Site site = siteDao.findById(siteId);
		if (null == site) {
			return;
		}
		siteDao.del(siteId);
		// 删除上传目录
		FileUtil.deleteDir(new File(FileUtil.getUploadRootPath() + site.getOrgFlag() + File.separator + site.getFlag() + File.separator));
		// 删除发布目录
		FileUtil.deleteDir(new File(deployPath + site.getOrgFlag() + File.separator + site.getFlag() + File.separator));
	}

	@Override
	public void editSiteTemplateRoot(Integer siteId, String templateName) throws SystemException {
		Site site = siteDao.findById(siteId);
		if (null == site) {
			throw new SystemException("无法获取站点信息!");
		}
		File templateDir = new File(FileUtil.getUploadRootPath() + site.getOrgFlag() + File.separator + site.getFlag() + File.separator + templateName + File.separator);
		if (!templateDir.exists()) {
			throw new SystemException("指定的模版目录不存在,请刷新模版目录!");
		}
		Map<String, Object> params = new HashMap<String, Object>(2);
		params.put("id", siteId);
		params.put("template", templateName);
		siteDao.updateSiteTemplate(params);
	}

	@Override
	public void delTempateDir(Integer siteId, String templateFlag) throws SystemException {
		Site site = siteDao.findById(siteId);
		if (null == site) {
			throw new SystemException("无法获取对应站点的信息，请确认站点是否存在!");
		}
		if (SimpleUtil.strIsNull(templateFlag)) {
			throw new SystemException("模版目录不能为空!");
		}
		templateFlag = templateFlag.trim();
		if (templateFlag.equals(site.getTemplate())) {
			throw new SystemException("无法删除在用模版!");
		}
		FileUtil.deleteDir(new File(FileUtil.getUploadRootPath() + site.getOrgFlag() + File.separator + site.getFlag() + File.separator + templateFlag + File.separator));
	}

}
