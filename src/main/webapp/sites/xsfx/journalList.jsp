<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="pg"
	uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form id="articlesSF" action="journalList">
	<input type="hidden" name="journal"
		value="<c:out value="${condition.journal }" />" /> <input type="text"
		name="start_y" value="${condition.start_y }" style="width: 60px;" />-
	<input type="text" name="end_y" value="${condition.end_y }"
		style="width: 60px;" /> &nbsp;&nbsp;<input type="text" name="val"
		value="${condition.val }" style="width: 260px;" /> <input
		type="hidden" name="sort" value="1" />
	<!-- 
	<select name="sort">
		<option value="" <c:if test="${condition.sort!=1 }">selected="selected"</c:if>>按相关性排序</option>
		<option value="1" <c:if test="${condition.sort==1 }">selected="selected"</c:if>>按时间排序</option>
	</select>
	 -->
	<input type="button" id="articlesSFBtn" value="查找" />
</form>
<ul class="articlesLB">
	<c:if
		test="${empty result ||empty result.rows|| fn:length(result.rows) == 0}">
		<c:choose>
			<c:when test="${not empty errorMsg }">
	 		${errorMsg }
	 	</c:when>
			<c:otherwise>
	 		该期刊最近一年没有发布文章。
	 	</c:otherwise>
		</c:choose>
	</c:if>
	<c:forEach items="${result.rows }" var="doc">
		<li>
			<h3 class="title textOver">
				<a href="${doc.href }" target="_blank">${doc.title }</a>
			</h3>
			<p class="about">${doc.source }</p>
			<p class="text">${doc.abstract_ }</p>
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
			</h6>
		</li>
	</c:forEach>
</ul>
<c:if test="${result.total>10}">
	<div class="paginatin" id='journal_doc_paginatin'>
		<ul>
			<!-- 首页 -->
			<pg:pager items="${result.total }" url="journalList"
				export="cp=pageNumber" maxPageItems="10" maxIndexPages="10"
				idOffsetParam="offset">
				<pg:param name="journal" value='${condition.journal }' />
				<pg:param name="start_y" value='${condition.start_y }' />
				<pg:param name="end_y" value='${condition.end_y }' />
				<pg:param name="val" value='${condition.val }' />
				<pg:param name="sort" value='${condition.sort }' />
				<!-- 首页 -->
				<pg:first>
					<input type='hidden' value='${pageUrl }' id='firstPage' />
				</pg:first>
				<pg:prev>
					<li><a href="${pageUrl}">上一页</a></li>
				</pg:prev>
				<!-- 中间页码开始 -->
				<pg:pages>
					<c:choose>
						<c:when test="${cp eq pageNumber }">
							<li class="current"><a href="javascript:return false ;">${pageNumber}</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageUrl}">${pageNumber}</a></li>
						</c:otherwise>
					</c:choose>
				</pg:pages>
				<!-- 中间页码结束 -->
				<pg:next>
					<li><a id="next_page" href="${pageUrl}">下一页</a></li>
				</pg:next>
			</pg:pager>
		</ul>
	</div>
</c:if>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/journalList.js"></script>
