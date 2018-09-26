<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>账户信息--学校选择</title>
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no,email=no" name="format-detection">
<link rel="apple-touch-icon" href="favicon.png">
<link rel="Shortcut Icon" href="favicon.png" type="image/x-icon">
</head>
<body>
	<div class="page out" data-callback="callback"
		data-params="onpagefirstinto=home&&amp;animationstart=startCollege&amp;animationend=endCollege">
		<div class="ui-scroller ui-scroller3">
			<div class="scroller-container">
				<div style="overflow: auto; height: 100%;">
					<header>
						<div class="headwrap">
							<a class="return-back" href="#pageHome" data-rel="back"> <i
								class="icon iconfont">&#xe610;</i> <span>返回</span>
							</a>
							<p class="section-tit">学院选择</p>
							<div class="clear"></div>
						</div>
					</header>
					<div class="item-section">
						<div class="school-list">
							<ul class="school-data-list" id="CollegeData">

							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>