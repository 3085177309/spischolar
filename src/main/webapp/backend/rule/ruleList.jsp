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

<div id='rule_list_panel'>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>规则名</th>
				<th>规则</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pager.rows }" varStatus="status" var="rule">
			<tr>
				<td>${status.index+1 }</td>
				<td>${rule.name }</td>
				<td>${rule.linkRule }</td>
				<td><button class='btn btn-small' onclick="editRule(this)" action_target='backend/rule/edit/' ruleId='${rule.id }'>编辑</button><button class='btn btn-small' action_target='backend/rule/del/' ruleId='${rule.id }' onclick="delRule(this)">删除</button></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${pager.total>10}">
	<div class="pagination db_pagination">
	<ul>
		<pg:pager items="${pager.total}" url="backend/rule/ruleList/${dbId }/${orgId }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:prev>
				<li><a href="${pageUrl}">上一页</a></li>
			</pg:prev>
			<!-- 中间页码开始 -->
			<pg:pages>
				<c:choose>
					<c:when test="${cp eq pageNumber }">
						<li><a href="javascript:return false ;" class='current_page'>${pageNumber}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageUrl}">${pageNumber}</a></li>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<li><a id="next_page" href="${pageUrl}">下一页</a></li>
			</pg:next>
		</pg:pager>
	</ul>
</div>
	</c:if>
</div>

<script type="text/javascript" src="<%=projectRootPath%>/resources/js/backend/rule/ruleList.js"></script>