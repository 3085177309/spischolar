<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>用户反馈</title>

<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>/resources/plugins/kindeditor/themes/default/default.css" />
<script charset="utf-8"
	src="<cms:getProjectBasePath/>/resources/plugins/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8"
	src="<cms:getProjectBasePath/>/resources/plugins/kindeditor/lang/zh_CN.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
	type="text/javascript"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 32 }">class="in"</c:if>>${xtgl.columnName }</a></li>
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
			<a href="#" class="in">用户反馈</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<form id="contentForm"
					action="<cms:getProjectBasePath/>backend/system/feedback/answer"
					method="post">
					<input type="hidden" name="id" value="${feedback.id }">
					<div class="radius">
						<table class="article-edit" width="600px">
							<tr>
								<th width="80px"><span>反馈类型</span></th>
								<td><span id="section_lx"> ${feedback.systemName } </span>
								</td>
							</tr>
							<tr>
								<th width="80px"><span>反馈邮箱</span></th>
								<td><span id="section_lx"> ${feedback.contact } </span></td>
							</tr>
							<tr>
								<th width="80px"><span>反馈时间</span></th>
								<td><fmt:formatDate value="${feedback.time }"
										pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
							<tr>
								<th width="80px"><span>反馈内容</span></th>
								<td>
									<div class="feedbackInfo">
										<c:forEach items="${feedback.feedbackInfo }"
											var="feedbackInfo" varStatus="status">
											<c:if test="${feedbackInfo.type == 1 }">
												<p>
													<strong>反馈：</strong>${feedbackInfo.content }
													<c:if test="${not empty feedbackInfo.options }">
														<a
															href="<cms:getProjectBasePath/>${feedbackInfo.options }"
															target="_blank">附件</a>
													</c:if>
													<span class="fr"><fmt:formatDate
															value="${feedbackInfo.time }" pattern="yyyy-MM-dd HH:mm" /></span>
												</p>
											</c:if>
											<c:if test="${feedbackInfo.type == 2 }">
												<p>
													<strong>&nbsp;&nbsp;回复：</strong>${feedbackInfo.content } <span
														class="fr"><fmt:formatDate
															value="${feedbackInfo.time }" pattern="yyyy-MM-dd HH:mm" /></span>
												</p>
											</c:if>
										</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th width="80px"><span><em>*</em>回复内容</span></th>
								<td><span> <textarea name="content" id="" cols="30"
											rows="10"></textarea>
								</span></td>
							</tr>
							<tr>
								<td colspan="2" class="tc" style="height: 60px"><input
									type="submit" onclick="publick()" class="downOut" value="保存">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
	
	/**预览*/
	function preview() {
		$('span[data-name=preview]').click();
	}
	
		function changeType(type){
			$('#type').val(type);
		}
		
		$(function(){
			$.validator.setDefaults({ ignore: '' });
			
			//表单验证
			$('#contentForm').validate({
		        errorPlacement:function(error, element){
		            var next=element.parents().siblings(".item-tips");
		               next.html(error.html());
		        },
		        success:function(element,label){
		        },
		        rules:{
		        	title:{
						required:true
					},
		            content:{
		            	required:true
		            }
		        },
		        messages:{
		        	title:{
						required:''
					},
					//,
		            //praise:{
					//	required:'请选择用户类型!'
		            //},
		            content:{
						required:''
		            }
		        }
			});
		});
	</script>
	</body>
	</html>