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
	<title>文献传递</title>
	<link href="<%=path%>/resources/backend/css/all-backend.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/backend/js/jquery-1.7.1.min.js"></script>
	<script src="<%=path%>/resources/backend/js/jquery-ui-1.8.18.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/backend/css/jquery-ui-1.8.18.custom.css" />
	<!--[if lte IE 6]>
	<script src="<%=path%>/resources/backend/js/ie6Png.js"></script>
	<script>
		DD_belatedPNG.fix('.png,img');
	</script>
	<![endif]-->
</head>

<body>
<div class="header"> <a href="#" class="png"></a> </div>
<div class="container">
  <!--sidebar-->
  <c:set scope="request" var="menu" value="dilivery"></c:set>
  <jsp:include page="../common/menu.jsp" />

  <!--content-->
  <div id="contentH" class="content" >
    <div class="tianj">
      <div class="xl_t"> <span>文献传递状态:</span>
      	<form action="backend/delivery/list" method="get" id="change_form">
        <select name="type" id="select_type">
        		<option value="">所有</option>
        		<option value="0" <c:if test="${type==0 }">selected="selected"</c:if>>未处理</option>
        		<option value="1" <c:if test="${type==1 }">selected="selected"</c:if>>已成功处理</option>
        		<option value="2" <c:if test="${type==2 }">selected="selected"</c:if>>提交第三方处理</option>
        		<option value="3" <c:if test="${type==3 }">selected="selected"</c:if>>无结果</option>
        		<option value="4" <c:if test="${type==4 }">selected="selected"</c:if>>其他途径</option>
        	</select>
        	<input type="text" name="keyword" value="${keyword }"/>
        	<input type="submit" name="查询" />
        </form>
      </div>
    </div>
    <div class="tj_con" id="tj_con">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr bgcolor="#f5f5f5">
          <td width="26%"><b>标 题</b></td>
          <td width="24%"><b>用 户</b></td>
          <td width="22%"><b>单 位</b></td>
          <td><b>申请时间</b></td>
          <td><b>状 态</b></td>
          <td><b>操 作</b></td>
        </tr>
        <c:forEach var="dd" items="${datas.rows }">
        <tr>
          <td><a href="${dd.url }" title="点击查看" target="_blank" style="display: inline;">${dd.title }</a></td>
          <td>${dd.email }</td>
          <td>${dd.orgName }</td>
          <td><fmt:formatDate value="${dd.addDate }" pattern="yyyy-MM-dd HH:mm"/></td>
          <td>
			<c:if test="${dd.processType ==0}">未处理</c:if>
			<c:if test="${dd.processType ==1}">已成功处理</c:if>
			<c:if test="${dd.processType ==2}">提交第三方处理</c:if>
			<c:if test="${dd.processType ==3}">无结果</c:if>
			<c:if test="${dd.processType ==4}">其他途径</c:if>
		</td>
          <td>
          	<c:if test="${dd.processType ==0 || dd.processType ==2 || dd.processType ==4}">
          	<a href="javascript:void(0);" class="process_btn p1" data_id="${dd.id }" data_title="${dd.title }" data_url="${dd.url }" data_type="${dd.processType }">处理</a>
          	</c:if>
          </td>
        </tr>
        </c:forEach>
      </table>
      <div class="page">
		<a class="a1">${datas.total}条</a>
		<pg:pager items="${datas.total}" url="backend/delivery/list" export="cp=pageNumber" maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
			<pg:param name="type" />
			<pg:param name="keyword" />
			<pg:prev>
				<a href="${pageUrl}" class="a1">上一页</a>
			</pg:prev>
			<!-- 中间页码开始 -->
			<pg:pages>
				<c:choose>
					<c:when test="${cp eq pageNumber }">
						 <span>${pageNumber }</span>
					</c:when>
					<c:otherwise>
						<a href="${pageUrl}">${pageNumber}</a>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next>
				<a class="a1" href="${pageUrl}">下一页</a>
			</pg:next>
	  </pg:pager>
    </div>
    </div>
  </div>
</div>
<!--处理弹窗-->
<div class="showin">
  <div class="showin-bj"></div>
  <div class="Win_bj Account" id="Account">
    <div class="panel-login"> <i></i>
      <div class="login-social">
        <form method="post" action="backend/delivery/process" enctype="multipart/form-data" id="process_form">
          <input type="hidden" name="id" id="id_input" />
          <ul>
            <li><span>标&#12288;题：</span>
              <div class="qq_bt" id="title_div"> </div>
            </li>
            <li><span>Url：</span> <a href="#" id="url_href" target="_blank"></a> </li>
            <li><span>处理方式：</span>
              <input type="radio" name="processType" value="1" checked="checked"/>直接处理&nbsp;&nbsp;
              <font class="types"><input type="radio" name="processType" value="2"/>提交第三方处理&nbsp;&nbsp;
              <input type="radio" name="processType" value="4"/>其他途径&nbsp;&nbsp;
              </font>
              <input type="radio" name="processType" value="3"/>无结果
            </li>
            <li id="file_line"><span>文&#12288;档：</span>
              <input type="file" name="doc" id="file_input"/>
            </li>
          </ul>
          <div class="clear"></div>
          <div class="social-action">
            <div class="action-auto cf">
              <input type="submit" class="action-btns fl" value="提交"/>
              <button class="action-btns close fr">取消</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script src="<%=path%>/resources/backend/js/all-backend.js"></script>
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
$(function(){
	var boardDiv = "<div id='message' style='display:none;'><span id='spanmessage'></span></div>";
	   	$(document.body).append(boardDiv);
	$('#select_type').bind('change',function(){
		$('#change_form').submit();
	});
	var pat=new show(false,"Account");
	$('.process_btn').bind('click',function(){
		$('#id_input').val($(this).attr('data_id'));
		$('#title_div').text($(this).attr('data_title'));
		$('#url_href').attr('href',$(this).attr('data_url'));
		$('#url_href').text($(this).attr('data_url'));
		var type=$(this).attr('data_type');
		if(type==0){
			$('.types').show();
		}else if(type==2||type==4){//第三方处理
			$('.types').hide();
		}
		pat.animati();
	});
	$('#Account').find('input[type="radio"]').bind('click',function(){
		var value=$('#Account').find('input[type="radio"]:checked').val();
		if(value==1){
			$('#file_line').show();
			$('#file_input').attr('disabled',false);
		}else{
			$('#file_line').hide();
			$('#file_input').attr('disabled',true);
		}
	});
	$('#process_form').bind('submit',function(e){
		var value=$('#Account').find('input[type="radio"]:checked').val();
		if(value==1){//如果是直接处理
			var file=$('#file_input').val();
			if(!file){
				message('请选择上传文件!',function(){
					$('#file_input').focus();
				});
				e.preventDefault();
				return false;
			}
		}
	});
});
</script>
</body>
</html>
