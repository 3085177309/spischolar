<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>新手指南</title>
</head>
<body>
	<jsp:include page="include/navbar.jsp"></jsp:include>
	<div class="wraper bg" id="minH">
		<div class="container">
			<div class="register border">
				<div class="reg-hd" style="border-bottom: 0">
					<div class="logo fl">
						<svg width="150" height="40">
                        <image
								xmlns:xlink="http://www.w3.org/1999/xlink"
								xlink:href="<cms:getProjectBasePath/>resources/images/logo.svg"
								src="<cms:getProjectBasePath/>resources/images/logo.png"
								width="150" height="40"></image>
                    </svg>
						<span><em>|</em>新手指南</span>
					</div>
				</div>
				<div class="single-bd">
					<div class="single-list">
						<div class="single-list-hd">
							<a href="<cms:getProjectBasePath/>system/page/1">关于轻学术发现</a>
						</div>
						<div class="single-list-bd">
							SpiScholar将文章搜索、期刊、数据库有机融合在一起，将文章、期刊与数据库编织在同一张资源网络，并在此基础之上为用户提供权威的、与资源网络无缝链接的资源评
							价信息，使得用户可以在网络上自由爬行，SpiScholar将文章搜索、期刊、数据库有机融并在此基础之上为用户提供权威的<br />
							<a href="<cms:getProjectBasePath/>system/page/1" class="btn-all">查看详情>></a>
						</div>
						<div class=""></div>
					</div>
					<div class="single-list">
						<div class="single-list-hd">
							<a href="<cms:getProjectBasePath/>system/page/2">关于期刊导航</a>
						</div>
						<div class="single-list-bd">
							SpiScholar将文章搜索、期刊、数据库有机融合在一起，将文章、期刊与数据库编织在同一张资源网络，并在此基础之上为用户提供权威的、与资源网络无缝链接的资源评
							价信息，使得用户可以在网络上自由爬行，SpiScholar将文章搜索、期刊、数据库有机融并在此基础之上为用户提供权威的.<br />
							<a href="<cms:getProjectBasePath/>system/page/2" class="btn-all">查看详情>></a>
						</div>
						<div class="single-list-fd">
							<a href="<cms:getProjectBasePath/>system/page/3" class="">学科体系</a>
							<a href="<cms:getProjectBasePath/>system/page/4">评价体系</a>
						</div>
					</div>
					<div class="single-list">
						<div class="single-list-hd">
							<a href="<cms:getProjectBasePath/>system/page/5">关于数据库导航</a>
						</div>
						<div class="single-list-bd">
							SpiScholar将文章搜索、期刊、数据库有机融合在一起，将文章、期刊与数据库编织在同一张资源网络，并在此基础之上为用户提供权威的、与资源网络无缝链接的资源评
							价信息，使得用户可以在网络上自由爬行，SpiScholar将文章搜索、期刊、数据库有机融并在此基础之上为用户提供权威的<br />
							<a href="<cms:getProjectBasePath/>system/page/5" class="btn-all">查看详情>></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
