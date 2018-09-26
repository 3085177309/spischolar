<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="qk-list">
	<table>
		<tr style="background: rgb(250, 250, 250);">
			<th width="15%">序 号</th>
			<th width="85%" align="left">刊 名</th>
		</tr>


		<c:forEach var="item" items="${searchResult.datas }" varStatus="idx">
			<tr>
				<td class="tc">${idx.index+1+offset }</td>
				<td class="tl" style="padding-left: 20px"><a target="_blank"
					href="<cms:getProjectBasePath/>journal/detail/${item._id }?batchId=${cdt.batchId}">${item.docTitleFull }</a>
					<c:if
						test="${fn:contains(login_org.flag,item.orgFlag)==true && not empty item.orgFlag }">
						<i class="gc-icon" title="馆藏期刊"></i>
					</c:if> <c:if test="${item.isOA == 1 }">
						<i class="oa-icon" title="Open Access"></i>
					</c:if> <c:if test="${item.isOA == 2 }">
						<i class="soa-icon" title="Partial Access"></i>
					</c:if> <c:if test="${item.core == '扩展' }">
						<i class="e-icon" title="${db }${item.coreInfo }"></i>
					</c:if></td>
			</tr>
		</c:forEach>
	</table>
</div>