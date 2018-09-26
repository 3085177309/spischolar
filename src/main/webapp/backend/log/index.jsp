<!-- 日志首页 -->
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
<br />
<style>
.box{
	min-height: 320px;
}
</style>
<div>
	<h3>概览</h3>
	时间：<select id='log_time_sel'>
		<c:forEach items="${mothList }" var="moth" varStatus="status">
			<c:if test="${status.last }">
				<c:choose>
					<c:when test="${moth==time }">
					<option value="${moth }" selected="selected">${moth }月</option>
					</c:when>
					<c:otherwise>
					<option value="${moth }">${moth }月</option>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${-1==time }">
					<option selected="selected" value="-1">最近30天</option>
					</c:when>
					<c:otherwise>
					<option value="-1">最近30天</option>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${!status.last }">
				<c:choose>
					<c:when test="${moth==time }">
					<option value="${moth }" selected="selected">${moth }月</option>
					</c:when>
					<c:otherwise>
					<option value="${moth }">${moth }月</option>
					</c:otherwise>
				</c:choose>
			</c:if>
		</c:forEach>
	</select>
	<ul>
		<li><span>期刊详细打开数：</span><strong>${overViewMap['detailOpenCount'] }</strong></li>
		<li><span>期刊检索次数：</span><strong>${overViewMap['journalSearchCount'] }</strong></li>
		<li><span>文章检索次数：</span><strong>${overViewMap['docSearchCount'] }</strong></li>
	</ul>
</div>

<div class='log_main'>
	<h3>期刊检索日志</h3>
	<div class='box' id='main_word_journal_panel' action_target='<cms:getProjectBasePath/>backend/log/journalWord/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' id='issn_journal_panel' action_target='<cms:getProjectBasePath/>backend/log/issnLog/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' id='sys_journal_panel' action_target='<cms:getProjectBasePath/>backend/log/sysLog/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' action_target='<cms:getProjectBasePath/>backend/log/sysSubjLog/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' action_target='<cms:getProjectBasePath/>backend/log/detailLog/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' action_target='<cms:getProjectBasePath/>backend/log/journalHomePage/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
</div>

<div class='log_main' style="clear: both;">
	<h3>文章检索日志</h3>
	<div class='box' action_target='<cms:getProjectBasePath/>backend/log/docTitleLog/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
	<div class='box' action_target='<cms:getProjectBasePath/>backend/log/docHomePage/<cms:getOrgFlag/>/<cms:getSiteFlag/>?time=${time}'>
	</div>
</div>


<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/log/index.js"></script>