<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp" />
<title>服务器繁忙</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch">
					<jsp:include page="include/qksearch.jsp"></jsp:include>
				</div>
				<div class="statistics-box"></div>
				<div class="wraper">
					<div class="container">
						<h4
							style="background:url(<cms:getProjectBasePath/>resources/images/busy.png) no-repeat center center;margin-top:80px;height:105px"></h4>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp" />
	<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
</body>
</html>