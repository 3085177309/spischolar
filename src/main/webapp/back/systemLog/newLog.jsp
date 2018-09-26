<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>新建日志</title>
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
			<span class="inc uv12"></span> <span class="inc uv40"></span> 系统日志
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtrz }" var="xtrz" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtrz.url}"
					<c:if test="${xtrz.id == 29 }">class="in"</c:if>>${xtrz.columnName }</a></li>
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
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统日志</a>>
			<a href="#" class="in">新建日志</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="radius clearfix">
					<form id="logForm"
						action="<cms:getProjectBasePath/>backend/systemLog/newLog/${method}"
						method="post" enctype="multipart/form-data">
						<c:if test="${method == 'updateLog' }">
							<input type="hidden" name="id" value="${log.id }">
						</c:if>
						<table class="article-edit">
							<tr>
								<th width="90px"><span><em>*</em>标题：</span></th>
								<td><span><input type="text" name="title"
										value="${log.title }" class="input-text"></span>&nbsp;&nbsp;<span
									class="item-tips" style="color: red"></span></td>
							</tr>
							<tr>
								<th width="90px"><span><em>*</em>责任人：</span></th>
								<td><span><input type="text" name="person"
										value="${log.person }" class="input-text"></span></td>
							</tr>
							<tr>
								<th width="90px"><span><em>*</em>上线时间：</span></th>
								<td><span class="log">
										<div class="datebox">
											<i class="inc uv13"></i> <input type="text" name="releases"
												value="${log.releases }"
												class="input-text attr-input datechoose"
												style="margin-right: 0"
												onclick="WdatePicker({isShowClear:false,readOnly:true})"
												readonly>
										</div>
								</span></td>

							</tr>
							<tr>
								<th width="90px"><span>摘要：</span></th>
								<td class="pdtextarea"><span> <input
										name="logAbstract" type="hidden" value="${log.logAbstract }" />
										<div id="abstract" class="abstract">${log.logAbstract }</div>
								</span></td>
							</tr>
							<tr>
								<th width="90px"><span><em>*</em>正文：</span></th>
								<td class="pdtextarea"><span> <textarea
											name="content" cols="30" rows="10" id="newarticlelog">${log.content }</textarea>
								</span></td>
							</tr>
							<tr>
								<th><span>附件：</span></th>
								<td><span class="uploadfile modify"><i></i>上传</span> <input
									style="display: none;" type="file" id="up-filebox" name="file"
									value="${log.path }" class="uploadfile" /> <span
									class="filename"></span></td>
							</tr>
							<tr>
								<th width="90px"><span>标签：</span></th>
								<td>
									<div>
										<input type="hidden" name="type" id="types" value=""> 
										<input type="hidden" name="lable" id="lable" value="${log.lable }">
										<p class="tagsShow">
											<c:forEach items="${log.lables }" var="lable">
												<span class="enabledelete">${lable }<i></i></span>
											</c:forEach>
										</p>
									</div>
								</td>
							</tr>
							<tr>
								<th></th>
								<td>
									<div class="tagsBox">
										<div class="tags">
											<p>
												<c:forEach items="${map }" var="map">
													<c:if test="${map.type ==1 }">
														<span>${map.name }</span>
													</c:if>
												</c:forEach>
											</p>
											<i class="addlable"></i>
										</div>
									</div>
									<div class="tagsBox">
										<div class="tags">
											<p>
												<c:forEach items="${map }" var="map">
													<c:if test="${map.type ==2 }">
														<span>${map.name }</span>
													</c:if>
												</c:forEach>
											</p>
											<i class="addlable"></i>
										</div>
									</div>
									<div class="tagsBox bdnoright">
										<div class="tags">
											<p>
												<c:forEach items="${map }" var="map">
													<c:if test="${map.type ==3 }">
														<span>${map.name }</span>
													</c:if>
												</c:forEach>
											</p>
											<i class="addlable"></i>
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td colspan="2" class="tc" style="height: 60px"><input
									type="button" onclick="publishs(1)" class="downOut"
									value="发布"> <input type="button"
									onclick="publishs(0)" class="downOut" value="保存到草稿">
								</td>
							</tr>
						</table>
					</form>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script
		src="<cms:getProjectBasePath/>/resources/back/js/createCatalog.js"></script>
	<script type="text/javascript">
		$('.modify').click(function(){
			$('#up-filebox').trigger('click');
		});
		$('#up-filebox').bind('change',function(){
			$(".filename").html($(this).val())
		})
		function publishs(type) {
			$('#newarticlelog').text(editor.html());
			var count = $('.tagsShow span').length;
			var lable="";
			for(var i =0; i<count;i++) {
				lable = lable + $('.tagsShow span').eq(i).text() + " ";
			}
			var val=$("#abstract").html();
			$('input[name="logAbstract"]').val(val);
			$('#types').val(type);
			$('#lable').val(lable);
			//内容验证
			//console.log(editor.edit.iframe.get().contentWindow.document.body.innerHTML)
			if(!editor.edit.iframe.get().contentWindow.document.body.innerHTML){
				console.log("##")
				editor.edit.iframe.get().contentWindow.document.body.focus();
				return false;
			}
			$('#logForm').submit(); 
		};
		
		KindEditor.ready(function(K) {
			window.editor=K.create('textarea[name="content"]', {
				uploadJson : '<cms:getProjectBasePath/>backend/systemLog/newLog/img',
				allowFileManager : true,
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						publishs(1)
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						publishs(1)
					});
				},
				
				afterChange : function() {
					createCatalog(this.html());
				}
			});
		});
		
		
		(function($){
			var tagsShow=$(".tagsShow"),tags=$(".tags span"),taginput=$(".tags i")
			var addlable='<span class="addlable"></span>';
			tags.live("click",tagsopr);
			taginput.live("click",tagsinput);
			tagsShow.find("i").live('click',function(){
				$(this).parents("span").remove();
			})
			function tagsopr(){
				var txt = tagsShow.html();
				var tagstxt = $(this).text();
				var clone=$(this);
				
				
				if(txt.indexOf(tagstxt) != -1 && tagstxt !="") {
					alert("已添加在列表");
					return false;
				}else{
					tagsShow.html(txt+"<span class='enabledelete'>"+$(this)[0].innerHTML+"<i></i></span>");
				}
			}
			function tagsinput(){
				$(this).unbind().addClass("editable").attr("contenteditable","true");	
				$(this).blur(function(){
					var $html=$(this).parents(".tags").find("p");
				
					if($(this).text() ==""){
						alert("请输入标签内容！");
						return false
					};
					if(chkText($(this).text())){
						alert("请输入不同的标签内容！");
						return false
					}
					$html.html($html.html()+'<span>'+$(this).text()+'</span>');
					var index=$(this).parents(".tagsBox").index();
					var lable = $(this).text()
					var lableName = document.createElement("input");
					lableName.type="hidden";
					lableName.name="lables";
					lableName.value=lable + index;
					$(this).parents(".tags").append(lableName);
					$(this).html("").removeClass().addClass("addlable").attr("contenteditable","false");
				})
				
			}
			function chkText(text){
				var flag=false;
				var txtspan=$(".tags p span");
				for(var i=0;i<txtspan.length;i++){
					if(txtspan.eq(i).text()==text){
						flag=true;
						return flag;
					}else{
						flag=false;
					}
				}
				return flag;
			}
		})(jQuery)
		
		
		 $(function(){
            	$.validator.setDefaults({ ignore: '' });
            	//表单验证
            	$('#logForm').validate({
                    errorPlacement:function(error, element){
                        var next=element.parents().siblings(".item-tips");
                           next.html(error.html());
                    },
                    success:function(element,label){
                    },
                    rules:{
                    	title:{
        					required:true,
        					rangelength:[1,50]
        				},
        				person:{
                        	required:true
                        },
        				releases:{
                        	required:true
                        },
        				content:{
                        	required:true
                        }
                    },
                    messages:{
                    	title:{
        					required:'',
        					rangelength:'标题长度超出限制!'
        				},
                    	
        				person:{
                        	required:''
                        },
        				releases:{
        					required:''
                        },
        				content:{
        					required:''
                        }
                    }
            	});
            });
	</script>
</div>
</body>
</html>
