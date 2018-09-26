package com.wd.comm.filter;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.nio.charset.Charset;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.AntPathMatcher;

import com.wd.backend.bo.Menu;
import com.wd.backend.bo.RolePermission;
import com.wd.backend.dao.SystemManageDaoI;
import com.wd.backend.model.Person;
import com.wd.backend.model.Powers;

public class PermissionFilter implements Filter {
	@Autowired
	private SystemManageDaoI sysDao;
	/**
	 * 指定需要进行权限控制的目录
	 */
	private String dir;
	/**
	 * 登录页地址
	 */
	private String login;
	/**
	 * 登出页地址
	 */
	private String logout;
	
	/**
	 * 验证码地址
	 */
	private String validateImg;
	private String backendIndex;
	private Map<Integer, RolePermission> rolePermissionsMap = new HashMap<Integer, RolePermission>(3);
	private AntPathMatcher antPathMatcher = new AntPathMatcher();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.dir = filterConfig.getInitParameter("dir");
		this.login = filterConfig.getInitParameter("login");
		this.logout = filterConfig.getInitParameter("logout");
		this.backendIndex = filterConfig.getInitParameter("backendIndex");
		this.validateImg=filterConfig.getInitParameter("validateImg");
		// 读取权限文件
		InputStream permissionInputStream = PermissionFilter.class.getClassLoader().getResourceAsStream("permission.xml");
		SAXReader saxReader = new SAXReader();
		try {
			Document document = saxReader.read(new StringReader(IOUtils.toString(permissionInputStream,Charset.forName("UTF-8"))));
			Element root = document.getRootElement();
			List<Node> roleList = root.selectNodes("/permission/role");
			Map<Integer, RolePermission> rolePermissionsMap = new HashMap<Integer, RolePermission>();

			for (Node roleNode : roleList) {
				RolePermission rolePermission = new RolePermission();

				List<Node> menuItemNodes = roleNode.selectNodes("menus/item");
				List<Node> permissionNodes = roleNode.selectNodes("permissions/permission");
				for (Node menuItemNode : menuItemNodes) {
					Element ele = (Element) menuItemNode;
					Menu menu = new Menu(ele.attributeValue("name"), ele.attributeValue("url"));
					rolePermission.addMenu(menu);
				}
				for (Node permissionNode : permissionNodes) {
					Element ele = (Element) permissionNode;
					rolePermission.addPermission(ele.attributeValue("flag"), ele.attributeValue("url"));
				}
				Element ele = (Element) roleNode;
				int id = Integer.parseInt(ele.attributeValue("id"));
				rolePermissionsMap.put(id, rolePermission);
			}

			this.rolePermissionsMap = rolePermissionsMap;
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		// 禁用缓存
		resp.setHeader("Pragma ", "No-cache ");
		resp.setHeader("Cache-Control ", "no-cache ");
		resp.setDateHeader("Expires ", 0);
		String reqPath = req.getServletPath();
		if (reqPath.startsWith(dir) && !reqPath.startsWith(this.login) && !reqPath.startsWith(this.logout) && !reqPath.startsWith(this.validateImg)) {
			Person person = (Person) req.getSession().getAttribute("person");
			if (null == person) {
				// 跳转到登录页
				resp.sendRedirect(req.getContextPath() + this.login);
				return;
			} else {
				// 需要进行权限判断
				RolePermission rolePermission = rolePermissionsMap.get(person.getRole());
				if (null == rolePermission) {
					// 无权访问
					return;
				}
				Collection<String> urls = rolePermission.getPermissions().values();
				boolean hasPermission = false;
				for (String url : urls) {
					if (antPathMatcher.match("/" + url, reqPath)) {
						hasPermission = true;
						break;
					}
				}
				if (!hasPermission) {
					return;
				}
			}
		} else if (reqPath.startsWith(this.login) || reqPath.startsWith(this.login + "/")) {
			// 如果进入的是登录页，判断是否登录
			if (null != req.getSession().getAttribute("person")) {
				// 跳转到首页
				resp.sendRedirect(req.getContextPath() + this.backendIndex);
				return;
			}
		}
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {

	}

	public void setLogin(String login) {
		this.login = login;
	}

	public void setBackendIndex(String backendIndex) {
		this.backendIndex = backendIndex;
	}

	public void setValidateImg(String validateImg) {
		this.validateImg = validateImg;
	}

}
