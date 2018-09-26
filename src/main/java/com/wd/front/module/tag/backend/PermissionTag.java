package com.wd.front.module.tag.backend;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.io.IOUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import com.wd.backend.bo.Menu;
import com.wd.backend.bo.RolePermission;
import com.wd.backend.model.Person;
import com.wd.comm.filter.PermissionFilter;

public class PermissionTag extends SimpleTagSupport {

	private Map<Integer, RolePermission> rolePermissionsMap = new HashMap<Integer, RolePermission>(3);

	/**
	 * 功能标识
	 */
	private String flag;

	public PermissionTag() {
		// 读取权限文件
		InputStream permissionInputStream = PermissionFilter.class.getClassLoader().getResourceAsStream("permission.xml");
		SAXReader saxReader = new SAXReader();
		try {
			Document document = saxReader.read(new StringReader(IOUtils.toString(permissionInputStream)));
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
	public void doTag() throws JspException, IOException {
		PageContext pageContext = (PageContext) getJspContext();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		Person person = (Person) request.getSession().getAttribute("loginPerson");
		RolePermission rolePermission = rolePermissionsMap.get(person.getRole());
		if (null != rolePermission && rolePermission.getPermissions().containsKey(flag)) {
			JspWriter out = pageContext.getOut();
			getJspBody().invoke(out);
		}
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
}
