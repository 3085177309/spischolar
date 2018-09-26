<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>添加机构</title>
	<script src="<%=path%>/resources/js/jquery-1.7.1.min.js"></script>  
	<script src="<%=path%>/resources/js/jquery-ui-1.8.18.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/jquery-ui-1.8.18.custom.css" />
	<link href="<%=path%>/resources/css/all-backend.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/js/all-backend.js"></script>
	</head>

<body>
<div class="wxcl_qq">
	<form id='person_form' method="post" action="backend/person/add">
		<ul>
			<li><input type="hidden" name='orgId' value="${orgId }"/></li>
			<li class="tjxq_li3"><span>姓名:</span><input type='text' name='name' /></li>
			<li class="tjxq_li3"><span>邮箱:</span><input type='text' name='email'/></li>
			<li class="tjxq_li3"><span>密码:</span><input type='password' name='password'/></li>
			<li class="tjxq_li3">
				<span>角色:</span>
				<select style="width:297px;" name='role'>
					<option value="2">机构超级管理员</option>
					<option value="3">机构站点管理员</option>
					<option value="4">普通用户</option>
				</select>
			</li>
			<li class="tjxq_li3">
				<span>&nbsp;</span>
				<textarea name='remark' cols="40" rows="5"></textarea>
			</li>
			<li class="tjxq_li3">
				<div class="qx_bc"><input type="submit" class="aaniu1"/><input type="reset" value="重置" class="aaniu2"/></div>
			</li>
		</ul>
	</form>
	 <div class="clear"></div>
</div>
</body>
</html>