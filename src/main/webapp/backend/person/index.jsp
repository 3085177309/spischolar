<!-- 人员管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms" %>

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

<div id='person_index_panel'>

	<input type="hidden" id='person_org_id' value='${orgId }' />
	<ul class='breadcrumb'>
		<li><a href='#' <cms:permissionTag flag="person_list">action_target='backend/person/list/'</cms:permissionTag> id='person_list_btn'>人员列表</a></li>
		<li style="float:right;position: relative;top:-3px;"><a class='btn btn-small' action_target='backend/person/add/' orgId='${orgId }' id='prepare_add_person_btn'>新增人员</a></li>
	</ul>

	<div id='person_list_container'></div>
	<div id='person_detail_container'></div>

</div>

<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/person/index.js"></script>