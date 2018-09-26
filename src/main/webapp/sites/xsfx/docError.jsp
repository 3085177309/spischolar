<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="./scholar/meta.jsp"></jsp:include>
<style>
.r_con1 {
	width: 100%;
	padding: 20px 0;
}

.r_con1 ul li {
	float: left;
	width: 980px;
	border: 1px solid #e1e1e1;
	margin-top: 15px;
	position: relative;
	padding: 15px;
}

a.xkjl {
	position: absolute;
	line-height: 24px;
	right: 15px;
	top: 35px;
	font-size: 12px;
	color: #297fff;
}

.r_con1 ul li h3 {
	font-weight: 200;
	font-size: 14px;
	line-height: 30px;
}

.r_con1 ul li h4 {
	line-height: 30px;
	font-size: 12px;
	height: 30px;
	font-weight: 200;
	height: 44px;
}

.r_con1 ul li h4 a {
	color: #297fff;
}

.r_con1 ul li h4 span {
	padding-left: 20px;
	color: #666;
}

.r_con1 ul li p {
	line-height: 24px;
	font-size: 12px;
	float: left;
	width: 100%;
}

.r_con1 ul li p a {
	color: #297fff;
	float: left;
}

.r_con1 ul li p span {
	float: right;
	color: #666;
}

a.xkjl:hover,.r_con1 ul li h4 a:hover,.r_con1 ul li p a:hover {
	color: #6b84aa;
}
</style>
<title>服务器繁忙</title>
</head>
<body style="position: relative; overflow: hidden;">
	<jsp:include page="./scholar/header.jsp"></jsp:include>
	<section class="Subject" id="Middle">
		<div class="Sub_seah">
			<div class="seah_auto cf">
				<form action="<cms:getProjectBasePath/>docList" method="get">
					<input type="text" name="val" class="txt_cont"
						value="${condition.val }" style="padding-left: 10px" /> <input
						type="submit" name="" class="txt_btn" value="" /> <a
						href="javascript:;;" id="p1">高级</a>
				</form>
				<p style="float: right; margin-right: 442px;">
					<a href="<cms:getProjectBasePath/>docHis"
						style="color: #666; padding-right: 20px;">我的检索历史</a> <a
						style="color: #666; padding-right: 20px;"
						href="<cms:getProjectBasePath/>docDilivery/view">文献传递查询</a>
				</p>
				<p>
					<input name="" type="checkbox" value="" id="kfzy"
						style="vertical-align: middle; margin-top: -2px;"> <span
						style="color: #666">开放资源</span><span
						style="margin-left: 20px; color: #89A0AF;" id="kfzydes">勾选即可获取全部开放资源结果</span>
				</p>
			</div>
		</div>
		<div class="Sub_opt cf">
			<div class="r_con1">
				<h3>${errorMsg }</h3>
			</div>
		</div>
	</section>
	<jsp:include page="./scholar/footer.jsp"></jsp:include>
	<div class="showin">
		<jsp:include page="./scholar/search.jsp"></jsp:include>
		<!--登陆-->
		<div class="Win_bj Account animatouts">
			<div class="panel-login">
				<i></i>
				<div class="login-social userlogin" l="ifr">
					<p>
						<span>账号：</span> <input type="text" name="username" class="txt"
							id="login_email_ifr">
					</p>
					<p>
						<span>密码：</span> <input type="password" name="password"
							class="txt" id="login_password_ifr">
					</p>
					<div class="social-action">
						<div class="action-auto cf">
							<input type="button" class="action-btns fl" value="提交"
								id="userSubmit_ifr">
							<button class="action-btns close fr">取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/public.js"></script>
	<script type="text/javascript">
      	new show(false,"pop","p1","animation","animation-out"); 
      	</script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/util.js"></script>
	<script type="text/javascript">
       $(function(){
    	   var cookie=Weidu.getCookie('scholar.query');
    	   if(!!cookie){
    		   $('#showHis').show();
    	   }
       });
       </script>
</body>
</html>
