<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>访问历史</title>

<jsp:include page="../head.jsp" flush="false"></jsp:include>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv00"></span> 流量分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.llfx }" var="llfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${llfx.url}"
					<c:if test="${llfx.id == 10 }">class="in"</c:if>>${llfx.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">浏览分析</a>>
			<a href="#" class="in">访问历史</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form action="<cms:getProjectBasePath/>backend/flow/visitHistory"
						id="visitFrom" method="get">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校:</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i>
									<c:if test="${school == null }">
										<span id="section_lx">全部学校</span>
									</c:if>
									<c:if test="${school != null }">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${org.flag == school }">
												<span id="section_lx">${org.name }</span>
											</c:if>
										</c:forEach>
									</c:if>
									<div class="sc_selopt" style="display: none;">
										<p onclick="change('')">全部学校</p>
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" onclick="change('${org.flag }')">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" name="school" id="school"
										value="${school }">
								</div>
							</label>
						</c:if>

						<label class="common"> <span class="labt">检索词:</span> <input
							type="text" class="tbSearch keyword" name="val" value="${val }"
							placeholder="请输入关键词检索...">
						</label> <label class="common"> <span class="labt">访问路径:</span> <input
							type="text" class="tbSearch refererUrl" name="refererUrl"
							value="${refererUrl }">
						</label> <label class="common"> <span class="labt">IP:</span> <input
							type="text" class="tbSearch ip" name="ip" value="${ip }">
							<input class="tbBtn" type="submit" value="查询" />
						</label>

					</form>
					<script type="text/javascript">
						var flag = false;
						function change(school){
							$('#school').val(school);
							flag=true;
							$('#visitFrom').submit();
						}
						//（关键字查询）
						$('#visitFrom').submit(function(){
							var val=$('.keyword').val();
							var refererUrl = $('.refererUrl').val();
							var ip=$('.ip').val();
							/* if(val =='' && refererUrl=='' && ip ==''||val==$('.keyword').attr("placeholder")) {
								$('.keyword').focus();
								return flag;
							} */
						});
					</script>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="history">
						<table class="tc data-table pd0">
							<tr>
								<th width="40px"><span></span></th>
								<th width="50px"><span>序号</span></th>
								<th width=""><span>学校</span></th>
								<th width="150px"><span>访问时间</span></th>
								<th width=""><span>来源</span></th>
								<th width=""><span>入口页面</span></th>
								<th width="100px"><span>访问IP</span></th>
								<th width="100px"><span>访问时长</span></th>
								<th width="80px"><span>访问页数</span></th>
							</tr>
							<c:forEach items="${visiteList }" var="visiteList" end="19"
								varStatus="status">
								<tr>
									<td><span class="toggle"></span></td>
									<td><span>${status.index+1+offset }</span></td>
									<td><span>${visiteList.schoolName }</span></td>
									<td><span>${visiteList.beginTime } </span></td>
									<td class="tl"><span class="url">${visiteList.refererUrl }</span></td>
									<td class="tl"><span class="url">${visiteList.chickPageList.get(0).url }</span></td>
									<td><span>${visiteList.ip }</span></td>
									<td><span>${visiteList.time }</span></td>
									<td><span>${visiteList.pageNum }</span></td>
								</tr>
								<tr class="none">
									<td colspan="9" class="pd0">
										<table class="innertable tl pd0">
											<tr>
												<td width="211px"><span class="hisinc computer"></span>
													<div class="visdetail">
														<p>
															<span>操作系统：</span>${visiteList.win }</p>
													</div></td>
												<td rowspan="2" class="verTop"><span
													class="hisinc user"></span>
													<div class="visdetail">
														<p>
															<span>访客类型：</span>
															<c:if test="${visiteList.memberType ==0 }">新访客</c:if>
															<c:if test="${visiteList.memberType ==1 }">老访客</c:if>
														</p>

														<p>
															<span>当天访问频次：</span>${visiteList.rate }</p>
														<p>
															<span>上一次访问时间：</span>${visiteList.lastVisitTime }</p>
														<p>
															<span>本次来路：</span>${visiteList.refererUrl }</p>
														<p>
															<span>入口页面：</span>${visiteList.chickPageList.get(0).url }</p>
														<p>
															<span>最后停留在：</span>${visiteList.chickPageList[visiteList.chickPageList.size()-1].url }</p>
													</div></td>

											</tr>
											<tr>
												<td width="170px"><span class="hisinc explore"></span>
													<div class="visdetail">
														<p>
															<span>浏览器：</span>${visiteList.userBrowser }</p>
														<p>
															<span>浏览器版本：</span>${visiteList.userBrowser }</p>
													</div></td>
											</tr>
											<tr>
												<td rowspan="2" colspan="2"><span
													class="hisinc explink"></span>
													<div class="visdetail">

														<dl class="searchWord">
															<dt>检索词</dt>
															<c:forEach items="${visiteList.chickPageList }"
																var="pageList">
																<c:if test="${pageList.keyWord.length()>20 }">
																	<dd title="${pageList.keyWord }">${pageList.keyWord.substring(0,19) }...</dd>
																</c:if>
																<c:if
																	test="${pageList.keyWord.length()<=20 || empty pageList.keyWord}">
																	<dd title="${pageList.keyWord }">${pageList.keyWord }</dd>
																</c:if>

															</c:forEach>
														</dl>
														<dl class="address">
															<dt>页面地址</dt>
															<c:forEach items="${visiteList.chickPageList }"
																var="pageList">
																<dd>
																	<a href="${pageList.url }">${pageList.url }</a>
																</dd>
															</c:forEach>
														</dl>
														<dl class="time">
															<dt>停留时长</dt>
															<c:forEach items="${visiteList.chickPageList }"
																var="pageList">
																<dd>${pageList.time }</dd>
															</c:forEach>
														</dl>
														<dl class="time">
															<dt>打开时间</dt>
															<c:forEach items="${visiteList.chickPageList }"
																var="pageList">
																<dd>${pageList.beginTime.substring(10,19) }</dd>
															</c:forEach>
														</dl>
													</div></td>
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="page" id="page">
					<a class="a1">${count }条</a>
					<pg:pager items="${count }" url="" export="cp=pageNumber"
						maxPageItems="20" maxIndexPages="5" idOffsetParam="offset">
						<pg:param name="school" />
						<pg:param name="val" />
						<pg:param name="ip" />
						<pg:param name="refererUrl" />
						<pg:first>
							<a href="${pageUrl}">首页</a>
						</pg:first>
						<pg:prev>
							<a href="${pageUrl}" class="a1">上一页</a>
						</pg:prev>
						<!-- 中间页码开始 -->
						<pg:page>
							<c:if test="${count/20 gt 5 and (cp gt 3)}">
								...
							</c:if>
						</pg:page>

						<pg:pages>
							<c:choose>
								<c:when test="${cp eq pageNumber }">
									<span>${pageNumber }</span>
								</c:when>
								<c:otherwise>
									<a href="${pageUrl}" class="a1">${pageNumber}</a>
								</c:otherwise>
							</c:choose>
						</pg:pages>

						<pg:page>
							<c:if test="${count/20 gt 5 and (count/20 gt (cp+2))}">
								...
							</c:if>
						</pg:page>
						<pg:next>
							<a class="a1" href="${pageUrl}">下一页</a>
						</pg:next>
						<pg:last>
							<a href="${pageUrl}">末页</a>
						</pg:last>

						<input type="text" onkeyup="clearNotInt(this)" id="go"
							style="width: 50px;" size="5">
						<pg:last>
							<a class="a1" onclick="go('${pageUrl}')">GO</a>
						</pg:last>
					</pg:pager>
				</div>
			</div>
		</div>
		<script type="text/javascript">
		/**
		 * 只能输入正整数
		 */
		function clearNotInt(obj){
		  obj.value = obj.value.replace(/[^\d]/g,"");
		}
		//跳转翻页
		function go(url){
			var page = $('#go').val();
			var offset = (page -1)*20;
			if(page == "") {
				return false;
			}
			var arr = new Array();
			arr = url.split("offset=");
			
			if(page*20-20 > arr[1]) {
				alert("超出页码范围！");
				return false;
			}
			if(page<1) {
				alert("超出页码范围！");
				return false;
			}
			url = arr[0]+"offset="+offset;
			window.location.href=url; 
		}
		</script>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>
</div>



</body>
</html>
