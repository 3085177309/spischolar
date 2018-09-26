<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>个人信息简介</title>
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">

<meta content="telephone=no,email=no" name="format-detection">
<link rel="apple-touch-icon" href="favicon.png">
<link rel="Shortcut Icon" href="favicon.png" type="image/x-icon">

<script src="js/flexible.js"></script>

<link rel="stylesheet" type="text/css" href="css/m.css" />
<link rel="stylesheet" href="css/iconfont.css">
<script src="js/lib/zepto.min.js"></script>
<!-- /*<script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>*/ -->
</head>
<body class="fix-pbhieght">
	<div class="page out" data-callback="optionsTest"
		data-onpagefirstinto="init">
		<div class="section-page">
			<header>
				<div class="headwrap">
					<div class="return-back" href="#&pageHome" data-rel="back">
						<i class="icon iconfont">&#xe610;</i> <span>返回</span>
					</div>

					<div class="head-search">
						<a href="">确定</a>
					</div>
					<!-- <div class="userbox">
				<div class="userSelect">
					<i class="icon iconfont iconfuzhi">&#xe600;</i>
				</div>
			</div> -->
					<p class="section-tit">简介</p>
					<div class="clear"></div>
				</div>
			</header>
			<div class="item-section">
				<div class="info-edit-box">
					<div class="inof-editin">
						<textarea name="textbox" id="textbox" placeholder="">我是某某大学一名大三学生，所学专业是艺术设计.主修动画等... </textarea>
						<span class="word-num"><em>0</em>/40</span>
					</div>
					<script type="text/javascript">
				var $counter=$(".word-num em");
				var val=$('#textbox').val();
				$counter.text(val.length);
				var cplock=false;
				$('#textbox').on('input', function() {
					$('#textbox').addClass("focus");
				    if(cplock){
				    	return;
				    }
				    $counter.text($(this).val().length);
				}).on('compositionstart',function(){
					cplock=true;
				}).on('compositionend',function(){
					cplock=false;
				})
			</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
