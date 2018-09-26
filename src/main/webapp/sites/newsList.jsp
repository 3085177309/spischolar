<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>公告</title>
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
						<span><em>|</em>公告</span>
					</div>
				</div>
				<div class="single-bd">
					<c:forEach items="${data.rows }" var="news">
						<div class="single-list">
							<div class="single-list-hd">
								<c:choose>
									<c:when test="${news.title.length()>=50 }">
										<a href="<cms:getProjectBasePath/>system/news/${news.id}"
											title="${news.title }">${news.title.substring(0,50) }</a>
									</c:when>
									<c:otherwise>
										<a href="<cms:getProjectBasePath/>system/news/${news.id}"
											title="${news.title }">${news.title }</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="single-list-bd">
								<div class="sub-info">
									<span class="fl"> 阅读（${news.times}） 赞（${news.praise }） <!-- <a href="javascript:void(0)">赞（520）</a> -->
									</span> <span class="fr time">更新时间：<fmt:formatDate
											value="${news.addTime}" pattern="yyyy-MM-dd HH:mm" /></span>
								</div>
								${news.content } <br /> <a
									href="<cms:getProjectBasePath/>system/news/${news.id}"
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

	<script type="text/javascript">
function praise(id){
	jQuery.get('<cms:getProjectBasePath/>system/news/praise/'+id,function(data){
		alert(data.message);
		window.location.reload();
	});
}
</script>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
