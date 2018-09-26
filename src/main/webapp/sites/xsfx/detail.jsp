<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set scope="request" var="pageTitle" value="期刊详细"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<style>
.T_3 span.tab_btn a {
	color: #666;
}

span.tab_btn a.in {
	color: #ffffff;
}
</style>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/journal_link.js"></script>
<jsp:include page="./common/search.jsp"></jsp:include>

<div class="container container_F" id="minH" minH='280'>
	<div class="sidebar">
		<c:if test="${not empty searchResult.relatedDatas['titleRelated'] }">
			<div class="newsList">
				<h3 class="T_4">相关期刊</h3>
				<div class="nr">
					<ul class="list">
						<c:forEach items="${searchResult.relatedDatas['titleRelated'] }"
							var="doc">
							<li><p class="textOver">
									<a href='<cms:docDetailUrl doc="${doc }"/>'
										title='<c:out value="${doc.docTitle }"></c:out>'>${doc.docTitle }</a>
								</p></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
	</div>
	<div class="content">

		<!--end 统计-->
		<!-- 期刊列表 -->
		<dl class="qk_LB">
			<c:forEach items="${searchResult.datas}" var="doc" varStatus="status">
				<dd>
					<div class="left">
						<a class="qk_pic" target="_blank" href="javascript:void(0);">
							<c:if test="${not empty doc['image'] }">
								<img alt="" title="" src="<cms:journaPicShow doc="${doc }"/>">
							</c:if>
						</a>
						<c:if test="${doc['isOpen']==1}">
							<a title="OA期刊" class="icon_qk png icon_qk_oa"
								href="<cms:journalHomePageUrl doc="${doc }"/>"> </a>
						</c:if>
						<ul class="qk_link" id="${doc['_id'] }_ul">
							<script>loadJournalMainLink("<cms:getSiteFlag/>","${doc['_id'] }",'_ul',"${doc['_id'] }","<cms:getProjectBasePath/>loadJournalLink",'主页地址',true);</script>
							<script>loadDbLink('_ul',"${doc['_id'] }","<cms:getProjectBasePath/>loadJournalLink");</script>
						</ul>
					</div>
					<div class="right">
						<h3 class="title">
							<a target="_blank" class="name" href="javascript:return false;"
								siteFlag='<cms:getSiteFlag/>' id='journal_name'>${doc['docTitle']}</a>
							<!-- <a class="gotoArticlesLB" href="<cms:docDetailUrl doc="${doc }"/>#thisTop" id='new_deploy_btn'>最新发表</a> -->
							<script>
								loadJournalMainUrl('${doc['_id'] }','<cms:getProjectBasePath/>loadJournalLink');
								</script>
						</h3>
						<ul class="field">
							<c:if test="${not empty doc['issn']}">
								<li><strong>ISSN：</strong> <cms:splitValueShow
										doc="${doc }" field="issn" splitStr=";" /></li>
							</c:if>
							<c:if test="${not empty doc['editor']}">
								<li><strong>主编：</strong>${doc['editor']}</li>
							</c:if>
							<c:if test="${not empty doc['country']}">
								<li><strong>国家：</strong>${doc['country']}</li>
							</c:if>
							<c:if test="${not empty doc['docLan']}">
								<li><strong>语种：</strong>${doc['docLan']}</li>
							</c:if>
							<c:if test="${not empty doc['publishCycle']}">
								<li><strong>出版频次：</strong>${doc['publishCycle']}</li>
							</c:if>
							<c:if test="${not empty doc['year']}">
								<li><strong>创刊年：</strong>${doc['year']}年</li>
							</c:if>
						</ul>

						<!-- 收录       -->
						<div class="sl">
							<cms:detailShouluView doc="${doc }" />
						</div>

						<!-- 评论       -->
						<div class="pj">
							<cms:evalDetailShowTag doc="${doc }" />
						</div>
					</div>
					<!--end right-->
				</dd>
			</c:forEach>
		</dl>
		<!-- end 期刊列表 -->

		<!-- 期刊介绍 -->
		<div class='about_qk'>
			<h3 class="T_3">
				<span class="title tab_btn" id="tab_news_btn"><a href="#"
					class="in">期刊介绍<i></i></a><a href="#thisTop" id="thisTop">文章列表<i></i></a></span>
			</h3>
			<dl id="tab_news_nr">
				<dd>
					<!-- 期刊介绍 -->
					<div class="nr">
						<c:forEach items="${searchResult.datas}" var="doc"
							varStatus="status">
							<c:if test="${not empty doc['description']}">
								<p style="color: #444">${doc['description'] }</p>
							</c:if>
						</c:forEach>
					</div>
				</dd>
				<dd style="display: none;">
					<!-- 最新文章列表 -->
					<div class="nr" id='doc_container' action_target='journalList'>
						<span style="color: #999">正在加载...</span>
					</div>
				</dd>
			</dl>
		</div>
		<!-- End -->

	</div>
	<div class="clear"></div>
</div>

<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>

<jsp:include page="common/footer.jsp"></jsp:include>

<form id='update_click_count_form'>
	<input type="hidden" name='id' value="${cdt.id }" />
</form>

<input type="hidden" id='logUrl'
	value="<cms:getProjectBasePath/>writeLog" />

<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/search-check.js"></script>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/detail.js"></script>
<script type="text/javascript">
	(function($){
		//Tab 菜单
		function tab(oa,obj){
			var titles=$(oa+" >a"),tabs=$(obj+' > dd');
			titles.each(function(){
				var index=titles.index($(this));
				(function(tar,_index){
					tar.bind('click',function(e){
						titles.removeClass('in');
						tar.addClass('in');
						tabs.hide();
						$(tabs.get(_index)).show();
						if(tar.attr('id')=='thisTop'){//如果是显示最新期刊的连接
							showTop();
						}
						e.preventDefault();
					});
				})($(this),index);
			});
		}
		//显示最新发表期刊
		function showTop(){
			if($('#doc_container').find('ul.articlesLB').size()>0){//如果已经加载过内容
				return ;
			}
			var action_target = $('#doc_container').attr('action_target');
			if (null != action_target && '' != $.trim(action_target)) {
				var journalName = $.trim($('#journal_name').text());
				if ('' != journalName) {
					action_target = $.trim(action_target) + "?journal=\"" + $('#journal_name').text().replace(/&/g,'%26') + "\"&sort=1";
					$('#doc_container').load(encodeURI(action_target),function(response,status){
						  if (status == "error"){//加载内容出错!
							  $('#doc_container').html('没有找到相关数据!');
						  }
					});
				}
			}
		}
		$(function(){
			tab("#tab_news_btn","#tab_news_nr");
			/*$('#new_deploy_btn').bind('click',function(){
				$('#thisTop').click();
			})*/
		});
	})(jQuery);
	</script>
</body>
</html>

