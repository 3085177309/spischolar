<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="include/meta.jsp" />
<title>文献互助</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="user-man-box">
					<a href="javascript:void(0)" class="in">文献互助</a> <a
						href="<cms:getProjectBasePath/>user/history">检索历史</a> <a
						href="<cms:getProjectBasePath/>user/favorite">我的收藏</a>
					<c:if test="${not empty front_member }">
						<a href="<cms:getProjectBasePath/>user/profile">账户管理</a>
					</c:if>
				</div>
				<div class="wraper bg">
					<div class="container">
						<div class="user-man-wraper border">
							<!--为空-->
							<div class="un-delivery-list"
								<c:if test="${empty data.rows }">style="display:block"</c:if>>
								<c:if test="${empty email }">
									<p class="poin">对不起，找不到您的文献互助记录，请输入提交的邮箱查询！</p>
								</c:if>
								<c:if test="${not empty email }">
									<p class="poin">对不起，找不到<span class="ajaxEmail">${email}</span>的文献互助记录，请输入提交的邮箱查询！</p>
								</c:if>
								<div class="search-mail-wrap">
									<form action="<cms:getProjectBasePath/>user/dilivery"
										method="get" id="searchEmail">
										<input type="text" name="email" value=""
											placeholder="请输入提交的邮箱查询" />
										<button class="btn" type="submit"></button>
									</form>
								</div>
							</div>

							<div class="on-delivery-list"
								<c:if test="${not empty data.rows }">style="display:block"</c:if>>
								<!--顶部工具条-->
								<div class="bar-delivery clearfix">
									<div class="search-wrap">
										<form action="<cms:getProjectBasePath/>user/dilivery"
											method="get" id="searchEmail">
											<input type="text" name="email" value="${email}"
												placeholder="请输入提交的邮箱查询" />
											<button class="btn" type="submit"></button>
										</form>
									</div>
									<a href="<cms:getProjectBasePath/>user/diliveryHelp" class="return_btn">返回互助中心</a>
								</div>
								<ul class="doc-delivery">

								</ul>
								<div class="pagination"></div>
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
			userId = $("#userId").val(); // 用户id
		(function(){
			if(!userId){return}
			$.ajax({
				url:realmName+'/front/help/records/'+userId+"?size=20&page=0",
				type:"get",
				success:function(data){
					if(data.code === 200){
						var pageUrl = realmName+'/front/help/records/'+userId+"?";
						ajaxHand(data.body,pageUrl);
					}
				}
			})
		}())
		var ajaxHand = function(data,pageUrl){

			
			// 分页条插件配置项
			$('.pagination').pagination({
			    coping: true,
			    totalData:data.totalElements, // 数据总数
			    current:data.number+1, // 当前页
			    showData:20, // 每页20条
			    isHide:true,
			    homePage:"首页",
			    endPage:"尾页",
			    prevContent: '上一页',
			    nextContent: '下一页',
			    callback: function (api) {
			    	var page = api.getCurrent() - 1;
			    	$.ajax({
			    		url:pageUrl+"page="+page+"&size=20",
						type:'get',
						success:function(data2){
							renderHtml(data2.body)
						}
			    	})
			    }
			});
			renderHtml(data)

			if(!data.content.length){
				$('.pagination').hide();
			}
		}
		var renderHtml = function(obj){
			var arr = obj.content;
			$(".doc-delivery").html('');
			if(!arr){return}
			$.each(arr,function(ind,item){
				var obj = {
					handTime:item.gmtModified,
					status:item.status,
					time:item.gmtCreate,
					title:item.literature.docTitle,
					href:item.literature.docHref,
					id:item.id
				};
				if(obj.handTime){
					var timex = timeDifference(obj.handTime);
					var day = 15-(timex / 86400 | 0); // 86400 : 为一天的秒数
				}
				var state=null;
				if(obj.status == 0 || obj.status == 1 || obj.status == 2){
					state = '<em class="i3">待传递</em><s>待传递</s>';
				}else if(obj.status == 4){
					if(day>0){
						state = '<span class="download"><a href="'+(realmName+"/file/download/"+obj.id)+'">下载全文</a></span><span class="state_prompt">下载有效期还剩<b>'+day+'</b>天</span>';
					}else{
						state = '<em class="i1">传递成功</em><s>传递成功</s>'+
							'<span class="state_prompt">求助成功的论文已过<b>15</b>天有效期</span>';
					}
				}else if(obj.status == 3){
					state = '<em class="i3">等待第三方应助</em><s>等待第三方应助</s>'
				}else{
					state = '<em class="i4">没有结果</em><s>没有结果</s>'
				}
				var html = '<li>'+
								'<p class="tit"><a href="'+obj.href+'" title="'+obj.title+'" target="_blank">'+
									obj.title+'</a></p>'+
								'<p class="con"><span>时间：'+obj.time+'</span><span class="cdinc">进度：'+
									state + '</span></p>'+
							'</li>';

				$(".doc-delivery").append(html);
			})
		}

		function timeDifference(time){
			var date1 = new Date(time),
				date2 = new Date();
				return Math.floor((date2.getTime()-date1.getTime())/1000);
		}

		$("#searchEmail .btn").click(function(e){
			e.preventDefault();
			var val = $('#searchEmail:visible input[name=email]').val();
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
					if(!obj.body.content.length){
						$(".user-man-wraper .un-delivery-list").show();
						$(".user-man-wraper .on-delivery-list").hide();
						$(".user-man-wraper .un-delivery-list .poin .ajaxEmail").text(val);
						$(".user-man-wraper .un-delivery-list [name=email]").val('');
					}else{
						$(".user-man-wraper .un-delivery-list").hide();
						$(".user-man-wraper .on-delivery-list").show();
						$(".user-man-wraper .on-delivery-list #searchEmail [name=email]").val(val);
						var pageUrl = realmName+'/front/help/records?email='+val+'&';
						ajaxHand(obj.body,pageUrl);
					}
				}
			})
		})



	function remove() {
		$('#searchEmail input[name=email]').val("");
		$('#searchEmail').submit();
	}
</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
