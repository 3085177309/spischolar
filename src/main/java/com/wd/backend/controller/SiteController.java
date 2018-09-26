package com.wd.backend.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;

import com.wd.backend.bo.SiteBO;
import com.wd.backend.bo.TemplateFileInfo;
import com.wd.backend.model.Org;
import com.wd.backend.model.Site;
import com.wd.backend.service.OrgServiceI;
import com.wd.backend.service.SiteServiceI;
import com.wd.exeception.SystemException;
import com.wd.util.ChineseUtil;
import com.wd.util.FileUtil;
import com.wd.util.JsonUtil;
import com.wd.util.SimpleUtil;
import com.wd.util.ZipUtil;

@Controller
@RequestMapping("/backend/site")
public class SiteController {

	@Autowired
	private SiteServiceI siteService;
	@Autowired
	private OrgServiceI orgService;

	@RequestMapping(value = { "/index/{orgId}" }, method = { RequestMethod.GET })
	public String index(@PathVariable Integer orgId, HttpServletRequest request) {
		request.setAttribute("orgId", orgId);
		return "backend/site/index";
	}

	@RequestMapping(value = { "/templateDel/{siteId}/{templateFlag}" }, method = { RequestMethod.GET })
	public void delTemplateDir(@PathVariable Integer siteId, @PathVariable String templateFlag, HttpServletResponse response) throws IOException {
		String rs = "{}";
		try {
			siteService.delTempateDir(siteId, templateFlag);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(rs);
	}

	@RequestMapping(value = { "/detail/{siteId}" }, method = { RequestMethod.GET })
	public void detail(@PathVariable Integer siteId, HttpServletResponse response) throws IOException {
		Site site = siteService.detail(siteId);
		response.setCharacterEncoding("UTF-8");
		if (null != site) {
			response.getWriter().println(JsonUtil.obj2Json(site));
		} else {
			response.getWriter().println("{\"error\":\"无法找到该站点信息,请尝试刷新站点列表!\"}");
		}
	}

	/**
	 * 查看机构下的站点列表
	 * 
	 * @param orgId
	 * @return
	 */
	@RequestMapping(value = { "/list/{orgId}" }, method = { RequestMethod.GET })
	public String orgSiteList(@PathVariable Integer orgId, HttpServletRequest request) {
		Org org = orgService.detail(orgId);
		request.setAttribute("org", org);
		String ztreeJson = siteService.searchSiteList(orgId);
		request.setAttribute("ztreeJson", ztreeJson);
		return "backend/site/list";
	}

	/**
	 * 新增站点
	 * 
	 * @param site
	 * @param response
	 */
	@RequestMapping(value = { "/add" }, method = { RequestMethod.POST })
	public void add(SiteBO site, HttpServletResponse response) {
		String rs = "{}";
		try {
			siteService.add(site);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().println(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/del/{orgId}/{siteId}" }, method = { RequestMethod.GET })
	public String del(@PathVariable Integer orgId, @PathVariable Integer siteId, HttpServletRequest request) {
		String deployPath = request.getRealPath("/") + "sites" + File.separator;
		siteService.del(siteId, deployPath);
		return UrlBasedViewResolver.FORWARD_URL_PREFIX + "/backend/site/list/" + orgId;
	}

	/**
	 * 站点发布
	 * 
	 * @param siteId
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/deploy/{siteId}" }, method = { RequestMethod.GET })
	public void deploySite(@PathVariable Integer siteId, HttpServletRequest request, HttpServletResponse response) {
		String rs = "rs";
		try {
			siteService.deploy(siteId, request.getRealPath("/") + "sites" + File.separator);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 站点反发布
	 * 
	 * @param siteId
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = { "/undeploy/{siteId}" }, method = { RequestMethod.GET })
	public void undeploySite(@PathVariable Integer siteId, HttpServletRequest request, HttpServletResponse response) {
		String rs = "rs";
		try {
			siteService.undeploy(siteId, request.getRealPath("/") + "sites" + File.separator);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = { "/editSiteTemplateRoot/{siteId}/{templateName}" }, method = { RequestMethod.GET })
	public void editSiteTemplateRoot(@PathVariable Integer siteId, @PathVariable String templateName, HttpServletResponse response) {
		String rs = "{}";
		try {
			siteService.editSiteTemplateRoot(siteId, templateName);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().println(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 记载文件内容
	 * 
	 * @param orgFlag
	 *            机构标识
	 * @param siteFlag
	 *            站点标识
	 * @param templateFlag
	 *            模版根目录
	 * @param fileName
	 *            文件名
	 * @param response
	 */
	@RequestMapping(value = { "/loadFileContent" }, method = { RequestMethod.POST })
	public void loadFileContent(TemplateFileInfo templateFlag, HttpServletResponse response) {

		String content;
		try {
			content = siteService.loadFileContent(templateFlag);
		} catch (SystemException e1) {
			content = e1.getMessage();
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(content);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 保存对文件的修改
	 * 
	 * @param templateFileInfo
	 * @param response
	 */
	@RequestMapping(value = { "/saveFileContent" }, method = { RequestMethod.POST })
	public void saveFileContent(TemplateFileInfo fileInfo, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		String rs = "{}";
		try {
			siteService.saveFileContent(fileInfo);
		} catch (SystemException e) {
			rs = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		try {
			response.getWriter().print(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 模版压缩包上传
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/upload/template", method = RequestMethod.POST)
	public void fileUpload(HttpServletRequest request, HttpServletResponse response) {
		String rs = "{}";
		// 设置上下方文
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());

		// 检查form是否有enctype="multipart/form-data"
		boolean hasError = false;
		String orgFlag = request.getParameter("orgFlag");
		if (SimpleUtil.strIsNull(orgFlag)) {
			hasError = true;
			rs = "{\"error\":\"机构数据异常!\"}";
		}
		String siteFlag = request.getParameter("siteFlag");
		if (SimpleUtil.strIsNull(siteFlag)) {
			hasError = true;
			rs = "{\"error\":\"站点数据异常!\"}";
		}
		if (!hasError && multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {

				// 由CommonsMultipartFile继承而来,拥有上面的方法.
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String path = FileUtil.getUploadRootPath() + orgFlag + File.separator + file.getOriginalFilename();

					String fileName = file.getOriginalFilename();
					// 获取文件后缀
					if (fileName.lastIndexOf('.') == -1) {
						rs = "{\"error\":\"只能上传zip压缩文件\"}";
						continue;
					}
					String hz = fileName.substring(fileName.lastIndexOf('.') + 1);
					if (!"application/octet-stream".equals(file.getContentType()) && !"zip".equals(hz)) {
						rs = "{\"error\":\"只能上传zip压缩文件\"}";
						continue;
					}
					File localFile = new File(path);
					String zipFileName = "";
					int pos = localFile.getName().lastIndexOf('.');
					if (-1 != pos) {
						zipFileName = localFile.getName().substring(0, pos);
					}
					if (new File(FileUtil.getUploadRootPath() + orgFlag + File.separator + siteFlag + File.separator + zipFileName + File.separator).exists()) {
						rs = "{\"error\":\"存在同名模版文件夹！\"}";
						continue;
					}
					// 验证文件名不为中文
					try {
						if (ChineseUtil.isChinese(localFile.getName())) {
							rs = "{\"error\":\"模版不能为中文!\"}";
							continue;
						}
						file.transferTo(localFile);
						boolean pass = ZipUtil.checkZipFile(zipFileName, localFile);
						if (!pass) {
							rs = "{\"error\":\"模版格式错误!\"}";
							continue;
						}
						ZipUtil.unZipFiles(localFile, FileUtil.getUploadRootPath() + orgFlag + File.separator + siteFlag + File.separator);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
						rs = "{\"error\":\"文件上传失败\"}";
					} finally {
						localFile.delete();
					}
				}

			}
		}
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().println(rs);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
