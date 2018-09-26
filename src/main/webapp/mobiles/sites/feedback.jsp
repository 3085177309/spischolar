<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我的反馈详情</title>
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
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<div class="fkdetail">
						<p class="fktitle">
							我：${feedback.question }
							<c:if test="${feedback.questionTime!=''}">
								<br>
								<span class="fktime"><fmt:formatDate
										value="${feedback.questionTime}" pattern="yyyy-MM-dd HH:mm" /></span>
							</c:if>
						</p>
						<c:if test="${feedback.answer!= null }">
							<p class="fkanwer">回复：${feedback.answer }</p>
						</c:if>

					</div>
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
