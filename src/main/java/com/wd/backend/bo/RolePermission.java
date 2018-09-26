package com.wd.backend.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wd.util.SimpleUtil;

/**
 * 角色权限集合
 * 
 * @author Administrator
 * 
 */
public class RolePermission {

	/**
	 * 角色拥有的菜单
	 */
	List<Menu> menus = new ArrayList<Menu>();

	/**
	 * 角色拥有的权限(key为功能标识，value为url)
	 */
	Map<String, String> permissions = new HashMap<String, String>();

	public RolePermission() {
	}

	public void addMenu(Menu menu) {
		if (SimpleUtil.strNotNull(menu.getName())) {
			this.menus.add(menu);
		}
	}

	public void addPermission(String flag, String url) {
		if (this.permissions.containsKey(flag)) {
			System.err.println("功能标识[" + flag + "]重复!");
		} else {
			this.permissions.put(flag.trim(), url == null ? "" : url.trim());
		}
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	public Map<String, String> getPermissions() {
		return permissions;
	}

	public void setPermissions(Map<String, String> permissions) {
		this.permissions = permissions;
	}
}
