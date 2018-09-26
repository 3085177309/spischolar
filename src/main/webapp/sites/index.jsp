<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>SpiScholar学术资源在线</title>
</head>
<body class="hd hdmodal-open ">
	<c:set scope="request" var="mindex" value="0"></c:set>
	<c:if test="${not empty isImposedOut }">
		<script type="text/javascript">
		alert("你的账号在其他地方登陆，如非本人操作，请修改密码！");
	</script>
	</c:if>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
					<div class="index-logo">
						<a href="<cms:getProjectBasePath/>" class="large-logo">学术资源在线</a>
					</div>
					<div class="w-wrap">
						<div class="search-box" id="search-box">
							<div class="search-tab">
								<form method="get"
									action="<cms:getProjectBasePath/>journal/search/list">
									<div class="qk-search">
										<input type="text" class="textInput" name="value"
											placeholder="请输入刊名/ISSN/学科名" value="" autocomplete="off"
											type_index="0"> <input type="submit"
											class="journal_hide_btn"> <input type="hidden"
											name="batchId"> <i class="c-i"></i>
									</div>
								</form>
							</div>
							<div class="search-tab" style="display: none">
								<form method="get"
									action="<cms:getProjectBasePath/>scholar/list">
									<div class="article-search">
										<input type="text" class="textInput" value="" name="val"
											placeholder="请输入刊名/ISSN/学科名"
											autocomplete="off" type_index="0"> <input
											type="submit" class="article_hide_btn"> <i
											class="c-i"></i>
									</div>
								</form>
							</div>
							<div class="search-btn">
								<button class="s-qk s-btn active journal_search_btn">搜期刊</button>
								<button class="s-ar s-btn article_search_btn">搜文章</button>
							</div>
							<div class="search-history"></div>
						</div>
					</div>
				</div>

				<div class="w-wrap">
					<div class="fast-ben">
						<div class="fast-box">
							<a href="<cms:getProjectBasePath/>journal"> <span
								class="col-i1"></span>
								<div class="fw">学术期刊指南</div>
								<p>
									为您提供SCI-E、SSCI、中科院分区表、CSSCI、CSCD等最新期刊<br>收录情况及影响因子等评价指标
								</p>
							</a>
						</div>
						<div class="fast-box">
							<a href="<cms:getProjectBasePath/>scholar"> <span
								class="col-i2"></span>
								<div class="fw">学术搜索</div>
								<p>
									便捷的学术搜索引擎，输入篇名或关键词即可在丰富的资源库中<br>查找学术论文及其他文献资源
								</p>
							</a>
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