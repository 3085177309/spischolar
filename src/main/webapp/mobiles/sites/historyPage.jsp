<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<ul class="mui-table-view" style="padding-top: 0px;">
	<c:forEach var="history" items="${data.rows }">
		<li class="list-li mui-table-view-cell" value="${historys.id}">
			<div class="mui-slider-right mui-disabled">
				<a class="mui-btn mui-btn-red" value="${history.id}">删除</a>
			</div>
			<div class="mui-slider-handle">
				<c:set var="fido" value="${history.batchId}"></c:set>
				<input type="hidden" name="title" value="${history.id}" /> <span>搜索：</span>
				<c:choose>
					<c:when test="${history.systemId==2 }">
						<a href="<cms:getProjectBasePath/>scholar/list?${history.url}"
							title="${history.keyword }">
					</c:when>
					<c:otherwise>
						<a
							href="<cms:getProjectBasePath/>journal/search/list?${history.url}"
							title="${history.keyword }">
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${fn:length(history.keyword) < 30 }">
		                                					${history.keyword }
		                                				</c:when>
					<c:otherwise>
		                                					${history.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,28) }...
		                                				</c:otherwise>
				</c:choose>
				</a> <span class="time"><fmt:formatDate value="${historys.time}"
						pattern="yyyy-MM-dd HH:mm" /></span>
			</div> <!-- <div class="delbtn">删除</div>  -->
		</li>
		<c:forEach var="historys" items="${dataTwo.rows }">
			<c:if test="${historys.batchId==fido }">
				<li class="list-li subli mui-table-view-cell" value="${historys.id}">
					<div class="mui-slider-right mui-disabled">
						<a class="mui-btn mui-btn-red" value="${historys.id}">删除</a>
					</div>
					<div class="mui-slider-handle">
						<input type="hidden" class="" name="title" value="${historys.id}" />
						<c:choose>
							<c:when test="${history.systemId==2 }">
								<a href="${historys.url}"
									title='${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }'>
							</c:when>
							<c:otherwise>
								<a
									href="<cms:getProjectBasePath/>journal/detail/${historys.url}"
									title="${history.keyword }">
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${fn:length(historys.keyword) < 40 }">
					                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "") }
					                                				</c:when>
							<c:otherwise>
					                                					${historys.keyword.replaceAll("<b>", "").replaceAll("</b>", "").substring(0,38) }...
					                                				</c:otherwise>
						</c:choose>
						</a> <span class="time"><fmt:formatDate
								value="${historys.time}" pattern="yyyy-MM-dd HH:mm" /></span>
					</div>
				</li>
			</c:if>
		</c:forEach>
	</c:forEach>
</ul>
