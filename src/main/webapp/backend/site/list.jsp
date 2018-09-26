<!-- 站点列表页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
	var ztreeJsonStr = '${ztreeJson}';
	if (null != ztreeJsonStr && '' != ztreeJsonStr) {
		var tree_site_nodes = [];
		console.log(ztreeJsonStr);
		ztreeJson = eval("(" + ztreeJsonStr + ")");
	}else{
		ztreeJson = null;
	}
</script>
<div id='site_list_panel'>

	<input type="hidden" id='site_org' value='${orgId }' />
	<h4>${org.name }</h4>
	<ul id='site_tree' class='ztree'></ul>
</div>

<script type="text/javascript"
	src="resources/plugins/zTree_v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/site/list.js"></script>