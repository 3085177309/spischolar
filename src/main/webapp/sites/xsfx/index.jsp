<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set scope="request" var="pageTitle" value="期刊导航首页"></c:set>
<c:set scope="request" var="navIndex" value="1"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<jsp:include page="./common/search.jsp"></jsp:include>
<div class="container container_1" id="minH" minH='280'>
	<div class="sidebar" id='discipline_system_list'>
		<h3 class="T_1">
			<span class="T_j png"></span> <span class="title">All Fields
				of Study</span>
		</h3>
		<!-- 展示权威数据库收录的学科 -->
		<div class='boxSrroll'></div>
		<div class="jb_fff_t png">
			<!--白色遮罩-->
		</div>
		<div class="jb_fff_b png">
			<!--白色遮罩-->
		</div>
	</div>
	<div class="content">
		<ul class="menu" id='authority_db_menu'>
			<!-- 展示权威数据库 -->
			<c:forEach items="${allAuthorityDBMap }" var="authorityDB"
				varStatus="status" begin="0" end="5">
				<c:choose>
					<c:when test="${status.first }">
						<c:choose>
							<c:when test="${'SJR' eq authorityDB.key }">
								<li><a class="in db_item" href="#" index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/<c:out value="${authorityDB.key }"/>'>
										SCOPUS </a></li>
							</c:when>
							<c:when test="${'中科院JCR分区(小类)' eq authorityDB.key }">
								<li><a class="in db_item" href="#" index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/<c:out value="${authorityDB.key }"/>'>
										JCR分区表(小类) </a></li>
							</c:when>
							<c:when test="${'中科院JCR分区(大类)' eq authorityDB.key }">
								<li><a class="in db_item" href="#" index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/<c:out value="${authorityDB.key }"/>'>
										JCR分区表(大类) </a></li>
							</c:when>
							<c:otherwise>
								<li><a class="in db_item" href="#" index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/<c:out value="${authorityDB.key }"/>'>
										${authorityDB.key } </a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${status.index>5 }">
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${'SJR' eq authorityDB.key }">
								<li><a href="#" class='db_item' index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/${authorityDB.key }'>
										SCOPUS </a></li>
							</c:when>
							<c:when test="${'中科院JCR分区(小类)' eq authorityDB.key }">
								<li><a href="#" class='db_item' index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/${authorityDB.key }'>
										JCR分区表(小类) </a></li>
							</c:when>
							<c:when test="${'中科院JCR分区(大类)' eq authorityDB.key }">
								<li><a href="#" class='db_item' index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/${authorityDB.key }'>
										JCR分区表(大类) </a></li>
							</c:when>
							<c:otherwise>
								<li><a href="#" class='db_item' index='${status.index }'
									action_target='subjectSystem/lastSubjectSystem/${authorityDB.key }'>
										${authorityDB.key } </a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li class="end"><a href="<cms:overviewPageShow/>"> 更多学科体系 </a></li>
		</ul>

		<div class="Top">
			<span class="title">最有影响力期刊 TOP 10：</span><a target="_blank"
				id='authority_journal_doc_more' class="more"
				href="javascript:return false">更多</a>
		</div>

		<div class="picShow picShow_2" id="picShow_2"></div>

		<div class="Top">
			<span class="title">最多点击量 TOP 10：</span>
		</div>

		<div class="picShow picShow_1" id="picShow_1"></div>

	</div>
	<div class="clear"></div>
</div>

<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>
<jsp:include page="common/footer.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/index.js"></script>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/search-check.js"></script>
</body>
</html>
