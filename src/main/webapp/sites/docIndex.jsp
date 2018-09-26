<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>SpiScholar学术搜索</title>
</head>
<body>
	<c:set scope="request" var="mindex" value="1"></c:set>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>

				<div class="w-wrap">
					<div class="article-logo">
						<a href="<cms:getProjectBasePath/>scholar" class="large-logo">学
							术 搜 索</a>
					</div>
					<div class="w-wrap">
						<div class="search-box article-index" id="search-box">
							<div class="search-tab">
								<form method="get"
									action="<cms:getProjectBasePath/>scholar/list">
									<div class="article-search">
										<input type="text" class="textInput" value="" name="val"
											autocomplete="off" type_index="2"> <input
											type="submit" class="article_hide_btn"> <i
											class="c-i"></i>
									</div>
									<div class="radio_js" id="lan_panel">
										<input type="hidden" id="radio_js" value="0" name="oaFirst">
										<!--  <input type="hidden" id="radio_js" name="oaFirst" value="0">-->
										<span id="" v="中文V"
											onclick="search_condi(this,&quot;radio_js_in&quot;);return false"
											class="fl" style="margin-left: 0">开放资源</span> <span
											style="margin-left: 0px; background: none; float: left"
											id="kfzydes">勾选即可获取全部开放资源结果</span>
									</div>
								</form>
								<a class="senior-search-btn" id="senior-search-btn">高级检索</a> <i
									class="i i-senior"></i>

								<div class="senior-search" id="senior-search">
									<jsp:include page="include/asearch.jsp"></jsp:include>
								</div>

							</div>
							<div class="search-btn">
								<button class="s-ar s-btn active article_search_btn">搜文章</button>
							</div>
							<div class="search-history"></div>
						</div>
						<p class="index-article-des fw">科学到最后便遇上了想象</p>
					</div>

				</div>
			</div>
		</div>
	</div>

	<jsp:include page="include/footer.jsp"></jsp:include>
	<jsp:include page="include/float.jsp"></jsp:include>
	<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
</body>
</html>