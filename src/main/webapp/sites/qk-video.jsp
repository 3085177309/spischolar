<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>投稿视频</title>
<link href="<cms:getProjectBasePath/>resources/css/video-js.css"
	rel="stylesheet">
<script src="<cms:getProjectBasePath/>resources/js/videojs-ie8.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/video.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
</head>

<body>
	<style type="text/css">
html,body,.wraper {
	height: 100%;
	overflow: hidden;
}

body {
	margin: 0;
	position: relative;
	height: 100%;
	width: 100%;
}

.wraper {
	height: auto;
	min-height: 100%;
}

video {
	width: 100%;
	height: 100%;
}
</style>
	<div class="wraper">
		<video id="example_video_1" class="video-js vjs-default-skin" controls
			preload="none" width="100%" height="100%"
			poster="<cms:getProjectBasePath/>resources/video/${submissionSystem }.png"
			data-setup="{}">
			<source
				src="<cms:getProjectBasePath/>resources/video/${submissionSystem }.mp4"
				type="video/mp4">
			<!--  <source src="<cms:getProjectBasePath/>resources/video/oceans.webm" type="video/webm">
       <source src="<cms:getProjectBasePath/>resources/video/oceans.ogv" type="video/ogg"> -->
			<track kind="captions" src="../shared/example-captions.vtt"
				srclang="en" label="English"></track>
			<!-- Tracks need an ending tag thanks to IE9 -->
			<track kind="subtitles" src="../shared/example-captions.vtt"
				srclang="en" label="English"></track>
			<!-- Tracks need an ending tag thanks to IE9 -->
			<p class="vjs-no-js">
				To view this video please enable JavaScript, and consider upgrading
				to a web browser that <a
					href="http://videojs.com/html5-video-support/" target="_blank">supports
					HTML5 video</a>
			</p>
		</video>

		<object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95"
			height="320" id="MediaPlayer1" width="310">
			<br>
			<param name="AutoStart" value="-1">
			<param name="ShowStatuBar" value="-1">
			<param name="Filename"
				value="<cms:getProjectBasePath/>resources/video/${submissionSystem }.mp4">
		</object>
	</div>
	<script type="text/javascript">
    $(function(){
    	$('#example_video_1,#MediaPlayer1').height($(window).height());
    	$('#example_video_1,#MediaPlayer1').width($(window).width())
    	if($.browser.msie&&($.browser.version ==8||$.browser.version==7)){
    		$('#example_video_1').hide();
    		$('#MediaPlayer1').show()
    	}else{
    		$('#example_video_1').show();
    		$('#MediaPlayer1').hide()
    	}
    })
    </script>
</body>

</html>
