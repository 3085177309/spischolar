<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="cms"
	uri="http://org.pzy.cms"%>
<div class="sidebar" style="*padding-bottom: 0; *margin-bottom: 0">
	<form method="get"
		action="<cms:getProjectBasePath/>journal/search/list">
		<input type="hidden" name="sort" value="${cdt.sort }" /> <input
			type="hidden" name='docType' value='9' /> <input type="hidden"
			name='field' value='${cdt.field }' /> <input type="hidden"
			name='value' value='<c:out value="${cdt.value }"></c:out>' /> <input
			type="hidden" name='lan' value='${cdt.lan }' /> <input type="hidden"
			name='effectSort' value='${cdt.effectSort }' />
		<c:forEach items="${cdt.queryCdt }" var="queryCdt">
			<input type="hidden" name='queryCdt' value="${queryCdt }" />
		</c:forEach>
		<c:forEach items="${cdt.filterMap }" var="entry">
			<c:if test="${'oa'==entry.key }">
				<c:forEach items="${entry.value }" var="norms">
					<c:if test="${'1'==norms }">
						<input type="hidden" name='filterCdt' value="oa_3_1_1" />
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
		<input type='hidden' name="sortField" value='${cdt.sortField }' /> <input
			type="hidden" value="${cdt.authorityDb }" name='authorityDb' /> <input
			type="hidden" value="${cdt.subject }" name='subject' /> <input
			type="hidden" value="${cdt.limit }" name='limit' /> <input
			type="hidden" name='detailYear' value='${cdt.detailYear }' /> <input
			type="hidden" name="viewStyle" value="${cdt.viewStyle }" />
		<%-- <input type="hidden" name='offset' value='${offset }' /> --%>
		<input type="hidden" name='offset' value='0' />

		<div class="com-condi">
			<ul class="sx-option">
				<c:forEach items="${disciplineSystemMap }" var="authorityDB"
					varStatus="status">
					<c:choose>
						<c:when test="${authorityDB.key eq '中科院JCR分区(大类)'}"></c:when>
						<c:when test="${authorityDB.key eq '中科院JCR分区(小类)'}"></c:when>
						<c:when test="${authorityDB.key eq 'Eigenfactor'}"></c:when>
						<c:otherwise>
							<li title='<c:out value="${authorityDB.key }"/>'><label>
									<input
									<c:forEach items="${cdt.filterMap }" var="entry"><c:if test="${'auDB'==entry.key }"><c:forEach items="${entry.value }" var="db"><c:if test="${authorityDB.key==db }"> checked="checked"</c:if></c:forEach>
								</c:if>
				</c:forEach>
				type="checkbox" name='filterCdt' value='auDB_3_1_
				<c:out value='${authorityDB.key }' />
				'/>
				<c:if test="${authorityDB.key=='SJR' }">SCOPUS</c:if>
				<c:if test="${authorityDB.key!='SJR' }">${authorityDB.key }</c:if>
				</label>
				</li>
				</c:otherwise>
				</c:choose>
				</c:forEach>
			</ul>
			<input type="submit" class="btn-blue" value="确认">
		</div>
	</form>
</div>