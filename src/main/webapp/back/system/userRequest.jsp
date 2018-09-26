<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>用户请求</title>
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
					<c:if test="${xtgl.id == 24 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统管理</a>>
			<a href="#" class="in">用户请求</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<form id="userRequestForm"
					action="<cms:getProjectBasePath/>backend/system/userRequest"
					method="get">
					<div class="pageTopbar clearfix">
						<label class="data-type"> <span class="labt">请求状态:</span>
							<div class="sc_selbox One-third">
								<i class="inc uv21"></i>
								<c:if test="${type == -1 }">
									<span id="section_lx">全部</span>
								</c:if>
								<c:if test="${type == 1 }">
									<span id="section_lx">已通过</span>
								</c:if>
								<c:if test="${type == 0 }">
									<span id="section_lx">未通过</span>
								</c:if>
								<div class="sc_selopt" style="display: none;">
									<p onclick="changeType('-1')">全部</p>
									<p onclick="changeType('1')">已通过</p>
									<p onclick="changeType('0')">未通过</p>
								</div>
								<input type="hidden" id="type" name="type" value="${type }">
							</div>
						</label>
						<div class="input-w">
							<input type="text" name="keyword"
								class="tbSearch subselect keyword" value="${keyword }"
								placeholder="请输入关键词"> <input type="submit"
								class="tbBtn submit" value="查询">
						</div>
						<div class="clear"></div>
					</div>
				</form>
				<div class="radius">
					<table class="data-table">
						<tr>
							<th width="6%"><span>序号</span></th>
							<th width="14%"><span>学校</span></th>
							<th><span>修改前</span></th>
							<th><span>修改后</span></th>
							<th width="12%"><span>修改方式</span></th>
							<th width="8%"><span>修改人</span></th>
							<th width="14%"><span>时间</span></th>
							<th width="8%"><span>状态</span></th>
						</tr>
						<c:forEach items="${list }" var="list" varStatus="status">
							<tr>
								<td><span>${status.index+1 }</span></td>
								<td><span>${list.school }</span></td>
								<td class="tl">
									<div class="reuqestdetail">
										<c:if
											test="${list.function =='用户信息删除' or  list.function =='用户信息修改'}">
											<p>
												<span>登录邮箱：</span>${list.member.email }</p>
											<p>
												<span>用户名：</span>${list.member.username }</p>
											<p>
												<span>真实姓名：</span>${list.member.nickname }</p>
											<p>
												<span>学校：</span>${list.member.school }</p>
											<p>
												<span>院系：</span>${list.member.department }</p>
											<p>
												<span>身份：</span>
												<c:if test="${list.member.identity == 1 }">学生</c:if>
												<c:if test="${list.member.identity == 2 }">老师</c:if>
												<c:if test="${list.member.identity == 3 }">其他</c:if>
											</p>
											<p>
												<span>职工号/学号：</span>${list.member.studentId }</p>
											<p>
												<span>学历：</span>
												<c:if test="${list.member.education == 1 }">大专</c:if>
												<c:if test="${list.member.education == 2 }">本科</c:if>
												<c:if test="${list.member.education == 3 }">硕士</c:if>
												<c:if test="${list.member.education == 4 }">博士</c:if>
												<c:if test="${list.member.education == 5 }">其他</c:if>
											</p>
											<p>
												<span>用户类型：</span>
												<c:if test="${list.member.userType ==0 }">终端用户</c:if>
												<c:if test="${list.member.userType ==1 }">管理员</c:if>
											</p>
											<p>
												<span>性别：</span>
												<c:if test="${list.member.sex == 1 }">男</c:if>
												<c:if test="${list.member.sex == 2 }">女</c:if>
											</p>
											<p>
												<span>校外登陆：</span>
												<c:if test="${list.member.permission == 2 }">
													<span>正在申请</span>
												</c:if>
												<c:if
													test="${list.member.permission == 1 || list.member.permission == 3 }">
													<span style="color: green">允许校外登录</span>
												</c:if>
												<%-- <c:if test="${list.member.permission == 3 }"><span style="color: #FF8800">申请失败</span></c:if>
												<c:if test="${list.member.permission == 4 }"><span style="color: red">未通过</span></c:if> --%>
												<c:if test="${list.member.permission == 0 }">
													<span style="color: red">不允许校外登录</span>
												</c:if>
											</p>
										</c:if>
										<c:if
											test="${list.function =='学院信息删除' or  list.function =='学院信息修改'}">
											<p>
												<span>学院名称：</span>${list.department.departmentName }</p>
										</c:if>
										<c:if test="${list.function =='学校信息修改'}">
											<p>
												<span>学校名称：</span>${list.org.name }</p>
											<p>
												<span>地区：</span>${list.org.province }省&nbsp;${list.org.city }市</p>
											<p>
												<span>联系人：</span>${list.org.contactPerson }</p>
											<p>
												<span>联系方式：</span>${list.org.contact }</p>
											<p>
												<span>邮箱：</span>${list.org.email }</p>
										</c:if>
									</div>
								</td>
								<td class="tl">
									<div class="reuqestdetail">
										<c:if
											test="${list.function =='用户信息添加' or  list.function =='用户信息修改'}">
											<p>
												<span>登录邮箱：</span>${list.memberAfter.email }</p>
											<p>
												<span>用户名：</span>${list.memberAfter.username }</p>
											<p>
												<span>真实姓名：</span>${list.memberAfter.nickname }</p>
											<p>
												<span>学校：</span>${list.memberAfter.school }</p>
											<p>
												<span>院系：</span>${list.memberAfter.department }</p>
											<p>
												<span>身份：</span>
												<c:if test="${list.memberAfter.identity == 1 }">
													<span>学生</span>
												</c:if>
												<c:if test="${list.memberAfter.identity == 2 }">
													<span>老师</span>
												</c:if>
												<c:if test="${list.memberAfter.identity == 3 }">
													<span>其他</span>
												</c:if>
											</p>
											<p>
												<span>职工号/学号：</span>${list.memberAfter.studentId }</p>
											<p>
												<span>学历：</span>
												<c:if test="${list.memberAfter.education == 1 }">
													<span>大专</span>
												</c:if>
												<c:if test="${list.memberAfter.education == 2 }">
													<span>本科</span>
												</c:if>
												<c:if test="${list.memberAfter.education == 3 }">
													<span>硕士</span>
												</c:if>
												<c:if test="${list.memberAfter.education == 4 }">
													<span>博士</span>
												</c:if>
												<c:if test="${list.memberAfter.education == 5 }">
													<span>其他</span>
												</c:if>
											</p>
											<p>
												<c:if test="${list.memberAfter.userType ==0 }">
													<span>用户类型：终端用户</span>
												</c:if>
												<c:if test="${list.memberAfter.userType ==1 }">
													<span>用户类型：管理员</span>
												</c:if>
											</p>
											<p>
												<span>性别：</span>
												<c:if test="${list.memberAfter.sex == 1 }">
													<span>男</span>
												</c:if>
												<c:if test="${list.memberAfter.sex == 2 }">
													<span>女</span>
												</c:if>
											</p>
											<p>
												<span>校外登陆：</span>
												<c:if test="${list.memberAfter.permission == 2 }">
													<span>正在申请</span>
												</c:if>
												<c:if test="${list.memberAfter.permission == 1 }">
													<span style="color: green">允许校外登录</span>
												</c:if>
												<c:if test="${list.memberAfter.permission == 3 }">
													<span style="color: #FF8800">申请失败</span>
												</c:if>
												<c:if test="${list.memberAfter.permission == 4 }">
													<span style="color: red">未通过</span>
												</c:if>
												<c:if test="${list.memberAfter.permission == 0 }">
													<span style="color: red">不允许校外登录</span>
												</c:if>
											</p>
										</c:if>
										<c:if
											test="${list.function =='学院信息添加' or  list.function =='学院信息修改'}">
											<p>
												<span>学院名称：</span>${list.departmentAfter.departmentName }</p>
										</c:if>
										<c:if test="${list.function =='学校信息修改'}">
											<p>
												<span>学校名称：</span>${list.orgAfter.name }</p>
											<p>
												<span>地区：</span>${list.orgAfter.province }省&nbsp;${list.orgAfter.city }市</p>
											<p>
												<span>联系人：</span>${list.orgAfter.contactPerson }</p>
											<p>
												<span>联系方式：</span>${list.orgAfter.contact }</p>
											<p>
												<span>邮箱：</span>${list.orgAfter.email }</p>
										</c:if>
										<c:if
											test="${list.function == '批量添加用户' or list.function == '批量添加学院' }">
											<span>文件：</span>
											<a href="<cms:getProjectBasePath/>${list.param }">${list.param.substring(16) }</a>
										</c:if>
									</div>
								</td>
								<td><span>${list.function }</span></td>
								<td><span>${list.person }</span></td>
								<td><span><fmt:formatDate value="${list.time }"
											pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
								<td><span> <c:if
											test="${list.type ==0 and list.function != '批量添加用户' and list.function != '批量添加学院'}">
											<a style="cursor: pointer"
												onclick="pass('${list.url }requestId=${list.id }')"
												class="cd00">未通过</a>
										</c:if> <c:if
											test="${list.type ==0 and (list.function == '批量添加用户' or list.function == '批量添加学院')}">
											<a style="cursor: pointer"
												onclick="pass('${list.url }path=${list.param }&requestId=${list.id }')"
												class="cd00">未通过</a>
										</c:if> <c:if test="${list.type ==1 }">
											<span class="c090">已通过</span>
										</c:if></span></td>
							</tr>
						</c:forEach>

					</table>
				</div>
				<div class="page" id="page">
					<a class="a1">${count}条</a>
					<pg:pager items="${count}" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="type" />
						<pg:param name="keyword" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<pg:page>
							<c:if test="${count/20 gt 5 and (cp gt 3)}">
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
							<c:if test="${count/20 gt 5 and (count/20 gt (cp+2))}">
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
		/**通过*/
		function pass(url) {
			$.get(url,function(data){
				layer.alert(data.message,function(){
					   location.reload();
				})
			});
		}
		//请求状态下拉框
		function changeType(type) {
			$('#type').val(type);
			var val=$('.keyword').val();
			if(val ==''||val==$('.keyword').attr("placeholder")) {
				$('.keyword').val("")
			}
			$('#userRequestForm').submit();
		}
		//（关键字查询）
		$('.submit').click(function(){
			var val=$('.keyword').val();
			if(val ==''||val==$('.keyword').attr("placeholder")) {
				$('.keyword').focus();
				return false;
			}
		});
	</script>
	<jsp:include page="../foot.jsp"></jsp:include>
	</body>
	</html>