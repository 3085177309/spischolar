<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<c:set scope="request" var="navIndex" value="2"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="./scholar/meta.jsp"></jsp:include>
<title>中外文学术发现系统</title>
</head>
<body style="position: relative; overflow: hidden;">
	<jsp:include page="./scholar/header.jsp"></jsp:include>
	<section class="Middle" id="Middle">
		<form action="<cms:getProjectBasePath/>docList" method="get">
			<div class="Middle_fm cf">
				<p class="fm_put" style="overflow: hidden; margin-right: -80px;">
					<input type="text" class="fm_text" name="val"
						style="padding-left: 10px;; width: 74%" /> <input type="submit"
						class="fm_btn" value=""> <a href="javascript:;;"
						class="fm_gj" id="p1">高级</a>
				</p>
				<p style="float: left; padding-top: 10px;">
					<input name="oaFirst" type="checkbox" value="1" id="kfzy"
						style="vertical-align: middle; margin-top: -2px; cursor: pointer">
					<span style="color: #666">开放资源</span>
				</p>
				<p class=""
					style="text-align: right; padding-top: 10px; margin-right: 80px;">
					<a href="<cms:getProjectBasePath/>docHis"
						" style="color: #666; padding-right: 20px;" id="showHis">我的检索历史</a>
					<a style="color: #666; padding-right: 20px;"
						href="<cms:getProjectBasePath/>docDilivery/view">文献传递查询</a>
				</p>
				<p class="fm_js">科学到了最后阶段，便遇上了想象。</p>
			</div>
		</form>
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
	<!-- 登录弹窗 END -->
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
