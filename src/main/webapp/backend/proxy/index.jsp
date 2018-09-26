<!-- 站点管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms" %>

<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<table class="table">
	<tr>
		<th>序号</th>
		<th>IP</th>
		<th>端口</th>
		<th>描述</th>
		<th>状态</th>
		<th>操作</th>
	</tr>
	<tr>
		<td>1</td>
		<td>192.126.119.62</td>
		<td>80</td>
		<td>美橙美国主机</td>
		<td><span class="badge badge-success">服务中</span></td>
		<td><a href="#" action_target="backend/proxy/detail">管理</a></td>
	</tr>
	<tr>
		<td>2</td>
		<td>113.10.137.86</td>
		<td>80</td>
		<td>云龙香港主机</td>
		<td><span class="badge badge-success">服务中</span></td>
		<td><a href="#" action_target="backend/proxy/detail">管理</a></td>
	</tr>
</table>
<script type="text/javascript">
$(function(){
	var statusURL="http://{ip}:{port}/web-search/command?name=status";
	$('.table tr').each(function(){
		
	});
});
</script>