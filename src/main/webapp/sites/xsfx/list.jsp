<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="cms"
	uri="http://org.pzy.cms"%><%@ taglib prefix="fn"
	uri="http://java.sun.com/jsp/jstl/functions"%><%@ taglib prefix="pg"
	uri="http://jsptags.com/tags/navigation/pager"%><!DOCTYPE html>
<c:set scope="request" var="pageTitle" value="期刊导航列表页"></c:set>
<c:set scope="request" var="navIndex" value="1"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/js/journal_link.js"></script>
<jsp:include page="./common/search.jsp"></jsp:include>

<div class="container" id="minH" minH='280'>
	<form id='shou_lu_form' method="get"
		action="<cms:getProjectBasePath/>list/result">
		<div class="sidebar">
			<h3 class="T_2">
				<span class="T_j png"></span> <span class="title">资源</span>
			</h3>
			<ul class="side_edi_js">
				<li><label><input
						<c:forEach items="${cdt.filterMap }" var="entry">
						<c:if test="${'oa'==entry.key }">
							<c:forEach items="${entry.value }" var="norms">
								<c:if test="${'1'==norms }">
									checked="checked"
								</c:if>
							</c:forEach>
					</c:if> </c:forEach> type="checkbox" name='filterCdt' value="oa_3_1_1"/> OA期刊</label></li>
			</ul>

			<h3 class="T_2">
				<span class="T_j png"></span> <span class="title">收录</span>
			</h3>
			<ul class="side_edi_js">
				<c:forEach items="${disciplineSystemMap }" var="authorityDB"
					varStatus="status">

					<c:choose>
						<c:when test="${authorityDB.key eq '中科院JCR分区(大类)'}">
						</c:when>
						<c:when test="${authorityDB.key eq '中科院JCR分区(小类)'}">
						</c:when>
						<c:when test="${authorityDB.key eq 'Eigenfactor'}">
						</c:when>
						<c:otherwise>
							<li title='<c:out value="${authorityDB.key }"/>'><label>
									<input
									<c:forEach items="${cdt.filterMap }" var="entry">
										<c:if test="${'auDB'==entry.key }">
											<c:forEach items="${entry.value }" var="db">
												<c:if test="${authorityDB.key==db }">
													checked="checked"
												</c:if>
											</c:forEach>
								</c:if>
				</c:forEach>

				type="checkbox" name='filterCdt' value='auDB_3_1_
				<c:out value='${authorityDB.key }' />
				'/>
				<c:if test="${authorityDB.key=='SJR' }">SCOPUS</c:if>
				<c:if test="${authorityDB.key!='SJR' }">${authorityDB.key }</c:if>
				</label>
				</li>
				</c:otherwise>
				</c:choose>

				</c:forEach>
			</ul>
			<input type="hidden" name='docType' value='9' /> <input
				type="hidden" name='field' value='${cdt.field }' /> <input
				type="hidden" name='value'
				value='<c:out value="${cdt.value }"></c:out>' /> <input
				type="hidden" name='lan' value='${cdt.lan }' /> <input
				type="hidden" name='sort' value='${cdt.sort }' />
		</div>
		<c:forEach items="${cdt.queryCdt }" var="queryCdt">
			<input type="hidden" name='queryCdt' value='${queryCdt }' />
		</c:forEach>
		<input type="hidden" name='viewStyle' value='${cdt.viewStyle }' /> <input
			type='hidden' name="sortField" value='${cdt.sortField }' /> <input
			type="hidden" value="${cdt.authorityDb }" name='authorityDb' /> <input
			type="hidden" value="${cdt.subject }" name='subject' /> <input
			type="hidden" value="${cdt.limit }" name='limit' /> <input
			type="hidden" name='effectSort' value='${cdt.effectSort }' /> <input
			type="hidden" name='detailYear' value='${cdt.detailYear }' />
	</form>
	<div class="content">

		<!--相关学科-->
		<cms:shouLuFacetShow facetMap="${searchResult.facetDatas }" />
		<!--end 相关学科-->

		<!--统计-->
		<c:choose>
			<c:when test="${searchResult.total>50}">
				<c:set var="total" value="${searchResult.total }" />
			</c:when>
			<c:otherwise>
				<c:set var="total" value="${searchResult.total }" />
			</c:otherwise>
		</c:choose>
		<c:if test="${cdt.field!='disciplineName' }">
			<div class="statistics">
				<span class="title textOver"> <cms:keywordShow />
				</span> <span class="right">
					<form method="get" action="<cms:getProjectBasePath/>list/result"
						id='hide_form'>
						<select id='view_select' name='viewStyle'>
							<option value='list'
								<c:if test="${cdt.viewStyle=='list' }">selected='selected'</c:if>>列表</option>
							<!--option的value值是要显示的div的id-->
							<option value="view"
								<c:if test="${cdt.viewStyle=='view' }">selected='selected'</c:if>>视图</option>
						</select> <select name='sort' id='sort_select'>
							<c:if test="${empty cdt.sortField}">
								<option value='0'>相关性</option>
							</c:if>
							<c:if test="${not empty cdt.sortField}">
								<option value='${cdt.effectSort }' selected="selected">影响力</option>
							</c:if>
							<option value='3'>刊名升序</option>
							<option value='4'>刊名降序</option>
							<option value='1'>创刊年升序</option>
							<option value='2'>创刊年降序</option>
						</select> <input type="hidden" name='docType' value='9' /> <input
							type="hidden" name='field' value='${cdt.field }' /> <input
							type="hidden" name='value'
							value='<c:out value="${cdt.value }"></c:out>' /> <input
							type="hidden" name='lan' value='${cdt.lan }' />
						<!-- 该隐藏域用于在页面加载完毕，做自动选择之用 -->
						<input type="hidden" id='hide_sort' value='${cdt.sort }' /> <input
							type="hidden" name='effectSort' value='${cdt.effectSort }' />
						<c:forEach items="${cdt.filterCdt }" var="filterCdt">
							<input type="hidden" name='filterCdt' value='${filterCdt }' />
						</c:forEach>
						<c:forEach items="${cdt.queryCdt }" var="queryCdt">
							<input type="hidden" name='queryCdt' value="${queryCdt }" />
						</c:forEach>
						<input type='hidden' name="sortField" value='${cdt.sortField }' />
						<input type="hidden" value="${cdt.authorityDb }"
							name='authorityDb' /> <input type="hidden"
							value="${cdt.subject }" name='subject' /> <input type="hidden"
							value="${cdt.limit }" name='limit' /> <input type="hidden"
							name='detailYear' value='${cdt.detailYear }' /> <input
							type="hidden" name='offset' value='${offset }' />
					</form>
				</span>
			</div>
		</c:if>
		<!--end 统计-->

		<!--  期刊列表 表格形式 -->
		<c:if test="${'disciplineName' != cdt.field }">
			<c:if test="${'list' eq cdt.viewStyle }">
				<div class="qk_LB" id='qk_LB_table'>
					<table>
						<thead>
							<tr>
								<th width="10%" class="tc"><strong>序 号</strong></th>
								<th width="50%" class="tc"><strong>刊 名</strong></th>
								<th width="10%" class="tc"><strong>ISSN</strong></th>
								<th width="10%" class="tc"><strong>链接</strong></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${searchResult.datas}" var="doc"
								varStatus="status">
								<c:choose>
									<c:when test="${(status.index+1)%2==0 }">
										<tr>
											<td class="tc">${status.index+offset+1 }</td>
											<td class="tl"><c:choose>
													<c:when test="${doc['isOpen']==1}">
														<a style="position: relative; top: 3px;" title="OA期刊"
															target="_blank"
															href="<cms:journalHomePageUrl doc="${doc }"/>"><img
															alt="OA期刊"
															src='<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/images/OA.png' /></a>
													</c:when>
													<c:otherwise>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</c:otherwise>
												</c:choose> <a target="_blank"
												href="<cms:docDetailUrl doc="${doc }" />">${doc['docTitle']}</a></td>
											<td class="tl" style="text-align: center;"><cms:splitValueShow
													doc="${doc }" field="issn" splitStr=";" /></td>
											<td class="tc" id="${doc['_id'] }_td"><script>loadJournalMainLink("<cms:getSiteFlag/>","${doc['docTitle'] }",'_td',"${doc['_id'] }","<cms:getProjectBasePath/>loadJournalLink",'期刊官网');</script></td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr
											style="background: none repeat scroll 0% 0% rgb(250, 250, 250);">
											<td class="tc">${status.index+offset+1 }</td>
											<td class="tl"><c:choose>
													<c:when test="${doc['isOpen']==1}">
														<a style="position: relative; top: 3px;" title="OA期刊"
															target="_blank"
															href="<cms:journalHomePageUrl doc="${doc }"/>"><img
															alt="OA期刊"
															src='<cms:getProjectBasePath/>resources/<cms:getSiteFlag/>/images/OA.png' /></a>
													</c:when>
													<c:otherwise>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											</c:otherwise>
												</c:choose> <a target="_blank"
												href="<cms:docDetailUrl doc="${doc }" />">${doc['docTitle']}</a></td>
											<td class="tl" style="text-align: center;"><cms:splitValueShow
													doc="${doc }" field="issn" splitStr=";" /></td>
											<td class="tc" id="${doc['_id'] }_td"><script>loadJournalMainLink("<cms:getSiteFlag/>","${doc['docTitle'] }",'_td',"${doc['_id'] }","<cms:getProjectBasePath/>loadJournalLink",'期刊官网');</script></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tbody>
					</table>

				</div>
			</c:if>
		</c:if>
		<!-- end 期刊列表 表格形式 -->

		<!-- 期刊列表 视图形式 -->
		<c:if test="${'view' eq cdt.viewStyle }">
			<dl class="qk_LB" id='qk_LB_view'>
				<c:forEach items="${searchResult.datas}" var="doc"
					varStatus="status">
					<dd>
						<div class="left">
							<a class="qk_pic" target="_blank"
								href="<cms:docDetailUrl doc="${doc }" />"> <span
								class="pm png"> ${status.index+offset+1} </span> <c:if
									test="${not empty doc['image'] }">
									<img alt="" title="" src="<cms:journaPicShow doc="${doc }"/>">
								</c:if>
							</a>
							<c:if test="${doc['isOpen']==1}">
								<a title="OA期刊" target='_blank' class="icon_qk png icon_qk_oa"
									href="<cms:journalHomePageUrl doc="${doc }"/>"></a>
							</c:if>
							<ul class="qk_link" id="${doc['_id'] }_ul">
								<!-- 期刊链接 -->
								<script>loadJournalMainLink("<cms:getSiteFlag/>","${doc['_id'] }",'_ul',"${doc['_id'] }","<cms:getProjectBasePath/>front/search/loadJournalLink",'主页地址',true);</script>
								<script>loadDbLink('_ul',"${doc['_id'] }","<cms:getProjectBasePath/>loadJournalLink");</script>
							</ul>
						</div>
						<!--end left-->
						<div class="right">
							<h3 class="title">
								<a class="name" target="_blank"
									href="<cms:docDetailUrl doc="${doc }" />">${doc['docTitle']}</a><span
									class="more"></span>
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
							<!--      收录       -->
							<div class="sl">
								<cms:simpleShouluView doc="${doc }" />
							</div>

							<!--      评论       -->
							<div class="pj">
								<cms:evalSimpleShowTag doc="${doc }" />
							</div>
						</div>
						<!--end right-->

					</dd>
				</c:forEach>
			</dl>
		</c:if>
		<!-- end 期刊列表 视图形式-->

		<!--
这个页码是抠了学术搜索的页码

但是学术搜索页码里面html结构嵌套有错误：

   1.每页结果多少条  的‘条’字   要放到 select 后面
   2.id为firstPage的隐藏域  放到ul的前面  
   
以上结构错误 在火狐下看不出来问题  但是在低版本浏览器下就可能会错位

-->
		<c:if test="${total>25}">

			<div class="paginatin">
				<ul>
					<!-- 首页 -->
					<pg:pager items="${total}" url="list/result" export="cp=pageNumber"
						maxPageItems="25" maxIndexPages="10" idOffsetParam="offset">
						<pg:param name="firstLetter" value='${cdt.firstLetter }' />
						<pg:param name="detailYear" value='${cdt.detailYear }' />
						<pg:param name="value" value='${cdt.value }' />
						<pg:param name="effectSort" value='${cdt.effectSort }' />
						<pg:param name="authorityDb" value='${cdt.authorityDb }' />
						<pg:param name="subject" value='${cdt.subject }' />
						<pg:param name="sortField" value='${cdt.sortField }' />
						<pg:param name="lan" value='${cdt.lan }' />
						<pg:param name="field" value='${cdt.field }' />
						<pg:param name="docType" value='${cdt.docType }' />
						<pg:param name="sort" value='${cdt.sort }' />
						<pg:param name="limit" value='${cdt.limit }' />
						<c:forEach items="${cdt.filterCdt }" var="filterCdt">
							<pg:param name="filterCdt" value='${filterCdt }' />
						</c:forEach>
						<c:forEach items="${cdt.queryCdt }" var="queryCdt">
							<pg:param name="queryCdt" value='${queryCdt }' />
						</c:forEach>
						<pg:param name="viewStyle" value='${cdt.viewStyle }' />
						<!-- 首页 -->
						<pg:first>
							<input type='hidden' value='${pageUrl }' id='firstPage' />
						</pg:first>
						<pg:prev>
							<li><a href="${pageUrl}">上一页</a></li>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:pages>
							<c:choose>
								<c:when test="${cp eq pageNumber }">
									<li class="current"><a href="javascript:return false ;">${pageNumber}</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${pageUrl}">${pageNumber}</a></li>
								</c:otherwise>
							</c:choose>
						</pg:pages>
						<!-- 中间页码结束 -->
						<pg:next>
							<li><a id="next_page" href="${pageUrl}">下一页</a></li>
						</pg:next>
					</pg:pager>
				</ul>
			</div>
		</c:if>
	</div>
	<div class="clear"></div>
</div>

<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>

<jsp:include page="common/footer.jsp"></jsp:include>

<script src="resources/<cms:getSiteFlag/>/js/list.js"></script>
<script src="resources/<cms:getSiteFlag/>/js/search-check.js"></script>
</body>

</html>