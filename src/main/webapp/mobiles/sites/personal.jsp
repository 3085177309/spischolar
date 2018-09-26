<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>个人中心</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="user-header">
						<div class="user-reglogin">
							<div>
								<img
									src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
									class="gravatar" />
								<div class="user-info">
									<p class="f16 loginin">
										<a href="<cms:getProjectBasePath/>user/login">立即登录</a>/<a
											href="<cms:getProjectBasePath/>user/register">注册</a>
									</p>
								</div>

							</div>
						</div>
					</div>
				</header>
				<div class="item-section">
					<ul class="usersetting-list">
						<li><a href="<cms:getProjectBasePath/>user/dilivery"> <i
								class="icon iconfont cd">&#xe60c;</i> 文献互助 <i
								class="icon iconfont fxj">&#xe60e;</i>
						</a></li>
						<li><a href="<cms:getProjectBasePath/>user/history"> <i
								class="icon iconfont sech">&#xe604;</i> 检索历史 <i
								class="icon iconfont fxj">&#xe60e;</i>
						</a></li>
						<li><a href="<cms:getProjectBasePath/>user/favorite?type=1"> <i
								class="icon iconfont sc">&#xe606;</i> <span>我的收藏</span> <i
								class="icon iconfont fxj">&#xe60e;</i>
						</a></li>
						<%-- <li>
						<a href="<cms:getProjectBasePath/>user/feedbacks">
							<i class="icon iconfont fk">&#xe607;</i>
							我的反馈
							<i class="icon iconfont fxj">&#xe60e;</i>
						</a>
					</li> --%>
					</ul>
				</div>
			</div>
			<jsp:include page="include/footer.jsp"></jsp:include>
		</div>
		<script
			src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	</div>
</body>
</html>
