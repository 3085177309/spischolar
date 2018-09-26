package com.wd.backend.service;

import com.wd.backend.bo.SiteBO;
import com.wd.backend.bo.TemplateFileInfo;
import com.wd.backend.model.Site;
import com.wd.exeception.SystemException;

public interface SiteServiceI {

	/**
	 * 获取机构下的所有站点列表
	 * 
	 * @param orgId
	 * @return 符合ztree要求的json字符串
	 */
	String searchSiteList(Integer orgId);

	/**
	 * 获取文件内容
	 * 
	 * @param templateFileInfo
	 * @return
	 * @throws SystemException
	 *             当文件不存在，或者无法正确获取文件内容时，抛出此异常
	 */
	String loadFileContent(TemplateFileInfo templateFileInfo) throws SystemException;

	/**
	 * 保存文件内容
	 * 
	 * @param fileInfo
	 * @throws SystemException
	 *             当文件保存失败时，抛出此异常
	 */
	void saveFileContent(TemplateFileInfo fileInfo) throws SystemException;

	/**
	 * 新建站点
	 * 
	 * @param site
	 * @throws SystemException
	 *             当站点信息不符合系统约束则抛出此异常
	 */
	void add(SiteBO site) throws SystemException;

	/**
	 * 站点删除
	 * 
	 * @param siteId
	 * @param deployPath
	 *            部署目录
	 */
	void del(Integer siteId, String deployPath);

	/**
	 * 修改站点模版根目录
	 * 
	 * @param siteId
	 * @param templateName
	 * @throws SystemException
	 *             当指定的模版目录不存在时，抛出此异常
	 */
	void editSiteTemplateRoot(Integer siteId, String templateName) throws SystemException;

	/**
	 * 站点发布
	 * 
	 * @param siteId
	 * @throws SystemException
	 */
	void deploy(Integer siteId, String deployDir) throws SystemException;

	/**
	 * 站点反发布
	 * 
	 * @param siteId
	 * @param string
	 * @throws SystemException
	 */
	void undeploy(Integer siteId, String string) throws SystemException;

	/**
	 * 查看站点详细信息
	 * 
	 * @param siteId
	 * @return
	 */
	Site detail(Integer siteId);

	/**
	 * 删除模版目录
	 * 
	 * @param orgFlag
	 * @param siteFlag
	 * @param templateFlag
	 * @throws SystemException 当站点
	 */
	void delTempateDir(Integer siteId, String templateFlag) throws SystemException;

}
