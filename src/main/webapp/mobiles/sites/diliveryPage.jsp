<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<ul class="delivery">
	<c:forEach var="d" items="${data.rows }" varStatus="index">
		<li>
			<%-- <a href="${d.url }" title="${d.title }" class="del-title"> --%>
			<c:if test="${d.url.contains('/academic/profile') }">
				<a href="<cms:getProjectBasePath/>scholar/bingRedirect/${d.id }" title="${d.title }" target="_blank">
			</c:if>
			<c:if test="${!d.url.contains('/academic/profile') }">
				<a href="${d.url }" title="${d.title }" target="_blank">
			</c:if>
				<c:choose>
					<c:when test="${fn:length(d.title) > 100 }">
                    	${index.index+1+offset }、${d.title.replaceAll("<b>", "").replaceAll("</b>", "").substring(0, 98) }...
                    </c:when>
					<c:otherwise>
						${index.index+1+offset }、${d.title.replaceAll("<b>", "").replaceAll("</b>", "") }
					</c:otherwise>
				</c:choose>
			</a>
			<div class="delist-detail">
				<p>
					时间：
					<fmt:formatDate value="${d.addDate}" pattern="yyyy-MM-dd HH:mm" />
				</p>

				<c:choose>
					<c:when test="${d.processType ==0 }">
						<p>
							进度：<span class="cking img"></span><span><em class="i3">待传递</em>
					</c:when>
					<c:when
						test="${d.processType ==1 || d.processType ==7 || d.processType ==6 }">
						<p>
							进度：<span class="cdok img"></span><span><em class="i1">传递成功</em>
					</c:when>
					<c:when test="${d.processType ==2 || d.processType ==4}">
						<p>
							进度：<span class="cking img"></span><span><em class="i3">传递中</em>
					</c:when>
					<c:otherwise>
						<p>
							进度：<span class="ckfd img"></span><span><em class="i4">没有结果</em>
					</c:otherwise>
				</c:choose>
				</span>
				</p>
				<c:choose>
					<c:when test="${d.processType !=1 }">
						<a class="art-download download-disable download">点击下载</a>
					</c:when>
					<c:otherwise>
						<a href="<cms:getProjectBasePath/>user/dilivery/download/${d.id}"
							class="art-download download">点击下载</a>
					</c:otherwise>
				</c:choose>
				<a href="#" class="download">点击下载</a>
			</div></li>
	</c:forEach>
</ul>