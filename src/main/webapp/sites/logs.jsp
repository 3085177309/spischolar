<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>系统日志</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg">
		<div class="container">
			<div class="register border" id="qkminH">
				<div class="reg-hd" style="border-bottom: none">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>系统日志</span>
					</div>
				</div>
				<div class="single-bd">
					<c:forEach var="log" items="${data.rows }">
						<div class="single-list">
							<div class="single-list-hd">
								<a href="javascript:void(0)">${log.title }</a>
							</div>
							<div class="single-list-bd">
								<div class="sub-info">
									<span class="fl"> 阅读（${log.times }） 赞（${log.praise }） </span> <span
										class="fr time"> 更新时间：<fmt:formatDate
											value="${log.addTime}" pattern="yyyy-MM-dd HH:mm" /></span>
								</div>
								<c:choose>
									<c:when test="${fn:length(log.content) > 200 }">
		                    	${log.content.substring(0, 198) }...<br />
									</c:when>
									<c:otherwise>
		                   		 ${log.content }<br />
									</c:otherwise>
								</c:choose>
								<a href="<cms:getProjectBasePath/>system/log/${log.id}"
									class="btn-all">查看详情>></a>
							</div>
						</div>
					</c:forEach>
					<div class="paginatin">
						<ul>
							<pg:pager items="${data.total }" url="list"
								export="cp=pageNumber" maxPageItems="10" maxIndexPages="10"
								idOffsetParam="offset">
								<pg:first>
									<li><a href="${pageUrl }">首页</a></li>
								</pg:first>
								<pg:prev>
									<li><a href="${pageUrl}">上一页</a></li>
								</pg:prev>
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
								<pg:next>
									<li><a id="next_page" href="${pageUrl}">下一页</a></li>
								</pg:next>
								<pg:last>
									<li><a id="last_page" href="${pageUrl}">尾页</a></li>
								</pg:last>
							</pg:pager>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
