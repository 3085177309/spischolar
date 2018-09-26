<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<ul id="con_wf">
	<c:forEach items="${result.rows }" var="doc">
		<li>
			<h2>
				<a href="${doc.href }" target="_blank" class="link"> <c:if
						test="${not empty doc.docType}">${doc.docType }</c:if> ${doc.title }
				</a>
			</h2>
			<h5>${doc.source }</h5>
			<p>${doc.abstract_ }</p>
			<h6>
				<c:if test="${not empty doc.quoteText}">
					<a target="_blank"
						href='<cms:getProjectBasePath/>docList?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20'>${doc.quoteText }</a>
				</c:if>
				<c:if test="${not empty doc.relatedLink}">
					<a target="_blank"
						href='<cms:getProjectBasePath/>docList?other=<cms:cmsUrl value="${doc.relatedLink }"/>&type=related&size=20'>相关文章</a>
				</c:if>
				<c:if test="${not empty doc.versionText }">
					<a target="_blank"
						href='<cms:getProjectBasePath/>docList?other=<cms:cmsUrl value="${doc.versionLink }"/>&type=version&size=20'>${doc.versionText }</a>
				</c:if>
				<c:if test="${!doc.isOpen && !doc.hasLocal}">
					<!-- <cms:getProjectBasePath/>docDilivery?title=<c:out value=" ${doc.title }" />&url=<c:out value=" ${doc.href }" />"  -->
					<a href="javascript:;;" class="deliver"
						d-title="<c:out value=" ${doc.title }" />"
						d-url="<c:out value=" ${doc.href }" />">文献互助 <span
						style="display: none;">${doc.title }</span>
					</a>
				</c:if>
				<c:if test="${not empty doc.openUri}">
					<a href="${doc.openUri }" target="_blank">下载</a>
				</c:if>
				<c:if test="${doc.isGoogleBook }">
					<a href="${doc.href }" target="_blank">Google图书馆</a>
				</c:if>
			</h6>
		</li>
	</c:forEach>
</ul>