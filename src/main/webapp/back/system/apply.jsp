<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>校外访问申请</title>
<jsp:include page="../head.jsp"></jsp:include>

<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
	type="text/javascript"></script>
<div id="content">
	<!-- 左侧栏目：开始 -->
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 33 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 左侧栏目：结束 -->

	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/member/list" class="in">校外访问申请</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar page-topbar clearfix">
					<form action="<cms:getProjectBasePath/>/backend/system/apply"
						id="search_form">
						<!--<div class="common " >-->
						<span class="labt">状态:</span>
						<div class="sc_selbox">
							<i class="inc uv21"></i> <span id="section_lx"> <c:if
									test="${permissions ==0 }">未通过</c:if> <c:if
									test="${permissions ==1 }">已通过</c:if> <c:if
									test="${permissions ==2 }">未审核</c:if> <c:if
									test="${empty permissions }">所有用户</c:if>
							</span>
							<div class="sc_selopt" style="display: none;">
								<p onclick="change('-1')">所有用户</p>
								<p onclick="change('0')">未通过</p>
								<p onclick="change('1')">已通过</p>
								<p onclick="change('2')">未审核</p>
							</div>
							<input type="hidden" id="permission" name="permission"
								value="${permissions }">
						</div>
						<div class="input-w">
							<input type="text" class="tbSearch keyword ie10"
								style="width: 180px; margin-left: 10px" name="key"
								value="${key }" placeholder="请输入用户名/邮箱/姓名/学校" autocomplete="off">
						</div>

						<input class="tbBtn" type="submit" value="查询" autocomplete="off">

						<!--</div>-->
						<label class="data-type"> </label>
					</form>
					<script>
					function change(permission){
						$('#permission').val(permission);
					}
					</script>

					<div class="clear"></div>
				</div>
				<!-- table表格：开始 -->
				<div class="radius">
					<div class="area">
						<table class="data-table" id="divTable">
							<tr>
								<th width="60px"><span>序号</span></th>
								<th><span>用户名</span></th>
								<th><span>邮箱</span></th>
								<!-- <th><span>真实姓名</span></th> -->
								<th><span>学校</span></th>
								<!-- 	<th><span>院系</span></th>
								<th><span>职工号/学号</span></th>
								<th><span>职工/学生证</span></th> -->
								<th><span>申请时间</span></th>
								<th><span>状态</span></th>
								<th><span>权限时长</span></th>
								<th><span>处理时间</span></th>
								<th><span>操作人</span></th>
								<th width="13%"><span>操作</span></th>
							</tr>
							<c:forEach items="${data.rows }" var="m" end="9"
								varStatus="status">
								<tr>
									<td><span>${status.index+1 }</span></td>
									<td><span><a
											href="<cms:getProjectBasePath/>backend/system/apply/photo?id=${m.id }">${m.username }</a></span></td>
									<td><span>${m.email }</span></td>
									<%-- <td><span>${m.nickname }</span></td> --%>
									<td><span>${m.school }</span></td>
									<%-- <td><span>${m.department } </span></td>
								<td><span>${m.studentId }</span></td>
								<c:if test="${not empty m.identification }">
									<td><span><a href="<cms:getProjectBasePath/>backend/system/apply/photo?id=${m.id }">查看图片</a></span></td>
								</c:if>
								<c:if test="${empty m.identification }">
									<td><span></span></td>
								</c:if> --%>
									<td><span><fmt:formatDate value="${m.applyTime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
									<td><span> <c:if
												test="${m.permission ==1 || m.permission ==3 || m.permission ==4}">通过</c:if>
											<c:if test="${m.permission ==0 }">未通过</c:if> <c:if
												test="${m.permission ==2 }">未审核</c:if>
									</span></td>
									<td><span> <c:if
												test="${m.permission ==1 || m.permission ==3}">长期</c:if> <c:if
												test="${m.permission ==4 }">6个月</c:if>
									</span></td>
									<td><span><fmt:formatDate value="${m.handleTime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
									<td><span>${m.handlePeople }</span></td>
									<td><span> <c:if test="${m.permission ==2 }">
												<%-- <a class="cd00 thickBtn" onclick="apply('${m.id }','3','','')" value="${m.id }" apply="3" href="#">通过</a> --%>
												<a class="cd00 apply thickBtn" email="${m.email }"
													username="${m.username }" value="${m.id }" href="#"
													data-thickcon="applyDiv">通过</a>
												<a class="cd00 notApply thickBtn" email="${m.email }"
													username="${m.username }" value="${m.id }" href="#"
													data-thickcon="notApplyDiv">不通过</a>
											</c:if>
									</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<!-- 分页页码：开始 -->
				<div class="page" id="page">
					<a class="a1">${data.total}条</a>
					<pg:pager items="${data.total}" url="" export="cp=pageNumber"
						maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="permission" />
						<pg:param name="key" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<pg:page>
							<c:if test="${data.total/10 gt 5 and (cp gt 3)}">
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
							<c:if test="${data.total/10 gt 5 and (data.total/10 gt (cp+2))}">
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
				<!-- 分页页码：结束 -->
			</div>
		</div>
	</div>
</div>
<div class="tickbox">
	<div class="export applyDiv" id="applyDiv" data-tit="校外访问申请通过">
		<form method="get" id="apply">
			<input type="hidden" name="id"> <select name="permission"
				id="permissionChange">
				<option value="3">长期</option>
				<option value="4">6个月</option>
			</select>
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
					<td><textarea rows="10" cols="55" name="content"></textarea></td>
				</tr>

			</table>
			<div class="tc">
				<input id="apply_button" onclick="apply()" type="button" value="确认"
					class="btnEnsure btn apply" /> <a class="btnCancle btn">取消</a>
			</div>
		</form>
	</div>
</div>
<div class="tickbox">
	<div class="export notApplyDiv" id="notApplyDiv" data-tit="校外访问申请不通过">
		<form method="get" id="notApply">
			<input type="hidden" name="id"> <input type="hidden"
				name="permission">
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
					<td><textarea rows="10" cols="55" name="content"></textarea></td>
				</tr>

			</table>
			<div class="tc">
				<input id="notApply_button" onclick="notApply()" type="button"
					value="确认" class="btnEnsure btn apply" /> <a class="btnCancle btn">取消</a>
			</div>
		</form>
	</div>
</div>
<jsp:include page="../foot.jsp"></jsp:include>
<script>
		$('.apply').click(function(){
			var email = $(this).attr('email');
			var id = $(this).attr('value');
			$("#apply input[name='id']").val(id);
			$("#apply input[name='email']").val(email);
			$("#apply input[name='subject']").val("[Spischolar校外登录申请]—审核通过");
			$("#apply textarea[name='content']").val("您好！欢迎您注册成为Spischolar学术资源在线用户！<br/>\r\n您提交的校外访问申请已经审核通过，并已获得长期校外访问权限！<br/>\r\n请注意保护您的账户安全。<br/><br/>\r\n\r\n欢迎您使用Spischolar学术资源在线<br/>\r\nhttp://www.spischolar.com/");
		})
		function apply(){
			var id = $("#apply input[name=id]").val();
			var email = $("#apply input[name=email]").val();
			var permission = $("#apply select[name=permission]").val();
			var subject = $("#apply input[name=subject]").val();
			var content = $("#apply textarea[name=content]").val();
			applys(id,email,permission,subject,content);
		}
		$('#permissionChange').change(function(){
			var permission = $(this).val();
			if(permission == 3) {
				$("#apply textarea[name='content']").val("您好！欢迎您注册成为Spischolar学术资源在线用户！<br/>\r\n您提交的校外访问申请已经审核通过，并已获得长期校外访问权限！<br/>\r\n请注意保护您的账户安全。<br/><br/>\r\n\r\n欢迎您使用Spischolar学术资源在线<br/>\r\nhttp://www.spischolar.com/");
			} else {
				$("#apply textarea[name='content']").val("您好！欢迎您注册成为Spischolar学术资源在线用户！<br/>\r\n由于您提交的照片不符合要求，暂能获得6个月校外访问权限。<br/>\r\n建议您在Spischolar学术资源在线系统中继续提交您的真实职工/学生证照片，以获得长期校外访问权限。请注意保护您的账户安全。<br/><br/>\r\n\r\n欢迎您使用Spischolar学术资源在线<br/>\r\nhttp://www.spischolar.com/");
			}
		})
		
		$('.notApply').click(function(){
			var email = $(this).attr('email');
			var username = $(this).attr('username');
			var id = $(this).attr('value');
			$("#notApply input[name='id']").val(id);
			$("#notApply input[name='permission']").val(0);
			$("#notApply input[name='email']").val(email);
			$("#notApply input[name='subject']").val("[Spischolar校外登录申请]—审核未通过");
			$("#notApply textarea[name='content']").val("您好，由于您的账号（邮箱： "+email+"；用户名： "+username+" ）在“Spischolar校外登录申请”中提交的信息不全，校外访问申请审核未通过，请补全您的真实信息后重新提交。<br/><br/>\r\n\r\n欢迎您使用Spischolar学术资源在线<br/>\r\nhttp://www.spischolar.com/ ");
		})
		function notApply(){
			var id = $("#notApply input[name=id]").val();
            var email = $("#apply input[name=email]").val();
			var permission = $("#notApply input[name=permission]").val();
			var subject = $("#notApply input[name=subject]").val();
			var content = $("#notApply textarea[name=content]").val();
			applys(id,email,permission,subject,content);
		}
		function applys(id,email,permission,subject,content) {
			//$.get('<cms:getProjectBasePath/>backend/member/list/apply?id='+id+'&permission='+permission+'&subject='+subject+'&content='+content,function(data){
			//$.get('<cms:getProjectBasePath/>backend/system/list/apply?id='+id+'&permission='+permission+'&subject='+subject+'&content='+content,function(data){
			$.post("<cms:getProjectBasePath/>backend/member/list/apply",
				{
				    id:id,
					email:email,
					permission:permission,
					subject:subject,
					content:content
				},
				function(data){
					layer.alert(data.message,function(){
    				location.reload();
				});
			});
		}
		
	</script>
<script type="text/javascript">
	/**
	 * 只能输入正整数
	 */
	function clearNotInt(obj){
	  obj.value = obj.value.replace(/[^\d]/g,"");
	}
	//跳转翻页
	function go(url){
		var page = $('#go').val();
		var offset = (page -1)*10;
		if(page == "") {
			return false;
		}
		var arr = new Array();
		arr = url.split("offset=");
		
		if(page*10-10 > arr[1]) {
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
	
	
       var err = '${error}';
       if(err!='') {
      	 alert(err); 
       }
       var addUsers = '${addUsers}';
       if(addUsers!='') {
         	 alert(addUsers); 
       }
       <%
       session.removeAttribute("addUsers"); 
       %>
    </script>
</div>
</body>
</html>
