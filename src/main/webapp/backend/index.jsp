<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="机构列表"></c:set>
<c:set var="title" value="后台首页" scope="request"></c:set>
<jsp:include page="/backend/common/header.jsp"></jsp:include>
<jsp:include page="/backend/common/nav.jsp"></jsp:include>
	<table class="table table-striped">
   		<tr>
   			<th>机构名</th>
   			<th>机构标识</th>
   			<th>注册日期</th>
   			<th>操作</th>
   		</tr>
   		<tr>
   			<td>纬度科技</td>
   			<td>wdkj</td>
   			<td>2014-12-01</td>
   			<td><a href="#">管理</a></td>
   		</tr>
   	</table>
   	<ul class="pagination">
 		<li class="disabled"><a href="#">&laquo;</a></li>
 		<li class="active"><a href="#">1</a></li>
 		<li><a href="#">2</a></li>
 		<li><a href="#">3</a></li>
  		<li><a href="#">4</a></li>
  		<li><a href="#">5</a></li>
  		<li><a href="#">&raquo;</a></li>
	</ul>
<jsp:include page="/backend/common/footer.jsp"></jsp:include>