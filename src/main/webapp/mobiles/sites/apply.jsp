<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>校外登录申请</title>
<jsp:include page="include/meta.jsp"></jsp:include>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/jquery.form.js"></script>
<script src="<cms:getProjectBasePath/>resources/mobiles/js/mui.min.js"></script>
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/mobiles/js/mobilebone.css">
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
</head>
<body>
	<div class="page" id="pageHome" style="overflow: auto;">
		<div class="mui-content">
			<div class="mui-scroll">
				<header>
					<div class="headwrap">
						<div class="return-back" onclick="history.go(-1)">
							<i class="icon iconfont">&#xe610;</i> <span><a>返回</a></span>
						</div>
						<p class="section-tit">校外登录申请</p>
						<div class="clear"></div>
					</div>
				</header>
				<div class="item-section">
					<form id="profile_home" method="post"
						action="<cms:getProjectBasePath/>user/applyLogin"
						data-ajax="false" enctype="multipart/form-data">
						<div class="loginbox registerbox mt0">
							<ul class="usersetting-list mt0">
								<c:if test="${member.permission != 0 && member.permission != 5}">
									<li class="block"><span class="acount-span">校外登录申请</span>
										<div class="user-info-input">
											<c:choose>
												<c:when
													test="${member.permission == 1 || member.permission == 3 }">
													<span class="outschoolbtn">长期访问权限</span>
												</c:when>
												<c:when test="${member.permission == 2 }">
													<span class="outschoolbtn ching">审核中</span>
												</c:when>
												<c:when test="${member.permission == 4 }">
													<span class="outschoolbtn">6个月访问权限</span>
												</c:when>
											</c:choose>
										</div></li>
									<li><span class="acount-span">真实姓名</span>
										<div class="user-info-input">
											<span>${member.nickname }</span> <input type="hidden"
												placeholder="" value="${member.nickname }" name="nickname">
										</div></li>
									<li><span class="acount-span">学校</span>
										<div class="user-info-input">
											<span class="userinfo-value">${member.school }</span>
										</div> <input type="hidden" id="school" name="school"
										value="${member.school }"> <input type="hidden"
										id="schoolFlag" name="schoolFlag"
										value="${member.schoolFlag }"> <input type="hidden"
										id="SchoolID" value="${schoolId }"></li>
									<li><span class="acount-span">院系</span>
										<div class="user-info-input">
											<span class="userinfo-value">${member.department }</span>
										</div> <input type="hidden" id="department" name="department"
										value="${member.department }"></li>
									<li><span class="acount-span">身份类别</span>
										<div class="user-info-input">

											<span class="userinfo-value"><c:choose>
													<c:when test="${member.identity ==1 }">学生</c:when>
													<c:when test="${member.identity ==2 }">老师</c:when>
													<c:when test="${member.identity ==3 }">其他</c:when>
												</c:choose></span> <input type="hidden" value="${member.identity }"
												name="identity">

										</div></li>
									<li><span class="acount-span">职工号/学号</span>
										<div class="user-info-input">
											<span class="userinfo-value">${member.studentId }</span> <input
												type="hidden" placeholder="" value="${member.studentId }"
												name="studentId">
										</div></li>
									
									<!-- 申请通过，如果是学生身份，显示入学年份 -->
									<c:if test="${member.identity == 1}">
										<li>
											<span class="acount-span">入学年份</span>
											<div class="user-info-input">
												<span class="userinfo-value">${member.entranceTime }</span> 
												<input type="hidden" placeholder="" value="${member.entranceTime }" name="entranceTime">
											</div>
										</li>
									</c:if>

									<li><span class="acount-span">学历</span>
										<div class="user-info-input">
											<span class="userinfo-value"><c:choose>
													<c:when test="${member.education ==1 }">大专</c:when>
													<c:when test="${member.education ==2 }">本科</c:when>
													<c:when test="${member.education ==3 }">硕士</c:when>
													<c:when test="${member.education ==4 }">博士</c:when>
													<c:when test="${member.education ==5 }">其他</c:when>
													<c:otherwise>请选择</c:otherwise>
												</c:choose></span> <input type="hidden" value="${member.education }"
												name="education">

										</div></li>
									<li><span class="acount-span">性别</span>

										<div class="user-info-input">
											<span class="userinfo-value"> <c:if
													test="${member.sex == 1 }">男</c:if> <c:if
													test="${member.sex == 2 }">女</c:if>
											</span> <input type="hidden" value="${member.sex }" name="sex">
										</div></li>
									<%-- <li>证件照片 <i class="icon iconfont fxj">&#xe60e;</i>
										<div class="user-upload-btn">
											<span class="user-upload-input"> <!-- <input id="up-filebox" type="file" onchange="fileChange(this);" name="file" class="user-upload-gravater" accept="image/jpeg,image/png,image/gif,image/bmp" multiple> -->
											</span> <span class="image-holder"> <c:if
													test="${empty member.identification  }">
													<img
														src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
														class="gravatar" />
												</c:if> <c:if test="${not empty member.identification  }">
													<img
														src="<cms:getProjectBasePath/>${member.identification  }"
														class="gravatar" />
												</c:if>
											</span>
										</div>
									</li> --%>
								</c:if>
								<c:if test="${member.permission == 0 || member.permission == 5}">
									<li class="block"><span class="acount-span">校外登录申请</span>
										<div class="user-info-input">
											<!-- <label class="ui-switch"><input type="checkbox"></label> -->
											<c:choose>
												<c:when test="${member.permission == 0 }">
													<span class="outschoolbtn">未申请</span>
												</c:when>
											</c:choose>
										</div></li>
									<li><span class="acount-span">真实姓名</span>
										<div class="user-info-input">
											<input type="text" placeholder="" value="${member.nickname }"
												name="nickname">
										</div></li>
									<li><a
										href="<cms:getProjectBasePath/>mobiles/sites/user-info-school.jsp"
										data-callback="callback" data-container="container"> <span
											class="acount-span">学校</span> <i class="icon iconfont fxj">&#xe60e;</i>
											<div class="user-info-input">
												<span class="userinfo-value" id="schoolChoose">${member.school }</span>
											</div>
									</a> <input type="hidden" id="school" name="school"
										value="${member.school }"> <input type="hidden"
										id="schoolFlag" name="schoolFlag"
										value="${member.schoolFlag }"> <input type="hidden"
										id="SchoolID" value="${schoolId }"></li>
									<li><a
										href="<cms:getProjectBasePath/>mobiles/sites/user-info-college.jsp"
										data-container="container2" data-preventdefault="schoolcheck">
											<span class="acount-span">院系</span> <i
											class="icon iconfont fxj">&#xe60e;</i>
											<div class="user-info-input">
												<span class="userinfo-value" id="departmentChoose">${member.department }</span>
											</div>
									</a> <input type="hidden" id="department" name="department"
										value="${member.department }"></li>
									<li><span class="acount-span">身份类别</span> <i
										class="icon iconfont fxj">&#xe60e;</i>
										<div class="user-info-input">
											<select name="identity">
												<option>请选择</option>
												<option value="2"
													<c:if test="${member.identity == 2 }">selected="selected"</c:if>>老师</option>
												<option value="1"
													<c:if test="${member.identity == 1 }">selected="selected"</c:if>>学生</option>
												<option value="3"
													<c:if test="${member.identity == 3 }">selected="selected"</c:if>>其他</option>
											</select>
										</div></li>
									<li><span class="acount-span">职工号/学号</span>
										<div class="user-info-input">
											<input type="text" placeholder=""
												value="${member.studentId }" name="studentId">
										</div></li>
									
									<li class="studentTime" style="display: none;">
										<span class="acount-span">入学年份</span>
										<div class="user-info-input">
											<select name="entranceTime">
												<option>请选择</option>
												<option value="2005">2005</option>
												<option value="2006">2006</option>
												<option value="2007">2007</option>
												<option value="2008">2008</option>
												<option value="2009">2009</option>
												<option value="2010">2010</option>
												<option value="2011">2011</option>
												<option value="2012">2012</option>
												<option value="2013">2013</option>
												<option value="2014">2014</option>
												<option value="2015">2015</option>
												<option value="2016">2016</option>
												<option value="2017">2017</option>
												<option value="2018">2018</option>
											</select>
										</div>
									</li>

									<li><span class="acount-span">学历</span> <i
										class="icon iconfont fxj">&#xe60e;</i>
										<div class="user-info-input">
											<!-- <c:if test="${member.education == null }"><span class="userinfo-value">请选择</span></c:if> -->
											<select name="education">
												<option>请选择</option>
												<option value="4"
													<c:if test="${member.education == 4 }">selected="selected"</c:if>>博士</option>
												<option value="3"
													<c:if test="${member.education == 3 }">selected="selected"</c:if>>硕士</option>
												<option value="2"
													<c:if test="${member.education == 2 }">selected="selected"</c:if>>本科</option>
												<option value="1"
													<c:if test="${member.education == 1 }">selected="selected"</c:if>>大专</option>
												<option value="5"
													<c:if test="${member.education == 5 }">selected="selected"</c:if>>其他</option>
											</select>
										</div></li>
									<li><span class="acount-span">性别</span> <i
										class="icon iconfont fxj">&#xe60e;</i>
										<div class="user-info-input">
											<!-- <a href="#" class="userinfo-value">男</a> -->
											<select name="sex">
												<option>请选择</option>
												<option value="1"
													<c:if test="${member.sex == 1 }">selected="selected"</c:if>>男</option>
												<option value="2"
													<c:if test="${member.sex == 2 }">selected="selected"</c:if>>女</option>
											</select>
										</div></li>
								</c:if>
									<li><label for="up-filebox" class="up-filebox">
											证件照片 <i class="icon iconfont fxj">&#xe60e;</i>
											<div class="user-upload-btn">
												<span class="user-upload-input"> <input
													id="up-filebox" onchange="fileChange(this);" type="file"
													name="file" class="user-upload-gravater" accept="image/*"
													multiple> <input type="hidden" id="path"
													name="path">
												</span> <span class="image-holder"> <c:if
														test="${empty member.identification  }">
														<img
															src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
															class="gravatar" />
													</c:if> <c:if test="${not empty member.identification  }">
														<img
															src="/user/showFile?filename=${member.identification  }"
															class="gravatar" />
													</c:if>
												</span>
											</div>
									</label></li>
							</ul>
						</div>
						<input type="hidden" name="isMobile" value="yes" />
						<div class="register-submit">
							<c:if test="${member.permission == 0 || member.permission == 4}">
								<input type="submit" value="提交">
							</c:if>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="container"></div>
	<div id="container2"></div>
	<div id="container3"></div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/mobilebone.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script>
var msg = '${success}';
if(msg != null && msg !='' ) {
	alert(msg);
}

$("body").height($(window).height());
var scrollHeight = $(window).height()-$(".fix-nav").height();
$(".mui-content").height(scrollHeight);

var headwrapHeight=$(".headwrap").height(),
	$schoolSide=$(".school-side-chose"),
	$schoolSideinNode=$(".school-side-chose a");
/* (function($) {
	$('.mui-content').scroll({
		indicators: false
	});
})(mui); */

var CollegeHtml="";
Mobilebone.captureForm = false;
Mobilebone.evalScript = true;
Mobilebone.pushStateEnabled=false;
Mobilebone.init();

FUN={
		//学校
	home:function(pageInto,pageOut,response){
		$(pageOut).find(".school-side-chose").hide();
	},
	start: function(page, into_or_out, options) {
	
		(function($) {
			var scroll2=$('.ui-scroller2').scroll({
				indicators: false
			});
			window.scroll2=scroll2;
		})(mui);
		
	},
	end: function(page, into_or_out) {
		$(".school-side-chose").show().height(scrollHeight);
		
		if($("#container .page.out").css("display")=="none" || $("#pageHome .page.in").css("display")=="block"){
			$(".school-side-chose").hide();
		}
		$(".school-data-list a").click(function(){
			var schoolChoosed=$(this).attr("data-flag");
			$("#schoolChoose").text($(this).text());
			$("#school").val($(this).text());
			$("#schoolFlag").val(schoolChoosed);
			$("#SchoolID").val($(this).attr("SchoolID"))
			$("#departmentChoose").text("请选择学院");
			$('#department').val("");
		})
	},
	//院系
	schoolScroll:function(target){
		var el=$(target).html();
		$(".school-side-chose a").removeClass("in");
		$(target).addClass("in");
		mui('.ui-scroller2').scroll().scrollTo(0,-document.getElementById(el).offsetTop,100);
		return true;
	},
	callback:function(pageInto){
		$(".school-side-chose a").css('visibility','visible')
		if($("#container .page.out").css("display")=="none" || $("#pageHome .page.in").css("display")=="block"){
			$(".school-side-chose").hide();
		}
		
	},
	startCollege:function(){
		//if($('#schoolChoose').val().length){
			(function($) {
				$('.ui-scroller3').scroll({
					indicators: false
				});
			})(mui);
			var schoolId=$("#SchoolID").val();
			$.get('<cms:getProjectBasePath/>user/department/'+schoolId,function(data){
					
				//alert(data.message);
				var data = eval("("+data.message+")");
				CollegeHtml="";

					if(data.length != 0) {
						
	        			for ( var i = 0; i < data.length; i++) {
	        				var department = data[i];
	        				CollegeHtml=CollegeHtml+'<li><a href="#pageHome" data-rel="back">'+department.departmentName+'</a></li>';
	        			}
	        		} 
			});
	},
	endCollege:function(){
		
			$("#CollegeData").html(CollegeHtml);
			$("#CollegeData a").on("click",function(){
				$("#departmentChoose").html($(this).text());
				$("#department").val($(this).text());
			})
		//}else{
			
			return false;
		//}
		
	},
	service:function(){
		(function($) {
			$('.ui-scroller4').scroll({
				indicators: false
			});
		})(mui);
	},
}
var schoolcheck=function(target) {
    // 支持一个参数target, 指的就是对应的a元素
    // 如果没有登录，返回true
	    if($('#schoolChoose').text().length){
	    	return false
	    }else{
	    	alert('请先选择学校');
	    	return true;
	    }   
	}
Mobilebone.rootTransition = FUN;

$.validator.setDefaults({ ignore: '' });
//表单验证
jQuery(function(){
	$(".usersetting-list select[name='identity']").change(function(){
		if($(this).val() == '1'){
			$("li.studentTime").show();
		}else{
			$("li.studentTime").hide();
		}
	})
	
	$('.register-submit input').click(function(e){
		if($('input[name="nickname"]').val()==''){
			layer.open({
    			content:'请输入您的姓名!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($('input[name="studentId"]').val()==''){
			layer.open({
    			content:'请输入您的职工号/学号!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($(".usersetting-list select[name='identity']").val()=="请选择"){
			layer.open({
    			content:'请选择身份类别!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($(".usersetting-list select[name='identity']").val()=='1' && 
			$(".usersetting-list select[name='entranceTime']").val()=='请选择'){
			layer.open({
    			content:'请选择您的入学时间!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($(".usersetting-list select[name='education']").val()=="请选择"){
			layer.open({
    			content:'请选择学历!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else if($(".usersetting-list select[name='sex']").val()=="请选择"){
			layer.open({
    			content:'请选择性别!',
    			time:2
    		})
			e.preventDefault();
			e.stopPropagation();
		}else{
			$('#profile_home').validate({
				onkeyup:false,
				onfocusout:false,
				focusInvalid:false,
			    submitHandler:function(form){
			    	if($('#schoolFlag').val()==""){
			    		layer.open({
			    			content:"请选择学校",
			    			time:2
			    		});
			    		return false;
			    	}else if($('#department').val()==""){
			    		layer.open({content:"请选择学院！",time:2});
			    		return false;
			    	}
			    	
			    	$(form).Submit();
			    },
			    errorPlacement:function(error, element){
			    	if(error.text()){
		        		layer.open({
		        			content:error.text(),
		        			time:2
		        		})
		        	}
			        /*var next=element.parents().siblings(".error-tips");
			           next.html(error.html());
			         //  alert(error.html());
			         setTimeout(function(){
			        	 next.html("");
		   				
		   			},2000);
			        $(element).attr("placeholder",error.html());*/
			    },
			    success:function(element,label){
			    	$(".register-submit").addClass("sure");
			    },
			    rules:{
			        nickname:{
			            required:true,
			        },
			        identity:{
			        	required:true,
			        },
			        education:{
			        	required:true,
			        },
			        studentId:{
			        	required:true,
			        }
			    },
			    messages:{
			        nickname:{
			            required:'请输入您的姓名!',
			        },
			        identity:{
			        	required:'请选择您的身份!',
			        },
			        education:{
			        	required:'请选择您的学历!',
			        },
			        studentId:{
			        	required:'请输入您的职工号/学号!',
			        }
			    }
			});
		}
	})
});
</script>
	<script type="text/javascript"> 
var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
function fileChange(target,id) { 
	var fileSize = 0; 
	var filepath = target.value; 
	var filemaxsize = 1024*2;//2M 
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
			content:"附件大小不能大于2M!",
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
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>

	<script type="text/javascript">
	$('#up-filebox').fileupload({
        url: "<cms:getProjectBasePath/>user/upload",
        disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
        maxFileSize: 2*1024*1024,
        maxNumberOfFiles:1,
        paramName:'files',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png|bmp)$/i,
    }).bind('fileuploaddone', function (e, data) {
  		$('.gravatar').attr("src","<cms:getProjectBasePath/>"+data.result.data);
  		$('#path').val(data.result.data);
    });
</script>
</body>
</html>