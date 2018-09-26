<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<footer>
	<div class="fix-nav _nav-show" id="jNav" data-animate="_nav-show">
		<div class="nav-list">
			<div class="nav-list">
				<c:if test="${indexShow }">
					<a class="<c:if test="${mindex==0 }">active </c:if>"
						href="<cms:getProjectBasePath/>"> <i
						class="icon iconfont iconfuzhi">&#xe602;</i>
						<p>首页</p>
					</a>
				</c:if>
				<c:if test="${journalShow}">
					<a class="<c:if test="${mindex==2 }">active </c:if>"
						href="<cms:getProjectBasePath/>journal/"><i
						class="icon iconfont">&#xe613;</i>
						<p>期刊</p></a>
				</c:if>
				<c:if test="${scholarShow}">
					<a class="<c:if test="${mindex==1 }">active </c:if>"
						href="<cms:getProjectBasePath/>scholar/"><i
						class="icon iconfont">&#xe614;</i>
						<p>文章</p></a>
				</c:if>
				<a class="<c:if test="${mindex==3 }">active </c:if>"
					href="<cms:getProjectBasePath/>/user/personal/"> <i
					class="icon iconfont">&#xe603;</i>
					<p>我的</p></a>
			</div>
		</div>
	</div>
</footer>