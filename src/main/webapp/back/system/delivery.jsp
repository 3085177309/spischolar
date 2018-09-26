<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>文献互助请求</title>

<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 26 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/delivery/list">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/system/powers" class="in">权限设置</a>
		</div>

		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/powers">栏目显示</a>
						<a href="<cms:getProjectBasePath/>backend/system/powers/quota">流量指标显示</a>
						<a href="<cms:getProjectBasePath/>backend/system/powers/delivery"
							class="in">文献互助请求</a>
					</div>
					<div>
						<div class="databody">
							<div class="mb10">
								<form id="change_form" method="get"
									action="<cms:getProjectBasePath/>backend/system/powers/delivery">
									<label class="common"> <input type="text"
										class="tbSearch keyword" name="keyWord"
										placeholder="请输入邮箱或学校名称" value="${keyWord }">
										<button class="tbBtn" type="submit">查询</button>
									</label> <span class="thickBtn addSchool" data-thickcon="addAccount"
										style="*vertical-align: top; *margin-top: 3px; padding: 0 10px 0 30px;">
										<i></i> 添加
									</span>
								</form>

							</div>
							<table class="jurisdiction">
								<tr>
									<th width="50px">序号</th>
									<th>邮箱</th>
									<th>请求上限/日</th>
									<th>学校</th>
									<th>是否注册</th>
									<th>操作人</th>
									<th>添加时间</th>
									<th>有效期</th>
									<th>操作</th>
									<th>邮件通知</th>
								</tr>
								<c:forEach items="${pager.rows }" var="list" varStatus="status">
									<tr>
										<td class="tc"><span>${status.index+1 }</span></td>
										<td>${list.email }</a></td>
										<td><span>${list.count }</span></td>
										<td><span>${list.orgName }</span></td>
										<td><span> <c:if
													test="${not empty list.isRegister }">是</c:if> <c:if
													test="${empty list.isRegister }">否</c:if>
										</span></td>
										<td><span>${list.procesorName }</span></td>
										<td><span>${list.time }</span></td>
										<td><span>${list.endTime }</span></td>
										<td><span class="cd00 write thickBtn" value="${list.id }"
											delivery_endTime="${list.endTime }"
											delivery_count="${list.count }"
											delivery_schoolName="${list.orgName }"
											delivery_email="${list.email }"
											delivery_schoolFlag="${list.orgFlag }"
											data-thickcon="updateAccount">编辑</span> <a href="#"
											value="${list.id }" class="cd00 delete sm-Btn">删除</a></td>
										<td><span class="cd00 sendEmail thickBtn"
											value="${list.id }" delivery_endTime="${list.endTime }"
											delivery_count="${list.count }"
											delivery_email="${list.email }" data-thickcon="emailAccount">发送邮件</span></td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="page" style="margin-right: 20px;">
							<a class="a1">${pager.total}条</a>
							<pg:pager items="${pager.total}" url="" export="cp=pageNumber"
								maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
								<pg:param name="keyWord" />
								<pg:first>
									<a href="${pageUrl}">首页</a>
								</pg:first>
								<pg:prev>
									<a href="${pageUrl}" class="a1">上一页</a>
								</pg:prev>
								<!-- 中间页码开始 -->
								<pg:page>
									<c:if test="${pager.total/20 gt 5 and (cp gt 3)}">
										...
									</c:if>
								</pg:page>
								<pg:pages>
									<c:choose>
										<c:when test="${cp eq pageNumber }">
											<span>${pageNumber }</span>
										</c:when>
										<c:otherwise>
											<a href="${pageUrl}" class="a1">${pageNumber}</a>
										</c:otherwise>
									</c:choose>
								</pg:pages>
								<pg:page>
									<c:if
										test="${pager.total/20 gt 5 and (pager.total/20 gt (cp+2))}">
										...
									</c:if>
								</pg:page>
								<pg:next>
									<a class="a1" href="${pageUrl}">下一页</a>
								</pg:next>
								<pg:last>
									<a href="${pageUrl}">末页</a>
								</pg:last>
								<input type="text" onkeyup="clearNotInt(this)" id="go"
									style="width: 50px;" size="5">
								<pg:last>
									<a class="a1" onclick="go('${pageUrl}')">GO</a>
								</pg:last>
							</pg:pager>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
	<div class="tickbox">
		<div id="emailAccount" class="export emailAccount" data-tit="发送邮件">
			<form method="get" id="sendEmail">
				<input type="hidden" name="id">
				<table>
					<tr>
						<td width="50px;">邮箱：</td>
						<td><input type="text" class="tbSearch " readonly="readonly"
							name="email"></td>
					</tr>
					<tr>
						<td>主题：</td>
						<td><input type="text" class="tbSearch " name="subject"
							value="[Spischolar文献互助]——请求权限变更"></td>
					</tr>
					<tr>
						<td>内容：</td>
						<td><textarea rows="10" cols="55" name="content"></textarea>
						</td>
					</tr>

				</table>
				<div class="tc">
					<input id="sendEmail_button" type="button" value="发送邮件"
						class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
	</div>
	<div class="tickbox">
		<div id="updateAccount" class="export addAccount" data-tit="编辑文献互助权限">
			<form method="get" id="update_deliveryValidity">
				<input type="hidden" name="id">
				<table>
					<tr>
						<td style="width: 80px;"><em>*</em>邮箱：</td>
						<td><input type="text" class="email" name="email"></td>
					</tr>
					<tr>
						<td>学校：</td>
						<td><label class="data-type">
								<div class="sc_selbox">
									<i class="inc uv21"></i> <span id="section_lx" class="school">请选择</span>
									<div class="sc_selopt" style="display: none;">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolFlag="${org.flag }"
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" id="orgName" class="orgName"
										name="orgName" value=""> <input type="hidden"
										id="orgFlag" class="orgFlag" name="orgFlag" value="">
								</div>
						</label></td>
					</tr>
					<tr>
						<td><em>*</em>文献互助：</td>
						<td><input type="text" class="count" name="count"
							onkeyup="clearNotInt(this)">条/每日</td>
					</tr>
					<tr>
						<td><em>*</em>有效期：</td>
						<td><input type="text" class="endTime" id="endTime"
							class="tbSearch datechoose" name="endTime"
							onfocus="WdatePicker({minDate:'%y-%M-%d',readOnly:true})"></td>
					</tr>
				</table>
				<div class="tc">
					<input id="update_button" type="button" value="确认修改"
						class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
	</div>
	<div class="tickbox">
		<div id="addAccount" class="export addAccount addAccount-box"
			data-tit="添加文献互助权限">
			<form method="get" id="add_deliveryValidity">
				<table>
					<tr>
						<td style="width: 70px;"><em>*</em>邮箱：</td>
						<td><input type="text" class="email" name="email"></td>
					</tr>
					<tr>
						<td>学校：</td>
						<td><label class="data-type">
								<div class="sc_selbox">
									<i class="inc uv21"></i> <span id="section_lx" class="school">请选择</span>
									<div class="sc_selopt" style="display: none;">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolFlag="${org.flag }"
												schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" id="orgName" class="orgName"
										name="orgName" value=""> <input type="hidden"
										id="orgFlag" class="orgFlag" name="orgFlag" value="">
								</div>
						</label></td>
					</tr>
					<tr>
						<td><em>*</em>文献互助：</td>
						<td><input type="text" class="count" name="count"
							onkeyup="clearNotInt(this)">条/每日</td>
					</tr>
					<tr>
						<td><em>*</em>有效期：</td>
						<td><input type="text" class="endTime" id="endTime"
							class="tbSearch datechoose" name="endTime"
							onfocus="WdatePicker({minDate:'%y-%M-%d',readOnly:true})"></td>
					</tr>
				</table>
				<div class="tc">
					<input id="add_button" type="button" value="确认添加"
						class="btnEnsure btn" /> <a class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
	</div>

</div>
<script type="text/javascript">
//跳转翻页
function go(url){
	var page = $('#go').val();
	var offset = (page -1)*20;
	if(page == "") {
		return false;
	}
	var arr = new Array();
	arr = url.split("offset=");
	
	if(page*20-20 > arr[1]) {
		alert("超出页码范围！");
		return false;
	}
	if(page<1) {
		alert("超出页码范围！");
		return false;
	}
	url = arr[0]+"offset="+offset;
	window.location.href=url; 
}
/**
 * 只能输入正整数
 */
function clearNotInt(obj){
  obj.value = obj.value.replace(/[^\d]/g,"");
}

$('.sendEmail').click(function(){
	var email = $(this).attr('delivery_email');
	var count = $(this).attr("delivery_count");
	var endTime = $(this).attr("delivery_endTime");
	$("#sendEmail input[name='email']").val(email);
	$("#sendEmail input[name='subject']").val("[Spischolar文献互助]——请求权限变更");
	$("#sendEmail textarea[name='content']").val("您好，您的邮箱 "+email+" 在“Spischolar文献互助”的请求权限已变更为 "+count+" 条/日，有效期至 "+endTime+" 。请您放心使用!<br/><br/>\r\n欢迎您使用Spischolar学术资源在线<br/>\r\n<a href='http://www.spischolar.com/'>http://www.spischolar.com/</a>");
})
$('#sendEmail_button').click(function(){
	
	var param = $("#sendEmail").serialize(); 
	$.ajax({  
    	url : "<cms:getProjectBasePath/>backend/system/powers/delivery/sendEmail",  
    	type : "get",  
    	dataType : "json",
    	data: param,  
    	success : function(data) { 
    		layer.alert(data.message);
    		$('#emailAccount a.btnCancle.btn').click();
    	}
   });
})

$('.school').click(function(){
	var schoolFlag = $(this).attr('schoolFlag');
	var schoolName = $(this).html();
	$("input[name='orgName']").val(schoolName);
	$("input[name='orgFlag']").val(schoolFlag);
})

$('#add_deliveryValidity .email').blur(function() { //失去焦点时触发的事件 
	var email = $("#add_deliveryValidity .email").val();
	$.get('<cms:getProjectBasePath/>backend/system/powers/delivery/findByEmail',{email:email},function(data){
		var rs=eval('('+data.message+')');
		if(rs==undefined || rs=="" || rs==null) {
			$('#add_deliveryValidity span.school').text("请选择");
			$('#add_deliveryValidity .orgName').val('');
			$('#add_deliveryValidity .orgFlag').val('');
		} else {
			$('#add_deliveryValidity p.school[schoolflag='+rs.schoolFlag+']').click();
		}
	}); 
});

$('#update_deliveryValidity .email').blur(function() { //失去焦点时触发的事件 
	var email = $("#update_deliveryValidity .email").val();
	$.get('<cms:getProjectBasePath/>backend/system/powers/delivery/findByEmail',{email:email},function(data){
		var rs=eval('('+data.message+')');
		if(rs==undefined || rs=="" || rs==null) {
			$('#update_deliveryValidity span.school').text("请选择");
			$('#update_deliveryValidity .orgName').val('');
			$('#update_deliveryValidity .orgFlag').val('');
		} else {
			$('#update_deliveryValidity p.school[schoolflag='+rs.schoolFlag+']').click();
		}
	}); 
});
		 
//添加用户
$('#add_button').click(function(){
	var email = $("#add_deliveryValidity .email").val();
	var count = $("#add_deliveryValidity .count").val();
	var endTime = $("#add_deliveryValidity .endTime").val();
	if(email==undefined || email=="" || email==null){  
	     alert("请输入邮箱！");  
	     return false;
	}
	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 if(!em.test(email)) {
		 alert("邮箱格式不正确"); 
		 return false;
	 }
	if(count==undefined || count=="" || count==null){  
	     alert("请输入文献互助数量！");  
	     return false;
	}
	if(endTime==undefined || endTime=="" || endTime==null){  
	     alert("请选择到期时间！");  
	     return false;
	}
	var param = $("#add_deliveryValidity").serialize(); 
	$.ajax({  
    	url : "<cms:getProjectBasePath/>backend/system/powers/delivery/add",  
    	type : "get",  
    	dataType : "json",
    	data: param,  
    	success : function(data) { 
    		layer.alert(data.message,function(){
    				location.reload();
			});
    	}
   });
})

//编辑用户
$('.write').bind("click",function(){
	var id = $(this).attr("value");
	var email = $(this).attr("delivery_email");
	var schoolName = $(this).attr("delivery_schoolName");
	var schoolFlag = $(this).attr("delivery_schoolFlag");
	var count = $(this).attr("delivery_count");
	var endTime = $(this).attr("delivery_endTime");
	$("#updateAccount input[name='id']").val(id);
	$("#updateAccount input[name='email']").val(email);
	$("#updateAccount input[name='orgName']").val(schoolName);
	$("#updateAccount input[name='orgFlag']").val(schoolFlag);
	$("#updateAccount input[name='count']").val(count);
	$("#updateAccount input[name='endTime']").val(endTime);
	$("#updateAccount span.school").html(schoolName);
})
$('#update_button').click(function(){
	var email = $("#update_deliveryValidity .email").val();
	var count = $("#update_deliveryValidity .count").val();
	var endTime = $("#update_deliveryValidity .endTime").val();
	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	 if(!em.test(email)) {
		 alert("邮箱格式不正确"); 
		 return false;
	 }
	if(email==undefined || email=="" || email==null){  
	     alert("请输入邮箱！");  
	     return false;
	}
	if(count==undefined || count=="" || count==null){  
	     alert("请输入文献互助数量！");  
	     return false;
	}
	if(endTime==undefined || endTime=="" || endTime==null){  
	     alert("请选择到期时间！");  
	     return false;
	}
	var param = $("#update_deliveryValidity").serialize();  
	$.ajax({  
    	url : "<cms:getProjectBasePath/>backend/system/powers/delivery/update",  
    	type : "get",  
    	dataType : "json",
    	data: param,  
    	success : function(data) { 
    		layer.alert(data.message,function(){
    				location.reload();
			});
    	}
   });
})
	
	$('.delete').click(function(){
		var id = $(this).attr("value");
		var index=layer.confirm('您确定要删除吗？', {
		    btn: ['确定','取消'] 
		}, function(){
			$.get('<cms:getProjectBasePath/>backend/system/powers/delivery/delete?id='+id,function(data){
				location.reload();
			});
		})
	})
	
	//（关键字查询）
	$('#change_form').submit(function(){
		var val=$('.keyword').val();
		if(val ==''||val==$('.keyword').attr("placeholder")) {
			window.location.href="<cms:getProjectBasePath/>backend/system/powers/delivery"; 
			/* $('.keyword').focus();
			return false; */
		}
	});
	
</script>
</body>
</html>
