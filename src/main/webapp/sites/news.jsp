<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>公告</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="wraper bg">
					<div class="container">
						<div class="register border">
							<div class="reg-hd bdbn">
								<div class="logo fl">
									<%-- <svg width="150" height="40">
                        <image xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg" src="<cms:getProjectBasePath/>resources/images/logo.png" width="150" height="40"></image>
                    </svg> --%>
									<span> <!-- <em>|</em> -->公告
									</span>
								</div>
							</div>
							<div class="single-bd">
								<div class="single-bd-tit">
									${news.title }<span>更新时间：<fmt:formatDate
											value="${news.addTime}" pattern="yyyy-MM-dd HH:mm" /></span>
								</div>
								<div class="single-bd-con">
									<div class="eassy" style="padding-top: 20px;">
										${news.content }</div>
									<div class="sub-info">
										<span class="fl"> <a href="javascript:void(0)">阅读（${news.times }）</a>
											<a href="javascript:praise(${news.id })">赞（${news.praise }）</a>
										</span> <span class="fr"> <c:choose>
												<c:when test="${empty next }">
													<a href="javascript:void(0)" title="${next.title }">已经是第一篇
													</a>
												</c:when>
												<c:otherwise>
													<a href="<cms:getProjectBasePath/>system/news/${next.id}">上一篇:
														<c:choose>
															<c:when test="${fn:length(next.title) < 10 }">
																<span title="${next.title }">${next.title }</span>
															</c:when>
															<c:otherwise>
																<span title="${next.title }">${next.title.substring(0, 8) }...</span>
															</c:otherwise>
														</c:choose>
													</a>
												</c:otherwise>
											</c:choose> | <c:choose>
												<c:when test="${empty prev }">
													<a href="javascript:void(0)">已经是最后一篇 </a>
												</c:when>
												<c:otherwise>
													<a href="<cms:getProjectBasePath/>system/news/${prev.id}">下一篇:
														<c:choose>
															<c:when test="${fn:length(prev.title) < 10 }">
																<span title="${prev.title }">${prev.title }</span>
															</c:when>
															<c:otherwise>
																<span title="${prev.title }">${prev.title.substring(0, 8) }...</span>
															</c:otherwise>
														</c:choose>
													</a>
												</c:otherwise>
											</c:choose>
										</span>
									</div>

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
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>