<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!-- 右侧浮动 -->

<div class="user-sider border">
	<div class="suer-side-hd">
		<div class="gravatar">
			<div class="gravatar-bg">
				<!--图像展示div-->
				<c:choose>
					<c:when test="${empty sessionScope.front_member.avatar }">
						<img src="<cms:getProjectBasePath/>resources/images/gravatar.gif">
					</c:when>
					<c:otherwise>
						<img src="/user/showFile?filename=${sessionScope.front_member.avatar}"
							width="90" height="90">
					</c:otherwise>
				</c:choose>
				<div href="#" id="filePicker" class="modify"></div>
				<!--上传按钮-->

				<div id="fileList" class="uploader-list"></div>
				<!--图像预览div-->

			</div>

			<%--   <div style="display: none;">
            <form method="post" action="<cms:getProjectBasePath/>user/avatar" id="avatar_form">
				<input type="hidden" name="path" id="up-fileboxs"/>
	            <input type="file" name="files" id="up-filebox" accept="image/jpeg,image/png,image/gif,image/bmp">
			</form>
			</div> --%>

			<div class="gravatar-bg-poin">
				<i></i>请上传10M以内的jpg、jpeg、gif、png、bmp格式的图片
			</div>

			<p class="name">${sessionScope.front_member.nickname==null?sessionScope.front_member.username:sessionScope.front_member.nickname }</p>

			<p class="email">
				登录邮箱：<span>${sessionScope.front_member.email }</span>
			</p>

		</div>
		<div class="user-side-tab">
			<ul>
				<li class="base-info"><a
					href="<cms:getProjectBasePath/>user/profile">基本信息</a></li>
				<!--
                <li class="gravatar-set">
                    <a href="<cms:getProjectBasePath/>user/avatar">头像设置</a>
                </li>
                -->
				<li class="safe-man"><a
					href="<cms:getProjectBasePath/>user/security" target="_blank">账户安全</a></li>
				<li class="outvisit"><a
					href="<cms:getProjectBasePath/>user/applyLogin">校外访问</a></li>
			</ul>
		</div>
	</div>
</div>



<!--
++++++ 文件上传插件webuploader ++++++
***文档：http://fex.baidu.com/webuploader/
-->

<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/plugins/Web-Uploader/webuploader.css"
	type="text/css" media="all" />
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/plugins/Web-Uploader/webuploader.min.js"></script>

<script type="text/javascript">
    // 初始化Web Uploader
	var uploader = WebUploader.create({

	    // 选完文件后，是否自动上传。
	    auto: true,

        //限制上传文件个数
	    fileNumLimit: 1,

        //限制文件大小
        fileSizeLimit :10*1024*1024, 


	    // swf文件路径 （兼容到IE8 不需要加载）
	    /*swf: BASE_URL + '/js/Uploader.swf',*/

	    // 文件接收服务端。
	    server: '<cms:getProjectBasePath/>user/avatar',

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#filePicker',

	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: ''
	    }
	});

	$list=$("#fileList");

	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file ) {
	    var $li = $(
	            '<div id="' + file.id + '" class="file-item thumbnail">' +
	                '<img>' +
	                '<div class="info">' + file.name + '</div>' +
	            '</div>'
	            ),
	        $img = $li.find('img');


	    // $list为容器jQuery实例
	    $list.append( $li );

	    // 创建缩略图
	    // 如果为非图片文件，可以不用调用此方法。
	    // thumbnailWidth x thumbnailHeight 为 100 x 100
	    uploader.makeThumb( file, function( error, src ) {
	        if ( error ) {
	            $img.replaceWith('<span>不能预览</span>');
	            return;
	        }

	        $img.attr( 'src', src );
	    }, 100, 100 );
	});
    


    /**
     * 验证文件格式以及文件大小
     */
    uploader.on("error", function (type) {
        if (type == "Q_TYPE_DENIED") { //判断文件格式

            $(".gravatar-bg-poin").show();
            setTimeout(function () { 
                $(".gravatar-bg-poin").hide();
            }, 3000);
            
        } else if (type == "Q_EXCEED_SIZE_LIMIT") { //验证文件大小
        
            $(".gravatar-bg-poin").show();
            setTimeout(function () { 
                $(".gravatar-bg-poin").hide();
            }, 3000);
            
        }
    });

   

</script>