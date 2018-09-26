<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<script type="text/javascript">
	/**
	 * 提示消息
	 * @param text 提示消息
	 * @param func 回调函数
	 */
	function message(text,func) {
	    $("#spanmessage").text(text);
	    $("#message").dialog({
	        title:"学术资源管理后台，提示您",
	        modal: true,
	        buttons: {
	            "确定": function() {
	                $(this).dialog("close");
	                if(func){
	                	func.call();
	                }
	            }
	        }
	    });
	}
	function queren(text, callback) {
	    $("#spanmessage").text(text);
	    $("#message").dialog({
	        title: "学术资源管理后台，提示您",
	        modal: true,
	        resizable: false,
	        buttons: {
	            "否": function() {
	                $(this).dialog("close");
	            },
	            "是": function() {
	                callback.call();//方法回调
	                $(this).dialog("close");
	            }
	        }
	    });
	}
	$(function(){
		var boardDiv = "<div id='message' style='display:none;'><span id='spanmessage'></span></div>";
 	   	$(document.body).append(boardDiv);
	});
	</script>
</head>

<body>
<div class="header"><a href="#" class="png"></a></div>
<div class="container"> 
  <!--sidebar-->
  
  <c:set scope="request" var="menu" value="org"></c:set>
  <jsp:include page="../common/menu.jsp" />
  
  <!--content-->
  <div id="contentH" class="content" >
    	<div class="tianj"><h1>${orgName}</h1></div>
        <div class="tj_con" id="tj_con">
        	${msg }
        	<div id="purchasedb_list" action="backend/purchasedb/list/${orgFlag}">
        	</div>
        	<br /><hr />
        	<div id="urlrule_lsit" action="backend/urlrule/list/${orgFlag }">
        	</div>
	</div>
   </div>
  </div>
<script type="text/javascript">
	$(function(){
		var purchasedb=$('#purchasedb_list');
		purchasedb.load(purchasedb.attr('action'));
		var urlrule=$('#urlrule_lsit');
		urlrule.load(urlrule.attr('action'));
	});
</script>
</body>
</html>