<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>机构列表</title>
	<link href="<%=path%>/resources/backend/css/all-backend.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/backend/js/all-backend.js"></script>
	<script src="<%=path%>/resources/backend/js/jquery-1.7.1.min.js"></script>  
	<script src="<%=path%>/resources/backend/js/jquery-ui-1.8.18.custom.min.js"></script>
	<link href="<%=path%>/resources/plugins/MDialog/MDialog.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/plugins/MDialog/MDialog.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/backend/css/jquery-ui-1.8.18.custom.css" />
	<!--[if lte IE 6]>
	<script src="<%=path%>/resources/backend/js/ie6Png.js"></script>
	<script>
		DD_belatedPNG.fix('.png,img');
	</script>
	<![endif]-->
</head>

<body>
<div class="header"><a href="#" class="png"></a></div>
<div class="container"> 
  <!--sidebar-->
  
  <c:set scope="request" var="menu" value="org"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
    <div id="contentH" class="content" >
    	<div class="tianj"><a href="javascript:void(0)" onclick="openAddWin('backend/person/add/${orgId}')" class="tianj_a"></a></div>
        <div class="tj_con" id="tj_con">
        
	<table class="table table-striped" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr bgcolor="#f5f5f5">
				<td>序号</td>
				<td>姓名</td>
				<td>邮箱</td>
				<td>注册日期</td>
				<td>角色</td>
				<td>状态</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${pager.rows }" var="person" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${person.name }</td>
					<td>${person.email }</td>
					<td><fmt:formatDate value="${person.registerDate }" pattern="yyyy-MM-dd HH:mm"/> </td>
					<td>
						<c:choose>
							<c:when test="${person.role==1 }">
								系统超级管理员
							</c:when>
							<c:when test="${person.role==2 }">
								机构管理员
							</c:when>
							<c:otherwise>
								机构站点管理员
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${person.status==1 }">
								启用
							</c:when>
							<c:otherwise>
								禁用
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<a href="#">重置密码</a>
					</td>
				</tr>
			</c:forEach>
	</table>
	<div class="page">
	<ul class="pagination">
		<pg:pager items="${pager.total}" url="backend/person/list/${orgId}" export="cp=pageNumber" maxPageItems="5" maxIndexPages="5" idOffsetParam="offset">
			<pg:prev>
				<li><a href="${pageUrl}">上一页</a></li>
			</pg:prev>
			<!-- 中间页码开始 -->
			<pg:pages>
				<c:choose>
					<c:when test="${cp eq pageNumber }">
						<li class="active"><a href="javascript:void(0);">${pageNumber}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${pageUrl}">${pageNumber}</a></li>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<li><a id="next_page" href="${pageUrl}">下一页</a></li>
			</pg:next>
		</pg:pager>
	</ul>
	</div>
	</div>
	</div>
	</div>
	<script type="text/javascript">
	function openAddWin(href){
		$M({
	    	title: '添加用户',
	    	iframe: true,
	    	padding: 0,
	    	top: '50%',
	    	lock: true,
	    	drag: false,
	    	fixed: true,
	    	content: href
		});
	}
	</script>
	</body>
</html>