<!-- 数据库规则列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<div id='rule_detail_panel'>

	<div class="alert alert-error <c:if test="${empty error }">hide</c:if>" id='rule_edit_error'>${error }</div>

	<div style="margin: auto; width: 500px; padding-top: 80px;">
		<form id='rule_form'>
			<input type='hidden' name='orgId' value='${orgId }' /> <input type='hidden' name='dbId' value='${dbId }' />
			<input type='hidden' name='id' value='${rule.id }' /> 
			<label> 
				<span style='width: 80px; text-align: right; display: inline-block;'>规则名：</span>
				<input style='width: 400; height: 30px;' type='text' value="${rule.name }" name='name'/>
			</label> 
			<label> 
				<span style='width: 80px; text-align: right; display: inline-block;'>规则：</span> 
				<textarea style='width: 400; height: 100px;' name='linkRule'>${rule.linkRule }</textarea>
			</label>
		</form>
		<c:if test="${opt=='edit' }">
			<button class='btn small-btn' id='rule_edit_btn' action_target='backend/rule/edit' onclick="saveOrEditRule(this)">保存修改</button>
		</c:if>
		<c:if test="${opt=='add' }">
			<button class='btn small-btn' id='rule_save_btn' action_target='backend/rule/add' onclick="saveOrEditRule(this)">新增</button>
		</c:if>
	</div>
</div>

<script type="text/javascript" src="<%=projectRootPath%>/resources/js/backend/rule/ruleDetail.js"></script>