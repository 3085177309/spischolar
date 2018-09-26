<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>草稿箱</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>

<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv40"></span> 系统日志
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtrz }" var="xtrz" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtrz.url}"
					<c:if test="${xtrz.id == 30 }">class="in"</c:if>>${xtrz.columnName }</a></li>
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
			<a href="#" class="in">草稿箱</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<label class="common">
						<form id="drafts_form"
							action="<cms:getProjectBasePath/>backend/systemLog/drafts"
							method="get">
							<input type="text" name="key" class="tbSearch keyword ie10"
								placeholder="请输入关键字"> <input class="tbBtn" value="查询"
								type="submit">
						</form>
					</label>
					<div class="clear"></div>
				</div>
				<div class="log">
					<div class="caogaobox">
						<div class="backbd">
							<ul class="bglineset">
								<c:forEach items="${data.rows }" var="log" varStatus="status">
									<li>
										<div class="log-single-tit">
											<span>${log.releases.substring(0,10) }<i class="arrow"></i></span>
										</div>
										<div class="post-box">
											<div class="post-time">
												<p>${log.releases.substring(11,16) }</p>
												<i class="time-arrow"></i>
											</div>
											<div class="post-con">
												<i class="left-arrow"></i>
												<h3 class="log-con-tit">
													<a
														href="<cms:getProjectBasePath/>backend/systemLog/newLog?id=${log.id}"
														class="log-edit fr"><i></i>编辑</a> <a href="#">${log.title }</a>
													<span class="log-post-time">发布时间：<fmt:formatDate
															value="${log.addTime }" pattern="yyyy-MM-dd HH:mm" /></span>
												</h3>
												<div class="log-abstract" id="log-abstract${status.index }">
													摘要：${log.logAbstract }
													<p>
														<a href="#" onclick="read('${status.index }')"
															class="readAll fr">阅读原文</a>
													</p>
												</div>
												<div class="log-abstract" id="content${status.index }"
													style="display: none;">
													内容：${log.content }
													<p>
														<a href="#" onclick="back('${status.index }')"
															class="readAll fr">阅读摘要</a>
													</p>
												</div>
												<p class="post-info">
													<span>责任人：${log.person }</span><span>标签：<a href="#">${log.lable }</a></span>
												</p>
												<div class="Attachment">
													<p>
														<a
															href="<cms:getProjectBasePath/>backend/systemLog/download?path=${log.path }">${log.name }</a>
													</p>
												</div>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
							<div class="line"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script>
	function read(index) {
		$('#log-abstract'+index+'').hide();
		$('#content'+index+'').show();
	}
	function back(index) {
		$('#log-abstract'+index+'').show();
		$('#content'+index+'').hide();
	}
	var logtoggle=function(){
		var $toggle=$(".log-year-toggle");
		$toggle.click(function(){
			if($(this).parents(".slideup").length>0){
				
				$(this).parents(".logbox").find(".log-body").show(200);
				$(this).parents(".logbox").removeClass("slideup");
			}else{

				$(this).parents(".logbox").addClass("slideup").find(".log-body").hide(200);
			}
		})
	}();
	
	//（关键字查询）
	$('#drafts_form').submit(function(){
		var val=$('.keyword').val();
		if(val ==''||val==$('.keyword').attr("placeholder")) {
			$('.keyword').focus();
			return false;
		}
	});
	</script>
	</body>
	</html>