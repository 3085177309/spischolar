<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:include page="include/meta.jsp" />
<link href="<cms:getProjectBasePath/>resources/css/chosen.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/js/chosen.jquery.js"></script>
<title>校外访问</title>
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

				<jsp:include page="include/user-sider.jsp"></jsp:include>

				<div class="user-man-main border">
					<div class="user-man-hd" id="nickname">校外访问</div>
					<c:if test="${member.permission == 0 || member.permission == 5}">
						<p class="inftips status1">请完善基本信息，保存后再提交申请</p>
					</c:if>
					<c:if test="${member.permission == 1 || member.permission == 3}">
						<p class="inftips status2">您已经获得长期校外访问权限！</p>
					</c:if>
					<c:if test="${member.permission == 2 }">
						<p class="inftips status4">您提交的校外访问正在申请审核中，请耐心等待...</p>
					</c:if>
					<c:if test="${member.permission == 4 }">
						<p class="inftips status3">您已获得6个月的校外访问权限，上传本人教职工证或学生证图片，可获得长期校外访问权限！</p>
					</c:if>

					<form action="<cms:getProjectBasePath/>user/applyLogin"
						method="post" id="profile_home" enctype="multipart/form-data">

						<ul class="user-man-info outside-info">

							<!-- 可校外登录，不许修改基本信息 -->
							<%--  <c:if test="${member.permission == 1 || member.permission == 3 || member.permission == 4}"> --%>
							<c:if test="${member.permission != 0 && member.permission != 5}">
								<li><label>真实姓名<em>*</em>：
								</label> <span class="text-box">${member.nickname }</span></li>
								<li><label>学校<em>*</em>：
								</label> <span class="text-box">${member.school }</span></li>
								<li><label>院系<em>*</em>：
								</label> <span class="text-box">${member.department }</span></li>
								<li><label>身份类别<em>*</em>：
								</label> <span class="text-box"> <c:choose>
											<c:when test="${member.identity ==1 }">学生</c:when>
											<c:when test="${member.identity ==2 }">老师</c:when>
											<c:when test="${member.identity ==3 }">其他</c:when>
										</c:choose>
								</span></li>
								<li><label>职工号/学号<em>*</em>：
								</label> <span class="text-box">${member.studentId }</span></li>
								<li><label>学历<em>*</em>：
								</label> <span class="text-box"> <c:choose>
											<c:when test="${member.education ==1 }">大专</c:when>
											<c:when test="${member.education ==2 }">本科</c:when>
											<c:when test="${member.education ==3 }">硕士</c:when>
											<c:when test="${member.education ==4 }">博士</c:when>
											<c:when test="${member.education ==5 }">其他</c:when>
											<c:otherwise>请选择</c:otherwise>
										</c:choose>
								</span></li>
								<li><label>性别<em>*</em>：
								</label> <span class="text-box"> <c:if test="${member.sex == 1 }">男</c:if>
										<c:if test="${member.sex == 2 }">女</c:if>
								</span></li>
								<input name="permission" type="hidden"
									value="${member.permission }">
								<input name="sex" type="hidden" value="${member.sex }">
								<input type="hidden"
									value="${empty member.education ? '' : member.education }"
									name="education">
								<input type="hidden"
									value="${empty member.entranceTime ? '': member.entranceTime }"
									name="entranceTime" id="entranceTime" />
								<input type="hidden" class="info-input" id="studentId"
									name="studentId" value="${member.studentId }" />
								<input type="hidden"
									value="${empty member.identity ? '': member.identity }"
									name="identity" id="identity" />
								<input type="hidden" name="department"
									value="${member.department }" class="info-input" />
								<input type="hidden" schoolId="" name="school"
									value="${member.school }" class="info-input" />
								<input type="hidden" name="nickname" value="${member.nickname }"
									class="info-input" />

								<input type="hidden" schoolId="" name="schoolFlag"
									value="${member.schoolFlag }" class="info-input" />
							</c:if>
							<!-- 基本信息修改 -->
							<%--  <c:if test="${member.permission != 1 && member.permission != 3 && member.permission != 4}">     --%>
							<c:if test="${member.permission == 0 || member.permission == 5}">
								<li><label>真实姓名<em>*</em>：
								</label> <span class="text-box"><input type="text"
										name="nickname" value="${member.nickname }" class="info-input" /></span>
									<span class="item-tip"></span></li>
								<li><label>学校<em>*</em>：
								</label> <span class="text-box"> <i></i> <input type="hidden"
										schoolId="" name="school" value="${member.school }"
										class="info-input" /> <select id="schoolSelect"
										class="info-input school-choose" name="schoolFlag">
											<option value="">请选择</option>
											<c:forEach var="org" items="${orgs }">
												<c:if
													test="${org.flag != 'Spis' && org.flag != 'wdkj' && member.schoolFlag != 'wdkj'}">
													<option schoolId="${org.id }" value="${org.flag }"
														<c:if test="${member.schoolFlag ==org.flag }" >selected="selected"</c:if>>${org.name}</option>
												</c:if>
												<c:if test="${member.schoolFlag == 'wdkj'}">
													<option schoolId="${org.id }" value="${org.flag }"
														<c:if test="${member.schoolFlag ==org.flag }" >selected="selected"</c:if>>${org.name}</option>
												</c:if>
											</c:forEach>
									</select> <script type="text/javascript">
                        	function department(schoolId){
                        		$.get('<cms:getProjectBasePath/>user/department/'+schoolId,function(data){
                        			$('#selectss').empty();
                        				data = eval("("+data.message+")");
                        				var trs = createTr(data);
                        				$("#selectss").append("<option value='aa'>请选择</option>");
                        				$("#selectss").append(trs);
                        				$("#selectss").trigger("chosen:updated");
                        			
                        		});
                        	}
                        	
                        	function createTr(jsonObj) {
                        		var jsAr = new Array();
                        		if(jsonObj.length != 0) {
                        			for ( var i = 0; i < jsonObj.length; i++) {
                        				var department = jsonObj[i];
                        				
                        				if("${member.department}" == department.departmentName) {
                        					jsAr.push("<option selected='selected' value='"+department.departmentId+"'>");
                        				} else {
                        					jsAr.push("<option value='"+department.departmentId+"'>");
                        				}
                        				
                        				jsAr.push(department.departmentName);
                        				jsAr.push("</option>");
                        			}
                        		} 
                        		return jsAr.join("");
                        	}
                        	
                        	
                        	$(function(){
                        		$('.school-choose').change(function(){
                        			var school=$('.school-choose option:selected').text();
                        			var schoolId = $('.school-choose option:selected').attr("schoolId");
                        			if(school == "请选择") school="";
                        			$('input[name="school"]').val(school);
                        			
                        			department(schoolId);
                        			
                        		});
                        		$('.school-choose').chosen({
                    				no_results_text:'没有找到!'
                    			});
                        	});
                        	</script>

								</span> <span class="item-tip"></span></li>

								<li class="department"><label>院系<em>*</em>：
								</label> <span class="text-box"> <input type="hidden"
										name="department" value="${member.department }"
										class="info-input" /> <select id="selectss"
										class="info-input department-choose" name="departmentId">

									</select> <script type="text/javascript">
                        	$(function(){
                        		$('.department-choose').change(function(){
                        			var department=$('.department-choose option:selected').text();
                        			if(department == "请选择"){
                        				department="";
                        			}else{
                        				
                        				$('#selectss').parents('.department').find('.item-tip').hide();
                        			}
                        			
                        			$('input[name="department"]').val(department);
                        		});
                        	});
                        	
                        	$.get('<cms:getProjectBasePath/>user/department/'+${schoolId},function(data){
                    			$('#selectss').empty();
                    			data = eval("("+data.message+")");
                				var trs = createTr(data);
                				$("#selectss").append("<option value='aa'>请选择</option>");
                				$("#selectss").append(trs);
                    			$("#selectss").trigger("chosen:updated");
                    		});
                    		$('#selectss').chosen({
                				no_results_text:'没有找到!'
                			});
                        	</script>

								</span> <span class="item-tip"></span></li>

								<li><label>身份类别<em>*</em>：
								</label> <span class="text-box"
									style="*z-index: 10; *position: relative;">
										<div class="sc_selbox"
											style="*z-index: 10; *position: absolute; *left: 0; *top: 0">
											<i></i> <span id="section_sf"> <c:choose>
													<c:when test="${member.identity ==1 }">学生</c:when>
													<c:when test="${member.identity ==2 }">老师</c:when>
													<c:when test="${member.identity ==3 }">其他</c:when>
													<c:otherwise>请选择</c:otherwise>
												</c:choose>
											</span>
											<div class="sc_selopt" style="*z-index: 10">
												<a href="javascript:chooseIdt(2)">老师</a> <a
													href="javascript:chooseIdt(1)">学生</a> <a
													href="javascript:chooseIdt(3)">其他</a>
											</div>
										</div> <input type="hidden"
										value="${empty member.identity ? '': member.identity }"
										name="identity" id="identity" /> <script
											type="text/javascript">
                            function chooseIdt(it){
                            	$('input[name="identity"]').val(it);
                            	
                            	if(it == 1) {
                            		$(".studentId").show();
                            		$(".studentTime").show();
                            	} else {
                            		$(".studentId").show();
                            		$(".studentTime").hide();
                            	} 
                            	$('#identity').parents('li').find('.item-tip').hide();
                            }
                            </script>
								</span> <span class="item-tip"></span></li>

								<!-- --------学号-------------- -->
								<li class="studentId"><label><span>职工号/学号<em>*</em>：
									</span></label> <span class="text-box"><input type="text"
										class="info-input" id="studentId" name="studentId"
										value="${member.studentId }" /></span> <span class="item-tip"></span>
								</li>
								<script type="text/javascript">
                    	$("#apply").click(function(){
                    		if("${member.nickname}" != "" && "${member.school}" !="" && "${member.department}" !="" && "${member.identity}" !="" && "${member.education}" !="" && "${member.studentId}" != "" ){
                    			if("${member.identity}" == 1  && "${member.entranceTime}" != "") {
                    				$(".infthick").show();
                    			} else if("${member.identity}" == 2) {
                    				$(".infthick").show();
                    			} else if("${member.identity}" == 3){
                    				$(".infthick").show();
                    			} else {
                    				$(".inftips").show();
                    			}
                    		} else {
                    			$(".inftips").show();
                    		}
                    	});
                    </script>

								<!-- ----------入学年份---------- -->
								<li class="studentTime" style="display: none;"><label>入学年份<em>*</em>：
								</label> <span class="text-box"
									style="*z-index: 10; *position: relative;">
										<div class="sc_selbox"
											style="*z-index: 10; *position: absolute; *left: 0; *top: 0">
											<i></i> <span id="section_ti"> <c:choose>
													<c:when test="${not empty member.entranceTime }">${member.entranceTime }</c:when>
													<c:otherwise>请选择</c:otherwise>
												</c:choose>
											</span>
											<%
												String datetime=new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()); //获取系统时间
												request.setAttribute("currentTime",datetime);
											%>
											<div class="sc_selopt">
												<c:forEach varStatus="s" begin="2005" end="${currentTime}">
													<a href="javascript:chooseIdti(${s.index })">${s.index }</a>
												</c:forEach>
											</div>
										</div> <input type="hidden"
										value="${empty member.entranceTime ? '': member.entranceTime }"
										name="entranceTime" id="entranceTime" /> <script
											type="text/javascript">
                            function chooseIdti(it){
                            	$('input[name="entranceTime"]').val(it);
                            }
                            </script>
								</span> <span class="item-tip"></span></li>

								<!-- 学历 -->
								<li><label>学历<em>*</em>：
								</label> <span class="text-box">
										<div class="sc_selbox">
											<i></i> <span id="section_xl"> <c:choose>
													<c:when test="${member.education ==1 }">大专</c:when>
													<c:when test="${member.education ==2 }">本科</c:when>
													<c:when test="${member.education ==3 }">硕士</c:when>
													<c:when test="${member.education ==4 }">博士</c:when>
													<c:when test="${member.education ==5 }">其他</c:when>
													<c:otherwise>请选择</c:otherwise>
												</c:choose>
											</span>
											<div class="sc_selopt">
												<a href="javascript:chooseEd(4)">博士</a> <a
													href="javascript:chooseEd(3)">硕士</a> <a
													href="javascript:chooseEd(2)">本科</a> <a
													href="javascript:chooseEd(1)">大专</a> <a
													href="javascript:chooseEd(5)">其他</a>
											</div>
											<input type="hidden"
												value="${empty member.education ? '' : member.education }"
												name="education" id="education">
											<script type="text/javascript">
                            		function chooseEd(it){
                            			$('input[name="education"]').val(it);
                            			$('#education').parents('li').find('.item-tip').hide();
                            		}
                            	</script>
										</div>
								</span> <span class="item-tip"></span></li>
								<li><label>性别<em>*</em>：
								</label> <span class="text-box"> <label><input name="sex"
											type="radio" value="1"
											<c:if test="${member.sex == 1 || empty member.sex }">checked="checked"</c:if>>男</label>
										<label><input name="sex" type="radio" value="2"
											<c:if test="${member.sex == 2 }">checked="checked"</c:if>>女</label>
								</span></li>
							</c:if>
							<li class="uoloadpto"><label class="fl">上传职工/学生证图片：</label>
								<div class="up-file">
									<span class="up-filebox"> <input type="file" name="file"
										id="up-filebox"
										accept="image/jpeg,image/png,image/gif,image/bmp"> <input
										type="hidden" id="path" name="path">
									</span> <span id="filename"></span> <span>支持jpg、jpeg、gif、png、bmp格式的图片</span>
								</div></li>
							<li><label>温馨提示：</label>上传本人教职工证或学生证图片，可获得长期校外访问权限！</li>
							<li style="height: 160px;">
								<div class="gravatar-review">职工/学生证图片预览</div>
								<div class="gravatar-show">
									<span> <c:if test="${empty member.identification  }">
											<img
												src="<cms:getProjectBasePath/>resources/images/gravatar.gif"
												class="gravatar" />
										</c:if> <c:if test="${not empty member.identification  }">
											<img
												src="/user/showFile?filename=${member.identification  }"
												width="100" height="100" class="gravatar" />
										</c:if> <%--  <img src="<cms:getProjectBasePath/>resources/images/gravatar.gif" alt="" width="100" height="100" class="gravatar"> --%>
									</span>
								</div>
							</li>
							<input type="hidden" name="qq" value="${member.qq }"
								class="info-input" />
							<input type="hidden" name="phone" value="${member.phone }"
								class="info-input" />
							<input type="hidden" name="intro" value="${member.intro }"
								class="info-input" />
							<c:if test="${member.permission == 0 || member.permission == 4}">
								<li class="applyLogin-li">
									<div class="applyLogin-poin">
										<i></i>
										<p>请上传10M以内的jpg、jpeg、gif、png、bmp格式的图片</p>
									</div>
								</li>
								<li><label><em>&nbsp;</em></label>
									<button type="submit" id="a" class="btn-ensave">提交申请</button></li>
							</c:if>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
		type="text/javascript"></script>
	<!-- 学号工号的显示 -->
	<c:if test="${member.identity == 1 }">
		<script>
           		$(".studentId").show();
           		$(".studentTime").show();
           </script>
	</c:if>
	<c:if test="${member.identity == 2 }">
		<script>
           		$(".studentId").show();
           		$(".studentTime").hide();
           	</script>
	</c:if>

	<c:if test="${member.permission != 1 && member.permission != 3}">
		<script type="text/javascript">

$(function(){
	//回到nickname位置
	$("#a").click(function(){
		var url = window.location.href;
		if(url.indexOf("#")==-1) {
			location.href = url+"#";
		} else {
			location.href = url;
		}
		var identitys = $('input[name="identity"]').val();
		if(identitys == 1) {
			$("#studentId").rules("remove");
   		    $("#studentId").rules("add", { required: true, messages: { required:'<span class="item-tip item-error">请输入你的编号!</span>'} });
   		 	$("#entranceTime").rules("remove");
		 	$("#entranceTime").rules("add", { required: true,number:true, messages: { required:'<span class="item-tip item-error">请选择您的入学时间!</span>', number:'<span class="item-tip item-error">请输入正确的编号！</span>'} });
		} else {
			$("#studentId").rules("remove");
   		 	$("#entranceTime").rules("remove");
   		 	$("#studentId").rules("add", { required: true, messages: { required:'<span class="item-tip item-error">请输入你的编号!</span>'} });
		} 
		
	});
	
	$.validator.setDefaults({ ignore: '' });
	//表单验证
	$('#profile_home').validate({
        submitHandler:function(form){
            $(form).Submit();
        },
        errorPlacement:function(error, element){
            var next=element.parents().siblings(".item-tip");
               //console.log(next)
               next.html(error.html());
        },
        success:function(element,label){
        },
        rules:{
            nickname:{
                required:true,
            },
            school:{
            	required:true,
            },
            identity:{
            	required:true,
            },
            education:{
            	required:true,
            },
            qq:{
                required:"#qq:checked",
                number:true,
                rangelength:[6,12],
            },
            phone:{
                required:"#phone:checked",
                number:true,
                rangelength:[11,11]
            },
            intro:{
                required:"#intro:checked",
                rangelength:[0,500]
            },
            department:{
            	required:true,
            }
           //
        },
        messages:{
            nickname:{
                required:'<span class="item-tip item-error">请输入您的姓名!</span>',
            },
            school:{
            	required:'<span class="item-tip item-error">请选择您的学校!</span>',
            },
            identity:{
            	required:'<span class="item-tip item-error">请选择您的身份!</span>',
            },
            education:{
            	required:'<span class="item-tip item-error">请选择您的学历!</span>',
            },
            qq:{
                number:'<span class="item-tip item-error">请输入正确的QQ号码！</span>',
                rangelength:'<span class="item-tip item-error">请输入正确长度的QQ号码！</span>',
            },
            phone:{
                number:'<span class="item-tip item-error">请输入11位的手机号码！</span>',
                rangelength:'<span class="item-tip item-error">请输入11位的手机号码！</span>',
            },
            intro:{
                required:'<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>',
                rangelength:'<span class="item-tip item-error">请输入少于500个字符的个人简介!</span>',
            },
            department:{
            	required:'<span class="item-tip item-error">请选择您的院系!</span>',
            }
        }
	});
});
</script>
	</c:if>

	<script type="text/javascript">
var success = '${success }';
if(success != "") {
	alert(success);
}
var emailEle=$(".email span"),emailVal=emailEle.html();
var fletter=emailVal.split("@")[0].substring(0,1).trim();
var lletter=emailVal.split("@")[0].substring(emailVal.split("@")[0].length-1,emailVal.split("@")[0].length).trim();
emailEle.html(fletter+'...'+lletter+'@'+emailVal.split("@")[1])
</script>

	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>

	<script type="text/javascript">
$("#up-filebox").bind('change',function(e){
	/*console.log(e);*/
	fileChange(this);
});

//显示提示3S后自动隐藏
function showPoinLi(){
	$(".user-man-info .applyLogin-li").show();
	setTimeout(function () { 
	    $(".user-man-info .applyLogin-li").hide();
	}, 3000);
}

var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
function fileChange(target,id) { 
	var fileSize = 0; 
	var filepath = target.value; 
	var filemaxsize = 1024*10;//2M 
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
			showPoinLi();
			return false; 
		} 
		var file = fileSystem.GetFile (filePath); 
		fileSize = file.Size; 
	} else { 
		fileSize = target.files[0].size; 
	} 
	var size = fileSize / 1024; 
	if(size>filemaxsize){ 
		showPoinLi();
		target.value =""; 
		return false; 
	} 
	if(size<=0){ 
		showPoinLi();
		target.value =""; 
		return false; 
	} 
} 
</script>
	<script type="text/javascript">
	$('#up-filebox').fileupload({
        url: "<cms:getProjectBasePath/>user/upload",
        disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
        maxFileSize: 10*1024*1024,
        maxNumberOfFiles:1,
        paramName:'files',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png|jpg|bmp)$/i,
    }).bind('fileuploaddone', function (e, data) {
  		$('.gravatar').attr("src","/user/showFile?filename="+data.result.data);
  		$('#path').val(data.result.data);
    });
</script>

	<div class="showWin infthick" id="infthick" style="display: none;">
		<div class="Win-bj"></div>
		<div class="Win-cont" id="inftips">
			<div class="Win-pannel">
				<p>请保证信息的真实性。</p>
				<form action="" id="outLogin" enctype="multipart/form-data">
					<input type="file" name="file" value="">
				</form>
				<div class="endiv">
					<a id="applyLogin" class="btn-c">确认</a><a href="#"
						class="btn-c close">取消</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
