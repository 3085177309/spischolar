<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container">
	<div class="row">
		<div class="col-md-2">
			<div class="bs-sidebar hidden-print" role="complementary">
			<ul class="nav bs-sidenav">
				<li><a href="javascript:void(0);">机构管理</a>
					<ul class="nav">
						<li><a href="backend/org/list">机构列表</a></li>
						<li><a href="#">基本信息管理</a></li>
						<li><a href="#">人员管理</a></li>
						<li><a href="#">日志管理</a></li>
						<li><a href="#">资源配置</a></li>
						<li><a href="backend/delivery/list">文献传递</a></li>
					</ul>
				</li>
				<hr />
				<li><a href="javascript:void(0);">个人信息管理</a>
					<ul class="nav">
						<li><a href="#">检索记录</a></li>
						<li><a href="#">资源收藏</a></li>
					</ul>
				</li>
				<hr />
				<li><a href="javascript:void(0);">元数据管理</a>
					<ul class="nav">
						<li><a href="backend/authorityDatabase/list">权威数据库管理</a></li>
						<li><a href="#">期刊元数据管理</a></li>
						<li><a href="#">数据库管理</a>
					</ul>
				</li>
				<hr />
				<li><a href="javascript:void(0);">系统管理</a>
					<ul class="nav">
						<li><a href="#">重新加载系统缓存</a></li>
						<li><a href="#">检索词过滤</a>
						<li><a href="#">问题反馈</a></li>
					</ul>
				</li>
				<hr />
				<li><a href="javascript:void(0);">权限管理</a>
					<ul class="nav">
						<li><a href="#">角色管理</a></li>
						<li><a href="#">权限管理</a></li>
						<li><a href="#">资源管理</a></li>
						<li><a href="#">用户管理</a></li>
					</ul>
				</li>
			</ul>
			</div>
		</div>
		<div class="col-md-10">
			<h1 class="page-header"><c:out value="${pageTitle}" /></h1>
			<div class="panel panel-default">
  				<div class="panel-body">