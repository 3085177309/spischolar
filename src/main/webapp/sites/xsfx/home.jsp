<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta
	content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui"
	name="viewport" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta content="telephone=no" name="format-detection" />
<meta name="author" content="weidu.com">
<meta name="copyright" content="Copyright ©weidu.com 版权所有">
<!-- UC默认竖屏 ，UC强制全屏 -->
<meta name="full-screen" content="yes" />
<meta name="browsermode" content="application" />
<!-- QQ强制竖屏 QQ强制全屏 -->
<meta name="x5-orientation" content="portrait" />
<meta name="x5-fullscreen" content="true" />
<meta name="x5-page-mode" content="app" />
<title>期刊导航首页</title>
<link
	href="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/css/all201505013.css"
	rel="stylesheet" />
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/all-new.js"></script>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/jquery-1.8.3.min.js"></script>
<!--[if lte IE 8]> 
.navbar{ 
top:expression(eval(document.documentElement.scrollTop)); 
} 

<![endif]-->
<!--[if lte IE 6]>

<script src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/ie6Png.js"></script>
<script>
    DD_belatedPNG.fix('.png');
</script>

<![endif]-->
<!-- <script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?0ffd5a7dbb62116d4d9623f406f211f5";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script> -->
</head>
<body>
	<div class="navbar">
		<div class="affiche">
			<h3 class="png">公告:</h3>
			<div id="affiche">
				<ul>
					<li><a href="javascript:void(0)">2014年SCI期刊数据更新aa</a><span
						class="time">2015-04-20 </span></li>
					<li><a href="javascript:void(0)">2014年SCI期刊数据更新bb</a><span
						class="time">2015-04-20 </span></li>
					<li><a href="javascript:void(0)">2014年SCI期刊数据更新cc</a><span
						class="time">2015-04-20 </span></li>
				</ul>
			</div>
			<div class="affiche-arrow">
				<span></span> <span></span>
			</div>
		</div>
		<div class="nav-side">

			<div class="user-setting">
				<div class="set-home">
					<a onclick="SetHome(this,window.location)">设为首页</a>
				</div>
				<div class="log-reg">
					<a href="javascript:void(0)">登陆</a> <span>/</span> <a
						href="javascript:void(0)">注册</a>
				</div>
				<div class="user-info" id="user-name">
					<p>个人中心</p>
					<i class="png"></i>
					<div class="user-toggle">
						<s></s>
						<ul>
							<li><a href="javascript:void(0)">账户管理</a></li>
							<li><a href="javascript:void(0)">搜索历史</a></li>
							<li><a href="javascript:void(0)">文献传递</a></li>
							<li><a href="javascript:void(0)">我的收藏</a></li>
							<li><a href="javascript:void(0)">我的反馈</a></li>
							<li><a href="javascript:void(0)">退出</a></li>
						</ul>
					</div>
				</div>
			</div>
			<ul class="nav">
				<li><a href="javascript:void(0)" class="index png active">首页</a></li>
				<li><a href="<cms:getProjectBasePath/>docIndex"
					class="paper png">文章</a></li>
				<li><a href="<cms:getProjectBasePath/>index"
					class="journal png">期刊</a></li>
				<li><a href="javascript:void(0)" class="database png">数据库</a></li>
				<li class="dot-line">|</li>
			</ul>
		</div>
	</div>
	<div id="minH">
		<div class="serch-wrap">
			<div class="lg">
				<svg width="300" height="80">
              <image
						xlink:href="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/image/logo.svg"
						src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/images/logo.png"
						width="300" height="80" />
            </svg>
			</div>

			<div class="search-form">
				<div class="tab" id="search-tab-btn">
					<a href="javascript:void(0)">文章</a><a href="javascript:void(0)"
						class="active">期刊</a>
					<!-- <a href="javascript:void(0)">数据库</a> -->
				</div>
				<div id="search-tab-box">
					<dd class="stab">
						<form method="get" action="<cms:getProjectBasePath/>docList">
							<span class="s-input"> <input type="text" name="val"
								value="" id="keyword_text" placeholder="请输入检索关键词" /> <a
								href="javascript:void(0)" class="clearinput"></a>
							</span> <span class="s-submit"><input type="submit"
								id="quick_search_btn"></span>
							<div class="radio_js" id="lan_panel">
								<input type="hidden" id="radio_js" name="oaFirst" value="0">
								<span v="中文V"
									onclick='search_condi(this,"radio_js","radio_js_in");return false'
									value="0">开放资源</span>
							</div>
						</form>
					</dd>
					<dd class="stab">
						<form method="get" action="<cms:getProjectBasePath/>list/result"
							id="j_form">
							<input name="fieldFlag" value="all" type="hidden" /> <input
								type="hidden" id='docTypeHide' value="9" name='docType' /> <input
								type="hidden" id='fieldHide' value="all" name='field' /> <input
								type="hidden" value="list" name='viewStyle' /> <input
								type="hidden" value="1" name='limit' /> <span class="s-input">
								<input type="text" name="value" placeholder="请输入刊名/ISSN/学科名" />
								<a href="javascript:void(0)" class="clearinput" onclick=""></a>
							</span> <span class="s-submit"><input type="submit" name=""
								value=""></span>
							<div class="radio_js" id="lan_panel1">
								<a href="<cms:getProjectBasePath/>overview" class="b-journal">浏览期刊</a>
								<input type="hidden" id="radio_js1" name="lan" value="0">
								<span id="radio_js_in1" v="0"
									onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
									value='0'>全部</span> <span v="1"
									onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
									value="0">中文</span> <span v="2"
									onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
									value="1">外文</span>
							</div>
						</form>
					</dd>
					<div class="clear"></div>
				</div>

			</div>
			<script type="text/javascript">
        (function($){
            $('#quick_search_btn').bind('click', function() {
                var key = $.trim($('#keyword_text').val());
                if ('' == key) {
                    alert('请输入关键词!');
                    return false;
                }
            });
            //期刊也要提示词 ==！
            $('#j_form').bind('submit',function(e){
            	var v=$(this).find('input[name="value"]').val();
            	if(!v){
            		alert('请输入检索关键词!');
            		e.preventDefault();
            		return false;
            	}
            })
        })(jQuery);
        </script>
		</div>
		<div class="c-wrap">
			<div class="c-left">
				<div class="c-lbox">
					<div class="c-ltbox">
						<h3>热门期刊</h3>
						<ul class="p-list" id="p-list">
							<c:forEach var="jp" begin="1" end="${jPageSize }">
								<li><a href="javascript:void(0)"
									<c:if test="${jp==1 }"> class="active"</c:if>>${jp }</a></li>
							</c:forEach>
						</ul>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
					<div class="j-list" id="j-list">
						<ul>
							<c:forEach var="j" items="${hotJournal }" varStatus="idx">
								<li><span>${idx.index+1 }</span><a
									href="<cms:getProjectBasePath/>detail/result?id=${j.flag}"
									title="${j.title }" />${j.title }</a></li>
								<c:if test="${(idx.index+1)%8==0}">
						</ul>
						<c:if test="${(idx.index+1)<jPageSize*8 }">
							<ul>
						</c:if>
						</c:if>
						</c:forEach>
						</ul>
					</div>
				</div>

			</div>
			<div class="c-right">
				<div class="c-ltbox">
					<h3>热搜词</h3>
					<ul class="p-list" id="j-hword">
						<c:forEach var="kp" begin="1" end="${kPageSize }">
							<li><a href="javascript:void(0)"
								<c:if test="${kp==1 }"> class="active"</c:if>>${kp }</a></li>
						</c:forEach>
					</ul>
					<!-- <a href="javascript:void(0)" class="chg-pannews">换一换</a> -->

					<div class="clear"></div>
				</div>
				<div id="j-hwordBox" class="hot-seaworld">
					<ul>
						<c:forEach var="k" items="${hotKeywords }" varStatus="idx">
							<li><span>1</span><a
								href="<cms:getProjectBasePath/>docList?val=<c:out value="${k.title }" />"
								title="${k.title }">${k.title }</a></li>
							<c:if test="${(idx.index+1)%24==0}">
					</ul>
					<c:if test="${(idx.index+1)<kPageSize*24 }">
						<ul>
					</c:if>
					</c:if>
					</c:forEach>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
			<div class="New-guide png">
				<a href="<cms:getProjectBasePath/>resources/xsfx/images/guide.ppt"
					class="guide1">新手指南</a> <a href="javascript:void(0)" class="guide2">系统日志</a>
				<a href="javascript:void(0)" class="guide3">公告</a>
			</div>
		</div>
	</div>
	<div class="service">
		<ul>
			<li><a href="javascript:void(0)" class="consult">咨询</a></li>
			<li><a href="javascript:void(0)" class="code">扫码</a></li>
			<li><a href="javascript:void(0)" class="advice">建议</a></li>
			<li><a href="javascript:void(0)" class="totop" id="totop"></a></li>
		</ul>
	</div>
	<div class="footer">
		<p>
			<a href="<cms:getProjectBasePath/>resources/xsfx/images/guide.ppt">新手指南</a>|<a
				href="javascript:void(0)">使用手册</a>|<span>邮箱：spischolar@hnwdkj.com</span>
		</p>
	</div>
</body>
</html>
