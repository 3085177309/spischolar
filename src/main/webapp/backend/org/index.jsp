<!-- 机构管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<div id='org_index_panel'>

	<!-- 该区域展示机构列表 -->
	<cms:permissionTag flag="org_list">
		<div id='org_list_panel' class='org_panel' action_target='backend/org/list'></div>
	</cms:permissionTag>

	<!-- 该区域展示机构详细信息和机构下的人员列表 -->
	<div id='org_persons_panel' class='org_panel'>

		<!-- 该区域展示机构详细信息 -->
		<div id='org_detail_panel'></div>
		<hr/>
		<!-- 该区域展示机构的人员列表 -->
		<div id='org_person_list'></div>

	</div>

</div>

<script type="text/javascript" src="<%=projectRootPath%>/resources/js/backend/org/index.js"></script>