<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="include/meta.jsp" />
<title>我的收藏</title>
<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
	<script src="<cms:getProjectBasePath/>resources/js/sidebarScroll.js"></script>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="user-man-box">
					<a href="<cms:getProjectBasePath/>user/dilivery">文献互助</a> <a
						href="<cms:getProjectBasePath/>user/history">检索历史</a> <a
						href="javascript:void(0)" class="in">我的收藏</a>
					<c:if test="${not empty front_member }">
						<a href="<cms:getProjectBasePath/>user/profile">账户管理</a>
					</c:if>
				</div>
				<div class="wraper bg">
					<div class="container">
						<div class="user-man-wraper border">
							<div class="history-tab">
								<a href="<cms:getProjectBasePath/>user/favorite?type=2"
									<c:if test="${type ==2 }">class="active"</c:if>>期刊收藏</a> <a
									href="<cms:getProjectBasePath/>user/favorite?type=1"
									<c:if test="${type ==1 }">class="active"</c:if>>文章收藏</a>
							</div>
							<c:if test="${type == 1 }">
								<ul class="artlist-bd-list">
									<c:if test="${empty data.rows }">
										<!--没有文章收藏提示-->
										<div class="unfavorite-scrap"></div>
									</c:if>
									<c:forEach var="c" items="${data.rows }">
										<c:set var="doc" value="${c.doc }"></c:set>
										<li>
											<h2 class="ovh">
												<div style="width: 80%; float: left;">
													<c:if test="${doc.href.contains('/academic/profile') }">
														<a href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id }" target="_blank" class="link fl">${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
													</c:if>
													<c:if test="${!doc.href.contains('/academic/profile') }">
														<a href="${doc.href }" target="_blank" class="link fl">${doc.title.replaceAll("<b>", "").replaceAll("</b>", "") }</a>
													</c:if>
												</div>
												<div class="fr">
													收藏时间：
													<fmt:formatDate value="${c.time }" type="date"
														pattern="yyyy-MM-dd" />
												</div>
											</h2>
											<h5>${doc.source.replaceAll("<b>", "").replaceAll("</b>", "") }</h5>
											<p>${doc.abstract_.replaceAll("<b>", "").replaceAll("</b>", "").replaceAll("<br />", "") }</p>
											<h6>
												<c:if test="${not empty doc.quoteText}">
													<c:if test="${source==1 }">
														${doc.quoteText }
													</c:if>
													<c:if test="${source==0 }">
														<a target="_blank"
														href="<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&size=20">${doc.quoteText }</a>
													</c:if>
												</c:if>
												<c:if test="${not empty doc.relatedLink}">
													<c:if test="${source==0 }">
														<a target="_blank"
														href="<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.relatedLink }"/>&type=related&size=20">相关文章</a>
													</c:if>
												</c:if>
												<c:if test="${not empty doc.versionText }">
													<c:if test="${source==0 }">
														<a target="_blank"
														href="<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.versionLink }"/>&type=version&size=20">${doc.versionText }</a>
													</c:if>
												</c:if>
												<c:if test="${!doc.isOpen && !doc.hasLocal}">
													<a
														href="javascript:delivery('${doc.id }','<c:out value=" ${doc.title }" />');"
														d-title="<c:out value=" ${doc.title }" />"
														d-url="<c:out value=" ${doc.href }" />" class="wxcd">文献互助 <span
														style="display: none;">${doc.title }</span>
													</a>
												</c:if>

												<c:if test="${not empty doc.openUri}">
													<c:if test="${!doc.href.contains('/academic/profile') }">
														<a href="${doc.openUri }" target="_blank">下载</a>
													</c:if>
													<c:if test="${doc.href.contains('/academic/profile') }">
														<a url_data="${doc.openUri }" class="exportdownload down" 
															docId="${doc.id }" docTitle="${doc.title }" docHref="${doc.href }">下载</a> 
													</c:if>
												</c:if>
												<a id="${c.docId}f"
													href="javascript:unfavorite('${c.docId}');">取消收藏</a> <a
													id="${c.docId}t" href="javascript:favorite('${c.docId}');"
													style="display: none;">收藏</a>
											</h6>
										</li>
									</c:forEach>
								</ul>
							</c:if>
							<c:if test="${type == 2 }">
								<c:if test="${empty data.rows }">
									<!--没有期刊收藏提示-->
									<div class="unfavorite-qikan"></div>
								</c:if>
								<ul class="qklist-sc-list">
									<c:forEach var="c" items="${data.rows }">
										<c:if test="${not empty c }">
											<li><c:set var="doc" value="${c.docJournal }"></c:set>
												<div class="qllist-sc-box">
													<c:choose>
														<c:when test="${not empty doc.jImage }">
															<a
																href="<cms:getProjectBasePath/>journal/detail/${c.docId}"
																class="img" target="_blank"> <img
																src="<cms:getProjectBasePath/>journal/image/${c.docId}"
																style="width: 70px; height: 94px" />
															</a>
														</c:when>
														<c:otherwise>
															<a
																href="<cms:getProjectBasePath/>journal/detail/${c.docId}"
																class="img" target="_blank"> <img
																src="<cms:getProjectBasePath/>resources/images/qk_default1.png"
																style="width: 70px; height: 94px" />
															</a>
														</c:otherwise>
													</c:choose>
													<h3>
														<a
															href="<cms:getProjectBasePath/>journal/detail/${c.docId}"
															target="_blank" class="fl">${c.content }</a><span
															class="fr">收藏时间：<fmt:formatDate value="${c.time }"
																type="date" pattern="yyyy-MM-dd" /></span>
													</h3>
													<h4 class="issn">
														<%-- <span>【ISSN】</span>${doc['issn'].substring(0,9)} --%>
													</h4>
													<p >
														<span class="soulu">
														<c:forEach var="item" items="${c.shoulu }" varStatus="idx">
															<c:if
																test="${item.key != '中科院JCR分区(大类)' && item.key != '中科院JCR分区(小类)' && item.key != 'Eigenfactor'}">
																<span class=""> ${item.key } </span>
															</c:if>
														</c:forEach> 
														</span>
														<a href="javascript:void(0)" class="fr favorite favorites"
															docId="${c.docId}" docTitle="${c.content }"
															style="display: none;">收藏</a> <a
															href="javascript:void(0)" class="fr favorite unfavorites"
															docId="${c.docId}" docTitle="${c.content }">取消收藏</a>
													</p>
												</div></li>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
							<script type="text/javascript">
			      	        	$('.favorites').each(function(i){
			      	        		$(this).click(function(){
			      	        			var id = $(this).attr("docId");
			      		        		var title = $(this).attr("docTitle");
			      		        		var type = 2;
			      		        		$.get('<cms:getProjectBasePath/>user/favorite/'+id+"?type=" + type + "&title="+title,function(data){
			      		               		if(data.status==1){
			      		               			$('.favorites').eq(i).hide();
			      		               			$('.unfavorites').eq(i).show();
			      		           			} else {
			      		           				alert(data.message);
			      		           			}
			      		               	 });
			      	        		})
			      	        	})
			      	        	$('.unfavorites').each(function(i) {
			      	        		$(this).click(function(){
			      	        			var id = $(this).attr("docId");
			      		        		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
			      		        			if(data.status==1){
			      		        				$('.unfavorites').eq(i).hide();
			      		               			$('.favorites').eq(i).show();
			      		        			}
			      		        		});
			      	        		})
			      	        		
			      	        	})
			      	        	
			                   var chooesId;
			                   function delivery(id,title){
			                  	 chooesId=id;
			                  	 $('body').addClass('delivers-open');
			                  	 $('p#title_line').html(title);
			                   }
			                   
			                   function search(){
			                  	 var email = document.getElementById("del-email").value;
			                  	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			                  	 if(!em.test(email)) {
			                  		 alert("!");
			                  		 $('#err').html("邮箱格式不正确").css("color","red");
			                  		 return false;
			                  	 }
			                  	 $.get('<cms:getProjectBasePath/>user/dilivery/'+chooesId+'/?email='+email +'&math='+Math.random(),function(data){
			                  		//alert(data.message); 
			                   		if(data.message == "请不要重复提交！") {
			                   			alert(data.message); 
			                   		} else { 
			                   			$('#deliveryAlert-moadl div.modal-context p.c').html('');
			                   			$('#deliveryAlert-moadl div.modal-context p.c').html(data.message);
			                       		deliveryAlert();
			                   			$('body').removeClass('delivers-open')
			                   			/* $('.delivers').hide(); 2016-11-7 i8+渐变过程*/
			                   		}
			                      });
			                   }
			                   
			                   $(function(){
			                       $('.delivers').find('.Win-close').click(function(e){
			                      	 $('body').removeClass('delivers-open');
			                           $('p#err').html("&nbsp;");
			                           e.preventDefault();
			                       })
			                   })
			                  	function unfavorite(id){
			                  		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
			                  			if(data.status==1){
			                  				$("#"+id+"f").hide();
			                  				$("#"+id+"t").show();
			                  			}
			                  		});
			                  	}
			                  	function favorite(id){
			                     	 $.get('<cms:getProjectBasePath/>user/favorite/'+id,function(data){
			                     		if(data.status==1){
			                     			$("#"+id+"t").hide();
			              				$("#"+id+"f").show();
			                 			}
			                     	 });
			                      }
			                  </script>
							<div class="paginatin">
								<c:if test="${data.total gt 10 }">
									<ul>
										<!-- 首页 -->
										<pg:pager items="${data.total }" url="favorite"
											export="cp=pageNumber" maxPageItems="10" maxIndexPages="10"
											idOffsetParam="offset">
											<pg:param name="type" />
											<pg:first>
												<li><a href="${pageUrl }">首页</a></li>
											</pg:first>
											<pg:prev>
												<li><a href="${pageUrl}">上一页</a></li>
											</pg:prev>
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
											<pg:next>
												<li><a id="next_page" href="${pageUrl}">下一页</a></li>
											</pg:next>
											<pg:last>
												<li><a id="last_page" href="${pageUrl}">尾页</a></li>
											</pg:last>
										</pg:pager>
									</ul>
								</c:if>
							</div>
						</div>
					</div>
				</div>
				<!-- 文献互助 00-->
				<div class="showWin delivers" id="delivers">
					<div class="Win-bj"></div>
					<div class="Win-cont">
						<div class="title">文献互助：</div>
						<div class="Win-pannel">
							<span class="Win-close"></span>
							<div class="">
								<input type="hidden" name="title"> <input type="hidden"
									name="url">
								<div class="middle-box">
									<p class="sech_title" id="title_line"></p>
								</div>


								<p class="con clearfix">
									<span>邮箱：</span> <input type="text" name="email" id="del-email"
										class="sc_put"
										value='<c:if test="${not empty sessionScope.front_member}">${sessionScope.front_member.email }</c:if>'>
									<span id="err" class="err">&nbsp;</span>
								</p>


								<div class="tc">
									<input name="journal" type="submit" class="submit-btn"
										onclick="search()" value="提交">
								</div>
							</div>
						</div>
					</div>
				</div>
		</div>
	</div>
	<!-- 文献互助结果弹窗 555-->
	<div class="modal deliveryAlert-moadl" id="deliveryAlert-moadl">
		<div class="modal-bg"></div>
		<div class="modal-line"></div>
		<div class="modal-box">
			<i class="modal-close"></i>
			<div class="modal-title">提示：</div>
			<div class="modal-context">
				<p class="c">&nbsp;</p>
			</div>
		</div>
	</div>
	<!-- 下载 -->
	<div class="modal exporttitle-moadl" id="exporttitle-moadl">
		<div class="modal-bg"></div>
		<div class="modal-line"></div>
		<div class="modal-box">
			<i class="modal-close"></i>
			<div class="modal-title">下载全文</div>
			<div class="modal-context"></div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		/*
		 * 文献互助结果弹窗
		 */
		 function deliveryAlert() {
			 $('body').addClass('deliveryAlert-open');
				
			$('.modal-close').live('click',function(){
				//$('.modal-context').html('')
			  	$('body').removeClass('deliveryAlert-open');
		  	})
		  	$('.close').live('click',function(){
				//$('.modal-context').html('')
			  	$('body').removeClass('deliveryAlert-open');
		  	})
		}
	 	/*
	  	* 下载全文
	  	*/
		$('.exportdownload').click(function(){
			$('body').addClass('exporttitle-open');
			var quote= $(this).attr("url_data");
			$('.modal-context').html('').addClass('loading');
			var str='';
			var appendFlag=true;
			var docId = $(this).attr("docId");;
			var docTitle = $(this).attr("docTitle");;
			var docHref = $(this).attr("docHref");;
			if(appendFlag){
			 $.get('<cms:getProjectBasePath/>scholar/quoteList', { url: quote,type : "download",},function(data){
				//$('.modal-context').html('');
	     		var result = eval("("+data.message+")");
	     		str='<div class="export-item-box">';
	     		var size = result.length;
	     		if(size > 2) {
	     			size = 2;
	     		}
	     		if(size == 0) {
	     			str+='抱歉，全文资源暂不可用，申请'
	     			str+='<a style="color: blue;" href="javascript:deliver(\'' + docId + '\',\''+docTitle+'\');"'
	     	      		+' d-title="'+docTitle+'" d-url="'+docHref+'">'
	     	      		+'文献互助 </a>'
	     		}
	     		for(var i=0;i<size;i++) {
	     			str+='<div class="export-item-name">'+result[i].source+'</div>'
			     			+'<div class="export-item-content-download" >'+'<a style="color: blue;" href="'+result[i].link+'" download>下载</a>'+'</div>'
							+'</div>'
	     		}
	     		str+='</div>';
	     		/* str='<div class="export-item-box">'
						+'<div class="export-item-name">'+result.source1+'</div>'
						+'<span class="copy-icon"></span>'
						+'<div class="export-item-content-download" contenteditable="true" id="select">'+result.type1+'</div>'
						+'<a href="'+result.link1+'" download>下载</a>'
					+'</div>'
					+'<div class="export-item-box">'
						+'<span class="export-item-name">'+result.source2+'</span>'
						+'<span class="copy-icon"></span>'
						+'<div class="export-item-content-download">'+result.type2+'</div>'
						+'<a href="'+result.link2+'" download>下载</a>'
					+'</div>'; */
				if(appendFlag){
					$('.modal-context').html('').append(str).removeClass('loading');
				}
				appendFlag=true;
	     	 });
			}
			$('.modal-close').live('click',function(){
				$('.modal-context').html('')
			  	$('body').removeClass('exporttitle-open');
				appendFlag=false;
		  	})
		})
		
		
		
		window.onload=function(){
			searchList();
		}
	 	
		function searchList() {
			var type = '${type}';
			var ids = '${ids}';
			if(type != 2) {
				return false;
			}
			ids = eval('(' + ids + ')');
			var data = {"ids": ids.join(',')};
			var pageUrl = 'http://cloud.test.hnlat.com/search-server/detail/ids';
			$.ajax({
				type:"get",
				dataType:"json",
				url: pageUrl,
				data:  data,
				success:function (result){
					console.log(result.body);
					ulInfo(result.body);
				},
				error:function(){
				}
			})
		}
		
		
		
		/* 期刊信息 */
		var ulInfo = function(data){
			var jsAr = new Array();
			var ul = ""; 
			var c = '${data.rows}';
			console.log(c);
			if(data.length > 0) {
				for(var i =0; i<data.length; i++) {
					var doc = data[i];
					$('.issn').eq(i).html("<span>【ISSN】</span>"+doc.issn.substring(0,9));
					var souluHtml="";
					var map = doc.souLu;
					for(var key in map){
						if(key != '中科院JCR分区(大类)' && key != '中科院JCR分区(小类)' && key != 'Eigenfactor') {
							souluHtml = souluHtml + "<span>"+key+"</span>";
						}
					}
					$('.soulu').eq(i).html(souluHtml);
				}
				
			} else {
				ul = ul + "<div class='unfavorite-qikan'></div>";
			}
			
			jsAr.push(ul);
			$("ul.qklist-sc-list").append(jsAr);
		}
		
	</script>
	<jsp:include page="include/float.jsp"></jsp:include>
	<div class="index-footer">
		<p>
			邮箱：<a href="mailto:spischolar@hnwdkj.com">spischolar@hnwdkj.com</a> </br>©<%=Calendar.getInstance().get(Calendar.YEAR) %>
			湖南纬度信息科技有限公司 湘ICP备13003055号-3
		</p>
	</div>
</body>
</html>
