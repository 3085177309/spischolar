<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp" />
<title>${condition.val }_Spi学术搜索</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch clearfix"><jsp:include
						page="include/articlesearch.jsp"></jsp:include></div>
				<div class="wraper" id="qkH">
					<div class="container ovh">
						<div class="con-hd">
							<div class="com-hd fl">
								<c:choose>
									<c:when test="${condition.type==\"quote\" }">施引文献</c:when>
									<c:when test="${condition.type==\"related\" }">相关文章</c:when>
									<c:when test="${condition.type==\"version\" }">所有版本</c:when>
									<c:otherwise>
						        		筛选:
						        	</c:otherwise>
								</c:choose>
							</div>
							<div class="resource-hd fl">找到约${result.count }条结果</div>
							<div class="fr">
								<div class="fr">
									<select class="select-nobd" onchange="loading()">
										<option value="1" onclick="loading()"
											<c:if test='${empty condition.sort or condition.sort==1 }'>selected</c:if>>
											相关性排序
										</option>
										<option value="2" <c:if test="${condition.sort==2 }">selected</c:if>>
											时间降序
										</option>
										<option value="3" <c:if test="${condition.sort==3 }">selected</c:if>>
											时间升序
										</option>
										<%-- <option value="4" <c:if test="${condition.sort==4 }">selected</c:if>>
											被引用次数
										</option> --%>
									</select> 
									<%-- <i class="i-question i-tips" <c:if test="${condition.sort==1 }">style="display:block"</c:if>>
										<div class="i-tips-content">
											<span></span> 最近一年添加的文章按时间排序
										</div>
									</i> --%>
								</div>
							</div>
						</div>
						<div class="sidebar"
							style="*padding-bottom: 0; *margin-bottom: 0;">
							<c:choose>
								<c:when test="${condition.type==\"quote\" }"></c:when>
								<c:when test="${condition.type==\"related\" }"></c:when>
								<c:when test="${condition.type==\"version\" }"></c:when>
								<c:otherwise>
									<!-- 时间筛选表单 -->
									<form action="<cms:getProjectBasePath/>scholar/list"
										method="get" id="sort_form">
										<input type="hidden" name="sort" value="${condition.sort }" />
										<div
											class="oafirst <c:if test="${not empty condition.oaFirst && condition.oaFirst==1 }">in</c:if>">
											<span onclick="loading()"><i class="i i-oaicon"></i>开放资源</span><i
												class="i i-oafirst"></i>
										</div>
										<c:if test="${not empty condition.val }">
											<input type="hidden" name="val" value='${condition.val }' />
										</c:if>
										<c:if test="${not empty condition.journal }">
											<input type="hidden" name="journal"
												value='${condition.journal }' />
										</c:if>
										<c:if test="${not empty condition.fileType }">
											<input type="hidden" name="fileType"
												value="${condition.fileType }" />
										</c:if>
										<c:if test="${not empty condition.queryType }">
											<input type="hidden" name="queryType"
												value="${condition.queryType }" />
										</c:if>
										<c:choose>
											<c:when
												test="${not empty condition.oaFirst or condition.oaFirst==1 }">
												<input type="hidden" name="oaFirst"
													value="${condition.oaFirst }" />
											</c:when>
											<c:otherwise>
												<input type="hidden" name="oaFirst" value="0" />
											</c:otherwise>
										</c:choose>
										<c:forEach var="group" items="${condition.groups }"
											varStatus="index">
											<input type="hidden" name="groups[${index.index}].logic"
												value="${group.logic }" />
											<input type="hidden" name="groups[${index.index}].field"
												value="${group.field }" />
											<input type="hidden" name="groups[${index.index}].value"
												value='${group.value }' />
										</c:forEach>
										<c:forEach var="site" items="${condition.sites }"
											varStatus="siteIndex">
											<input type="hidden" name="sites[${siteIndex.index}]"
												value="${site }" class="site" />
										</c:forEach>
										<%-- <c:if test="${empty condition.sort or condition.sort==0 }"> --%>
											<div class="affectoi" style="margin-top: 20px">
												<div id="iner">
													<div class="affectoi-hd mar-bot">年份筛选</div>
													<div class="affectoi-bd">
														<input type="text" name="start_y"
															onkeyup="clearNotInt(this)" value="${condition.start_y }">
														<i></i> <input type="text" name="end_y"
															onkeyup="clearNotInt(this)" value="${condition.end_y }">
														<button type="submit" class="btn-blue fr"
													style="width: 52px; height: 25px; float: left;margin-left:16px;"
													onclick="loading()">确认</button>
													</div>
												</div>
											</div>
										<%-- </c:if> --%>
										<script type="text/javascript">
						            		function changeSortVal(v){
						            			jQuery('#sort_form input[name="sort"]').val(v);
						            		}
						            	</script>
									</form>
									<!-- 时间筛选表单End -->
									<script>
						            $(function(){
						                var html=$('#iner').html();
						                $('#seq_sl a').click(function(event) {
						                    if($(this).attr("value")==1){
						                        $('#iner').html('最近一年添加的文章按时间排序');
						                    }else{
						                        $('#iner').html(html);
						                    }
						                });
						                $("#lan_panel span").eq(0).click(function() {
						                    if($(this).attr("id")=="radio_js_in"){
						                        $('#kfzydes').html('取消即可获取更多检索结果');
						                    }else{ 
						                        $('#kfzydes').html("勾选即可获取全部开放资源结果");
						                }
						                });
						                $('.select-nobd').change(function(){
						            		if($(this).val()=='1'){
						            			$('.i-question ').show();
						            			$('.affectoi').hide();
						            			$("input[name='start_y']").val('');
						            			$("input[name='end_y']").val('');
						            		}
						            		$('#sort_form input[name="sort"]').val($(this).val());
						            		$('#sort_form').submit();
						            	})
						                
						            });
						        </script>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="content">

							<c:if
								test="${not empty condition.journal || not empty condition.fileType || not empty condition.start_y ||not empty condition.end_y || not empty condition.sites}">
								<ul class="senior-res-chose">
									<c:if test="${not empty condition.journal }">
										<li onclick="removes('journal')"><span>出版物：${condition.journal }</span></li>
									</c:if>
									<c:if test="${not empty condition.fileType }">
										<li onclick="removes('fileType')"><span">文档类型：${condition.fileType }</span></li>
									</c:if>
									<c:if
										test="${not empty condition.start_y ||not empty condition.end_y }">
										<li onclick="removes('start_y')"><span>年份：${condition.start_y }-
												${condition.end_y } </span></li>
									</c:if>
									<c:if test="${not empty condition.sites }">
										<c:forEach var="sites" items="${condition.sites }"
											varStatus="siteIndex">
											<li onclick="removes('sites[${siteIndex.index}]')"><span>来源网站：
													${sites } </span></li>
										</c:forEach>
									</c:if>
								</ul>
							</c:if>
							<c:if test="${result.count =='0' }">
								<div class="adta-list">
									<p class="nofindtips">
										建议您：<br> 请检查输入拼写是否错误；<br> 请更换检索词；<br> 请在<a
											href="<cms:getProjectBasePath/>journal">学术期刊指南</a>中检索相关期刊。
									</p>
								</div>
							</c:if>
							<div class="adta-list">
								<ul class="artlist-bd-list" id="con_wf">
									<c:forEach items="${result.rows }" var="doc" varStatus="s">
										<li>
											<h2 class="ovh">
												<c:if test="${not empty doc.href }">
													<a	<c:if test="${not empty doc.href }"> 
															href="<cms:getProjectBasePath/>scholar/bingRedirect/${doc.id}?batchId=${condition.batchId}"
														</c:if>
														target="_blank" class="link fl"> ${s.index+1+offset }、
														<c:if test="${not empty doc.docType}">${doc.docType }</c:if>
														${doc.title }
													</a>
												</c:if>
												<c:if test="${empty doc.href }">
									            	${s.index+1+offset }、
									            	<c:if test="${not empty doc.docType}">${doc.docType }</c:if>
									                 ${doc.title }
									            </c:if>
											</h2>
											<h5>${doc.source.replaceAll("\\|", "") }</h5>
											<p>${doc.abstract_.replaceAll("<br />", "")}</p>
											<h6>
												<c:if test="${not empty doc.quoteText}">
													${doc.quoteText }
													<%-- <a target="_blank"
														href='<cms:getProjectBasePath/>scholar/list?other=<cms:cmsUrl value="${doc.quoteLink }"/>&type=quote&counts=${doc.quoteText.replaceAll("被引用次数：","") }'>${doc.quoteText }</a> --%>
												</c:if>
												<%-- <c:if test="${!doc.isOpen && !doc.hasLocal}"> --%>
												<c:if test="${!doc.isOpen}">
													<a	href="javascript:deliver('${doc.id }','<c:out value=" ${doc.title }" />');"
														d-title="<c:out value=" ${doc.title }" />"
														d-url="<c:out value=" ${doc.href }" />" class="wxcd">文献互助 <span
														style="display: none;">${doc.title }</span>
													</a>
												</c:if>
												<a href="javascript:favorites('${doc.id }','${s.index }');"
													id="${doc.id}t" lang="${doc.isFavorite }" class="favorite">收藏</a>
												<a href="javascript:unfavorite('${doc.id }','${s.index }');"
													id="${doc.id}f" class="favoriteY"><b>已收藏</b></a>
												<c:if test="${not empty doc.openUri}">
													<a url_data="${doc.openUri }" class="exportdownload down" 
													docId="${doc.id }" docTitle="${doc.title }" docHref="${doc.href }">下载</a> 
												<%-- 	<a href="${doc.openUri }" target="_blank" download
													class="download down" doc_title="${doc.title }">下载</a> --%>
												</c:if>
												<c:if test="${not empty doc.quoteUrl }">
													<a url_data='${doc.quoteUrl }' class="exporttitle">导出题录</a>
												</c:if>
											</h6>
										</li>
									</c:forEach>
								</ul>
								<script type="text/javascript">
						            var favorite = $('.favorite');
						            for(var i = 0; i < favorite.length; i++) {
						            	
						            	if(favorite.eq(i).attr("lang") == "true") {
						            		$('.favorite').eq(i).hide();
						            		$('.favoriteY').eq(i).show();
						            	} else {
						            		$('.favorite').eq(i).show();
						            		$('.favoriteY').eq(i).hide();
						            	}
						            }
						            function unfavorite(id,s){
						        		$.get('<cms:getProjectBasePath/>user/unfavorite/'+id,function(data){
						        			if(data.status==1){
						        				//$("#"+id+"f").hide();
						        				$('.favoriteY').eq(s).hide();
						        				//$("#"+id+"t").show();
						        				$('.favorite').eq(s).show();
						        			}
						        		});
						        	}
						        	function favorites(id,s){
						           	 $.get('<cms:getProjectBasePath/>user/favorite/'+id,function(data){
						           		if(data.status==1){
						           			//$("#"+id+"t").hide();
						           			$('.favorite').eq(s).hide();
						    				//$("#"+id+"f").show();
						           			$('.favoriteY').eq(s).show();
						       			} else {
						       				alert(data.message);
						       			}
						           	 });
						            }
						        	
						             var chooesId;
						             function deliver(id,title){
						            	 chooesId=id;
						            	 $('body').addClass('delivers-open');
						            	 $('p#title_line').html(title);
						             }
						             
						             function search(){
						            	 var email = document.getElementById("del-email").value;
						            	 var em = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
						            	 if(!em.test(email)) {
						            		 $('#err').html("邮箱格式不正确").css("color","red");
						            		 return false;
						            	 }
						            	 $.get('<cms:getProjectBasePath/>user/dilivery/'+chooesId+'/?email='+email +'&math='+Math.random(),function(data){
						              		//alert(data.message); 
						              		if(data.message == "请不要重复提交！") {
						              			alert(data.message); 
						              		} else { 
							              		$('body').removeClass('delivers-open').addClass('deliveryAlert-open');
						              			$('#deliveryAlert-moadl div.modal-context p.c').html('');
						              			$('#deliveryAlert-moadl div.modal-context p.c').html(data.message);
						                  		deliveryAlert();
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
						                
						        </script>
								<!-- 分页表单 -->
								<form action="<cms:getProjectBasePath/>scholar/list"
									method="get" id="ajax-form">
									<c:if test="${not empty condition.val }">
										<input type="hidden" name="val" value='${condition.val }' />
									</c:if>
									<input type="hidden" name="offset" value="0" />
									<input type="hidden" name="counts" value="${result.count.replaceAll(',','').replaceAll(' ','') }" />
									<c:if test="${not empty condition.journal }">
										<input type="hidden" name="journal"
											value='${condition.journal }' />
									</c:if>
									<c:if test="${not empty condition.fileType }">
										<input type="hidden" name="fileType"
											value="${condition.fileType }" />
									</c:if>
									<c:if test="${not empty condition.start_y }">
										<input type="hidden" name="start_y"
											value="${condition.start_y }" />
									</c:if>
									<c:if test="${not empty condition.end_y }">
										<input type="hidden" name="end_y" value="${condition.end_y }" />
									</c:if>
									<c:if test="${not empty condition.sort }">
										<input type="hidden" name="sort" value="${condition.sort }" />
									</c:if>
									<c:if test="${not empty condition.queryType }">
										<input type="hidden" name="queryType"
											value="${condition.queryType }" />
									</c:if>
									<c:if
										test="${not empty condition.oaFirst or condition.oaFirst==1 }">
										<input type="hidden" name="oaFirst"
											value="${condition.oaFirst }" />
									</c:if>
									<c:forEach var="group" items="${condition.groups }"
										varStatus="index">
										<input type="hidden" name="groups[${index.index}].logic"
											value="${group.logic }" />
										<input type="hidden" name="groups[${index.index}].field"
											value="${group.field }" />
										<input type="hidden" name="groups[${index.index}].value"
											value='${group.value }' />
									</c:forEach>
									<c:if test="${not empty condition.type }">
										<input type="hidden" name="type" value="${condition.type }" />
									</c:if>
									<c:if test="${not empty condition.other }">
										<input type="hidden" name="other" value="${condition.other }" />
									</c:if>
									<c:forEach var="site" items="${condition.sites }"
										varStatus="siteIndex">
										<input type="hidden" name="sites[${siteIndex.index}]"
											value="${site }" class="site" />
									</c:forEach>
								</form>
								<!-- 分页表单End -->
								<!--和原期刊分页结构未变 直接扣过来的 -->
								<c:if test="${pageCount>0 }">
									<div class="paginatin">
										<ul>
											<li><a href="javascript:toPage(${0 });"
												onclick="loading()">首页</a></li>
											<c:if test="${currentPage>0 }">
												<li><a href="javascript:toPage(${currentPage-1 });"
													onclick="loading()">上一页</a></li>
											</c:if>
											<c:forEach var="i" begin="${start}" end="${ end}">
												<c:choose>
													<c:when test="${i==currentPage }">
														<li class="current"><a href="javascript:void(0);"
															onclick="loading()">${i+1 }</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="javascript:toPage(${i })"
															onclick="loading()">${i+1 }</a></li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<c:if test="${currentPage<pageCount }">
												<li><a href="javascript:toPage(${currentPage+1 })"
													onclick="loading()">下一页</a></li>
											</c:if>
										</ul>
									</div>
								</c:if>
								<script type="text/javascript">
									function toPage(page){
										var offset=page*10;
										$('#ajax-form').find('input[name="offset"]').val(offset);
										$('#ajax-form').submit();
									}
								</script>
							</div>
						</div>
						<div class="clear"></div>

						<!--文章加载动效-->
						<div class="loading-box loading-list-box"></div>
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

				<!-- 导出题录 -->
				<div class="modal exporttitle-moadl" id="exporttitle-moadl">
					<div class="modal-bg"></div>
					<div class="modal-line"></div>
					<div class="modal-box">
						<i class="modal-close"></i>
						<div class="modal-title">导出题录</div>
						<div class="modal-context"></div>
					</div>
				</div>
				
				<!-- 下载 -->
				<div class="modal exportdownload-moadl" id="exportdownload-moadl">
					<div class="modal-bg"></div>
					<div class="modal-line"></div>
					<div class="modal-box">
						<i class="modal-close"></i>
						<div class="modal-title">下载全文</div>
						<div class="modal-context"></div>
					</div>
				</div>

				<jsp:include page="include/toarpsearch.jsp"></jsp:include>

			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp" />
	<script src="<cms:getProjectBasePath/>resources/js/sensear.js"></script>
	<script src="<cms:getProjectBasePath/>resources/js/sidebarScroll.js"></script>
	<script type="text/javascript">
		$('.download').click(function(){
			var title = $(this).attr("doc_title");
			var url = $(this).attr("href");
			$.get('<cms:getProjectBasePath/>user/downloadRecord?title='+title+'&url='+url,function(data){
				
			}) 
		})
		
		function loading() {
			$('div.loading-box.loading-list-box').show();
		}
		
		/*
		*删除所选条件
		*/
	   function removes(id) {
		   loading();
		   $(document).find("input[name='counts']").remove();
	    	if(id == "start_y") {
	    		$(document).find("input[name='"+id+"']").remove();
	    		$(document).find("input[name='end_y']").remove();
	    	} else {
	    		$(document).find("input[name='"+id+"']").remove();
	    	}
	    	$('#ajax-form').submit();
	    }
	
	  
	  /*
	  *选中文本
	  */  
	  function selectText(element) {
	    var text =element[0];
	    $(text).addClass('selected');
	    if (document.body.createTextRange) {
	        var range = document.body.createTextRange();
	        range.moveToElementText(text);
	        range.select();
	    } else if (window.getSelection) {
	        var selection = window.getSelection();
	        var range = document.createRange();
	        range.selectNodeContents(text);
	        selection.removeAllRanges();
	        selection.addRange(range);
	        /*if(selection.setBaseAndExtent){
	            selection.setBaseAndExtent(text, 0, text, 1);
	        }*/
	    } else {
	        alert("none");
	    }
	  }
	  /*
	  *复制成功提示
	  */
	  function copySuccess(){
	    var ele=document.createElement('div');
	    $(ele).addClass('copySuccess');
	    $(ele).html('<p>复制成功</p>');
	    $(ele).appendTo($('.modal-box'));
	    setTimeout(function(){
	      $(ele).remove();
	    },1500)
	  }
	  /*
	  *复制点击事件
	  */
	  $('.copy-icon,.export-item-content').live('click',function(event){
	    var element=null;
	    if($(this).hasClass('copy-icon')){
	      element=$(this).next('.export-item-content');
	    }else{
	      element=$(this);
	    } 
	    $(this).parents('.export-item-box').addClass('active').siblings().removeClass('active');
	  	selectText(element);
	  	document.execCommand('copy','false',null);
	    if($(this).hasClass('copy-icon')&&!$.browser.mozilla){//火狐不显示复制成功
	      setTimeout(function(){
	        copySuccess();
	      },500)
	    }
	  	
	  })
	  /*
	   * 导出题录
	   */
		$('.exporttitle').click(function(){
			$('body').addClass('exporttitle-open');
			var quote= $(this).attr("url_data");
			$('.modal-context').html('').addClass('loading');
			var str='';
			var appendFlag=true;
			if(appendFlag){
			 $.get('<cms:getProjectBasePath/>scholar/quoteList', { url: quote,type : "quotes",},function(data){
				//$('.modal-context').html('');
	      		var result = eval("("+data.message+")");
	      		str='<h3 class="export-title-des">以下为常用参考文献引用格式</h3>'
	                +'<div class="export-item-box">'
						+'<div class="export-item-name">'+result.t1+'<i class="tips"><div class="tips-context">文后参考文献著录规则-国家标准<span></span></div></i></div>'
						+'<span class="copy-icon"></span>'
						+'<div class="export-item-content" contenteditable="true" id="select">'+result.r1+'</div>'
					+'</div>'
					+'<div class="export-item-box">'
						+'<span class="export-item-name">'+result.t2+'</span>'
						+'<span class="copy-icon"></span>'
						+'<div class="export-item-content">'+result.r2+'</div>'
					+'</div>'
					+'<div class="export-item-box">'
						+'<span class="export-item-name">'+result.t3+'</span>'
						+'<span class="copy-icon"></span>'
						+'<div class="export-item-content">'+result.r3+'</div>'
					+'</div>';
				if(appendFlag){
					$('.modal-title').html('').append("导出题录");
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
				if(appendFlag){
					$('.modal-title').html('').append("下载全文");
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
	</script>
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
</script>
</body>
</html>