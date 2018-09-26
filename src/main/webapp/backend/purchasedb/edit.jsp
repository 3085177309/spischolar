<!-- 站点列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
<body style="background-color: #fff;background: none;">
<div class="wxcl_qq" style="width:500px;background-color: #fff;">
<form method="post" action="<%=basePath %>backend/purchasedb/edit" id="purchase_add_form">
	<input type="hidden" name="id" value="${detail.id }" />
	<input type="hidden" name="orgFlag" value="${detail.orgFlag }"/>
    <ul class="xs_fxgl">
    <li><span>资源名称：</span><input name="dbName" value="${detail.dbName }" type="text"  class="ip_input1"/></li>
    <li><span>网&#12288;&#12288;址：</span><input name="url" value="${detail.url }" type="text" class="ip_input1" /></li>
    <li><span>顺&#12288;&#12288;序：</span><input name="orderNum" value="${detail.orderNum }" type="text" class="ip_input1" /></li>
    <li><span>是否显示：</span><input name="showDB" type="radio" <c:if test="${detail.showDB==1}">checked="checked"</c:if> value="1"/>是&nbsp;&nbsp;
    <input name="showDB" type="radio" <c:if test="${detail.showDB==0}">checked="checked"</c:if> value="0"/>否
    </li>
    <li><input value="" type="submit" class="aaniu1" /></li>
    </ul>
</form>
</div>
</body>
</html>