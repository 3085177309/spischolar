<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="include/meta.jsp" />
<link
	href="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/css/jquery.fileupload.css"
	type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<cms:getProjectBasePath/>resources/js/imgareaselect/css/imgareaselect-default.css" />
<title>头像设置</title>
</head>
<body>
	<div class="head sub-head">
		<jsp:include page="include/navbar.jsp"></jsp:include>
	</div>
	<div class="user-man-box">
		<a href="<cms:getProjectBasePath/>user/dilivery">文献互助</a> <a
			href="<cms:getProjectBasePath/>user/history">检索历史</a> <a
			href="<cms:getProjectBasePath/>user/favorite">我的收藏</a> <a
			href="javascript:void(0)" class="in">账户管理</a>
	</div>
	<div class="statistics-user-box"></div>
	<div class="wraper bg">
		<div class="container">
			<div class="user-man-wraper">
				<div class="user-sider border">
					<div class="suer-side-hd">
						<div class="gravatar">
							<div class="gravatar-bg">
								<c:choose>
									<c:when test="${empty sessionScope.front_member.avatar }">
										<img
											src="<cms:getProjectBasePath/>resources/images/gravatar.gif">
									</c:when>
									<c:otherwise>
										<img src="/user/showFile?filename=${sessionScope.front_member.avatar}"
											width="90" height="90">
									</c:otherwise>
								</c:choose>
								<div href="#" class="modify">
									<p class="poin">
										<i></i>请上传10M以内的jpg、jpeg、gif、png、bmp格式的图片
									</p>
								</div>

							</div>
							<p class="name">${sessionScope.front_member.nickname==null?sessionScope.front_member.username:sessionScope.front_member.nickname }</p>

							<p class="email">
								登录邮箱:<span>${sessionScope.front_member.email }</span>
							</p>

						</div>
						<div class="user-side-tab">
							<ul>
								<li class="base-info"><a
									href="<cms:getProjectBasePath/>user/profile">基本信息</a></li>
								<li class="gravatar-set in"><a href="javascript:void(0);">头像设置</a>
								</li>
								<c:if
									test="${sessionScope.front_member.username != 'spischolar'}">
									<li class="safe-man"><a
										href="<cms:getProjectBasePath/>user/security">账户安全</a></li>
									<li class="outvisit"><a
										href="<cms:getProjectBasePath/>user/applyLogin">校外访问</a></li>
								</c:if>
							</ul>

						</div>
					</div>
				</div>
				<div class="user-man-main border">
					<form method="post" action="<cms:getProjectBasePath/>user/avatar"
						id="avatar_form">
						<input type="hidden" name="path" id="up-fileboxs" />
						<div class="user-man-hd">头像设置</div>
						<div class="user-man-bd">
							<p class="p">自定义头像：</p>
							<p class="p">选择本地照片，上传编辑自己的头像</p>
							<div class="up-file">
								<span class="up-filebox"><input type="file" name="files"
									id="up-filebox"
									accept="image/jpeg,image/png,image/gif,image/bmp"></span> <span>支持jpg、jpeg、gif、png、bmp格式的图片</span><br>
								<span id="filename">未选择任何文件</span>
							</div>
							<!-- 
                    <div id="proview">
                    
                    </div> -->
							<div class="gravatar-review">头像预览</div>
							<div class="gravatar-show">
								<span> <img
									src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
									alt="" width="100" height="100" class="avatar">
									<p>大头像100*100</p>
								</span> <span class="s"> <img
									src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
									alt="" width="55" height="55" class="avatar">
									<p>小头像55*55</p>
								</span>
							</div>
							<p class="his">我使用过的标签</p>
							<ul class="his-gravatar">
								<c:choose>
									<c:when
										test="${sessionScope.front_member.fristAvatar eq 'null' || empty  sessionScope.front_member.fristAvatar}">
										<li><img
											src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
											width="48px" height="48px;"></li>
									</c:when>
									<c:otherwise>
										<li><img
											src="<cms:getProjectBasePath/>${sessionScope.front_member.fristAvatar}"
											width="48px" height="48px;"></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when
										test="${sessionScope.front_member.twoAvatar eq 'null' || empty  sessionScope.front_member.twoAvatar}">
										<li><img
											src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
											width="48px" height="48px;"></li>
									</c:when>
									<c:otherwise>
										<li><img
											src="<cms:getProjectBasePath/>${sessionScope.front_member.twoAvatar}"
											width="48px" height="48px;"></li>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when
										test="${sessionScope.front_member.threeAvatar eq 'null' || empty  sessionScope.front_member.threeAvatar}">
										<li><img
											src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
											width="48px" height="48px;"></li>
									</c:when>
									<c:otherwise>
										<li><img
											src="<cms:getProjectBasePath/>${sessionScope.front_member.threeAvatar}"
											width="48px" height="48px;"></li>
									</c:otherwise>
								</c:choose>
							</ul>
							<button type="button" class="btn-ensave">保存</button>
						</div>
					</form>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload-process.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload-validate.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/js/imgareaselect/scripts/jquery.imgareaselect.pack.js"></script>
	<script type="text/javascript">
		$("#up-filebox").bind('change', function(e) {
			console.log(e);
			fileChange(this);
		})

		var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
		function fileChange(target) {
			var fileSize = 0;
			var filepath = target.value;
			var filemaxsize = 1024 * 10;//2M 
			if (filepath) {
				var isnext = false;
				var fileend = filepath.substring(filepath.indexOf("."));
			} else {
				return false;
			}
			if (isIE && !target.files) {
				var filePath = target.value;
				var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
				if (!fileSystem.FileExists(filePath)) {
					alert("附件不存在，请重新输入！");
					return false;
				}
				var file = fileSystem.GetFile(filePath);
				fileSize = file.Size;
			} else {
				fileSize = target.files[0].size;
			}
			var size = fileSize / 1024;
			if (size > filemaxsize) {
				alert("附件大小不能大于" + filemaxsize / 1024 + "M！");
				target.value = "";
				return false;
			}
			if (size <= 0) {
				alert("附件大小不能为0M！");
				target.value = "";
				return false;
			}
		}
	</script>
	<script type="text/javascript">
		$(function() {
			$('#up-filebox').fileupload(
					{
						url : "<cms:getProjectBasePath/>user/upload",
						disableImageResize : /Android(?!.*Chrome)|Opera/
								.test(window.navigator.userAgent),
						maxFileSize : 10 * 1024 * 1024,
						maxNumberOfFiles : 1,
						paramName : 'files',
						acceptFileTypes : /(\.|\/)(gif|jpe?g|png|bmp)$/i,
					})
					.bind(
							'fileuploaddone',
							function(e, data) {
								$('.avatar').attr(
										'src',
										'<cms:getProjectBasePath/>'
												+ data.result.data);
								$('#proview').html(
										'<img src="<cms:getProjectBasePath/>'
												+ data.result.data
												+ '" height="200px"/>');
								$('#proview img').imgAreaSelect({
									handles : true,
									aspectRatio : '1:1'
								});
								$('#avatar_form').find('input[name="path"]')
										.val(data.result.data);
							});
			$('.btn-ensave').click(function(e) {
				var img = $('#up-fileboxs').val();
				if (img == '') {
					return false;
				}
				$('#avatar_form').ajaxSubmit(function(data) {
					alert(data.message);
					if (data.status == 1) {
						window.location.reload();
					}
				});
				e.preventDefult();
			});
			$('.modify').click(function(e) {
				$('#up-filebox').trigger('click');
			});
		});
		var emailEle = $(".email span"), emailVal = emailEle.html();
		var fletter = emailVal.split("@")[0].substring(0, 1).trim();
		var lletter = emailVal.split("@")[0].substring(
				emailVal.split("@")[0].length - 1,
				emailVal.split("@")[0].length).trim();
		emailEle.html(fletter + '...' + lletter + '@' + emailVal.split("@")[1]);
	</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>