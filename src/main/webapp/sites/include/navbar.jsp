<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="navbar clearfix">
	<div class="<c:if test="${mindex==0 }">in </c:if> logo">
		<a href="<cms:getProjectBasePath/>" alt="Spischolar" title="SpiScholar学术资源在线"><i></i>Spischolar</a>
	</div>
	<div class="nav">
		<ul>
			<c:if test="${journalShow}">
				<li><a href="<cms:getProjectBasePath/>journal"
					   class="<c:if test="${mindex==2 }">in </c:if>journal navicon"><i></i>期刊</a></li>
			</c:if>
			<c:if test="${scholarShow}">
				<li><a href="<cms:getProjectBasePath/>scholar"
					   class="<c:if test="${mindex==1 }">in </c:if>article navicon"><i></i>文章</a></li>
			</c:if>
			<c:if test="${crsShow}">
				<li><a href="${crsPath}"
					   class="article navicon"><i></i>CRS</a></li>
			</c:if>
		</ul>
	</div>
	<div class="user-setting">
		<input id="realmName" type="hidden" value='http://cloud.test.hnlat.com/doc-delivery'>
		<div class="user-info" id="user-name">
			<p>
				<em class="i i-arraw"></em><i class="i i-user"></i>
				<c:choose>
					<c:when test="${empty sessionScope.front_member }">
						<c:if test="${sessionScope.proStatus == 2}">
							<span>${sessionScope.login_org.name}</span>
							<span class="try">(试用)</span>
						</c:if>
						<c:if test="${sessionScope.proStatus == 1}">
							<span>${sessionScope.login_org.name}</span>
						</c:if>
						<span id="usernameText" hidden>Tourist</span>
						<input id="userId" type="hidden" value=${sessionScope.spischolarID}>
					</c:when>
					<c:otherwise>
						<span id="usernameText">${sessionScope.front_member.username}</span>
						<input id="userId" type="hidden" value=${sessionScope.front_member.id}>
					</c:otherwise>
				</c:choose>
				<input id="orgId" type="hidden" value=${sessionScope.login_org.id}>
				<input id="orgName" type="hidden" value=${sessionScope.login_org.name}>
			</p>

			<div class="user-select">
				<i class="i i-triangle"></i>
				<p>
					<c:choose>
						<c:when test="${empty sessionScope.front_member }">
							<a href="javascript:void(0)" id="login-btn">登录个人账号</a>
							<a href="<cms:getProjectBasePath/>user/dilivery">文献互助</a>
							<a href="<cms:getProjectBasePath/>user/history">检索历史</a>
							<a href="<cms:getProjectBasePath/>user/favorite">我的收藏</a>
						</c:when>
						<c:otherwise>
							<a href="<cms:getProjectBasePath/>user/dilivery">文献互助</a>
							<a href="<cms:getProjectBasePath/>user/history">检索历史</a>
							<a href="<cms:getProjectBasePath/>user/favorite">我的收藏</a>
							<a href="<cms:getProjectBasePath/>user/profile">账户管理</a>
							<a href="<cms:getProjectBasePath/>user/logout">退出</a>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
	</div>
</div>
<c:if test="${sessionScope.ieMessage}">
	<script type="text/javascript">
		isIE8Upgrade();
	</script>
</c:if>
<c:if test="${empty sessionScope.front_member}">
	<jsp:include page="login.jsp"></jsp:include>
</c:if>