<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>内容编辑</title>

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
					<c:if test="${xtgl.id == 25 }">class="in"</c:if>>${xtgl.columnName }</a></li>
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
			<a href="#" class="in">内容编辑</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<form id="contentForm"
					action="<cms:getProjectBasePath/>backend/system/list/${method}"
					method="post">
					<c:if test="${not empty news }">
						<input type="hidden" name="id" value="${news.id }">
					</c:if>
					<div class="radius">
						<table class="article-edit" width="600px">
							<tr>
								<th width="80px"><span><em>*</em>栏目</span></th>
								<td>
									<div class="sc_selbox">
										<i class="inc uv21"></i> <span id="section_lx"> <c:if
												test="${empty news }">新手指南</c:if> <c:if
												test="${news.type == 1 }">新手指南</c:if> <c:if
												test="${news.type == 2 }">学科体系</c:if> <c:if
												test="${news.type == 3 }">评价体系</c:if> <c:if
												test="${news.type == 4 }">系统日志</c:if> <c:if
												test="${news.type == 5 }">公告</c:if> <c:if
												test="${news.type == 6 }">使用手册</c:if>
										</span>
										<div class="sc_selopt" style="display: none;">
											<p onclick="changeType('1')">新手指南</p>
											<p onclick="changeType('2')">学科体系</p>
											<p onclick="changeType('3')">评价体系</p>
											<p onclick="changeType('4')">系统日志</p>
											<p onclick="changeType('5')">公告</p>
											<p onclick="changeType('6')">使用手册</p>
										</div>
										<c:if test="${empty news }">
											<input type="hidden" id="type" name="type" value="1">
										</c:if>
										<c:if test="${not empty news }">
											<input type="hidden" id="type" name="type"
												value="${news.type }">
										</c:if>
									</div>
								</td>
							</tr>
							<tr>
								<th width="80px"><span><em>*</em>标题</span></th>
								<td><span><input type="text" name="title"
										value="${news.title }" class="input-text attr-input"></span></td>
							</tr>
							<tr>
								<th width="80px"><span>状态</span></th>
								<td><span>显示<input type="radio" name="isShow"
										value="1" checked="checked"></span> <span>显示并轮播<input
										type="radio" name="isShow" value="2"
										<c:if test="${news.isShow == 2 }">checked="checked"</c:if>></span>
									<span>隐藏<input type="radio" name="isShow" value="0"
										<c:if test="${news.isShow == 0 }">checked="checked"</c:if>></span>
								</td>
							</tr>
							<c:if test='${method == "edit"}'>
								<tr>
									<th width="80px"><span>阅读数</span></th>
									<td><span><input type="text" name="times"
											value="${news.times }" class="input-text attr-input"></span></td>
								</tr>
								<tr>
									<th width="80px"><span>点赞数</span></th>
									<td><span><input type="text" name="praise"
											value="${news.praise }" class="input-text attr-input"></span></td>
								</tr>
							</c:if>
							<c:if test='${method == "edit"}'>
								<tr>
									<th width="80px"><span>发布时间</span></th>
									<td><span><fmt:formatDate value="${news.addTime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></span></td>
								</tr>
								<tr>
									<th width="80px"><span>发布人</span></th>
									<td><span>${news.publishers }</span></td>
								</tr>
							</c:if>
							<tr>
								<th width="80px"><span><em>*</em>内容</span></th>
								<td><span> <textarea name="content" id="" cols="30"
											rows="10">${news.content }</textarea>
								</span></td>
							</tr>
							<tr>
								<td colspan="2" class="tc" style="height: 60px"><input
									type="submit" onclick="publick()" class="downOut" value="保存并发表">
									<input type="button" onclick="preview()" class="downOut"
									value="预览"></td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
	function publick(){
		if(!editor.edit.iframe.get().contentWindow.document.body.innerHTML){
			editor.edit.iframe.get().contentWindow.document.body.focus();
			return false;
		}
		//$('#contentForm').submit();
	}
	KindEditor.ready(function(K) {
		window.editor=K.create('textarea[name="content"]', {
			uploadJson : '<cms:getProjectBasePath/>backend/system/list/img',
			allowFileManager : true,
			
		    afterBlur:function(){ 
		        this.sync(); 
		    },
			afterCreate : function() {
				var self = this;
				
				K.ctrl(document, 13, function() {
					self.sync();
					document.forms['contentForm'].submit();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
					document.forms['contentForm'].submit();
				});
				
			}
		});
		
	});
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