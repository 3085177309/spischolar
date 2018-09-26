<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set scope="request" var="navIndex" value="2"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="./scholar/meta.jsp"></jsp:include>
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/css/showLoading.css" />
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/jquery.showLoading.js"></script>
<title>检索结果</title>
<style>
.delivers {
	height: 190px !important;
}

.delivers .sech_title {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	word-wrap: normal;
	width: 100%;
	text-align: center;
}

.delivers .seach_contant {
	width: 80%;
	margin: 0 auto;
	display: block;
	height: 25px;
	border: 1px solid #e1e1e1;
	padding-left: 12px;
}

@media screen and (max-width: 980px) {
	.Subject .Sub_opt .r_con .r_res,.Subject .Sub_opt .opt_zy {
		display: none;
	}
	.Subject .Sub_opt .opt_lw {
		display: none;
	}
	.Subject .Sub_seah .seah_auto {
		width: 96%;
		margin: 0 auto;
	}
	.Subject .Sub_seah .seah_auto .txt_cont {
		width: 60%;
	}
	.Subject .Sub_opt {
		width: 96%;
		margin: 0 auto;
	}
	.Subject .Sub_opt .opt_lw .lw_seq,.Subject .Sub_opt .opt_lw,.Subject .Sub_opt .r_con
		{
		width: 100%;
	}
}

@media screen and (max-width: 460px) {
	.Subject .Sub_seah .seah_auto .txt_cont {
		width: 50%;
	}
	.Subject .Sub_opt .opt_lw .lw_seq .seq_sl {
		margin-bottom: 12px;
	}
}

.paginatin {
	margin-top: 20px;
	margin-bottom: 20px;
	text-align: center;
	font-size: 12px
}

.paginatin ul,.paginatin li {
	display: inline;
	border-bottom: none !important;
}

.paginatin li {
	display: inline;
	padding: 2px 0
}

.paginatin li a {
	padding: 4px 7px;
	line-height: 12px;
	display: inline-block;
	text-align: center;
	border: 1px solid #dedede;
	color: #666;
}

.paginatin li a:hover {
	color: #454545;
	border: 1px solid #4496cc;
}

.paginatin .current a {
	color: #fff;
	background: #4496cc;
}
</style>
</head>
<body style="position: relative; overflow: hidden;">
	<jsp:include page="./scholar/header.jsp"></jsp:include>
	<section class="Subject" id="Middle">
		<div class="Sub_seah">
			<div class="seah_auto cf">
				<form action="<cms:getProjectBasePath/>docList" method="get"
					id="searchForm">
					<input type="text" name="val" class="txt_cont"
						value="${searchKey }" style="padding-left: 10px;" /> <input
						type="submit" name="" class="txt_btn" value="" /> <a
						href="javascript:;;" id="p1">高级</a> <input name="oaFirst"
						type="hidden" />
				</form>
				<p style="float: right; margin-right: 442px;">
					<a href="<cms:getProjectBasePath/>docHis"
						style="color: #666; padding-right: 20px;">我的检索历史</a> <a
						style="color: #666; padding-right: 20px;"
						href="<cms:getProjectBasePath/>docDilivery/view">文献传递查询</a>
				</p>
				<p>
					<input name="oaFirst" type="checkbox" value="1" id="kfzy"
						style="vertical-align: middle; margin-top: -2px;"
						<c:if test="${condition.oaFirst==1 }">checked="checked"</c:if> />
					<span style="color: #666">开放资源</span><span
						style="margin-left: 20px; color: #89A0AF;" id="kfzydes"> <c:if
							test="${condition.oaFirst==0 }">勾选即可获取全部开放资源结果</c:if> <c:if
							test="${condition.oaFirst==1 }">取消即可获取更多检索结果</c:if>
					</span>
				</p>
			</div>
		</div>
		<div class="Sub_opt cf">
			<c:if
				test="${condition.type!='quote' && condition.type!='related' && condition.type!='version'}">
				<!-- 排序 -->
				<div class="opt_lw fl">
					<div class="lw_seq">
						<form action="<cms:getProjectBasePath/>docList" method="get"
							id="sort_form">
							<c:if test="${not empty condition.val }">
								<input type="hidden" name="val" value="${condition.val }" />
							</c:if>
							<c:if test="${not empty condition.journal }">
								<input type="hidden" name="journal"
									value="${condition.journal }" />
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
									value="${group.value }" />
							</c:forEach>
							<c:forEach var="site" items="${condition.sites }"
								varStatus="siteIndex">
								<input type="hidden" name="sites[${siteIndex.index}]"
									value="${site }" class="site" />
							</c:forEach>
							<select name="sort" class="seq_sl fl" id="seq_sl">
								<option value="0"
									<c:if test="${empty condition.sort or condition.sort==0 }">selected="selected"</c:if>>相关排序</option>
								<option value="1"
									<c:if test="${condition.sort==1 }">selected="selected"</c:if>>时间排序</option>
							</select>
							<p class="fl" id="iner">
								<span>年份筛选:</span> <input type="text" name="start_y"
									class="seq_txt" value="${condition.start_y }" /> <span
									class="seq_h">--</span> <input type="text" name="end_y"
									class="seq_txt" value="${condition.end_y }" />

							</p>
							<input type="submit" class="seq_btn" value="确定" />
						</form>
					</div>
					<script>
                    $(function(){
                    	var html=$('#iner').html();
                    	if($('#seq_sl').val()==1){
                    		$('#iner').html('最近一年添加的文章按照时间排序');
                    	}
                    	$('#seq_sl').bind('change',function(){
                    		if($(this).val()==1){
                    			$('#iner').html('最近一年添加的文章按照时间排序');
                    		}else{
                    			$('#iner').html(html);
                    		}
                    	});
                    	$('#kfzy').click(function(){
                    		var form=$('#sort_form');
                    		if($(this).is(':checked')){
                    			form.find('input[name="oaFirst"]').val(1);
                    		}else{
                    			form.find('input[name="oaFirst"]').val(0);
                    		}
                    		form.submit();
                    	});
                    	$('#searchForm').bind('submit',function(){
                    		if($('#kfzy').is(":checked")){
                    			$(this).find('input[name="oaFirst"]').val(1);
                    		}
                    	});
                    });
                    </script>
				</div>
				<!-- 排序end -->
				<c:if test="${dbs!= null && fn:length(dbs) > 0}">
					<!-- 馆藏资源 -->
					<div class="opt_zy fr">
						<form action="<cms:getProjectBasePath/>docList" method="get"
							id="gc_form">
							<c:if test="${not empty condition.val }">
								<input type="hidden" name="val" value="${condition.val }" />
							</c:if>
							<c:if test="${not empty condition.journal }">
								<input type="hidden" name="journal"
									value="${condition.journal }" />
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
									value="${group.value }" />
							</c:forEach>
							<h3>本馆已购资源</h3>
							<ul>
								<c:forEach var="d" items="${dbs }" varStatus="i">
									<li><input name="" type="checkbox" value="${d.url }"><span>${d.dbName }</span></li>
								</c:forEach>
							</ul>
							<input name="" type="submit" class="rl_button" value="筛 选">
						</form>
					</div>
					<script type="text/javascript">
                $(function(){
                	$('#gc_form').bind('submit',function(){
                		var index=0;
                		$(this).find('ul > li >input[type="checkbox"]:checked').each(function(){
                			var html='<input type="hidden" name="sites['+index+']" value="';
                			html+=$(this).val();
                			html+='" />';
                			$('#gc_form').append(html);
                			index++;
                		});
                	});
                	$('#sort_form input.site').each(function(){
                		var url=$(this).val();
                		$('#gc_form ul > li >input[type="checkbox"]').each(function(){
                			if($(this).val()==url){
                				$(this).attr('checked',true);
                			}
                		});
                	});
                });
                </script>
					<!-- 馆藏资源End -->
				</c:if>
			</c:if>
			<!-- 删除选项 -->
			<div class="r_con fl" id="r_con">
				<form action="<cms:getProjectBasePath/>docList" method="get"
					id="hidden_form">
					<c:if test="${not empty condition.val }">
						<input type="hidden" name="val" value="${condition.val }" />
					</c:if>
					<c:if test="${not empty condition.journal }">
						<input type="hidden" name="journal" value="${condition.journal }" />
					</c:if>
					<c:if test="${not empty condition.fileType }">
						<input type="hidden" name="fileType"
							value="${condition.fileType }" />
					</c:if>
					<c:if test="${not empty condition.start_y }">
						<input type="hidden" name="start_y" value="${condition.start_y }" />
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
						<input type="hidden" name="oaFirst" value="${condition.oaFirst }" />
					</c:if>
					<c:forEach var="group" items="${condition.groups }"
						varStatus="index">
						<input type="hidden" name="groups[${index.index}].logic"
							value="${group.logic }" />
						<input type="hidden" name="groups[${index.index}].field"
							value="${group.field }" />
						<input type="hidden" name="groups[${index.index}].value"
							value="${group.value }" />
					</c:forEach>
					<c:forEach var="site" items="${condition.sites }"
						varStatus="siteIndex">
						<input type="hidden" name="sites[${siteIndex.index}]"
							value="${site }" />
					</c:forEach>
				</form>
				<dl class="r_res">
					<dd>
						<c:if test="${condition.type=='quote' }">
							<b>施引文章</b>
						</c:if>
						<c:if test="${condition.type=='related' }">
							<b>所有文字</b>
						</c:if>
						<c:if test="${condition.type=='version' }">
							<b>所有版本</b>
						</c:if>
						找到约${result.count }条结果
					</dd>
					<c:if test="${not empty condition.journal }">
						<dt field="journal">
							<span>出版物：${condition.journal }</span>
						</dt>
					</c:if>
					<c:if test="${not empty condition.fileType }">
						<dt field="fileType">
							<span>文档类型：${condition.fileType }</span>
						</dt>
					</c:if>
					<c:if test="${not empty condition.start_y }">
						<dt field="start_y">
							<span>年份：${condition.start_y }- <c:choose>
									<c:when test="${empty condition.end_y }">现在</c:when>
									<c:otherwise>${condition.end_y }</c:otherwise>
								</c:choose>
							</span>
						</dt>
					</c:if>
					<c:forEach var="site" items="${condition.sites }" varStatus="i">
						<dt field="sites[${i.index }]">
							<span>来源网站：${site }</span>
						</dt>
					</c:forEach>
				</dl>
				<jsp:include page="./docListInc.jsp"></jsp:include>
				<div class="paginatin">
					<ul>
						<c:if test="${currentPage>0 }">
							<li><a href="javascript:toPage(${currentPage-1 });">上一页</a></li>
						</c:if>
						<c:forEach var="i" begin="${start}" end="${ end}">
							<c:choose>
								<c:when test="${i==currentPage }">
									<li class="current"><a href="javascript:void(0);">${i+1 }</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="javascript:toPage(${i })">${i+1 }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${currentPage<pageCount }">
							<li><a href="javascript:toPage(${currentPage+1 })">下一页</a></li>
						</c:if>
					</ul>
				</div>
			</div>
			<script type="text/javascript">
                function id(id){
                    return document.getElementById(id);
               	}
                (function($){
                	function sortSites(){
                		var index=0;
                		$('#hidden_form input[name^="sites"]').each(function(){
                			$(this).attr('name','sites['+index+']');
                			index++;
                		});
                	}
                	$(function(){
                		var odt=id("r_con").getElementsByTagName("dt");
                		for (var i = 0; i < odt.length; i++) {
                      	  (function(index){
                      		  odt[index].onclick=function(){
                      			  var tar=$(odt[index]);
                      			  var name=tar.attr('field')
                      			  var ele=$('#hidden_form').find('input');
                      			  ele.each(function(){
                      				  var _name=$(this).attr('name');
                      				  if(_name==name){
                      					  $(this).remove();
                      				  }
                      			  });
                      			  if(name=='start_y'){//同时删除结束年份
                      				$('#hidden_form').find('input[name="end_y"]').remove();
                      			  }
                      			  sortSites();
                      			  $('#hidden_form').submit();
                      			  this.parentNode.removeChild(this);
                      		  }
                      	  })(i);
                        };  
                	});
                })(jQuery);
                </script>
			<!-- 删除选项End -->
			<script>
                (function($){
                	$(function(){
                		var oli=id("r_con").getElementsByTagName("li");
                	 	/*function run(){
                        	var scrtop=document.documentElement.scrollTop||document.body.scrollTop,
                           	WinH=document.documentElement.clientHeight;
                           	for (var i = 0; i < oli.length; i++) {*/
                            	/*liH=(oli[i].offsetHeight)/3;
                            	litop=scrtop+oli[i].getBoundingClientRect().top; 
                            	if(litop>=scrtop&&WinH+scrtop>=litop+liH){
                                	Stratmove(oli[i],{"opacity":100})
                               	}*/
                               /*	Stratmove(oli[i],{"opacity":100})
                          	};
                    	}
                		run();
                		window.run=run;*/
                		$("#con_wf").delegate("a.deliver","click",function(){
                			$('.showin').show();
                            $('.showin .delivers').show();
                            var title=$(this).find('span').text(),url=$(this).attr('d-url');
                            $('#dilivery_form').find('input[name="title"]').val(title);
                            $('#dilivery_form').find('input[name="url"]').val(url);
                            $('#dilivery_form').find('#title_line').html('<h5>'+title+'</h5>');
                            return false;
                        });
                		 $('.showin .delivers').find('.d-cls').bind('click',function(e){
                			 $('.showin').hide();
                             $('.showin .delivers').hide();
                             e.preventDefault();
               			 	return false;
                		 });
                	/*
                       window.onscroll=function(){
                   		if(!getByClass(id("Middle"),"Sub_seah")[0])return false;
                           var osub=getByClass(id("Middle"),"Sub_seah")[0];
                           var ofixed=document.getElementById("top_fixed");
                           var scrollTops=document.documentElement.scrollTop||document.body.scrollTop;
                           if(scrollTops>20){
                               osub.className="fixed Sub_seah";
                               ofixed.style.display="block";
                           }else{
                                osub.className="Sub_seah";
                                ofixed.style.display="none";
                           }
                   	}*/
                	});
                })(jQuery);
                </script>
		</div>
	</section>
	<jsp:include page="./scholar/footer.jsp"></jsp:include>
	<a href="#" id="top_fixed"></a>
	<div class="showin">
		<jsp:include page="./scholar/search.jsp"></jsp:include>
		<!--登陆-->
		<div class="Win_bj Account animatouts">
			<div class="panel-login">
				<i></i>
				<div class="login-social userlogin" l="ifr">
					<p>
						<span>账号：</span> <input type="text" name="username" class="txt"
							id="login_email_ifr">
					</p>
					<p>
						<span>密码：</span> <input type="password" name="password"
							class="txt" id="login_password_ifr">
					</p>
					<div class="social-action">
						<div class="action-auto cf">
							<input type="button" class="action-btns fl" value="提交"
								id="userSubmit_ifr">
							<button class="action-btns close fr">取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--文献传递-->
		<div class="Win_bj delivers">
			<div class="panel-login">
				<i class="d-cls"></i>
				<div class="login-social userlogin">
					<form action="<cms:getProjectBasePath/>docDilivery"
						name="from_sech" id="dilivery_form" method="post">
						<input type="hidden" name="title" /> <input type="hidden"
							name="url" />
						<p class="sech_title" id="title_line">标题</p>
						<p>
							<span>邮箱：</span> <input type="text" name="email"
								class="seach_contant" value="">
						</p>
						<div class="social-action">
							<div class="action-auto cf">
								<input type="button" class="action-btns fl" value="提交"
									id="userSubmit_ifr" onclick="submitDilivery()">
								<button class="action-btns close d-cls fr">取消</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<script type="text/javascript">
         function isEmail(str){ 
        	 var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; 
        	 return reg.test(str); 
         } 
         function submitDilivery(){
        	 	 var value=$('#dilivery_form').find('input[name="email"]').val();
        		 if(value==''){
        			 alert('请填写您的邮箱地址!');
        			 $('#dilivery_form').find('input[name="email"]').focus();
        		 }else if(!isEmail(value)){
        			 alert('邮箱格式不正确!');
        		 }else{
        			 $('#dilivery_form').ajaxSubmit(function(data){
        				 var rs=eval("("+data+")");
        				 if(!!rs.error){
        					 alert('请求失败!');
        				 }else if(!!rs.duplicate){
        					 alert('请不要重复提交！');
        				 }else{
        					 alert('提交成功,我们将尽快为您处理!');
        				 }
        				 $('.showin').hide();
                         $('.showin .delivers').hide();
        			 });
        		 }
    			 return false;
         }
         </script>
	</div>
	<div id="loads">
		<div id="bg"></div>
		<div class="load_gif"></div>
	</div>
	<form action="<cms:getProjectBasePath/>docList" method="get"
		id="ajax-form">
		<c:if test="${not empty condition.val }">
			<input type="hidden" name="val" value="${condition.val }" />
		</c:if>
		<input type="hidden" name="offset" value="10" />
		<c:if test="${not empty condition.journal }">
			<input type="hidden" name="journal" value="${condition.journal }" />
		</c:if>
		<c:if test="${not empty condition.fileType }">
			<input type="hidden" name="fileType" value="${condition.fileType }" />
		</c:if>
		<c:if test="${not empty condition.start_y }">
			<input type="hidden" name="start_y" value="${condition.start_y }" />
		</c:if>
		<c:if test="${not empty condition.end_y }">
			<input type="hidden" name="end_y" value="${condition.end_y }" />
		</c:if>
		<c:if test="${not empty condition.sort }">
			<input type="hidden" name="sort" value="${condition.sort }" />
		</c:if>
		<c:if test="${not empty condition.queryType }">
			<input type="hidden" name="queryType" value="${condition.queryType }" />
		</c:if>
		<c:if test="${not empty condition.oaFirst or condition.oaFirst==1 }">
			<input type="hidden" name="oaFirst" value="${condition.oaFirst }" />
		</c:if>
		<c:forEach var="group" items="${condition.groups }" varStatus="index">
			<input type="hidden" name="groups[${index.index}].logic"
				value="${group.logic }" />
			<input type="hidden" name="groups[${index.index}].field"
				value="${group.field }" />
			<input type="hidden" name="groups[${index.index}].value"
				value="${group.value }" />
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
	<script
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/public.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/jquery.form.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/json2.js"></script>
	<script type="text/javascript"
		src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/util.js"></script>
	<script type="text/javascript">
		function toPage(page){
			var offset=page*10;
			$('#ajax-form').find('input[name="offset"]').val(offset);
			$('#ajax-form').submit();
		}
      	new show(false,"pop","p1","animation","animation-out"); 
      	/**
      	* 将访问记录添加到Cookie中
      	*/
		function bind(keyword,addTime,searchHref){
      		//添加检索词
			var cookie=Weidu.getCookie('scholar.query'),json,index=-1,uuid;
			if(cookie){
				json=JSON.parse(Weidu.getCookie('scholar.query'))
			}
			if(!json){
				json=[];
			}
			for(var i=0;i<json.length;i++){
				if(json[i].key==keyword){
					index=i;
				}
			}
			if(index==-1){
				uuid=Math.uuid();
				json.push({'key':keyword,'values':uuid,'time':addTime,'href':searchHref});
			}else{
				uuid=json[index].values;
				json[index]={'key':keyword,'values':uuid,'time':addTime,'href':searchHref};
			}
			if(json.length>8){
				console.log(json.shift());//删除第一个元素
			}
			Weidu.addCookie('scholar.query',JSON.stringify(json),100000);
			//添加访问记录
			$('#con_wf').delegate('a.link','click',function(){
				var href=$(this).attr('href'),title=$(this).text(),_time=new Date();
				var cookie=Weidu.getCookie('scholar.query'),json,values,index=-1;
				if(cookie){
					json=JSON.parse(Weidu.getCookie('scholar.query'))
				}
				if(!json){
					json=[];
				}
				var uuid;
				for(var i=(json.length-1);i>=0;i--){
					if(json[i].key==keyword){
						uuid=json[i].values;
						index=i;
					}
				}
				if(!uuid){
					values=[];
				}else{
					valuesCookie=Weidu.getCookie(uuid);
					if(!valuesCookie){
						values=[];
					}else{
						values=JSON.parse(Weidu.getCookie(uuid));
					}
				}
				var find=false;
				var size=values.length;
				for(var i=0;i<size;i++){
					if(title==values[i].title){
						find=true;
					}
				}
				var time=_time.format("yyyy-MM-dd hh:mm");
				if(!find){
					values.push({'title':title,'href':href,'time':time});
					if(size>=4){
						values.shift();
					}
				}
				if(!uuid){
					uuid=Math.uuid();
					json.push({'key':keyword,'values':uuid,'time':addTime,'href':searchHref});
					Weidu.addCookie('scholar.query',JSON.stringify(json),100000);
				}
				Weidu.addCookie(uuid,JSON.stringify(values),100000);
			});	
		}
	
	/**
	* 显示文档类容
	*/
	function renderDoc(doc){
		var html;
		html='<li><h2><a href="'+doc.href+'" target="_blank">';
		if(doc.docType) html+=doc.docType
		html+=doc.title+'</a></h2>';
		html+='<h5>'+doc.source+'</h5>'
		html+='<p>'+doc.abstract_+'</p><h6>'
		if(doc.quoteText){
			html+='<a target="_blank" href="<cms:getProjectBasePath/>docList?other='+encodeURIComponent(doc.quoteLink)+'&type=quote&size=20">'+doc.quoteText+'</a>'
		}
		if(doc.relatedLink){
			html+='<a target="_blank" href="<cms:getProjectBasePath/>docList?other='+encodeURIComponent(doc.relatedLink) +'&type=related&size=20">相关文章</a>';
		}
		if(doc.versionText){
			html+='<a target="_blank" href="<cms:getProjectBasePath/>docList?other='+encodeURIComponent(doc.versionLink) +'&type=version&size=20">'+doc.versionText +'</a>';
		}
		if(!doc.isOpen&&!doc.hasLocal){
			html+='<a href="javascript:;;" d-title="'+doc.title+'" d-url="'+doc.href+'" class="deliver">文献传递<span style="display:none">'+doc.title+'</span></a>';
		}
		if(!!doc.openUri){
			html+='<a href="'+doc.openUri+'" target="_blank">下载</a>';
		}
		if(!!doc.isGoogleBook){
			html+='<a href="'+doc.href+ '" target="_blank">Google图书馆</a>';
		}
		html+='</h6></li>';
		$('#con_wf').append(html);	
	}
	$(function(){
		var keyword='${cookieKey}';
		if(!!keyword){
			var time=new Date();
			bind(keyword,time.format("yyyy-MM-dd hh:mm"),window.location.href);
		}
		var loadedInfos=[];//保存已经加载的页数，不做重复加载
		function showMore(offset){
			var size=loadedInfos.length;
			for(var i=0;i<size;i++){
				if(loadedInfos[i]==offset){
					return ;
				}
			}
			$('#loads').show();
			$('#ajax-form').find('input[name="offset"]').val(offset);
			loadedInfos.push(offset);
			$('#ajax-form').ajaxSubmit(function(data){
				if(data){		
					var result=eval("("+data+")");
					if(result.error){
						alert('加载数据失败!请稍后重试。');
						var size=loadedInfos.length;
						for(var i=0;i<size;i++){
							if(loadedInfos[i]==offset){
								loadedInfos.splice(i,1);
							}
						}
					}else{
						var rows=result.rows,doc,line;
						for(var i=0;i<rows.length;i++){
							doc=rows[i];
							renderDoc(doc);
						}
						//run();
					}
					$('#loads').hide();
				}
			});
		}
		var totalheight = 0;
		var count=parseInt('${count }');
		/*
		$(window).scroll( function() { 
			 totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop()); 
			  if ($(document).height() <= totalheight) {
				  var offset=$('#con_wf > li').size();//获取已经加载完成的条数
				  if(offset<count){
				  	showMore(offset);
				  }
			  }
		});*/
	});
       </script>
</body>
</html>