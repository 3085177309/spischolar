<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link href="<cms:getProjectBasePath/>resources/images/favicon.ico"
	rel="SHORTCUT ICON">
<title>spischolar管理中心</title>
<script
	src="<cms:getProjectBasePath/>/resources/xsfx/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>/resources/back/js/admin.js"></script>
<link href="<cms:getProjectBasePath/>/resources/back/css/admin.css"
	rel="stylesheet" type="text/css" />
<link href="<cms:getProjectBasePath/>/resources/back/css/adminpage.css"
	rel="stylesheet" type="text/css" />
<script src="<cms:getProjectBasePath/>/resources/back/js/layer/layer.js" type="text/javascript"></script>
<script>
var SITE_URL='<cms:getProjectBasePath/>';
</script>
</head>
<body>
<input id="realmName" type="hidden" value='http://cloud.test.hnlat.com/doc-delivery'>
	<div class="header">
		<a href="#" class="logo"></a>
		<div class="col-hdr">
			<%-- <span class="weclome">欢迎你：<a style="color: #afdeff" href="<cms:getProjectBasePath/>backend/user">${person.name }</a></span> --%>
			<span class="weclome">欢迎你：<a style="color: #afdeff"
				href="<cms:getProjectBasePath/>backend/user">${front_member.username }</a></span>
			<a href="<cms:getProjectBasePath/>backend/logout" class="loginout">退出登录</a>
		</div>
		<div class="navbox">
			<ul>
				<li><a href="<cms:getProjectBasePath/>backend/index"
					<c:if test="${show == 1 }">class="in"</c:if>>网站概况</a></li>
				<c:if test="${permission.llfx.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.llfx.get(0).url }"
						<c:if test="${show == 2 }">class="in"</c:if>>流量分析</a></li>
				</c:if>
				<c:if test="${permission.yhfx.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.yhfx.get(0).url }"
						<c:if test="${show == 3 }">class="in"</c:if>>用户分析</a></li>
				</c:if>
				<c:if test="${permission.nrfx.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.nrfx.get(0).url }"
						<c:if test="${show == 4 }">class="in"</c:if>>内容分析</a></li>
				</c:if>
				<c:if test="${permission.xxgl.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.xxgl.get(0).url }"
						<c:if test="${show == 5 }">class="in"</c:if>>学校管理</a></li>
				</c:if>
				<c:if test="${permission.xtgl.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.xtgl.get(0).url }"
						<c:if test="${show == 6 }">class="in"</c:if>>系统管理</a></li>
				</c:if>
				<c:if test="${permission.xtrz.size()>0 }">
					<li><a
						href="<cms:getProjectBasePath/>${permission.xtrz.get(0).url }"
						<c:if test="${show == 7 }">class="in"</c:if>>系统日志</a></li>
				</c:if>
			</ul>
		</div>
		<c:if test="${org.flag=='wdkj' }">

			<label class="header-data-type">
				<div class="sc_selbox">
					<i class="inc uv21"></i>
					<c:if test="${type == -1 }">
						<span id="section_lx">所有数据</span>
					</c:if>
					<c:if test="${type == 0 }">
						<span id="section_lx">原始数据</span>
					</c:if>
					<c:if test="${type == 1 }">
						<span id="section_lx">添加数据</span>
					</c:if>
					<div class="sc_selopt" style="display: none;">
						<p onclick='changess(-1)'>所有数据</p>
						<p onclick='changess(0)'>原始数据</p>
						<p onclick='changess(1)'>添加数据</p>
					</div>
					<input type="hidden" name="type" id="type" value="${type }">
				</div>
			</label>


			<script type="text/javascript">
		function changess(type) {
			console.log("<cms:getProjectBasePath/>backend/index/changeType?type="+type);
			$.get("<cms:getProjectBasePath/>backend/index/changeType?type="+type, function(result){
				console.log(result.message);
				location.reload();
			})
		}
	</script>
		</c:if>
	</div>