<!-- 规则管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<div id='rule_index_container'>
	<a href='#' id='db_list_btn' action_target='backend/rule/dbList/' orgId='${orgId }'>数据库列表</a>
	<div id='db_list_container'></div>
	<div id='db_rules_container'></div>
</div>

<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/rule/index.js"></script>