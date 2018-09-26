<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<title>用户反馈</title>
<jsp:include page="../head.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<div id="content">




	<div class="col-left left-menue" id="side-menue">

		<!--<h3>
			<span class="inc uv12"></span>
			<span class="inc uvA0"></span>
			系统管理
		</h3>-->



		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 32 }">class="in"</c:if>>${xtgl.columnName }</a>
				</li>
			</c:forEach>
		</ul>
	</div>





	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">系统管理</a>>
			<a href="#" class="in">用户反馈</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="radius">
					<div class="sugbox">
						<div class="sug-list">
							<div class="sug-list-head">
								<form action="<cms:getProjectBasePath/>/backend/system/feedback"
									method="get">
									<label class="data-type"> <span class="labt">是否回复:</span>
										<div class="sc_selbox">
											<i class="inc uv21"></i> <span id="section_lx"> <span
												id="section_lx"> <c:if test="${isProcess ==0 }">未回复</c:if>
													<c:if test="${isProcess ==1 }">已回复</c:if> <c:if
														test="${empty isProcess }">所有反馈</c:if>
											</span>
											</span>
											<div class="sc_selopt" style="display: none;">
												<p onclick="change('-1')">所有反馈</p>
												<p onclick="change('0')">未回复</p>
												<p onclick="change('1')">已回复</p>
											</div>
											<input type="hidden" id="isProcess" name="isProcess">
										</div>
									</label> <label
										style="margin-top: 6px; margin-top: 0\9; *margin-top: 8px">
										<input type="submit" class="tbBtn submit" value="查询"
										autocomplete="off">
									</label>
								</form>
							</div>
							<div class="sug-list-body">
								<ul class="sug-his-list">
									<c:forEach items="${data.rows }" var="feedback"
										varStatus="status">
										<li
											onclick="findFeedBack('${feedback.id }','${feedback.contact }',this)">
											<div class="user-gratar">
												<img
													src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
													width="48px" height="48px">
											</div>
											<p class="sug-title">
												<c:if test="${feedback.memberName == 'Tourist' }">
													<span class="sug-name">游客</span>
												</c:if>
												<c:if test="${feedback.memberName != 'Tourist' }">
													<span class="sug-name">${feedback.memberName }</span>
												</c:if>
												<c:set var="isDoing" value="0" />
												<c:forEach items="${feedback.feedbackInfo }"
													var="feedbackInfo">
													<c:if test="${not empty feedbackInfo.options }">
														<c:set var="isDoing" value="1" />
													</c:if>
												</c:forEach>
												<c:if test="${isDoing==1}">
													<span class="fj-icon"></span>
												</c:if>
												<span class="fr sug-time"><fmt:formatDate
														value="${feedback.time }" pattern="yyyy-MM-dd HH:mm" /></span>
											</p>
											<p class="sug-cont">
												<span class="sug-cate">【${feedback.systemName }】</span>
												<c:forEach items="${feedback.feedbackInfo }"
													var="feedbackInfo" begin="0" end="0">
													<c:if test="${not empty feedbackInfo.content }">
					   							${fn:substring(feedbackInfo.content,0,25)}<c:if
															test="${fn:length(feedbackInfo.content)>25 }">...</c:if>
													</c:if>
												</c:forEach>
											</p> <c:if test="${feedback.isProcess ==0 }">
												<p class="sug-message">
													<a><span></span>未回复</a>
												</p>
											</c:if> <c:if test="${feedback.isProcess ==1 }">
												<p class="sug-message active">
													<a><span></span>已回复</a>
												</p>
											</c:if>
											<div class="clear"></div>
										</li>
									</c:forEach>
								</ul>


								<div class="page" style="margin-right: 20px;">
									<%-- <a class="a1">${data.total}条</a> --%>
									<pg:pager items="${data.total}" url="" export="cp=pageNumber"
										maxPageItems="20" maxIndexPages="3" idOffsetParam="offset">
										<pg:param name="isProcess" />
										<pg:first>
											<a href="${pageUrl}">首页</a>
										</pg:first>
										<pg:prev>
											<a href="${pageUrl}" class="a1">上一页</a>
										</pg:prev>
										<%-- 中间页码开始 --%>
										<%-- 	<pg:page>
												<c:if test="${data.total/20 gt 3 and (cp gt 2)}">
													...
												</c:if>
											</pg:page> --%>
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
										<%-- <pg:page>
												<c:if test="${data.total/20 gt 5 and (data.total/20 gt (cp+2))}">
													...
												</c:if>
											</pg:page> --%>
										<pg:next>
											<a class="a1" href="${pageUrl}">下一页</a>
										</pg:next>
										<pg:last>
											<a href="${pageUrl}">末页</a>
										</pg:last>
									</pg:pager>
								</div>

							</div>
						</div>
						<div class="sug-detail">
							<div class="sug-content">
								<c:forEach items="${data.rows }" var="feedback"
									varStatus="status" begin="0" end="0">
									<ul class="sug-his-list">
										<li>
											<div class="user-gratar">
												<img
													src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
													width="48px" height="48px">
											</div>
											<p class="sug-title">
												<span class="sug-name"> <c:if
														test="${feedback.memberName == 'Tourist'}">
														游客
													</c:if> <c:if test="${feedback.memberName != 'Tourist'}">
														${feedback.memberName}
													</c:if>
												</span>
												<c:if test="${not empty feedback.contact}">
													<span class="email-icon"></span>
													<span>${feedback.contact}</span>
												</c:if>
											</p>
											<p>
												<span>反馈类型：</span><span class="sug-cate">${feedback.systemName}</span>
											</p>
											<p>
												<span>反馈内容：</span>
												<c:forEach items="${feedback.feedbackInfo }"
													var="feedbackInfo" begin="0" end="0">
													<c:if test="${not empty feedbackInfo.content }">${feedbackInfo.content }</c:if>
												</c:forEach>
											</p>
											<p class="sug-line"></p>
											<div class="upload-filelist">
												<c:forEach items="${feedback.feedbackInfo }"
													var="feedbackInfo">
													<c:if test="${not empty feedbackInfo.options }">
														<c:set var="fileName"
															value="${feedbackInfo.options.substring(15) }"></c:set>
														<c:set var="num" value="${fn:indexOf(fileName, '/')}"></c:set>
														<c:if
															test="${!fn:contains(fileName,'.jpg') && !fn:contains(fileName,'.png') && !fn:contains(fileName,'.jpeg') && !fn:contains(fileName,'.bmp') && !fn:contains(fileName,'.gif')}">
															<a class="file-type" target="_blank"
																href="<cms:getProjectBasePath/>${feedbackInfo.options }">${fileName.substring(num+1) }
															</a>
														</c:if>

													</c:if>
												</c:forEach>

											</div>
											<div class="clear"></div>
										</li>
									</ul>
								</c:forEach>
								<div class="sug-content-body">
									<div class="sug-chat-item">
										<c:forEach items="${data.rows }" var="feedback"
											varStatus="status" begin="0" end="0">
											<c:forEach items="${feedback.feedbackInfo }"
												var="feedbackInfo" varStatus="infoStatus">

												<c:if test="${feedbackInfo.type == 1 }">
													<c:if test="${feedback.memberName == 'Tourist'}">
														<c:set var="memberName" value="游客"></c:set>
													</c:if>
													<c:if test="${feedback.memberName != 'Tourist'}">
														<c:set var="memberName" value="${feedback.memberName}"></c:set>
													</c:if>

													<div class="sug-user-item">
												</c:if>
												<c:if test="${feedbackInfo.type == 2 }">
													<c:set var="memberName" value="后台管理员"></c:set>
													<div class="sug-user-item sug-admin-item">
												</c:if>
												<div class="sug-user-gravatar">
													<img
														src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
														width="36px" height="36px">
												</div>
												<div class="sug-user-text clearfix">

													<i class="sug-arrow"></i>
													<div class="sug-u-body">
														<p class="sug-name">${memberName}
															<span class="fr sug-time"><fmt:formatDate
																	value="${feedbackInfo.time}" pattern="yyyy-MM-dd HH:mm" /></span>
														</p>
														<p>${feedbackInfo.content }</p>
													</div>
													<c:if test="${not empty feedbackInfo.options }">
														<div class="sug-file-show">
															<%-- 附件或图片地址${feedbackInfo.options } --%>
															<c:if
																test="${fn:contains(feedbackInfo.options,'.jpg') || fn:contains(feedbackInfo.options,'.png') || fn:contains(feedbackInfo.options,'.jpeg') || fn:contains(feedbackInfo.options,'.bmp') || fn:contains(feedbackInfo.options,'.gif')}">
																<a
																	href="/user/showFile?filename=${feedbackInfo.options }"
																	target="_blank"><img
																	src="/user/showFile?filename=${feedbackInfo.options }"
																	alt="" width="100%" height="auto"></a>
															</c:if>
															<c:if
																test="${fn:contains(feedbackInfo.options,'.doc') || fn:contains(feedbackInfo.options,'.docx')}">
																<%-- <c:set var="filelastName" value="${fn:indexOf(feedbackInfo.options, '/')}"></c:set>
																<a href="<cms:getProjectBasePath/>${filelastName}" target="_blank"></a> --%>

																<c:set var="fileName"
																	value="${feedbackInfo.options.substring(15) }"></c:set>
																<c:set var="num" value="${fn:indexOf(fileName, '/')}"></c:set>
																<c:if
																	test="${!fn:contains(fileName,'.jpg') && !fn:contains(fileName,'.png') && !fn:contains(fileName,'.jpeg') && !fn:contains(fileName,'.bmp') && !fn:contains(fileName,'.gif')}">
																	<%-- <a class="file-type" target="_blank" href="<cms:getProjectBasePath/>${feedbackInfo.options }">${fileName.substring(num+1) } </a> --%>
																	<span>附件：</span>
																	<a
																		href="/user/showFile?filename=${feedbackInfo.options }"
																		target="_blank">${fileName.substring(num+1) }</a>
																</c:if>
															</c:if>
														</div>
													</c:if>
												</div>
									</div>

									</c:forEach>
									</c:forEach>
								</div>
							</div>





							<div class="sug-replay-box">
								<form method="post" enctype="multipart/form-data" id="fb_form"
									action="" target="frameFile">
									<input type="file" hidden="hidden" name="file" id="uploadfile">
									<c:forEach items="${data.rows }" var="feedback"
										varStatus="status" begin="0" end="0">
										<input type="text" hidden="hidden" name="id" id="feedId"
											value="${feedback.id }">
									</c:forEach>

									<input type="text" hidden="hidden" name="contact" value="">
									<textarea name="content" cols="30" rows="10"
										placeholder="请在此输入回复内容..."></textarea>
									<div class="sug-replay-btn">
										<input type="submit" value="发送" name="" id="submitfeedback">
									</div>
								</form>
								<iframe id="frameFile" name="frameFile" style="display: none;"></iframe>
							</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>
</div>

<script type="text/javascript">
var userimgnone='<cms:getProjectBasePath/>resources/images/gravatar.gif';
function change(isProcess){
	$('#isProcess').val(isProcess);
}
	
function queren(text, callback) {
    $("#spanmessage").text(text);
    $("#message").dialog({
        title: "学术资源管理后台，提示您",
        modal: true,
        resizable: false,
        buttons: {
            "否": function() {
                $(this).dialog("close");
            },
            "是": function() {
                callback.call();//方法回调
                $(this).dialog("close");
            }
        }
    });
}

function deleteOrg(org,href){
	queren("确定要删除机构'"+org+"'吗?",function(){
		window.location.href=href;
	});
}
function dateMYD(time){
	var dates=new Date(time),
    Y = dates.getFullYear(),
    M = dates.getMonth() + 1,
    D = dates.getDate(),
    H = dates.getHours(),
    m = dates.getMinutes(),
    s = dates.getSeconds();
	//小于10的在前面补0
    if (M < 10) {
        M = '0' + M;
    }
    if (D < 10) {
        D = '0' + D;
    }
    if (H < 10) {
        H = '0' + H;
    }
    if (m < 10) {
        m = '0' + m;
    }
    if (s < 10) {
        s = '0' + s;
    }
    return Y + '-' + M + '-' + D + ' ' + H + ':' + m;
}
$(function(){
	var boardDiv = "<div id='message' style='display:none;'><span id='spanmessage'></span></div>";
	$(document.body).append(boardDiv);	 
})

function findFeedBack(id,contact,ele){
	$(ele).addClass('in').siblings().removeClass('in');
	$('#feedId').val(id);
	 $.get("<cms:getProjectBasePath/>backend/system/feedback/"+id, function(result){
		 result = eval("("+result.message+")");
		
		 //console.log(result);
		 var strf='',strS='';
		 $('.sug-content li').eq(0).html('');
		 var memberName = result.memberName;
		 if(memberName == 'Tourist') {
			 memberName = '游客'
		 }

		 strf+='<div class="user-gratar"><img src="'+userimgnone+'" width="48px" height="48px"></div>'
				+'<p class="sug-title">'
					+'<span class="sug-name">'+memberName+'</span>';
					if(result.contact){
						strf+='<span class="email-icon"></span>'
							+'<span>'+result.contact+'</span>';
					}
					
			strf+='</p>'
				+'<p><span>反馈类型：</span><span class="sug-cate">'+result.systemName+'</span></p>'
				+'<p><span>反馈内容：</span>'+result.feedbackInfo[0].content+'</p>'
				+'<p class="sug-line"></p>'
				+'<div class="upload-filelist">';
				for(var i = 0; i < result.feedbackInfo.length; i++) {
					if(result.feedbackInfo[i].options != null) {
						if(!isImage(fileType(result.feedbackInfo[i].options))){
							strf+='<a class="file-type" target="_blank" href="'+"/user/showFile?filename="+result.feedbackInfo[i].options+'">'+fileName(result.feedbackInfo[i].options)+'</a>';
						}
					}
				}
				
		    strf+='</div>'
				+'<div class="clear"></div>';
		$('.sug-content li').eq(0).append(strf);

		$('.sug-content-body').html("");

		strS+='<div class="sug-chat-item">';
		var str='';
		for(var i = 0; i < result.feedbackInfo.length; i++) {
			var text=result.feedbackInfo[i].content;
				file=result.feedbackInfo[i].options,
				type=result.feedbackInfo[i].type,
				time=result.feedbackInfo[i].time,
				name='';
			
            var userimg='${sessionScope.front_member.avatar }'?'${sessionScope.front_member.avatar }':userimgnone;
				str+='<div class="';
				if(type==1){
			       str+='sug-user-item">';
			       name = result.memberName=="Tourist"?"游客":result.memberName;//修改Tourist显示为游客
			    }else{
			       str+='sug-user-item sug-admin-item">';
			       name = "后台管理员";
			    }
				str+='<div class="sug-user-gravatar">'
					+'<img src="'+userimgnone+'" width="36px" height="36px">'
					+'</div>'
					+'<div class="sug-user-text clearfix">'
					+'<i class="sug-arrow"></i>'
					+'<div class="sug-u-body">'
					+'<p class="sug-name">'+name+'<span class="fr sug-time">'+dateMYD(time)+'</span></p>'
					+'<p>'+text+'</p>'
					+'</div>';

					if(file){
						if(isImage(fileType(file))){
							
						
							str+='<div class="sug-file-show">'
								+'<a href="'+"/user/showFile?filename="+file+'" target="_blank"><img src="'+"/user/showFile?filename="+file+'" alt="" width="100%" height="auto"></a>'
							+'</div>' 
						}else{
							var filelast=file.split('\/');
							str+='<div class="sug-file-show"><span>附件：</span>'
								+'<a href="'+"/user/showFile?filename="+file+'" target="_blank">'+filelast[filelast.length-1]+'</a>'
							+'</div>' 
						}
					}
						
					str+='</div>'
						+'</div>'

		    /*str+='<div class="';
		    if(type==1){
		       str+='sug-user-item">';
		    }else{
		       str+='sug-user-item sug-admin-item">';
		    }
		       str+='<div class="sug-user-text clearfix">'
		       +'<i class="sug-arrow"></i>';

		    if(text){
		        str+='<div class="sug-u-body">'
		                +'<p>'+text+'</p>'
		            +'</div>';     
		    }
		    if(text&&file){
		        str+='<div class="sug-seg-line"></div>'
		    }       
		    if(file){
		        str+='<div class="sug-u-bottom">'
		                +'<span class="upload-icon"></span>'
		                +'<span><a>'+file+'</a></span>'
		            +'</div>';
		    }
		    str+='</div>'
		            +'<div class="clear"></div>'
		            +'<div class="s-input-time">'+time+'</div>'
		        +'</div>';*/
		    //$('#sug-content').append(str);
		}
		strS+=str;
		strS+='</div></div>'
		$('.sug-content-body').append(strS);
		 if(contact == null || contact =='') {
			 $('.email-colect').addClass('email-colectShow');
			 $('#feedback_id').val(id);
		 }
		 $('#feedId').val(id);
	 })
}


$('#submitfeedback').click(function(){
	var content = $("textarea[name='content']").val();
	if(content =='') {
		alert("您还未回复信息！");
		return false;
	}
	content = content.replace(/\n|\r\n/g,"<br/>");
	$("textarea[name='content']").val(content);

	$('#fb_form').ajaxSubmit({
	     dataType:"json",
	     type: "POST",
	     data : $('#fb_form').serialize(),
	     url:'<cms:getProjectBasePath/>backend/system/feedback/answer',
	     success: function(msg){
	        var str="";
	        var message=eval("("+msg.message+")");
	        var text=$('.sug-replay-box textarea').val();
	        var userimgnone='<cms:getProjectBasePath/>resources/images/gravatar.gif';
	        if(msg.status){
	        	str+='<div class="';

			       str+='sug-user-item sug-admin-item">';
				str+='<div class="sug-user-gravatar">'
					+'<img src="'+userimgnone+'" width="36px" height="36px">'
					+'</div>'
					+'<div class="sug-user-text clearfix">'
					+'<i class="sug-arrow"></i>'
					+'<div class="sug-u-body">'
					+'<p class="sug-name">后台管理员 <span class="fr sug-time">'+dateMYD(message.time)+'</span></p>'
					+'<p>'+text+'</p>'
					+'</div>'	
					+'</div>'
					+'</div>';
				$('.sug-content-body').append(str);
				$('.sug-replay-box textarea').val('');
	        }else{
	        	
	        }
	     }
	});
})

function fileName(uploadfile){
	var uploadfile=uploadfile.split('/');
	return uploadfile[uploadfile.length-1];
}
function fileType(fileOptions){
	var fileOptions=fileOptions.split('/');
	var fileType=fileOptions[fileOptions.length-1].split('.');
	fileType=fileType[fileType.length-1];
	return fileType;
}
function isImage(str){
	var str=str.toLocaleLowerCase();
	if(str=="bmp"||str=="png"||str=="jpg"||str=="jpeg"||str=="gif"){
		return true;
	}
}
</script>
</body>
</html>
