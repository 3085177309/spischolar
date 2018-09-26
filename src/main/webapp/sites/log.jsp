<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>系统日志</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd bdbn">
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
					<div class="single-bd-tit">
						${log.title }<span>更新时间：<fmt:formatDate
								value="${log.addTime}" pattern="yyyy-MM-dd HH:mm" /></span>
					</div>
					<div class="single-bd-con">
						<div class="sub-info">
							<span class="fl"> <a href="javascript:void(0)">阅读（${log.times }）</a>
								<a href="javascript:praise(${log.id })">赞（${log.praise }）</a>
							</span> <span class="fr"> <c:choose>
									<c:when test="${empty prev }">
										<a href="javascript:void(0)">已经是第一篇 </a>
									</c:when>
									<c:otherwise>
										<a href="<cms:getProjectBasePath/>system/news/${prev.id}">上一篇:${next.title }
										</a>
									</c:otherwise>
								</c:choose> | <c:choose>
									<c:when test="${empty next }">
										<a href="javascript:void(0)">已经是最后一篇 </a>
									</c:when>
									<c:otherwise>
										<a href="<cms:getProjectBasePath/>system/news/${next.id}">一篇:${next.title }
										</a>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="eassy">${log.content }</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
function praise(id){
	jQuery.get('<cms:getProjectBasePath/>system/log/praise/'+id,function(data){
		alert(data.message);
	});
}
</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>