<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>链接失效</title>
<link href="http://spischolar.com:80/resources/css/all.css"
	rel="stylesheet" />
<!--[if lte IE 6]>
<script src="http://spischolar.com:80/resources/null/null/js/ie6Png.js"></script>
<script>
DD_belatedPNG.fix('.png');
</script>
<![endif]-->
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?0ffd5a7dbb62116d4d9623f406f211f5";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
</head>
<style>
.box_404 {
	width: 520px;
	margin: 160px auto;
	text-align: center;
}

.box_404 img {
	margin: 0 auto;
}

.this404 .cont {
	text-align: center;
	padding-top: 12px;
}

.this404 .cont h3 {
	font-size: 0;
	line-height: 60px;
	height: 60px;
	margin-top: -10px;
	text-align: center;
	width: 280px;
	margin: auto;
}

.this404 .cont h3 strong {
	line-height: 60px;
	height: 60px;
	font-size: 36px;
	float: left;
}

.this404 .cont h3 span {
	line-height: 57px;
	height: 60px;
	display: inline-block;
	text-align: left;
	font-size: 32px;
	text-indent: 0;
	/*! float: left; */
}

.this404 .poin a {
	cursor: pointer;
	color: #3879d9;
	text-decoration: none;
}

.this404 .poin a:hover {
	color: #003c8d;
}
</style>
<body class="this404">
	<div class="box_404">

		<img src="<cms:getProjectBasePath/>resources/images/404nofond.png"
			class="pic png" style="margin-bottom: 0" />
		<div class="cont">
			<h3>
				<strong>SORRY</strong><span>链接失效</span>
			</h3>
			<p class="poin">
				由于您长时间没有操作，链接已失效，<a href="<cms:getProjectBasePath/>">点我去首页</a>。
			</p>
		</div>
	</div>
</body>
</html>