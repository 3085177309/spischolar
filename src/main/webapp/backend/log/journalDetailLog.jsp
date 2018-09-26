<!-- 主要检索词 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<dl>
	<dt>主要查看的期刊</dt>
	<c:forEach items="${pager.rows }" var="jour_word_log">
		<dd title="<c:out value="${jour_word_log.value }(${jour_word_log.count })"/>">
			<span><c:out value="${jour_word_log.value }"/></span><strong>(${jour_word_log.count })</strong>
		</dd>
	</c:forEach>
</dl>
<c:if test="${pager.total>10 }">

	<div class="pagination" id='main_detail_pg'>
		<ul>
			<pg:pager items="${pager.total}" url="backend/log/detailLog/${orgFlag }/${siteFlag }" export="cp=pageNumber" maxPageItems="10" maxIndexPages="10" idOffsetParam="offset">
				<pg:param name="time" value="${time }"/>
				<pg:first>
					<li><a href="${pageUrl }">首页</a></li>
				</pg:first>
				<pg:prev>
					<li><a href="${pageUrl}">上一页</a></li>
				</pg:prev>
				<pg:next>
					<li><a href="${pageUrl}">下一页</a></li>
				</pg:next>
				<pg:last>
					<li><a href="${pageUrl }">尾页</a></li>
				</pg:last>
			</pg:pager>
		</ul>
	</div>

</c:if>

<script>
$('#main_detail_pg a').bind('click', function() {
	$(this).parent().parent().parent().parent().load($(this).attr('href'));
	return false;
});
</script>