<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp"></jsp:include>
<title>SpiScholar期刊指南</title>
<body>
	<c:set scope="request" var="mindex" value="2"></c:set>
	<div class="index-wraper qikan-page">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch">
					<div class="qksearch-wrap">
						<div class="search-box single-search-btn">
							<div class="search-tab">
								<form method="get"
									action="<cms:getProjectBasePath/>journal/search/list">
									<div class="qk-search">
										<input type="text" class="textInput" name="value"
											placeholder="请输入刊名/ISSN/学科名" value="" autocomplete="off"
											type_index="1"> <input type="submit"
											class="journal_hide_btn"> <input type="hidden"
											name="batchId"> <i class="c-i"></i>
									</div>
								</form>
							</div>
							<div class="search-btn">
								<button class="s-qk s-btn active journal_search_btn">搜期刊</button>
							</div>
							<div class="search-history"></div>
						</div>
					</div>
				</div>
				<div class="wraper" id="">
					<div class="container">
						<div class="sidebar" style="padding-bottom: 0; margin-bottom: 0;"
							id="sidefix">
							<div class="ll_fl">
								<div class="ll_fl_top">学科门类</div>
								<c:forEach var="subject" items="${subjectList }" varStatus="s">
									<c:if test="${empty subject.url }">
										<a subject_id="${subject.id }" class="ll_no" id="1">${subject.name }</a>
									</c:if>
									<c:if test="${not empty subject.url }">
										<a subject_id="${subject.id }"
											href="<cms:getProjectBasePath/>${subject.url }" id="1">${subject.name }</a>
									</c:if>
								</c:forEach>
								<input type="hidden" id="subjectNameId">
							</div>
						</div>
						<div class="content border1">
							<script type="text/javascript">
			    	$(function() {
			        $("#tab_R").click(function() {
			                var div = $("#tab_tit");
			                if(div.hasClass("tab_tit_list")) {
			                        div.removeClass("tab_tit_list").addClass("tab_tit_list_1");
			                        
			                } 
			                else {
			                        div.removeClass("tab_tit_list_1").addClass("tab_tit_list");
			                }
			        })
					});
					$(function(){
						var i=0;
						$("#tab_R").click(function(){
							i++;
							if(i%2!=0){
								$("#tab_R").removeClass("tab_R").addClass("tab_R1");
							}else{
								$("#tab_R").removeClass("tab_R1").addClass("tab_R");
							}
						});
					})
			    </script>
							<div class="tab_tit">
								<ul class="tab_tit_list" id="tab_tit">
									<c:forEach var="db" items="${authDbs }" varStatus="s">

												<li href="#" dbSystem="${db.id }" dbYear="${db.lastYear }"
													id="${db.id }">${db.flag }</li>
									</c:forEach>

								</ul>
								<input type="hidden" id="dbSystem">
								<div class="tab_R_box">
									<a id="tab_R" class="tab_R" href="#"></a>
								</div>
							</div>
							<!-- 内容 -->
							<div class="titbox border">
								<div class="fl pagesearch ">
									<input type="hidden" id="current_url" /> <span
										class="page-input">
										<div class="sc_put png">
											<form action="" type="get" name="search">


												<input class="text" id="q" name="q" placeholder="学科筛选"
													value="" autocomplete="off" type="text"> <input
													class="submit" type="" onclick="" />
											</form>
										</div>
									</span>
								</div>

								<div class="fr copyright-sel">
									<span>版本：</span>
									<div class="sc_selbox">
										<i></i> <span id="section_bb"></span>
										<div class="sc_selopt">
											<c:forEach var="db" items="${authDbs }">
												<c:forEach var="y" items="${db.yearList }">
													<c:choose>
														<c:when
															test="${(db.id==2||db.id==3)&&cms:formatYear(y)!=db.lastYear&&zky!=1 }"></c:when>
														<c:otherwise>
															<a
																href="javascript:choose('<c:out value="${cms:formatYear(y)}" />')"
																class="year_${db.id }">${y }</a>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</c:forEach>
										</div>
										<input type="hidden" id="value_bb" name="catid" value="20">
									</div>
								</div>
							</div>

							<div class="adta-list border" id="subject_list">


							</div>
						</div>
						<script type="text/javascript">
					(function($){
						var subjectList = '${subjectListJson}';
						$(function(){
							$('div.ll_fl a').each(function(){
								$(this).click(function(e){
                                    var href=$(this).attr('href');
									var db = href.substring(href.length-7,href.length-5);
									db = db.replace('/','');
									$('#dbSystem').val(db);
									//焦点切换
									$('html,body').animate({scrollTop:0}, 100);
									$('#goto_fixed').removeClass('letter-list-fixed');
									$('div.ll_fl a').removeClass('in');
									$(this).addClass('in'); 
									$('div.tab_tit li').removeClass('in');
									$('div.tab_tit li').removeClass('li_no');
									$('div.tab_tit li[id='+db+']').addClass('in');
									
									var subjectNameId = $(this).attr("subject_id");
									$('#subjectNameId').val(subjectNameId);
									var dataObj= eval("("+subjectList+")");
									for(var i=0;i<dataObj.length;i++) {
										if(subjectNameId == dataObj[i].id) {
											for(var j=0;j<dataObj[i].list.length;j++) {
												var dbSystem = dataObj[i].list[j].flag;
												var hasContent = dataObj[i].list[j].hasContent;
												if(hasContent == false) {
													/*$('div.tab_tit li[id='+dbSystem+']').addClass('li_no');*/
												}
											}
										}
									}
									
									//加载内容列表
									$('#subject_list').load(href);
									$('#current_url').val(href);
									var id=$(this).attr('id');
									var year = $('#section_bb').text();
									if(year == '') {
										$('.copyright-sel .sc_selbox a').hide();
										$('.sc_selbox .year_'+id).show();
										var v=$($('.sc_selbox .year_'+id).get(0)).text();
										$('#section_bb').text(v);
									}
									$('.data-des').hide();
									$('.desc_'+id).show();
									$('.sc_put .text').val('');
									e.preventDefault();
								});
							});
							$('div.tab_tit li').each(function(){
								$(this).mouseenter(function(e){
									var className = $(this).attr("class");
									if(className == 'li_no') {
										return;
									}

									var dbsystem = $(this).attr("dbsystem");
									var dbyear = $(this).attr("dbyear");
                                    $('div.ll_fl a').each(function(){
                                        var arr = $(this).attr('href').split('/');
                                        var hrefn="";
                                        for (var i=0;i<arr.length;i++){
                                            if(i==6){   //线上和本地区别，线上6本地7
                                                arr[i]=dbsystem;
                                            }
                                            if(i==7){ 	//线上和本地区别，线上7本地8
                                                arr[i]=dbyear;
                                            }
                                            hrefn=hrefn+arr[i];
                                            if(i<arr.length-1){
                                                 hrefn=hrefn+"/";
                                            }
                                        }
                                        $(this).attr("href",hrefn);
                                    });
                                    
									//焦点切换
									$('html,body').animate({scrollTop:0}, 100);
									//alert(1);
									$('#goto_fixed').removeClass('letter-list-fixed');
									$('div.tab_tit li').removeClass('in');
									$(this).addClass('in');
									
									var subjectNameId = $('#subjectNameId').val();
									var dbSystem = $(this).attr('dbSystem');
									$('#dbSystem').val(dbSystem);
									var dbYear = $(this).attr('dbYear');
									//加载内容列表
									var href='<cms:getProjectBasePath/>journal/subject/'+subjectNameId+'/'+dbSystem+'/'+dbYear;
									$('#subject_list').load(href);
									$('#current_url').val(href);
									var id=$(this).attr('id');
									$('.copyright-sel .sc_selbox a').hide();
									$('.sc_selbox .year_'+id).show();
									var v=$($('.sc_selbox .year_'+id).get(0)).text();
									$('#section_bb').text(v);
									$('.data-des').hide();
									$('.desc_'+id).show();
									$('.sc_put .text').val('');
									
									e.preventDefault();
								});
							});
							$('div.ll_fl a:eq(0)').click();
							$('.sc_put .text').bind('keyup',function(){
								var v=$(this).val();
								var href=$('#current_url').val();
								$('#subject_list').load(href,{'subject':v});
							})
						});
					})(jQuery);
					function choose(dbYear){
						var subjectNameId = $('#subjectNameId').val();
						var dbSystem = $('#dbSystem').val();
						var href='<cms:getProjectBasePath/>journal/subject/'+subjectNameId+'/'+dbSystem+'/'+dbYear;
						jQuery('#subject_list').load(href);
						jQuery('#current_url').val(href);
						jQuery('.sc_put .text').val('');
					}
				</script>
					</div>
					<jsp:include page="include/topsearch.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>