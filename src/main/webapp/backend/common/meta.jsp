<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<link href="<%=path%>/resources/backend/css/all-backend.css" rel="stylesheet" type="text/css" />
<script src="<%=path%>/resources/backend/js/all-backend.js"></script>
<script src="<%=path%>/resources/backend/js/jquery-1.7.1.min.js"></script>  
<script src="<%=path%>/resources/backend/js/jquery-ui-1.8.18.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/backend/css/jquery-ui-1.8.18.custom.css" />
<!--[if lte IE 6]>
<script src="<%=path%>/resources/backend/js/ie6Png.js"></script>
<script>
	DD_belatedPNG.fix('.png,img');
</script>
<![endif]-->