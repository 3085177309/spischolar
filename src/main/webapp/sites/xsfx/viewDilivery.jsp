<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

@media screen and (max-width: 980px) {
	.Subject .Sub_opt {
		width: 96%;
	}
	.r_con1 ul li {
		width: 100%;
	}
	.r_con1 ul li .xkjl {
		display: none;
	}
	.r_con1 ul li p span {
		display: none;
	}
	.Subject .Sub_seah .seah_auto {
		width: 96%;
		margin: 0 auto;
	}
	.Subject .Sub_seah .seah_auto .txt_cont {
		width: 60%;
	}
}

@media screen and (max-width: 460px) {
	.Subject .Sub_seah .seah_auto .txt_cont {
		width: 50%;
	}
}

.clear {
	clear: both;
	height: 0;
	font-size: 0;
	overflow: hidden;
	line-height: 0;
}

.email_search {
	width: 1000px;
	margin: 0 auto;
	padding-top: 20px;
	overflow: hidden;
}

.email_search input {
	float: left;
	width: 250px;
	height: 26px;
	border: 1px solid #e1e1e1;
	background: #fff;
}

.email_search button {
	width: 76px;
	height: 28px;
	background: #AACEE5;
	color: #2B74A3;
	border-radius: 2px;
	float: left;
	margin-left: 10px;
	_display: inline;
	border: none;
	outline: 0;
}

.docfile {
	width: 1000px;
	margin: 16px auto 20px auto;
	background: #E4F0F8;
	line-height: 42px;
	text-indent: 10px;
}

.docfile span {
	float: left;
}

.download_select {
	float: left;
	width: 167px;
	margin-top: 8px;
	margin-left: 10px;
	background: #fff;
}

.download_select select {
	width: 167px;
	height: 24px;
}

/* div重绘下拉列表
        .model-select-box {height: 23px;line-height: 24px;border: 1px solid #aaa;float: left;margin-right: 20px;text-indent: 5px;position: relative;width: 100%;}
        .model-select-text {height: 23px;padding-right: 24px;background: url(images/list_bg.png) no-repeat right center ;cursor: pointer;-moz-user-select: none;-webkit-user-select: none;user-select: none;}
        .model-select-option {display: none;position: absolute;background: #fff;width: 100%;left: -1px;border: 1px solid #aaa; z-index:10001;}
        .model-select-option li {height: 22px;line-height: 22px;color: #555;cursor: pointer; }
        .model-select-option li:hover { background-color:#e2e2e2; } */
.container {
	width: 10000px;
	margin: 22px auto 0 auto;
}

.content ul {
	overflow: hidden;
}

.content li {
	border: 1px solid #e1e1e1;
	line-height: 35px;
	text-indent: 10px;
	color: #333333;
	margin-bottom: 11px;
}

.content li a {
	color: #e36c09
}

.content li span {
	padding-left: 10px;
}

/*footer*/
.footer {
	height: 50px;
	line-height: 25px;
	padding-top: 17px;
	background: #37383a;
	margin-top: 26px;
	color: #bebebe
}

.footer a {
	color: #bebebe;
	padding: 0 10px
}

.footer a:hover {
	text-decoration: underline;
}

.footer .p1 {
	font-size: 14px;
}

.footer .p2 {
	font-size: 12px;
}

/*content*/
.container {
	width: 1000px;
	margin: 0 auto;
	text-align: left;
	overflow: hidden;
	font-size: 14px;
}
</style>
<title>我的检索历史</title>
</head>
<body style="position: relative; overflow: hidden;">
	<jsp:include page="./scholar/header.jsp"></jsp:include>
	<section class="Subject" id="Middle">
		<div class="Sub_seah">
			<div class="seah_auto cf">
				<form action="<cms:getProjectBasePath/>docList" method="get">
					<input type="text" name="val" class="txt_cont" value=""
						style="padding-left: 10px;" /> <input type="submit" name=""
						class="txt_btn" value="" /> <a href="javascript:;;" id="p1">高级</a>
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
			<div class="container">
				<div class="email_search">
					<form method="get">
						<input type="text" name="email" value="${email }" id="emailInput">
						<button type="">搜索</button>
					</form>
					<script type="text/javascript">
                    $(function(){
                    	if($('#emailInput').val()==''){
                    		$('#emailInput').val('请输入您的邮箱...');
                    	}
                    	$('#emailInput').focus(function(){
                    		if($(this).val()=='请输入您的邮箱...'){
                    			$(this).val('');
                    		}
                    	}).blur(function(){
                    		if($(this).val()==''){
                    			$(this).val('请输入您的邮箱...');
                    		}
                    	});
                    });
                    </script>
				</div>
				<div class="docfile">
					<span>以下是您的文献传递请求：</span>
					<!-- 
                  <div class="download_select">
                      <select name="seq_sl" class="seq_sl fl" id="seq_sl">
                          <option value="0">相关排序</option>
                          <option value="1">时间排序</option>
                      </select>
                  </div> -->
					<div class="clear"></div>
				</div>

				<div class="content">
					<ul>
						<c:forEach var="d" items="${datas.rows }">
							<li>${d.title }<span> <c:if
										test="${d.processType==0 }">
                 		[待传递]
                 		</c:if> <c:if test="${d.processType==1 }">
										<c:choose>
											<c:when test="${empty d.path }">
                 				[已经发送至邮箱]
                 			</c:when>
											<c:otherwise>
                 				[<a
													href="<cms:getProjectBasePath/>docDilivery/download/${d.id}">下载</a>]
                 			</c:otherwise>
										</c:choose>

									</c:if> <c:if test="${d.processType==2 }">
                 		[传递中]
                 		</c:if> <c:if test="${d.processType==3 }">
                 		[无结果]
                 		</c:if>
							</span> <span class="time"><fmt:formatDate value="${d.addDate }"
										pattern="yyyy-MM-dd HH:mm" /></span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="./scholar/footer.jsp"></jsp:include>
	<div class="showin">
		<jsp:include page="./scholar/search.jsp"></jsp:include>
		<!--登陆弹窗-->
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
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/util.js"></script>
	<script type="text/javascript">
       new show(false,"pop","p1","animation","animation-out");
       $(function(){
    	   var cookie=Weidu.getCookie('scholar.query');
    	   if(!!cookie){
    		   $('#showHis').show();
    	   }
       });
       </script>
</body>
</html>
