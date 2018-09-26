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
	<title>添加公告</title>
	<script src="<%=path%>/resources/backend/js/jquery-1.7.1.min.js"></script>  
	<script src="<%=path%>/resources/backend/js/jquery-ui-1.8.18.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/backend/css/jquery-ui-1.8.18.custom.css" />
	<script src="<%=path%>/resources/backend/js/all-backend.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/plugins/kindeditor/themes/default/default.css" />
	<script charset="utf-8" src="<%=path%>/resources/plugins/kindeditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%=path%>/resources/plugins/kindeditor/lang/zh_CN.js"></script>
	
	<style>
	input.red{
		border: 1px solid red !important;
	}
	input.green{
		border :1px solid green !important;
	}
		body,html{
		padding:10px;
		margin: 0px;
	}
	body{
		font-family: 微软雅黑;
	}
	input.red{
		border: 1px solid red !important;
	}
	input.green{
		border :1px solid green !important;
	}
	ul{
		padding:0px;
		margin:0px;
	}
	li{
		list-style: none;
	}
	input.lg{
		width:440px;
		height: 23px;
		line-height: 23px;
		border: 1px solid #e1e1e1;
		margin-right: 13px;
		padding: 0 5px;
		font-size: 14px;
	}
	</style>
</head>

<body>
<div class="wxcl_qq">
 <h4 style="color: red" id="msg">&nbsp;${error }</h4>
  <form name="qq_form" method="post" action="backend/news/add">
    <ul>
      <li class="tjxq_li1"><span>标&#12288;&#12288;题：</span>
        <input name="title" type="text" value="${org.name }" class="log"/>
      </li>
      <li class="tjxq_li5" ><span>内&#12288;&#12288;容:</span>
      	<textarea rows="5" cols="100" class="ip_input1" name="content"></textarea>
      </li>
      <li>
        <div class="qx_bc"><input type="submit" class="aaniu1"/><input type="reset" value="重置" class="aaniu2"/></div>
      </li>
    </ul>
  </form>
  <div class="clear"></div>
</div>
<script>
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
$(function(){
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="content"]', {
			allowFileManager : true,
			width:800,
			height:500
		});
	});
});
</script>
</body>
</html>