<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>用户管理</title>
<jsp:include page="../head.jsp"></jsp:include>

<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
	type="text/javascript"></script>
<div id="content">
	<!-- 左侧栏目：开始 -->
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 21 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<!-- 左侧栏目：结束 -->

	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/member/list" class="in">用户管理</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form action="<cms:getProjectBasePath/>/backend/member/list/school"
						id="search_form">
						<label class="common" style="float: right"> <input
							type="text" class="tbSearch keyword ie10" name="key"
							value="${key }" placeholder="请输入用户名、邮箱、用户类型" autocomplete="off">
							<c:if test="${not empty schoolFlag }">
								<input type="hidden" name="schoolFlag" value="${schoolFlag }">
							</c:if> <c:if test="${empty schoolFlag }">
								<input type="hidden" name="schoolFlag" value="all">
							</c:if> <input class="tbBtn" type="submit" value="查询" autocomplete="off">
						</label>
					</form>
					<script>
					$('#search_form').submit(function(){
						var val=$('.keyword').val();
						if(val ==''||val==$('.keyword').attr("placeholder")) {
							$('.keyword').focus();
							return false;
						}
					});	
					</script>

					<!-- 学校下拉框：开始 -->
					<c:if test="${org.flag == 'wdkj' }">
						<label class="data-type">
							<div class="sc_selbox">
								<i class="inc uv21"></i>
								<c:forEach items="${orgList }" var="org" varStatus="status">
									<c:if test="${org.flag == schoolFlag }">
										<span id="section_lx">${org.name }</span>
										<input type="hidden" id="schoolId" name="schoolId"
											value="${org.id }">
									</c:if>
								</c:forEach>
								<c:if test="${schoolFlag == null }">
									<span id="section_lx">全部学校</span>
									<input type="hidden" id="schoolId" name="schoolId" value="60">
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p class="school" schoolFlag="all" schoolId="">全部学校</p>
									<c:forEach items="${orgList }" var="org" varStatus="status">
										<p class="school" schoolFlag="${org.flag }"
											schoolId="${org.id }">${org.name }</p>
									</c:forEach>
								</div>
								<input type="hidden" id="schoolFlag" name="schoolFlag"
									value="${schoolFlag }">
							</div>
						</label>
					</c:if>
					<c:if test="${org.flag != 'wdkj' }">
						<input type="hidden" id="schoolId" name="schoolId"
							value="${org.id }">
						<input type="hidden" id="schoolFlag" name="schoolFlag"
							value="${org.flag }">
					</c:if>
					<!-- 学校下拉框：结束 -->
					<!-- 学院下拉框：开始 -->
					<label>
						<div class="sc_selbox sc_selbox_col">
							<i class="inc uv21"></i>
							<c:if test="${empty department }">
								<span id="section_lx">全部学院</span>
							</c:if>
							<c:if test="${!empty department }">
								<span id="section_lx">${department }</span>
							</c:if>
							<div class="sc_selopt" id="departments" style="display: none;">
							</div>
							<input type="hidden" id="department" name="department"
								value="${department }">
						</div>
					</label>
					<!-- 学院下拉框：结束 -->
					<!-- 学校学院切开js代码：开始 -->
					<script type="text/javascript">
					//加载学院信息
						$(document).ready(function(){ 
							var schoolId = $('#schoolId').val();
							$.get('<cms:getProjectBasePath/>backend/member/list/findDepBySchool?schoolId='+schoolId,function(data){
								data = eval("("+data.message+")");
								$("#departments").empty();
								/*添加搜索框*/
								$("#departments").prepend('<div class="input-sd"><input class="se-val" type="text" value="" style="width:96%"/></div>');
									
								var jsAr = new Array();
								jsAr.push("<p <p class='school' onclick='department(\"\")'>全部学院</p>");
								for(var i=0; i<data.length;i++) {
									jsAr.push("<p class='school' onclick='department(\""+data[i].departmentName+"\")'>"+data[i].departmentName+"</p>");
								}
								$("#departments").append(jsAr);
								//添加用户时的学院信息
								$("#addDepartments").empty();
								var jsAr = new Array();
								for(var i=0; i<data.length;i++) {
									jsAr.push("<p onclick='addDepartmentName(\""+data[i].departmentName+"\")'>"+data[i].departmentName+"</p>");
								}
								$("#addDepartments").append(jsAr);
								//修改用户信息时的学院信息
								$("#updateDepartments").empty();

                                /*添加搜索框*/
                                $("#updateDepartments").prepend('<div class="input-sd"><input class="se-val" type="text" value="" style="width:96%"/></div>');
								
								var jsAr = new Array();
								for(var i=0; i<data.length;i++) {
									jsAr.push("<p onclick='updateDepartmentName(\""+data[i].departmentName+"\")'>"+data[i].departmentName+"</p>");
								}
								$("#updateDepartments").append(jsAr);
								if(!$(".sc_selbox_col").find(".chosen-search").length){
									var eleS=getByClass("sc_selbox_col","div");
									/*_select(eleS[0]);*/
								}
								if(!$(".sc_selbox_col1").find(".chosen-search").length){
									var eleS=getByClass("sc_selbox_col1","div");
									/*_select(eleS[0]);*/
								}
								if(!$(".sc_selbox_col2").find(".chosen-search").length){
									var eleS=getByClass("sc_selbox_col2","div");
									/*_select(eleS[0]);*/
								}
								
							});
						});
						//切换学校
						$('.school').click(function(){
							var schoolFlag = $(this).attr('schoolFlag');
							window.location.href = '<cms:getProjectBasePath/>backend/member/list/school?schoolFlag=' +schoolFlag;
						});
						//根据学院查询用户
						function department(department) {
							var schoolFlag = $('#schoolFlag').val();
							window.location.href = '<cms:getProjectBasePath/>backend/member/list/school?department='+department+'&schoolFlag='+schoolFlag;
						}
						
					</script>
					<!-- 学校学院切开js代码：结束 -->
					<span class="thickBtn addschool" data-thickcon="addAccount">
						<i></i> 添加
					</span>
					<!-- 上传文档，注册多个用户：开始 -->
					<c:if test="${org.flag == 'wdkj' }">
						<span class="uploadfile modify" style="margin-left: 10px"><i></i>上传</span>
						<form id="postForm"
							action="<cms:getProjectBasePath/>backend/member/list/addUsers"
							enctype="multipart/form-data" method="post">
							<input style="display: none;" onchange="submit()" type="file"
								id="up-filebox" name="file" class="uploadfile" />
						</form>
					</c:if>
					<!-- 上传文档，注册多个用户：结束 -->

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
								<th><span
									<c:if test="${order == 11}">class="down" onclick="order('12')"</c:if>
									<c:if test="${order == 12}">class="up" onclick="order('11')"</c:if>
									onclick="order('12')">注册时间</span></th>
								<c:if test="${org.flag == 'wdkj' }">
									<th><span>注册IP</span></th>
								</c:if>
								<th><span>用户类型</span></th>
								<c:if test="${org.flag == 'wdkj' }">
									<th width="200px"><span>操作</span></th>
									<th><span
										<c:if test="${order == 21}">class="down" onclick="order('22')"</c:if>
										<c:if test="${order == 22}">class="up" onclick="order('21')"</c:if>
										onclick="order('22')">登录次数</span></th>
								</c:if>
								<th><span
									<c:if test="${order == 31}">class="down" onclick="order('32')"</c:if>
									<c:if test="${order == 32}">class="up" onclick="order('31')"</c:if>
									onclick="order('32')">在线状态</span></th>

							</tr>
							<c:forEach items="${data.rows }" var="m" end="9"
								varStatus="status">
								<tr>
									<td><span>${status.index+1 }</span></td>
									<td><span>${m.username }</span></td>
									<td><span>${m.email }</span></td>
									<td><span><fmt:formatDate
												value="${m.registerTime }" pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
									<c:if test="${org.flag == 'wdkj' }">
										<td><span>${m.registerIp } </span></td>
									</c:if>
									<c:if test="${m.userType ==0 }">
										<td><span>终端用户</span></td>
									</c:if>
									<c:if test="${m.userType ==1 }">
										<td><span>管理员</span></td>
									</c:if>
									<c:if test="${org.flag == 'wdkj' }">
										<td><span> <span class="cd00 write thickBtn"
												value="${m.id }" data-thickcon="updateAccount">编辑</span> <c:if
													test="${m.forbidden == 1 }">
													<a href="#" class="cd00 forbidden sm-Btn" value="${m.id }"
														type="2">禁用</a>
												</c:if> <c:if test="${m.forbidden == 2 }">
													<a href="#" class="cd00 forbidden sm-Btn" value="${m.id }"
														type="1">还原</a>
												</c:if> <a href="#" value="${m.id }" class="cd00 delete sm-Btn">删除</a>
										</span></td>
										<td><span>${m.loginCount }</span></td>
									</c:if>
									<td><span> <c:if test="${m.isOnline ==1 }">在线</c:if>
											<c:if test="${m.isOnline ==0 }">离线</c:if>
									</span></td>

								</tr>
							</c:forEach>
							<script>
								/**
								*上传
								*/
								$('.modify').click(function(){
									$('#up-filebox').trigger('click');
								});
								function submits() {
								//	$('#postForm').submit();
								var formData = new FormData($( "#postForm" )[0]);
								//var formData = document.getElementById("up-filebox").files[0];
									$.ajax({
										   type: "POST",
										   url: "<cms:getProjectBasePath/>backend/member/list/addUsers",
										   data:  formData,
										   async: false,  
									       cache: false,  
									       contentType: false,  
									       processData: false,
										   success: function(msg){
											   layer.alert(msg.message,function(){
												   location.reload();
												})
										   }
									});
								}
								/**排序*/
								function order(type) {
									order = type;
									var url = "?order=" + order;
									var schoolFlag = $('#schoolFlag').val();
									var department = $('#department').val();
									url = url + "&schoolFlag="+schoolFlag;
									if(department != "") {
										url = url + "&department="+department;
									}
									window.location.href = '<cms:getProjectBasePath/>backend/member/list/school' + url;
								}
								//删除用户
								$('.delete').click(function(){
									var that=$(this)
									var index=layer.confirm('你确定要删除此用户吗？', {
									    btn: ['确定','取消'] 
									}, function(){
										var id = that.attr("value");
										$.get('<cms:getProjectBasePath/>backend/member/list/deleteUser?id='+id,function(data){
											location.reload();
										});
										layer.close(index);
									}, function(){
										layer.close(index);
									    return false;
									});
								});
								/**禁用*/
								$('.forbidden').click(function(){
									var that=$(this);
									var id = $(this).attr("value");
									var type = $(this).attr("type");
									var message="";
									if(type == 2) {
										message = '你确定要禁用此账户吗？';
									} else {
										message = '你确定要还原此账户吗？';
									}
									var index=layer.confirm(message, {
									    btn: ['确定','取消'] 
									}, function(){
										$.get('<cms:getProjectBasePath/>backend/member/list/forbidden?id='+id+'&type='+type,function(data){
											location.reload();
										});
									},function(){
										layer.close(index)
									})
								});
							/* 	//验证校外登录
								$('.apply').click(function(){
									var id = $(this).attr("value");
									$.get('<cms:getProjectBasePath/>backend/member/list/apply?id='+id,function(data){
										location.reload();
									});
								}) */
								//编辑用户
								$('.write').bind("click",function(){
									var id = $(this).attr("value");

									$.get('<cms:getProjectBasePath/>backend/member/list/getById?id='+id,function(data){
										data = eval("("+data.message+")");
										$('.item-tips').html("");
										$('#updateId').val(data.id);
										$('#updateEmail').text(data.email);
										$('#updateUsername').text(data.username);
										$('#updateEmailInput').val(data.email);
										$('#updateUsernameInput').val(data.username);
									//	$('#updatePwd').val(data.pwd);
										$('#updateNickname').val(data.nickname);
										$('#updateStudentId').val(data.studentId);
										if(data.permission == 1) {
											$('#updatePermission').attr("checked",true);
										}
									//	var school = $('a[schoolflag='+data.schoolFlag+']').html();
									//	alert(school);
									//	$('span[data_type=school]').html(school);
										$('span[data_type=UpdateSchool]').html(data.school);
										$('#updateSchool').val(data.school);
										$('#updateSchoolFlag').val(data.schoolFlag);
										
										$('span[data_type=updateDepartment]').html(data.department);
										$('#updateDepartment').val(data.department);
										
										var identity = $('p[class=updateIdentity][value='+data.identity+']').html();
										$('span[data_type=updateIdentity]').html(identity);
										$('#updateIdentity').val(data.identity);
										
										if(data.identity == 1) {
											$('.updateEntranceTime').show();
											$('#updateEntranceTime').val(data.entranceTime);
										}
										
										var education = $('p[class=updateEducation][value='+data.education+']').html();
										$('span[data_type=updateEducation]').html(education);
										$('#updateEducation').val(data.education);
										
										var userType = $('p[class=updateUserType][value='+data.userType+']').html();
										$('span[data_type=updateUserType]').html(userType);
										$('#updateUserType').val(data.userType);
										
										$('input[name=sex][value='+data.sex+']').attr("checked",'checked');
									})
								})
								//添加用户时先清空input
								$('.addschool').click(function(){
									$('#profile_home')[0].reset();
									$('#addSchoolFlag').val("");
									$('#addDepartment').val("");
									$('#identity').val("");
									$('#education').val("");
									$('.section_lx').html("请选择");
									$('.item-tip').html("");
								})
							</script>
						</table>
					</div>
				</div>
				<!-- 分页页码：开始 -->
				<div class="page" id="page">
					<a class="a1">${data.total}条</a>
					<pg:pager items="${data.total}" url="" export="cp=pageNumber"
						maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="order" />
						<pg:param name="key" />
						<pg:param name="schoolFlag" />
						<pg:param name="department" />
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
				<!-- 添加用户：开始 -->
				<div class="tickbox">
					<div id="addAccount" class="export addAccount addAccountBox"
						data-tit="添加用户">
						<form action="" method="post" id="profile_home">
							<ul>
								<li><label class="data-type"> <span class="labt"><em>*</em>登录邮箱：</span>
										<input type="text" id="email" name="email" class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>用户名：</span>
										<input type="text" id="username" name="username" class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>密码：</span>
										<input type="password" id="pwd" name="pwd" class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">真实姓名：</span>
										<input type="text" name="nickname" id="nickname" class="text">
								</label> <span class="item-tip"></span></li>
								<c:if test="${org.flag == 'wdkj' }">
									<li><label class="data-type"> <span class="labt">选择学校：</span>
											<div class="sc_selbox" style="*z-index: 999">
												<i class="inc uv21"></i> <span id="section_lx"
													data_type="school" class="section_lx">请选择</span>
												<div class="sc_selopt" style="display: none;">
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<p class="school addSchools" schoolFlag="${org.flag }"
															schoolId="${org.id }">${org.name }</p>
													</c:forEach>
												</div>
												<input type="hidden" name="school" id="addSchool" value="">
												<input type="hidden" name="schoolFlag" id="addSchoolFlag"
													value="">
											</div>
									</label> <span class="item-tip"></span></li>
								</c:if>
								<c:if test="${org.flag != 'wdkj' }">
									<input type="hidden" name="school" id="addSchools"
										value="${org.name }">
									<input type="hidden" name="schoolFlag" id="addSchoolFlags"
										value="${org.flag }">
								</c:if>
								<li><label class="data-type"> <span class="labt">院系：</span>
										<div class="sc_selbox sc_selbox_col1" style="*z-index: 998">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="department" class="section_lx">请选择</span>
											<div class="sc_selopt" id="addDepartments"
												style="display: none;"></div>
											<input type="hidden" id="addDepartment" name="department"
												value=""> <input type="hidden" id="addDepartmentId"
												name="departmentId" value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">身份类别：</span>
										<div class="sc_selbox" style="*z-index: 997">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="identity" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="2" class="identity">老师</p>
												<p value="1" class="identity">学生</p>
												<p value="3" class="identity">其他</p>
											</div>
											<input type="hidden" value="" name="identity" id="identity" />

										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">职工号/学号：</span>
										<input type="text" id="studentId" name="studentId"
										class="text">
								</label> <span class="item-tip"></span></li>
								<li class="studentTime" style="display: none;"><label
									class="data-type"> <span class="labt">入学年份：</span> <input
										type="text" name="entranceTime" id="entranceTime" class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">学历：</span>
										<div class="sc_selbox" style="*z-index: 996">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="education" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="4" class="education">
													博士</a>
												<p value="3" class="education">
													硕士</a>
												<p value="2" class="education">
													本科</a>
												<p value="1" class="education">
													大专</a>
												<p value="5" class="education">
													其他</a>
											</div>
											<input type="hidden" id="education" name="education" value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>用户类型：</span>
										<div class="sc_selbox" style="*z-index: 995">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="userType" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="0" class="userType">
													终端用户</a>
												<p value="1" class="userType">
													管理员</a>
											</div>
											<input type="hidden" id="userType" name="userType" value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">性别：</span>
										<div class="genderbox">
											<input name="sex" type="radio" value="1" checked="checked" />男
											<input name="sex" type="radio" value="2" />女
										</div>
								</label> <span class="item-tip"></span></li>
								<li style="margin-top: -10px;">
									<div class="single-data">
										<input type="checkbox" name="permission" value="1"
											style="vertical-align: middle; margin-top: -3px" /> 允许校外登录
									</div>
								</li>
							</ul>
							<script type="text/javascript">
							/**添加用户：切换学校*/
							$('.addSchools').click(function(){
								var that=$(this);												
								var schoolId = $(this).attr('schoolId');
								var schoolFlag = $(this).attr('schoolFlag');
								var school=$(this).html();
								$('#addSchool').val(school);
								$('#addSchoolFlag').val(schoolFlag);
								$('#addDepartment').val("");
								$.get('<cms:getProjectBasePath/>backend/member/list/findDepBySchool?schoolId='+schoolId,function(data){
									data = eval("("+data.message+")");
									$("#addDepartments").empty();

									/*添加搜索框*/
									$("#addDepartments").prepend('<div class="input-sd"><input class="se-val" type="text" value="" style="width:96%"/></div>');
									
									var jsAr = new Array();
									for(var i=0; i<data.length;i++) {
										jsAr.push("<p onclick='addDepartmentName(\""+data[i].departmentName+"\",\""+data[i].departmentId+"\")'>"+data[i].departmentName+"</p>");
									}
									
									
									//console.log(that.parents("div.thickbody").find(".sc_selbox").eq(1))
									
									$("#addDepartments").append(jsAr);
									
									if(!$(".sc_selbox_col1").find(".chosen-search").length){
										var eleS=getByClass("sc_selbox_col1","div");
										_select(eleS[0]);
									}
									/* _select(that.parents("div.thickbody").find(".sc_selbox").eq(1)[0]) */
								});
							});
							/**添加用户：切换学院*/
							function addDepartmentName(department,id) {
								$('#addDepartment').val(department);
								$('#addDepartmentId').val(id);
							}
							/**添加用户：切换身份*/
							$('.identity').click(function(){
								var val = $(this).attr("value");
								$('input[name="identity"]').val(val);
                            	if(val == 1) {
                            		$(".studentTime").show();
                            	} else {
                            		$(".studentTime").hide();
                            	} 
							});
							/**添加用户：切换学历*/
							$('.education').click(function(){
								var val = $(this).attr("value");
								$('#education').val(val);
                    		});
							/**添加用户：切换用户类型*/
							$('.userType').click(function(){
								var val = $(this).attr("value");
								$('#userType').val(val);
								if(val == 1) {
									$('#permission').attr('checked',true);
								} else {
									$('#permission').attr('checked',false);
								}
                    		})
							</script>
							<div class="tc" style="margin-right: -2px;">
								<input type="submit" value="确认添加" class="btnEnsure btn" /> <a
									href="" class="btnCancle btn">取消</a>
							</div>
						</form>
					</div>
				</div>
				<!-- 添加用户：结束 -->
				<!------------------------ 编辑用户：开始 --------------------->
				<div class="tickbox 000000">
					<div id="updateAccount" class="export addAccount edAccount-warp"
						data-tit="用户编辑">
						<form action="" method="post" id="update_profile_home">
							<input type="hidden" name="id" id="updateId" value="">
							<ul>
								<li><label class="data-type"> <span class="labt"><em>*</em>登录邮箱：</span>
										<span class="labt" id="updateEmail" style="text-align: left"></span>
										<input type="hidden" id="updateEmailInput" name="email"
										class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>用户名：</span>
										<span class="labt" id="updateUsername"
										style="text-align: left"></span> <input type="hidden"
										id="updateUsernameInput" name="username" class="text">
								</label> <span class="item-tip" id="updateUsernames"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>密码：</span>
										<input type="password" id="updatePwd" name="pwd" class="text"
										value="      ">
								</label> <span class="item-tip"></span></li>

								<li><label class="data-type"> <span class="labt">真实姓名：</span>
										<input type="text" name="nickname" id="updateNickname"
										class="text" value="null">
								</label> <span class="item-tip"></span></li>
								<c:if test="${org.flag == 'wdkj' }">
									<li><label class="data-type"> <span class="labt">选择学校：</span>
											<div class="sc_selbox" style="*z-index: 999">
												<i class="inc uv21"></i> <span id="section_lx"
													data_type="UpdateSchool" class="section_lx">请选择</span>
												<div class="sc_selopt" style="display: none;">
													<c:forEach items="${orgList }" var="org" varStatus="status">
														<p class="school updateSchools" schoolFlag="${org.flag }"
															schoolId="${org.id }">${org.name }</p>
													</c:forEach>
												</div>
												<input type="hidden" name="school" id="updateSchool"
													value=""> <input type="hidden" name="schoolFlag"
													id="updateSchoolFlag" value="">
											</div>
									</label> <span class="item-tip"></span></li>
								</c:if>
								<c:if test="${org.flag != 'wdkj' }">
									<input type="hidden" name="school" id="updateSchool"
										value="${org.name }">
									<input type="hidden" name="schoolFlag" id="updateSchoolFlag"
										value="${org.flag }">
								</c:if>
								<li><label class="data-type"> <span class="labt">院系：</span>
										<div class="sc_selbox sc_selbox_col2" style="*z-index: 998">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="updateDepartment" class="section_lx">请选择</span>
											<div class="sc_selopt" id="updateDepartments"
												style="display: none;"></div>
											<input type="hidden" id="updateDepartment" name="department"
												value=""> <input type="hidden"
												id="updateDepartmentId" name="departmentId" value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">身份类别：</span>
										<div class="sc_selbox" style="*z-index: 997">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="updateIdentity" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="2" class="updateIdentity">老师</p>
												<p value="1" class="updateIdentity">学生</p>
												<p value="3" class="updateIdentity">其他</p>
											</div>
											<input type="hidden" value="" name="identity"
												id="updateIdentity" />
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">职工号/学号：</span>
										<input type="text" id="updateStudentId" name="studentId"
										class="text">
								</label> <span class="item-tip"></span></li>
								<li class="updateEntranceTime" style="display: none;"><label
									class="data-type"> <span class="labt">入学年份：</span> <input
										type="text" name="entranceTime" id="updateEntranceTime"
										class="text">
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">学历：</span>
										<div class="sc_selbox" style="*z-index: 996">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="updateEducation" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="4" class="updateEducation">
													博士</a>
												<p value="3" class="updateEducation">
													硕士</a>
												<p value="2" class="updateEducation">
													本科</a>
												<p value="1" class="updateEducation">
													大专</a>
												<p value="5" class="updateEducation">
													其他</a>
											</div>
											<input type="hidden" id="updateEducation" name="education"
												value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt"><em>*</em>用户类型：</span>
										<div class="sc_selbox " style="*z-index: 995">
											<i class="inc uv21"></i> <span id="section_lx"
												data_type="updateUserType" class="section_lx">请选择</span>
											<div class="sc_selopt" style="display: none;">
												<p value="0" class="updateUserType">
													终端用户</a>
												<p value="1" class="updateUserType">
													管理员</a>
											</div>
											<input type="hidden" id="updateUserType" name="userType"
												value="">
										</div>
								</label> <span class="item-tip"></span></li>
								<li><label class="data-type"> <span class="labt">性别：</span>
										<div class="genderbox">
											<input name="sex" type="radio" value="1" checked="checked">男
											<input name="sex" type="radio" value="2">女
										</div>
								</label> <span class="item-tip"></span></li>
								<li style="margin-top: -10px;">
									<div class="single-data">
										<input type="checkbox" id="updatePermission" name="permission"
											value="1" style="vertical-align: middle; margin-top: -3px" />
										允许校外登录
									</div>
								</li>
							</ul>
							<script type="text/javascript">
							/**编辑用户：切换学校*/
							$('.updateSchools').click(function(){
								var schoolId = $(this).attr('schoolId');
								var schoolFlag = $(this).attr('schoolFlag');
								var school=$(this).html();
								var that=$(this);
								$('#updateSchool').val(school);
								$('#updateSchoolFlag').val(schoolFlag);
								$('#updateDepartment').val("");
								$('#updateDepartmentId').val("");
								$.get('<cms:getProjectBasePath/>backend/member/list/findDepBySchool?schoolId='+schoolId,function(data){
									data = eval("("+data.message+")");
									$("#updateDepartments").empty();
									var jsAr = new Array();
									for(var i=0; i<data.length;i++) {
										jsAr.push("<p class='school' onclick='updateDepartmentName(\""+data[i].departmentName+"\",\""+data[i].departmentId+"\")'>"+data[i].departmentName+"</p>");
									}
									$("#updateDepartments").append(jsAr);
									if(!$(".sc_selbox_col2").find(".chosen-search").length){
										var eleS=getByClass("sc_selbox_col2","div");
										/*_select(eleS[0]);*/
									}
									/* _select(that.parents("div.thickbody").find(".sc_selbox").eq(1)[0]) */
								});
							});
							/**编辑用户：切换学院*/
							function updateDepartmentName(department,id) {
								$('#updateDepartment').val(department);
								$('#updateDepartmentId').val(id);
							}
							/**编辑用户：切换身份*/
							$('.updateIdentity').click(function(){
								var val = $(this).attr("value");
								$('#updateIdentity').val(val);
                            	if(val == 1) {
                            		$(".updateEntranceTime").show();
                            	} else {
                            		$("#updateEntranceTime").val("");
                            		$(".updateEntranceTime").hide();
                            	} 
							});
							/**编辑用户：切换学历*/
							$('.updateEducation').click(function(){
								var val = $(this).attr("value");
								$('#updateEducation').val(val);
                    		});
							/**编辑用户：切换用户身份*/
							$('.updateUserType').click(function(){
								var val = $(this).attr("value");
								$('#updateUserType').val(val);
								if(val == 1) {
									$('#updatePermission').attr('checked',true);
								} else {
									$('#updatePermission').attr('checked',false);
								}
                    		})
							</script>
							<div class="tc" style="margin-right: -2px;">
								<input type="submit" value="保存" class="btnEnsure btn" /> <a
									href="" class="btnCancle btn">取消</a>
							</div>
						</form>
					</div>
					<!-- 编辑用户：结束 -->
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
	var addUserFlag = true;
            $(function(){
            	$.validator.setDefaults({ ignore: '' });
            	//表单验证
            	$('#profile_home').validate({
                    submitHandler:function(form){
                     var param = $("#profile_home").serialize();
	                     if(addUserFlag) {  //防止因为网速问题的多次注册
	                        $.ajax({  
	                        	url : "<cms:getProjectBasePath/>backend/member/list/addUser",  
	                        	type : "post",  
	                        	dataType : "json",
	                        	data: param,  
	                        	success : function(data) { 
	                        		layer.alert(data.message,function(){
	                        				location.reload();
									});
	                        	}
	                       });
	                        addUserFlag = false;
	                    }
                    },
                    errorPlacement:function(error, element){
                        var next=element.parents().siblings(".item-tip");
                           next.html(error.html());
                    },
                    success:function(element,label){
                    },
                    rules:{
                    	email:{
        					required:true,
        					email:true,
        					remote: {
        					    url: "<cms:getProjectBasePath/>user/checkEmail",     //后台处理程序
        					    type: "get",               //数据发送方式
        					    dataType: "json",           //接受数据格式   
        					    data: {                     //要传递的数据
        					        email: function() {
        					            return $("#email").val();
        					        }
        					    }
        					}
        				},
        				username:{
        					required:true,
        					rangelength:[6,15],
        					remote: {
        					    url: "<cms:getProjectBasePath/>user/checkUsername",     //后台处理程序
        					    type: "get",               //数据发送方式
        					    dataType: "json",           //接受数据格式   
        					    data: {                     //要传递的数据
        					    	username: function() {
        					            return $("#username").val();
        					        }
        					    }
        					}
        				},
        				pwd:{
        					required:true,
        					rangelength:[6,15]
        				},/**
                        nickname:{
                            required:true,
                        },
                        schoolFlag:{
                        	required:true,
                        },
                        department:{
                        	required:true,
                        },
                        identity:{
                        	required:true,
                        },
                        studentId:{
                        	required:true,
                        },
                        education:{
                        	required:true,
                        },*/
                        userType:{
                        	required:true
                        }
                    },
                    messages:{
                    	email:{
        					required:'请输入您的邮箱!',
        					email:'邮箱格式不能使用!',
        					remote:'该邮箱已注册，如<a href="<cms:getProjectBasePath/>/backend/member/list/findPwd" class="red">忘记密码</a>点此找回'
        				},
        				username:{
        					required:'长度为6-15个字符，不允许重名！',
        					rangelength:'长度为6-15个字符，不允许重名！',
        					remote:'长度为6-15个字符，不允许重名！'
        				},
        				pwd:{
        					required:'由任意6-15个字符组成，注意区分大小写!',
        					rangelength:'由任意6-15个字符组成'
        				},
                        userType:{
                        	required:'请选择用户类型!'
                        }
                        
                    }
            	});
            });
    /**修改编辑：------------------------------------------*/
            $(function(){
            	$.validator.setDefaults({ ignore: '' });
            	//表单验证
            	$('#update_profile_home').validate({
                    submitHandler:function(form){
                    //    $(form).Submit();
                     var param = $("#update_profile_home").serialize();  
                        $.ajax({  
                        	url : "<cms:getProjectBasePath/>backend/member/list/updateUser",  
                        	type : "post",  
                        	dataType : "json",  
                        	data: param,  
                        	success : function(data) { 
                        		layer.alert(data.message,function(){
                        			if(data.status==1 && data.message == "修改成功！因为修改了本账号密码!需要重新登录。"){
                    					window.location.href="<cms:getProjectBasePath/>"+data.redirect;
                    				} else {
                    					result = data.message
                                		location.reload();
                    				}
								});
                				
                        	}  
                       }); 
                    },
                    errorPlacement:function(error, element){
                        var next=element.parents().siblings(".item-tip");
                           //console.log(next)
                           next.html(error.html());
                    },
                    success:function(element,label){
                    },
                    rules:{
                    	pwd:{
        					required:true,
        					rangelength:[6,15]
        				},
                    	
                        userType:{
                        	required:true
                        }
                    },
                    messages:{
                    	pwd:{
        					required:'由任意6-15个字符组成，注意区分大小写!',
        					rangelength:'由任意6-15个字符组成'
        				},
                        userType:{
                        	required:'请选择用户类型!'
                        }
                    }
            	});
            });
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
    </script>
</div>
</body>
</html>
