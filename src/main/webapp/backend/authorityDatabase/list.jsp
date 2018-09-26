<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set var="pageTitle" value="权威数据库管理" scope="request"></c:set>
<c:set var="title" value="权威数据库管理" scope="request"></c:set>
<jsp:include page="/backend/common/header.jsp"></jsp:include>
<jsp:include page="/backend/common/nav.jsp"></jsp:include>
	<table class="table table-striped table-bordered">
   		<tr>
   			<th>序号</th>
			<th>数据库标识</th>
			<th>别名</th>
			<th>分区名</th>
			<th>分区</th>
			<th>前缀</th>
			<th>后缀</th>
			<th>优先级</th>
			<th>收录年份</th>
			<th>操作</th>
   		</tr>
   		<c:forEach items="${pager.rows }" var="dbPartion" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${dbPartion.flag }</td>
				<td>${dbPartion.alias }</td>
				<td>${dbPartion.partitionName }</td>
				<td>${dbPartion.allPartition }</td>
				<td>${dbPartion.prefix }</td>
				<td>${dbPartion.suffix }</td>
				<td>${dbPartion.priority }</td>
				<td>${dbPartion.years }</td>
				<td>
					<a class="btn btn-primary btn-xs" href="backend/authorityDatabase/edit/${dbPartion.id }">编辑</a></td>
			</tr>
		</c:forEach>
   	</table>
   	<ul class="pagination">
		<pg:pager items="${pager.total}" url="backend/org/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:prev><li><a href="${pageUrl}">上一页</a></li></pg:prev>
			<pg:pages>
				<c:choose>
					<c:when test="${cp eq pageNumber }">
						<li class="active"><a href="javascript:void(0);">${pageNumber}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageUrl}">${pageNumber}</a></li>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<li><a href="${pageUrl}">下一页</a></li>
			</pg:next>
		</pg:pager>
	</ul>
<jsp:include page="/backend/common/footer.jsp"></jsp:include>