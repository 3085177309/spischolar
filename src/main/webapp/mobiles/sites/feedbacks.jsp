<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我的反馈</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<a class="return-back" onclick="history.go(-1)"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<!-- <div class="head-search">
						<i class="icon iconfont">&#xe604</i>
					</div> -->
						<!-- <div class="userbox">
						<div class="userSelect">
							<i class="icon iconfont iconfuzhi">&#xe600;</i>
						</div>
					</div> -->
						<p class="section-tit">我的反馈</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<c:choose>

						<c:when test="${empty data.rows }">
							<div class="nofeedback nomessage">
								<p style="text-align: center;">您还未提交反馈</p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="user-fankui">
								<ul>
									<c:forEach var="fb" items="${data.rows }">
										<li>
											<h3 class="textOver">
												<a href="<cms:getProjectBasePath/>user/feedback/${fb.id }">${fb.question }</a>
											</h3> <!-- <p>${fb.answer }<c:if test="${fb.answer == null }">您好，反馈已收到，我们将尽快跟进。在反馈中...</c:if></p> -->
											<p class="fktime">
												反馈时间：
												<fmt:formatDate value="${fb.questionTime}"
													pattern="yyyy-MM-dd HH:mm" />
											</p>
										</li>
									</c:forEach>
								</ul>

							</div>
						</c:otherwise>
					</c:choose>


				</div>
			</div>
			<div class="fixfk">
				<a href="<cms:getProjectBasePath/>user/editFeedback">我要反馈</a>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script type="text/javascript">
	
	var list=$(".user-fankui li");
	$.each(list,function(val){
		listDelete($(this),$(".delbtn").eq(0).width());
	})
	list.bind("tap",function(){
		if($(this).find("p").css("height")=="auto"){
			$(this).find("p").css("height","1.5em");
		}else{
			$(this).find("p").css("height","auto");
		}
		
	})
</script>
</body>
</html>
