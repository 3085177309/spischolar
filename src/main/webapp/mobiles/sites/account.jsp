<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>账户管理</title>
<jsp:include page="include/meta.jsp"></jsp:include>

<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
</head>
<body class="fix-pbhieght">
	<div class="section-page">
		<div class="mui-content">
			<header>
				<div class="headwrap">
					<div class="return-back">
						<a class="return-back"
							href="<cms:getProjectBasePath/>user/personal"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
					</div>
					<!-- <div class="head-search">
				<i class="icon iconfont">&#xe604</i>
			</div> -->
					<!-- <div class="userbox">
				<div class="userSelect">
					<i class="icon iconfont iconfuzhi">&#xe600;</i>
				</div>
			</div> -->
					<p class="section-tit">账户管理</p>
					<div class="clear"></div>
				</div>
			</header>
			<div class="item-section">
				<ul class="usersetting-list">
					<li><a href="<cms:getProjectBasePath/>user/profile"> 基本信息
							<i class="icon iconfont fxj">&#xe60e;</i>
					</a></li>
					<li><label for="up-filebox" class="up-filebox"> 头像设置 <i
							class="icon iconfont fxj">&#xe60e;</i>
							<div class="user-upload-btn">
								<span class="user-upload-input"> <input id="up-filebox"
									type="file" onchange="fileChange(this);"
									class="user-upload-gravater" accept="image/*"></span> <span
									class="image-holder"> <c:if
										test="${empty sessionScope.front_member.avatar }">
										<img
											src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
											class="gravatar" />
									</c:if> <c:if test="${not empty sessionScope.front_member.avatar }">
										<img
											src="<cms:getProjectBasePath/>${sessionScope.front_member.avatar}"
											class="gravatar" />
									</c:if>
								</span>
							</div>
					</label></li>
					<li><a href="<cms:getProjectBasePath/>user/security"> 账户安全
							<i class="icon iconfont fxj">&#xe60e;</i>
					</a></li>
				</ul>
				<form method="post" action="<cms:getProjectBasePath/>user/avatar"
					id="avatar_form">
					<input type="hidden" name="path" id="up-fileboxs" />
				</form>
				<div class="user-set-out">
					<input type="button" id="logout" value="退出当前账号" />
				</div>
			</div>
		</div>

		<script type="text/javascript"> 
var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
function fileChange(target,id) { 
	var fileSize = 0; 
	var filepath = target.value; 
	var filemaxsize = 1024*10;//10M 
	if(filepath){ 
		var isnext = false; 
		var fileend = filepath.substring(filepath.indexOf(".")); 
	}else{ 
		return false; 
	} 
	if (isIE && !target.files) { 
		var filePath = target.value; 
		var fileSystem = new ActiveXObject("Scripting.FileSystemObject"); 
		if(!fileSystem.FileExists(filePath)){ 
			layer.open({
				content:"附件不存在，请重新输入！",
				time:2
			});
			return false; 
		} 
		var file = fileSystem.GetFile (filePath); 
		fileSize = file.Size; 
	} else { 
		fileSize = target.files[0].size; 
	} 
	var size = fileSize / 1024; 
	if(size>filemaxsize){ 
		layer.open({
			content:"附件大小不能大于10M!",
			time:2
		});
		target.value =""; 
		return false; 
	} 
	if(size<=0){ 
		layer.open({
			content:"附件大小不能为0M！",
			time:2
		});
		target.value =""; 
		return false; 
	} 
} 
</script>

		<script type="text/javascript">
	$('#logout').click(function(){
		window.location.href="<cms:getProjectBasePath/>user/logout";
	});
	(function(){
		$('#up-filebox').fileupload({
	        url: "<cms:getProjectBasePath/>user/upload",
	        disableImageResize: /Android(?!.*Chrome)|Opera/
	            .test(window.navigator.userAgent),
	        maxFileSize: 2*1024*1024,
	        maxNumberOfFiles:1,
	        paramName:'files',
	        acceptFileTypes: /(\.|\/)(gif|jpe?g|png|bmp)$/i,
	    }).bind('fileuploaddone', function (e, data) {
	  		$('#avatar_form').find('input[name="path"]').val(data.result.data);
	  		$('#avatar_form').ajaxSubmit(function(data){
				alert(data.message);
				if(data.status==1){
					window.location.reload();
				}
			});
	    });
	})(jQuery)
	
</script>
	</div>
</body>
</html>
