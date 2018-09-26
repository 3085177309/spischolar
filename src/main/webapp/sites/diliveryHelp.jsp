<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp" />
<title>文献互助中心</title>
<link href="<cms:getProjectBasePath/>resources/css/webuploader.css"
    rel="stylesheet" />
<script src="<cms:getProjectBasePath/>resources/js/webuploader.js"></script>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<!-- 文献互助中心 主体 -->
                   <div class="literature-top">
                   	<div class="literature-top-container">
						<div class="literature-title">
							<span>文献互助中心</span>
						</div>
						<div class="literature-input">
							<input type="text" id="search_val" name="val" placeholder="请输入提交的邮箱查询" value="${val }" class="text">
							<input type="submit" id="search" value="" class="submit">
						</div>
					</div>
                   </div>
                   <div class="literature-tab">
                   	<div class="literature-tab-container">
                   		<span data-type='1' <c:if test="${type == 1 }">class="in"</c:if>><a href="javascript:void(0)">待应助</a></span>
                   		<span data-type='2' <c:if test="${type == 2 }">class="in"</c:if>><a href="javascript:void(0)">求助完成</a></span>
                   		<span><a href="<cms:getProjectBasePath/>user/dilivery">我的求助</a></span>
                   	</div>
                   </div>
                   <c:if test="${empty data.rows }">
						<!--为空-->
						<div class="wraper bg">
							<div class="container">
								<div class="user-man-wraper border">
									<div class="un-delivery-list">
										<c:if test="${not empty val }">
											<p class="poin">没有找到符合搜索条件的文献互助记录！</p>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</c:if>
                   <div class="container">
                   	<!-- 应助区域class对应： -->
                    	<!-- 我来应助 ；seek_help -->
                    	<!-- 待确认 / 正在应助 ：state_wait -->
                    	<!-- 应助状态说明文本 ：state_prompt -->
                    	<!-- 上传 ：upload -->
                    	<!-- 取消应助 ：cancel_help -->

                   	<ul class="literature-list">

                   	</ul>
                   	<!-- <div class="paginatin">
						<c:if test="${data.total gt 20 }">
							<ul>
								<pg:pager items="${data.total }" url="diliveryHelp"
									export="cp=pageNumber" maxPageItems="20" maxIndexPages="5"
									idOffsetParam="offset">
									<pg:param name="val" />
									<pg:param name="type" />
									<pg:prev>
										<li><a href="${pageUrl}">上一页</a></li>
									</pg:prev>
									<c:if test="${data.total/20 gt 5 and (cp gt 3)}">
										<pg:first>
											<li><a href="${pageUrl}">${pageNumber}</a></li>
										</pg:first>
										<c:if test="${data.total/20 gt 7 and (cp gt 4)}">
										...
										</c:if>
									</c:if>
									<pg:pages>
										<c:choose>
											<c:when test="${cp eq pageNumber }">
												<li class="current"><a
													href="javascript:return false ;">${pageNumber}</a></li>
											</c:when>
											<c:otherwise>
												<li><a href="${pageUrl}">${pageNumber}</a></li>
											</c:otherwise>
										</c:choose>
									</pg:pages>
									<c:if test="${data.total/20 gt 5 and (data.total/20 gt (cp+2))}">
										<c:if test="${data.total/20 gt 7 and (data.total/20 gt (cp+3))}">
										...
										</c:if>
										<pg:last>
											<li><a id="next_page" href="${pageUrl}">${pageNumber}</a></li>
										</pg:last>
									</c:if>
									<pg:next>
										<li><a id="next_page" href="${pageUrl}">下一页</a></li>
									</pg:next>
								</pg:pager>
							</ul>
						</c:if>
					</div> -->

					<div class="pagination"></div>

                   	<!-- 邮箱验证弹窗 -->
                    <div class="mailbox_popup">
                    	<div class="mailbox_bg"></div>
                    	<div class="mailbox_line"></div>
                    	<div class="mailbox_cont">
                    		<i class="popup_cancel"></i>
							<div class="title">邮箱验证</div>
							<div class="subtitle">请输入提交文献传递邮箱</div>
							<div class="mailbox_wrap">
								<form method="get" action="">
									<input type="text" class="mail_text">
									<input type="submit" class="mail_submit" value="提取文件">
								</form>
							</div>
                    	</div>
                    </div>
            	</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		jQuery.support.cors = true;
		var realmName = $("#realmName").val(), // 域名
			userId = $("#userId").val(), // 用户id
			userName = $("#usernameText").text(); // 用户名称
		// ajax 请求，获得数据
		$.ajax({
			url:realmName+'/front/help/wait/2?size=20&page=0',
			type:'get',
			success:function(data){
				var pageUrl = realmName+'/front/help/wait/2?';
				ajaxHand(data,pageUrl)
			}
		})

		var ajaxHand = function(data,pageUrl){
			// 分页条插件配置项
			$('.pagination').pagination({
			    coping: true,
			    totalData:data.totalElements?data.totalElements:1, // 数据总数
			    current:data.number+1, // 当前页
			    showData:20, // 每页10条
			    isHide:true,
			    prevContent: '上一页',
			    nextContent: '下一页',
			    callback: function (api) {
			    	var page = api.getCurrent() - 1;
			    	$.ajax({
			    		url:pageUrl+'page='+page+'&size=20',
						type:'get',
						success:function(data2){
							renderHtml(data2)
						}
			    	})
			    }
			});
			renderHtml(data)
		}

		// ajax得到结果后，渲染html
		var renderHtml = function(obj){
			var size=obj.size
			var num = obj.number;
			var arr = obj.content;
			$(".literature-list").html('');
			if(!arr.length){
				$(".literature-list").after('<div class="list-empty">对不起，找不到文献互助记录</div>');
				return
			}else{
				$(".literature-list").siblings('.list-empty').remove();
			}
			$.each(arr,function(ind,item){
				var obj = {
					time:item.gmtCreate,
					handTime:item.gmtModified,
					email:item.helperEmail,
					id:item.id,
					title:item.literature.docTitle,
					href:item.literature.docHref,
				}
				var give = item.giveRecords,
					uploadState=true;
				if(give.length && give[0].auditStatus!=null && give[0].auditStatus!=2 &&
					give[0].giverId == userId){
					uploadState = false;
				}
				var status=item.status;
				if(obj.handTime){
					var timex = timeDifference(obj.handTime);
				}

				var html = "<li><div class='list_title'>"+
						   "<b>"+(num*size+(ind+1))+"、标题：</b>"+
						   '<a href="'+obj.href+'" title="'+obj.title+'" target="_blank">'+obj.title+'</a>'+
						   "</div>";
				html += '<div class="seek_help_data"><span class="help_name">'+
						'求助者：<label style="">'+obj.email+'</label></span>'+
						'<span class="help_time">求助时间 ：'+obj.time+'</span>';
				if(status === 0){
					html += '<div class="help_state"><span class="seek_help doHelp" data_id="'+obj.id+'">'+
							'我来应助</span><div class="uploadDiv" style="display: none;">'+
							'<span class="upload" data_id="'+obj.id+'">上传</span>'+
							'<span class="state_prompt">距认领截止剩余<label class="fm_time"><b>900</b>秒'+
							'</label></span><span class="seek_help removeHelp" data_id="'+obj.id+'">'+
							'取消应助</span></div></div></div>';
				}else if(status === 1){
					if(uploadState){
						html += '<div class="help_state"><span class="state_wait" data_id="'+obj.id+'">'+
							'该求助已被其他用户应助</span>'+
							'<span class="state_prompt">距截止剩余<label class="fm_time on"><b>'+(900-timex)+'</b>秒</label></span></div></div>';
					}else{
						html += '<div class="help_state">'+
								'<span class="upload" data_id="'+obj.id+'">上传</span>'+
								'<span class="state_prompt">距认领截止剩余<label class="fm_time"><b>'+(900-timex)+'</b>秒'+
								'</label></span><span class="seek_help removeHelp" data_id="'+obj.id+'">'+
								'取消应助</span></div></div>';
					}
				}else if(status === 2 || status === 3){
					html += '<div class="help_state"><span class="state_wait">待确认</span></div></div>';
				}else if(status === 4){
					html += '<div class="help_state"><span class="state_wait">求助成功</span></div></div>';
				}

				html += '<div class="careful" style="display:none">注 ：支持文件类型为:pdf,txt,doc,docx,zip,rar,caj 文件不超过30MB</div></li>';
				$(".literature-list").append(html);
			})
			loadFinish()
			time_reduce();
			if($(".upload:visible").length){
				web_uploader();
			}
		}

		// 点击切换栏目
		$('.literature-tab-container>span').click(function(){
			var types = $(this).attr("data-type"),
				url,
				pageUrl;
			if(!types){
				return
			}
			if(types == 1){
				url = realmName+'/front/help/wait/2?size=20';
				pageUrl = realmName+'/front/help/wait/2?';
			}else if(types == 2){
				url = realmName+'/front/help/finish/2?size=20';
				pageUrl = realmName+'/front/help/finish/2?';
			}
			$(this).addClass('in').siblings('span').removeClass('in');
			$.ajax({
				url:url,
				type:'get',
				success:function(obj){
					types == 1 ? ajaxHand(obj) : ajaxHand(obj.body);
				}
			})
		})


		$("#search").click(function() {
			var val = $('#search_val').val();
			var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
			if(val == null || val == '' || val =="undefined") {
				alert("请输入邮箱查询！");
				return false;
			}else if(!myreg.test(val)){
				alert("邮箱格式错误！");
				return false;
			}
			$.ajax({
				url:realmName+'/front/help/records?email='+val,
				type:'get',
				success:function(obj){
					var pageUrl = realmName+'/front/help/records?email='+val+"&";
					ajaxHand(obj.body,pageUrl)
				}
			})
		})
		function loadFinish(){
			$(".literature-list .help_state .upload:visible").parents(".seek_help_data").siblings(".careful").show();
			$(".literature-list .help_name").each(function(){
				var email =$.trim($(this).find("label").text());
				if(email.indexOf("@")!=-1){
					var arr = email.split("@");
					var str1=arr[0].substring(0,1);
					var str2=arr[0].substring(arr[0].length-1);
					$(this).find("label").text(str1+'...'+str2+'@'+arr[1]);
					$(this).find("label").show();
				}
			})
		}
		function remove() {
			$('#searchEmail input[name=email]').val("");
			$('#searchEmail').submit();
		}
		function timeDifference(time){
			var date1,date2;
			if (!document.all) {
	 	       	date1 = new Date(time);
		    }else{
		    	var str = time.replace(/-/g,'/');
		    	date1 = new Date(str);
		    }
			date2 = new Date();
			return Math.floor((date2.getTime()-date1.getTime())/1000);
		}
		$('.literature-list').delegate('.help_state .doHelp','click',function() {
			var id = $(this).attr("data_id");
			var sp = $(this).parent();
			var tt = $(this);
			var url = realmName+'/front/give/'+id;

			if(!userId){
				layer.msg('请您登录后再进行应助！')
				return
			}
			$.ajax({
				url:url,
				type:"PATCH",
				data:{
					giverId:userId,
					giverName:userName
				},
				success:function(data){
				    console.log(data);
					if(data.code == 0){
						layer.msg(data.msg);
					}else if(data.code == 200) {//可以应助
						tt.hide();
						sp.children(".uploadDiv").show();
						sp.parents(".seek_help_data").siblings(".careful").show();
						time_reduce();
						web_uploader();//调用webuploader插件
					}else if(data.code == 501){
						var time = data.body.gmtModified;
						var timex = timeDifference(time);
						sp.html('<span class="state_wait"  data_id='+id+'>该求助已被其他用户应助</span><span class="state_prompt">距截止剩余<label class="fm_time on"><b>'+(900-timex)+'</b>秒</label></span>');
						time_reduce(id);
					}
				}
			})
		})
		/**取消应助*/
		$('.literature-list').delegate('.help_state .removeHelp','click',function() {
			var id = $(this).attr("data_id");
			var that=$(this);
			$.ajax({
				url:realmName+"/front/give/cancle/"+id,
				type:"PATCH",
				data:{
					giverId:userId
				},
				success:function(data){
					if(data.code == 200){
						that.parents(".seek_help_data").siblings(".careful").hide();
						that.parents(".help_state").html('<span class="seek_help doHelp" data_id="'+id+'">'+
							'我来应助</span><div class="uploadDiv" style="display: none;">'+
							'<span class="upload" data_id="'+id+'">上传</span>'+
							'<span class="state_prompt">距认领截止剩余<label class="fm_time"><b>900</b>秒'+
							'</label></span><span class="seek_help removeHelp" data_id="'+id+'">'+
							'取消应助</span></div>');
					}
				}
			})
		})
		var upload_btn,
			upload_id=$('.upload:visible').attr('data_id');


		// $("#up-dilivery").bind('change', function(e) {
		// 	fileChange(this);
		// })

		// 11-14 新增
		function time_reduce(){
			var time_s=$(".state_prompt .fm_time:visible");
			if(time_s.length){
				time_s.each(function(){
					if($(this).find("b").length>1){
						return;
					}
					var num =parseInt($(this).find("b").text());
					var that=$(this);
					that.html(fm_fun(num));
					num-=1;
					var timer1=setInterval(function(){
						if(num<=0){
							if(that.is(".on")){
								var id=that.parents(".help_state").find(".state_wait").attr("data_id");
								that.parents(".help_state").html(paren_htm(id));
							}else{
								that.parents(".help_state").find(".removeHelp").click();
							}
							clearInterval(timer1);
							timer1=null;
							return false;
						}
						that.html(fm_fun(num));
						num-=1;
					},1000);
				})
			}
		}
		function fm_fun(num){
			var m = Math.floor(num/60);
			var s = Math.floor(num%60);
			return "<b>"+m+"</b>"+"分"+"<b>"+s+"</b>"+"秒";
		}

		function paren_htm(id){
			var htm='<span class="seek_help doHelp" data_id="'+id+'">我来应助</span>';
			htm+='<div class="uploadDiv" style="display: none;"><span class="upload" data_id="'+id+'">上传</span><span class="state_prompt">距认领截止剩余<label class="fm_time"><b>900</b>秒</label></span><span class="seek_help removeHelp" data_id="20877">取消应助</span></div>';
			return htm;
		}

		function web_uploader(){
			upload_id=$('.upload:visible').attr('data_id');
			var uploader = WebUploader.create({
                auto: true,
                // swf文件路径
                swf:'<cms:getProjectBasePath/>resources/swf/Uploader.swf',

                // 文件接收服务端。
                server: 'http://cloud.test.hnlat.com/zuul/doc-delivery/front/give/upload/'+upload_id,

                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: '.upload'
            });
            // 上传前 事件
            uploader.on( 'uploadStart', function( file ) {
                var fileSize=file.size / 1024,
                    fileMaxSize=1024 * 30;//2M
                if(fileSize>fileMaxSize){
                    layer.msg("附件大小不能大于30M！");
                    uploader.stop();
                    uploader.reset();
                    return false;
                }
                if (fileSize <= 0) {
					alert("附件大小不能为0M！");
					uploader.stop();
                    uploader.reset();
                    return false;
				}
                if (!/\.(pdf|txt|doc|docx|zip|rar|caj)$/.test(file.name)) {
		            alert("附件类型必须为 pdf，txt，doc，docx，zip，rar，caj！");
		            uploader.stop();
                    uploader.reset();
		            return false;
		        }
		        upload_txt(upload_btn,file.name);
            });
            uploader.on('beforeFileQueued',function(){
            	upload_btn=$('.upload:visible');
            	uploader.options.formData.giverId=userId
            })
            // 上传失败 事件
            uploader.on( 'uploadError', function( file, reason ) {
                alert('附件上传失败！');
            });
            // 上传成功 事件
            uploader.on( 'uploadSuccess', function( file,response ) {
            	alert('您的应助文献已上传成功！');
                if (response.code == 200) {
					window.location.reload();
				}
            });
		}

		function getFileName(path){
			var pos1 = path.lastIndexOf('/');
			var pos2 = path.lastIndexOf('\\');
			var pos  = Math.max(pos1, pos2)
			if( pos<0 )
			return path;
			else
			return path.substring(pos+1);
		}
		function upload_txt(that,txt){
	        var txt_box = that.parents(".seek_help_data").siblings(".careful");
	        txt_box.css({
	        	"textIndent":"20px",
	        	"backgroundImage":"none"
	        });
	        txt_box.text("正在上传文件：  "+txt);
		}
		
		// 弹窗邮箱格式验证
		$(".mailbox_popup .mailbox_wrap .mail_submit").click(function(){
			var input_val=$(".mailbox_popup .mailbox_wrap .mail_text").val();
			if(input_val==""){
				alert("请输入您的邮箱地址！")
				return false;
			}else if(!input_val.match(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/)){
			   	alert("邮箱格式错误");
			   	return false;
			}else{
				alert("发出ajax请求！");
				// 关闭弹窗
				$(".mailbox_popup").hide();
			}
		})
	</script>
	<jsp:include page="include/float.jsp"></jsp:include>


	<div class="literature_copyright_avowal">
   		<b>版权申明</b>：用户在本平台求助获得的文献仅限用于个人学习和研究目的，不能用于任何营利目的。且应在 “合理使用” 范围内利用文献。
   	</div>


	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
