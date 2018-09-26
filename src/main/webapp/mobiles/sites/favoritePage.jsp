<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${type == 2 }">
	<ul class="colect qkcolect">
		<c:forEach var="c" items="${data.rows }">
			<c:set var="doc" value="${c.docJournal }"></c:set>
			<li>
				<p class="post-time">
					收藏时间：
					<fmt:formatDate value="${c.time }" type="date" pattern="yyyy-MM-dd" />
					</span>
				</p> <c:choose>
					<c:when test="${not empty doc.jImage }">
						<a href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
							class="img"> <img
							src="<cms:getProjectBasePath/>journal/image/${doc._id}" />
						</a>
					</c:when>
					<c:otherwise>
						<a href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
							class="img"> <img
							src="<cms:getProjectBasePath/>resources/images/qk_default1.png" />
						</a>
					</c:otherwise>
				</c:choose>
				<h2 class="tit">
					<span>刊名：</span><a
						href="<cms:getProjectBasePath/>journal/detail/${doc._id}"
						class="link">${doc.docTitle }</a>
				</h2>
				<h3 class="tit">
					<span>ISSN：</span>${doc['issn'].substring(0,9)}
				</h3>
				<p class="issn-block">
					<c:forEach var="item" items="${c.shoulu }" varStatus="idx">
						<c:if
							test="${item.key != '中科院JCR分区(大类)' && item.key != '中科院JCR分区(小类)' && item.key != 'Eigenfactor'}">
							<span class=""> ${item.key } </span>
						</c:if>
					</c:forEach>

				</p>
				<p class="is-favrite">
					<a id="${c.docId}f" href="javascript:unfavorite('${c.docId}');"
						class="favorite favorited">取消收藏</a> <a id="${c.docId}t"
						href="javascript:favorite('${c.docId}');" class="favorite "
						style="display: none;">收藏</a>
				</p>
			</li>
		</c:forEach>
	</ul>
</c:if>
<c:if test="${type == 1 }">
	<ul class="colect">
		<c:forEach var="c" items="${data.rows }" varStatus="index">
			<c:set var="doc" value="${c.doc }"></c:set>
			<li>
				<p class="post-time">
					收藏时间：
					<fmt:formatDate value="${c.time }" type="date" pattern="yyyy-MM-dd" />
				<h2 class="tit ovh">
					<div style="width: 85%; float: left;">
						<c:if test="${doc.href.contains('/academic/profile') }">
							<a href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id }" target="_blank" class="link fl">${index.index+1 }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
						</c:if>
						<c:if test="${!doc.href.contains('/academic/profile') }">
							<a href="${doc.href }" target="_blank" class="link fl">${index.index+1 }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
						</c:if>
						<%-- <a href="${doc.href }" target="_blank" class="link fl">${index.index+1+offset }、${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a> --%>
					</div>

				</h2>
				<h5 class="author">${doc.source.replaceAll("<b>", "").replaceAll("</b>", "") }</h5>
				<div class="abstract" onclick="javascript:abstract(this)">
					<p>
						<span>查看摘要</span><i class="icon iconfont fr">&#xe60e;</i>
					</p>
					<div class="abstract-text">${doc.abstract_.replaceAll("<br />", "")}</div>
				</div>
				<h6>
					<c:if test="${not empty doc.quoteText}">
						<a>${doc.quoteText }</a>
						<%-- <a href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20'>${doc.quoteText }</a> --%>
					</c:if>
					<c:if test="${empty doc.openUri}">
						<a target="_blank" href="javascript:delivery('${c.docId}')">文献互助</a>
					</c:if>
					<c:if test="${not empty doc.openUri}">
						<c:if test="${!doc.href.contains('/academic/profile') }">
							<a href="${doc.openUri }" target="_blank">下载</a>
						</c:if>
						<c:if test="${doc.href.contains('/academic/profile') }">
							<a url_data="${doc.openUri }" class="exportdownload down" 
								docId="${doc.id }" docTitle="${doc.title }" docHref="${doc.href }">下载</a> 
						</c:if>
						<%-- <a href="${doc.openUri }" target="_blank">下载</a> --%>
					</c:if>
					<a id="${c.docId}f" href="javascript:unfavorite('${c.docId}');"
						class="favorite favorited">取消收藏</a> <a id="${c.docId}t"
						href="javascript:favorite('${c.docId}');" class="favorite "
						style="display: none;">收藏</a>
				</h6> <%-- <h5>
		                        	
		                        	<a id="${c.docId}f" href="javascript:unfavorite('${c.docId}');" >取消收藏</a>
		                            <a id="${c.docId}t" href="javascript:favorite('${c.docId}');" style="display: none;">收藏</a>
		                            </p>
		                        	
		                        </h5> --%>
			</li>
		</c:forEach>
	</ul>
</c:if>