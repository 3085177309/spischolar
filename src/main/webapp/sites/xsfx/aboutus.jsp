<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<c:set scope="request" var="pageTitle" value="期刊导航--帮助页"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<style>
.container {
	overflow: hidden;
}

.content {
	overflow: hidden;
	float: none;
	padding: 35px 40px 20px 40px;
	width: 922px;
}

.content h2 {
	text-align: center;
	font-size: 19px;
	margin: 15px auto;
	color: #333;
	font-weight: bold;
	letter-spacing: 9px;
}

.content p {
	width: 910px;
	margin: 0 auto;
	margin-bottom: 15px;
	text-indent: 25px;
	line-height: 25px;
	font-size: 16px;
	font-family: "微软雅黑";
}

.content p img {
	margin: auto;
	display: block;
}

.content .pic img {
	vertical-align: -5px;
}
</style>
<div class="container container_F" id="minH" minH='280'>
	<div class="content">
		<h2>关于我们</h2>
		<p>您关于Spischolar学术资源导航系统的任何问题，都可以通过以下任一途径与我们产品团队直接交流与沟通；也欢迎您提出宝贵的意见和建议，我们希望与您一起努力，让Spischolar更加完善，更加贴近您的需求。</p>
		<p>
			微博：<b>@Spischolar学术资源导航</b> 手机扫描可以直接关注
		</p>
		<p>
			<img src="resources/<cms:getSiteFlag/>/images/wb.png" alt="" />
		</p>
		<div class="pic">
			点击QQ交谈：<img style="CURSOR: pointer"
				onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&sid=1962740172&o=www.spischolar.com&q=7', '_blank', 'height=502, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');"
				border="0" SRC=http://wpa.qq.com/pa?p=1:1962740172:7 alt="欢迎交流">
		</div>
		<p>
			<img src="resources/<cms:getSiteFlag/>/images/qq.jpg" alt="" />
		</p>
		<p>
			邮箱: <a href=mailto:Spischolar@hnwdkj.com>Spischolar@hnwdkj.com</a>
		</p>
		<p>电话：0731-82656399</p>
	</div>
</div>
<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>

<jsp:include page="common/footer.jsp"></jsp:include>
</body>
</html>

