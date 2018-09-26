<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>我的反馈</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd" style="border-bottom: none">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>我的反馈</span>
					</div>
				</div>
				<div class="single-bd">
					<c:forEach var="fb" items="${data.rows }">
						<div class="single-list">
							<div class="single-list-hd">
								<span class="tit" style="float: left;">反馈内容:</span> <span
									class="time fr" style="padding-right: 10px; float: right;"><fmt:formatDate
										value="${fb.questionTime}" pattern="yyyy-MM-dd HH:mm" /></span>
							</div>
							<div class="single-list-bd">
								<h2>
									<a href="javascript:void(0)"></a>
								</h2>
								<div class="sub-info">${fb.question }</div>
								<c:if test="${!empty fb.imgPath }">
									<span><strong>截图:</strong></span>
									<br>
									<img src="<cms:getProjectBasePath/>resources/images/u38.png" />
								</c:if>
							</div>
							<c:if test="${not empty fb.answer }">
								<div class="reply border">
									<div class="reply-hd">
										<span class="time fr" style="padding-right: 10px;"><fmt:formatDate
												value="${fb.answerTime}" pattern="yyyy-MM-dd HH:mm" /></span> <span>回复:</span>
									</div>
									<div class="reply-bd">${fb.answer }</div>
								</div>
							</c:if>
						</div>
					</c:forEach>
					<c:if test="${empty data.rows }">
						<h2 style="font-size: large; font-weight: bolder;">您还没有提交反馈!</h2>
					</c:if>
					<div class="paginatin">
						<c:if test="${ not empty data.rows }">
							<ul>
								<pg:pager items="${data.total }" url="feedbacks"
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
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
