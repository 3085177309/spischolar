<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>服务器繁忙</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<div class="return-back">
							<a class="return-back" onclick="history.go(-1)"> <i
								class="icon iconfont">&#xe610;</i> <span>返回</span>
							</a>
						</div>
						<p class="section-tit">服务器繁忙</p>
						<!-- <div class="userbox">
						<div class="userSelect">
							<span class="username">Miss.W</span>
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
					</div>
				</header>
				<div class="common-search">
					<dd class="stab" style="display: block;">
						<form method="get" action="<cms:getProjectBasePath/>scholar/list">
							<div class="search-inputwrap">
								<input type="hidden" name="batchId" value="<cms:batchId />" />
								<input type="text" class="input-text" value='${searchKey }'
									id="keyword_text" autocomplete="off" name="val" placeholder="">
								<input type="submit" class="input-submit" id="quick_search_btn"
									value="检索"> <input type="button" class="searchCancle"
									value="取消">
							</div>
							<div class="radio_js" id="lan_panel">
								<div class="ui-checkbox-s">
									<input type="checkbox" name="oaFirst" value="1"
										<c:if test="${condition.oaFirst ==1 }">checked="checked"</c:if>>
									<em>开放资源</em>
								</div>
								<i class="ftnm">勾选即可获取全部开放资源结果</i>
							</div>
						</form>
					</dd>
				</div>
				<div class="server-busy">
					<h2>服务器繁忙</h2>
				</div>

				<div class="clear10"></div>
			</div>
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>

	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
</body>
</html>