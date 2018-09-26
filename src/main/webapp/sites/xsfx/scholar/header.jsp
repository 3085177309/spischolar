<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%>
<!--  
<header class="header">
	<div class="headerBox">
    	<div class="logo png">
        	<a href="<cms:getProjectBasePath/>"></a>
        </div>
        <ul id="nav" class="nav">
        	<cms:checkPurchased pid="1">
        	<li class="A1"><a href="<cms:getProjectBasePath/>"></a></li>
            <li class="A2"><a href="<cms:getProjectBasePath/>overview"></a></li>
            </cms:checkPurchased>
            <cms:checkPurchased pid="2">
            <li class="A3"><a class='in' href="<cms:getProjectBasePath/>docIndex"></a></li>
            </cms:checkPurchased>
        </ul>
    </div>
</header>
-->
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
			<li><a href="<cms:getProjectBasePath/>"
				class="index png <c:if test="${navIndex==0 }">active</c:if>">首页</a></li>
			<cms:checkPurchased pid="2">
				<li><a href="<cms:getProjectBasePath/>docIndex"
					class="paper png <c:if test="${navIndex==2 }">active</c:if>">文章</a></li>
			</cms:checkPurchased>
			<cms:checkPurchased pid="1">
				<li><a href="<cms:getProjectBasePath/>overview"
					class="journal png <c:if test="${navIndex==1 }">active</c:if>">期刊</a></li>
			</cms:checkPurchased>
			<li><a href="javascript:void(0)" class="database png">数据库</a></li>
			<li class="dot-line">|</li>
		</ul>
	</div>
</div>
