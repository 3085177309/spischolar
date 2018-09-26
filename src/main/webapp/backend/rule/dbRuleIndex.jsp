<!-- 数据库规则首页 -->
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

<div id='rule_index_panel'>
	
	<ul>
		<li>
			<strong>数据库名:</strong>
			<span>${database.cnName }</span>
		</li>
		<li>
			<strong>数据库地址:</strong>
			<span>${database.url }</span>
		</li>
	</ul>
	<a href='#' id='db_rule_list_btn' action_target='backend/rule/ruleList/' orgId='${orgId }' dbId='${dbId }'>规则列表</a>
	<a href='#' class='btn mini-btn pull-right' id='prepare_db_rule_add_btn' action_target='backend/rule/add/' orgId='${orgId }' dbId='${dbId }'>新建规则</a>
	<div id='rule_list_container'>
	</div>

</div>

	
<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/rule/dbRuleIndex.js"></script>