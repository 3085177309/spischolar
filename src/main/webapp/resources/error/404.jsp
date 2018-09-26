<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<cms:getProjectBasePath/>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>404资源未找到</title>
<link href="<cms:getProjectBasePath/>resources/css/all.css" rel="stylesheet" />
<!--[if lte IE 6]>
<script src="<cms:getProjectBasePath/>resources/<cms:getOrgFlag/>/<cms:getSiteFlag/>/js/ie6Png.js"></script>
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
<body class="this404">
	<div class="box_404">
		<img src="<cms:getProjectBasePath/>resources/images/404.png" class="pic png" />
		<div class="cont">
			<h3>
				<strong>sorry</strong> 您访问的页面丢失了
			</h3>
			<p>
				很抱歉，您访问的页面未能找到或者出现了未知的错误，您可 <a href="#">刷新</a> 此页或去其他页面逛逛~~~
			</p>
		</div>
	</div>
</body>
</html>