<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="cms"
	uri="http://org.pzy.cms"%><%@ taglib prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="pg"
	uri="http://jsptags.com/tags/navigation/pager"%>
<c:forEach items="${disciplineSystemList}" var="disciplineSystem"
	varStatus="status">
	<c:choose>
		<c:when test="${status.first }">
			<a onclick="disciplineItemClick(this)" class="in"
				href="javascript:return false"
				more_authority_journal_url='<cms:moreAuthorityJournalUrl disciplineSystem="${disciplineSystem }"/>'
				hot_url='<cms:pushJournalUrl disciplineSystem="${disciplineSystem }" type="1"/>'
				authority_url='<cms:pushJournalUrl disciplineSystem="${disciplineSystem }" type="2"/>'>${disciplineSystem.discipline}
				<c:if test="${not empty disciplineSystem.name}">
					<br />
					<span>${disciplineSystem.name}</span>
				</c:if>
			</a>
		</c:when>
		<c:otherwise>
			<a onclick="disciplineItemClick(this)" href="javascript:return false"
				more_authority_journal_url='<cms:moreAuthorityJournalUrl disciplineSystem="${disciplineSystem }"/>'
				hot_url='<cms:pushJournalUrl disciplineSystem="${disciplineSystem }" type="1"/>'
				authority_url='<cms:pushJournalUrl disciplineSystem="${disciplineSystem }" type="2"/>'>
				${disciplineSystem.discipline} <c:if
					test="${not empty disciplineSystem.name}">
					<br />
					<span>${disciplineSystem.name}</span>
				</c:if>
			</a>
		</c:otherwise>
	</c:choose>
</c:forEach>

<script src="resources/<cms:getSiteFlag/>/js/lastSubjectSystem.js"></script>

