<!-- 数据库列表页 -->
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

<div id='db_list_panel'>
	<div>
		<label>
			<span>检索关键词:</span>
			<input type='text' id="db_search_key" value="${key }"/>
		</label>
		<button id="db_search_btn" class='btn btn-small' action_target='backend/rule/dbList/' org_id='${orgId }'>查找</button>
	</div>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>数据库名</th>
				<th>数据库链接地址</th>
				<th>刊名链接地址</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pager.rows }" var="db" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>
					<c:choose>
						<c:when test="${not empty db.cnName }">
						${db.cnName }
						<c:if test="${not empty db.enName }">
							(${db.enName })
						</c:if>
						</c:when>
						<c:otherwise>
						${db.enName }
						<c:if test="${not empty db.cnName }">
							(${db.cnName })
						</c:if>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:if test="${not empty db.url }">
					<a target="_blank" href='${db.url }'>数据库首页</a>
					</c:if>
				</td>
				<td>
					<c:if test="${not empty db.kmUrl }">
					<a target="_blank" href='${db.kmUrl }'>期刊首页</a>
					</c:if>
				</td>
				<td><button class='btn btn-small rule_list_btn' action_target='backend/rule/ruleIndex/' org_id='${orgId }' db_id='${db.id }'>查看规则</button></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${pager.total>10}">
	<div class="pagination db_pagination">
	<ul>
		<pg:pager items="${pager.total}" url="backend/rule/dbList/${orgId }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:param name="key" value="${key }"/>
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

<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/rule/dbList.js"></script>