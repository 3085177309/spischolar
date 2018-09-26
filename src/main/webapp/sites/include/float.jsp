<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!-- 右侧浮动 -->
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/css/suggest.css">
<div class="suggest2 append_qq">
	<div class="sug-app-box">
		<a href="javascript:;" class="sug sug-top" id="totop">Totop</a>
		<c:if test="${not empty sessionScope.login_org.qunwpa }">
			<div class="tool_qq">
				<i class="open"></i>
				<i class='stop'></i>
				<p>为满足用户校外科研、学习需求，特开通文献传递服务群。${sessionScope.login_org.qunwpa}</p>
			</div>
			<input hidden value="${sessionScope.front_member.showQunwpa}" id="isShowQunwpa" />
			<input hidden value="${sessionScope.showQunwpa}" id="touristIsShowQunwpa" />
		</c:if>
		<a href="<cms:getProjectBasePath/>user/diliveryHelp"  title="文献互助中心" class="sug sug-help show"></a>
		<div class="sug sug-app"   title="咨询反馈"></div>
		<a href="#" title="咨询反馈" class="sug sug-chart"></a> <a href="#"
			class="sug wx-box"> </a>
		<div class="wb-wrap wx-wrap">
			<img src="<cms:getProjectBasePath/>resources/images/weibo.jpg" alt="">
			<p>扫一扫微博二维码</p>
		</div>
		<a href="#" class="sug wb-link"> </a>
		<div class="wb-wrap">
			<img src="<cms:getProjectBasePath/>resources/images/weixin.jpg"
				alt="">
			<p>扫一扫微信二维码</p>
		</div>
		<a href="tencent://message/?Menu=yes&uin=1962740172"
			class="sug qq-link"></a>
	</div>
</div>
<div class="suggestwrap">
	<div class="sug-toggle-box active">
		<div class="sug-head">
			<span class="sug-toggle"></span> <span class="sug-swin"></span> <span
				class="sug-close"></span>
			<h3 class="fw">意见反馈</h3>
		</div>
		<div class="sug-body">
			<div class="sug-text">
				<p>
					如果您在使用过程中遇到什么问题，<br> 或者对本网站有任何建议与意见，欢迎在此留言，<br>
					我们将关注您的问题并尽快解决！
				</p>
			</div>
			<div id="sug-content-wrap">
				<div id="sug-content"></div>
				<c:if test="${empty sessionScope.front_member }">
					<div class="email-colect">
						<div class="email-in-colect">
							<p>
								您的意见我们已经收到，为方便我们能更快的<br>将反馈信息发送给您，请让我们通过电子邮件通知您！
							</p>
							<div class="email-nosend">
								<h4>请在此处填写您的电子邮箱</h4>
								<div class="email-col-wrap">
									<form id="feedback_email"
										action="<cms:getProjectBasePath/>user/feedbackEmail"
										method="get">
										<input type="text" name="email" class="email-input"> <input
											type="hidden" name="id" id="feedback_id"> <input
											type="submit" class="email-submit">
									</form>
								</div>
							</div>
						</div>
						<p class="email-post-after">
							谢谢！已经收到您的邮箱，<br> 我们会在1-3个工作日内尽快回复您！<br>
							（spischolar@hnwdkj.com）
						</p>
					</div>
				</c:if>
			</div>
		</div>
		<div class="sug-bottom">
			<form method="post" enctype="multipart/form-data" id="fb_form"
				action="<cms:getProjectBasePath/>user/feedback">
				<div class="sug-bot-head">
					<div class="sc_selbox">
						<i></i> <span id="section_fknr">期刊指南</span>
						<div class="sc_selopt" style="display: none;">
							<a href="javascript:void(0);">期刊指南</a> <a
								href="javascript:void(0);">学术搜索</a> <a
								href="javascript:void(0);">其他</a>
						</div>
						<input type="hidden" id="value_fknr" name="systemName"
							value="期刊指南">
					</div>
				</div>
				<div class="sug-bot-body">
					<div class="sug-textarea-box">
						<div class="textreabox">
							<label class="sug-upload-files"><input type="file"
								hidden="hidden" name="file" id="uploadfile"
								accept="image/gif,image/jpeg,image/jpg,image/png"></label> <input
								type="text" hidden="hidden" name="id" id="feedId"> <input
								type="text" hidden="hidden" name="memberId"
								value="${spischolarID }"> <input type="text"
								hidden="hidden" name="contact" value="${front_member.email }">
							<input type="text" hidden="hidden" name="contents" value="">
							<textarea id="content" placeholder="请输入内容..."></textarea>
							<div class="upload-file-box">
								<span class="upload-icon-2"></span>
								<p class="upload-text"></p>
								<span class="upload-del">删除</span>
							</div>
							<p>
								按Enter键发送 <input type="button" class="sug-submit" value="发送">
							</p>
						</div>
					</div>
				</div>
			</form>
			<!--  <iframe id='frameFile' name='frameFile' style='display: none;'></iframe> -->
		</div>
	</div>
	<div class="sug-toggle-box">
		<div class="sug-head">
			<span class="sug-close"></span>
			<h3 class="fw">反馈记录</h3>
		</div>
		<div class="sug-bot-body">
			<ul class="sug-his-list">
			</ul>
			<div class="new-sug-btn">
				<a href="#">新建反馈</a>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/js/suggest.js"></script>
<script type="text/javascript">
	//查看反馈列表
     //var suggestHistory;
	 $('.sug-toggle').click(function(){
		
         suggestHistoryShow();
	})
    function suggestHistoryShow(){
		 $.ajax({
			 url:'<cms:getProjectBasePath/>user/findFeedbacks',
			 cache:false,
			 success:function(result){
	             $('.sug-his-list').html("");
	             result = eval("("+result.message+")");
	             
	             //suggestHistory=result.length;
	             var str='';
	             if(result != null && result.length != 0) {
	                for ( var i = 0; i < result.length; i++) {
	                    var feedBack = result[i];
	                    var feedBackInfoList = feedBack.feedbackInfo;
	                    var feedbackLength=feedBackInfoList.length;
	                    var time =feedBack.interval;
	                        time=sug.getDateDiff(time,feedBack.time);
	                        
	                    var userimgnone='<cms:getProjectBasePath/>resources/images/gravatar.gif';
	                    var userimg='${sessionScope.front_member.avatar }'?'${sessionScope.front_member.avatar }':userimgnone;
	                    
	                    var type1Num=[],
	                        type2Num=[];
	                    for(var j=0;j<feedbackLength;j++){
	                        if(feedBackInfoList[j].type==1){
	                            type1Num.push(j);
	                        }else{
	                            type2Num.push(j);
	                        }
	                    }

	                    var type=feedBackInfoList[type1Num[type1Num.length-1]].type,
	                        content=feedBackInfoList[type1Num[type1Num.length-1]].content,
	                        options=feedBackInfoList[type1Num[type1Num.length-1]].options;
	                    if(type2Num.length){
	                        var repContent=feedBackInfoList[type2Num[type2Num.length-1]].content;
	                    }else{
	                        var repContent=null;
	                    }
	                        
	                        str+='<li onclick="findFeedBack('+feedBack.id+',\''+feedBack.contact+'\')" >'
	                                +'<div class="user-gratar">'
	                                    +'<img src="'+userimg+'" onerror="javascript:this.src=\''+userimgnone+'\'" width="48px" height="48px">'
	                                +'</div>'
	                            +'<p class="sug-title"><span class="sug-name">'+feedBack.systemName+'</span>';
	                        
	                        str+='<span class="fr sug-time">'+time+'</span></p>';


	                        
	                        if(content){
	                            str+='<p>';
	                            str+='<strong>我：</strong>'+content;
	                            var float="fl";
	                            str+='</p>';
	                        }
	                        if(repContent){
	                            str+='<p><strong>回复：</strong>'+repContent+'</p>';
	                        }
	                        if(options){
	                            str+='<p>';
	                            str+='<span class="fj-icon';
	                            if(!content){
	                                str+='fl';
	                            }
	                            str+='"><a href="'+SITE_URL+options+'" target="_blank">[附件]</a></span>';
	                            str+='</p>';
	                        }
	                        
	                        //str+='</p>';     
	                    } 
	                    str+='</li>';
	                    
	             } else {
	                  str+='<p class="sug-nodata">暂无反馈记录</p>';
	             }
	             $('.sug-his-list').append(str);
			 }
		 })
        
    }
	//提交Email
	$('#feedback_email').submit(function(){
		var email = $(".email-input").val();
		var emailRegex = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
		if(!emailRegex.test(email)) {
			alert("请输入正确的邮箱！");
			return false;
		}
		$('#feedback_email').ajaxSubmit({
            type: "GET",
            data : $('#feedback_email').serialize(),
            success: function(msg){
                sug.emailflag=false;
           	 	$(".email-in-colect").addClass('email-in-colect-hide').hide(400);
                setTimeout(function(){
                    $(".email-post-after").addClass('email-post-show');
                },500)
            }
         });
		return false;
	}) 
	//查看反馈详情
	function findFeedBack(id,contact){
		 $.ajax({
			 url:'<cms:getProjectBasePath/>user/findFeedback/'+id,
			 cache:false,
			 success:function(result){
				 result = eval("("+result.message+")");
				 $('.sug-toggle-box').show();
				 $('.sug-toggle-box.active').hide();
				 $('#sug-content').html("");
				 for(var i = 0; i < result.length; i++) {
					 var text=result[i].content;
		                 file=result[i].options,
	                     type=result[i].type,
	                     time=result[i].interval;
					 var str='';
	                 str+='<div class="';
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
	                    var files=file.split('/');
	                     str+='<div class="sug-u-bottom">'
	                             +'<span class="upload-icon"></span>'
	                             +'<span><a href="'+SITE_URL+file+'" target="_blank">'+files[files.length-1]+'</a></span>'
	                         +'</div>';
	                 }
	                 str+='</div>'
	                         +'<div class="clear"></div>'
	                         +'<div class="s-input-time">'+sug.getDateDiff(time,result[i].time)+'</div>'
	                     +'</div>';
	                 $('#sug-content').append(str);
				 }
				 if(contact == null || contact =='') {
					 $('.email-colect').addClass('email-colectShow');
					 $('#feedback_id').val(id);
				 }
				 $('#feedId').val(id);
				 $('.sug-bot-head,.sug-bot-head #section_fknr,.sug-bot-head i').addClass('disabled').attr('disabled',true);//禁止点击
	             //$('#section_fknr').addClass('disabled');
			 }
		 })
	 }



	 // 加群通知提示
	$(function(){
		var tool_qq = $(".suggest2 .tool_qq");
		if(!tool_qq.length){
		    $(".suggest2.append_qq").removeClass("append_qq");
		    return false;
		}
		var open_btn =$(".suggest2 .tool_qq i.open");
		var stop_btn =$(".suggest2 .tool_qq i.stop");
		open_btn.click(function(){
			if(!tool_qq.is(".click")){
				open_fun();
			}
		})
		stop_btn.click(function(){
			stop_fun();
		})
		function open_fun(){//展开 加群通知
			tool_qq.addClass("click");
			tool_qq.animate({
				"width":"333px"
			},120);
		}
		function stop_fun(){//收起 加群通知
			tool_qq.animate({
				"width":"53px"
			},80,function(){
				tool_qq.removeClass("click");
			});
		}
		// 需后台判断，如果用户是第一次访问，则调用 open_fun() 展开
		if ($("#isShowQunwpa").val() == "true" || $("#touristIsShowQunwpa").val() == "true"){
            open_fun();
            $.ajax({
				url:"/user/updateShowQunwp",
				type: "get",
                success: function(res){
				    // console.log(res);
                }
			})
        }
		// 	open_fun();
	})
		

</script>