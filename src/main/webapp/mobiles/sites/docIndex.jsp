<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>学术搜索首页</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="userbox">
			<a href="<cms:getProjectBasePath/>/user/personal"> <span>${front_member.username }</span>
				<i class="icon iconfont">&#xe603;</i></a>
		</div>
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<!-- <header>
				<div class="headwrap">
					<div class="return-back">
						
					</div>
					<div class="userbox">
						<div class="userSelect">
							<span class="username">Miss.W</span>
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
							
						</div>
					</div>
				</div>
			</header> -->
				<div class="lg">
					<img
						src="<cms:getProjectBasePath/>resources/mobiles/images/logo2.png">
				</div>
				<div class="search-form">
					<div id="search-tab-box">
						<dd class="stab" style="display: block;">
							<div class="search-inputwrap">
								<form method="get"
									action="<cms:getProjectBasePath/>scholar/list">
									<input type="hidden" name="batchId" value="<cms:batchId />" />
									<input type="text" class="input-text" placeholder="" value=""
										autocomplete="off" name="val" id="keyword_text">
									<button type="submit" class="input-submit search"
										id="journal_search_btn" value="检索">
										<i class="icon iconfont">&#xe604;</i>
									</button>
									<input type="button" class="searchCancle" value="取消">
									<div class="radio_js" id="lan_panel">
										<div class="ui-checkbox-s">
											<input type="checkbox" name="oaFirst" value="1"> <em>开放资源</em>
										</div>
										<i class="ftnm">勾选即可获取全部开放资源结果</i>
									</div>
								</form>
							</div>
						</dd>
						<div class="clear"></div>
					</div>
				</div>
				<div class="search-des">
					<p>科学到最后便遇上了想象</p>
				</div>
			</div>

		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<script>
	$(".ui-checkbox-s input").bind("click",function(){
		var checkact=$(this).attr("checked");
		if(checkact){
			$(".ftnm").html("取消即可获取更多检索结果")
		}else{
			$(".ftnm").html("勾选即可获取全部开放资源结果");
		}
		
	})
</script>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
</body>
</html>