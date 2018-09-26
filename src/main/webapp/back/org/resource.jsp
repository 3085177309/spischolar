<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>馆藏资源</title>
<jsp:include page="../head.jsp"></jsp:include>
<body>
	<div id="content">
		<div class="col-left left-menue" id="side-menue">
			<h3>
				<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
			</h3>
			<ul class="side-nav">
				<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
					<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
						<c:if test="${xxgl.id == 22 }">class="in"</c:if>>${xxgl.columnName }</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="col-left col-auto">
			<div class="crumb">
				<span class="inc uv02"></span> <a
					href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
					href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
					href="<cms:getProjectBasePath/>backend/org/resource" class="in">馆藏资源</a>
			</div>
			<div class="iframe-con" id="rightMain">
				<div class="scroll">
					<div class="pageTopbar clearfix">
						<form id="search_form"
							action="<cms:getProjectBasePath/>backend/org/resource/purchasedb/findSchool" method="get">
							<span class="common fr"> <span class="labt">资源：</span> 
								<input type="text" class="tbSearch keyword" name="val" value="${val }" placeholder="资源名称或网址"> 
								<input type="hidden" name="dbType" value="${dbType }"> 
								<input class="tbBtn" type="submit" value="查询" />
							</span>
						</form>
						<script>
							$('#search_form').submit(function(){
								var val=$('.keyword').val();
								if(val ==''||val==$('.keyword').attr("placeholder")) {
									$('.keyword').focus();
									return false;
								}
							});
						</script>
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <span class="labt">学校：</span>
								<div class="sc_selbox">
									<i class="inc uv21"></i> <span id="section_lx">${orgName}</span>
									<div class="sc_selopt" style="display: none;">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p value="${org.name }" schoolFlag="${org.flag }" class="school">${org.name }</p>
										</c:forEach>
									</div>
									<input type="hidden" id="school" name="school" value="${orgFlag}">
								</div>
							</label>
						</c:if>
						<label class="data-type"> <span class="labt">类型：</span>
							<div class="sc_selbox">
								<i class="inc uv21"></i> 
								<span id="section_lx"><c:if test="${dbType == 1 }">馆藏数据库</c:if><c:if test="${dbType == 2 }">数据库筛选</c:if></span>
								<div class="sc_selopt" style="display: none;">
									<p value="1" class="dbType">馆藏数据库</p>
									<p value="2" class="dbType">数据库筛选</p>
								</div>
								<input type="hidden" id="dbType" name="dbType" value="${dbType }">
							</div>
						</label>
						<div class="clear"></div>
					</div>
					<c:if test="${type != 1 }">
						<div class="radius" id="purchasedb_list"
							action="<cms:getProjectBasePath/>backend/org/resource/purchasedb/list/${orgFlag}?dbType=${dbType }&${offsets}">
						</div>
						<script>
							var purchasedb=$('#purchasedb_list');
							$.ajax({
								url:purchasedb.attr('action')+"&fresh="+Math.random(),
								async:false,
								success:function(data){
									purchasedb.html(data);
								}
							});
						</script>
						<div class="radius" id="urlrule_lsit"
							action="<cms:getProjectBasePath/>backend/org/resource/urlrule/list/${orgFlag }">
						</div>
						<script type="text/javascript">
							var urlrule=$('#urlrule_lsit');
							$.ajax({
								url:urlrule.attr('action')+"?fresh="+Math.random(),
								async:false,
								success:function(data){
									urlrule.html(data);
								}
							});
						</script>
					</c:if>
					<c:if test="${type == 1 }">
						<div class="radius">
							<table>
								<tr>
									<th colspan="4" class="tl"></th>
								</tr>
							</table>
							<table class="tc" id="mytable1">
								<tr>
									<td width="15%"><span>序号</span></td>
									<td><span>学校</span></td>
									<td><span>资源名称</span></td>
									<td><span>网址</span></td>
								</tr>
								<c:forEach var="pd" items="${datas.rows }" varStatus="status">
									<tr>
										<td><span>${status.index + 1 }</span></td>
										<td><span>
											<a href="<cms:getProjectBasePath/>backend/org/resource?orgFlag=${pd.orgFlag}">${pd.org }</a>
										</span></td>
										<td><span>${pd.dbName }</span></td>
										<td>${pd.url }</td>
									</tr>
								</c:forEach>
							</table>
							<div class="page" style="padding-right: 20px;">
								<a class="a1">${datas.total}条</a>
								<pg:pager items="${datas.total}" url="" export="cp=pageNumber"
									maxPageItems="10" maxIndexPages="5" idOffsetParam="offset">
									<pg:param name="val" />
									<pg:param name="dbType" />
									<pg:first>
										<a href="${pageUrl}">首页</a>
									</pg:first>
									<pg:prev>
										<a href="${pageUrl}">上一页</a>
									</pg:prev>
									<!-- 中间页码开始 -->
									<pg:page>
										<c:if test="${datas.total/10 gt 5 and (cp gt 3)}">
									...
								</c:if>
									</pg:page>
									<pg:pages>
										<c:choose>
											<c:when test="${cp eq pageNumber }">
												<span>${pageNumber }</span>
											</c:when>
											<c:otherwise>
												<a href="${pageUrl}">${pageNumber}</a>
											</c:otherwise>
										</c:choose>
									</pg:pages>
									<pg:page>
										<c:if
											test="${datas.total/10 gt 5 and (datas.total/10 gt (cp+2))}">
											...
										</c:if>
									</pg:page>
									<pg:next>
										<a href="${pageUrl}">下一页</a>
									</pg:next>
									<pg:last>
										<a href="${pageUrl}">末页</a>
									</pg:last>
								</pg:pager>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<jsp:include page="../foot.jsp"></jsp:include>
	</div>



	<!-- 弹出 -->
	<div class="tickbox">
		<!-- 本馆已购馆藏数据库 -->
		<div id="modifytick" class="modifytick" data-tit="添加">
			<form method="post"
				action="<cms:getProjectBasePath/>backend/org/resource/purchasedb/add"
				id="purchase_add_form">
				<input type="hidden" name="orgFlag" value="${orgFlag }" />
				<input type="hidden" name="dbType" value="${dbType }" /> 
				<input type="hidden" id="orderNum" name="orderNum" value="">
				<ul>
					<li><label class="data-type"> <span class="labt">资源名称：</span>
							<input name="dbName" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">网址：</span>
							<input name="url" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">是否显示：</span>
							<input name="showDB" type="checkbox" checked="checked" value="1" />
					</label></li>
				</ul>
				<div class="tc">
					<input value="确认" type="submit" class="ip_button1 btnEnsure btn" />
					<a href="" class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
		<!-- 本馆已购馆藏数据库 -->
		<div id="modifytickUpdate" class="modifytick" data-tit="修改">
			<form method="post"
				action="<cms:getProjectBasePath/>backend/org/resource/purchasedb/edit"
				id="purchase_add_form">
				<input type="hidden" name="orgFlag" value="${orgFlag }" />
				<input type="hidden" name="dbType" value="${dbType }" />  
				<input type="hidden" id="orderNumUp" name="orderNum" value=""> 
				<input type="hidden" id="id" name="id" value="">
				<ul>
					<li><label class="data-type"> <span class="labt">资源名称：</span>
							<input id="dbName" name="dbName" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">网址：</span>
							<input id="url" name="url" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">是否显示：</span>
							<input id="showDB" name="showDB" type="checkbox" value="1" />
					</label></li>
				</ul>
				<div class="tc">
					<input value="确认" type="submit" class="ip_button1 btnEnsure btn" />
					<a href="" class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
		<!-- 本馆已购馆藏数据库 -->
		<script type="text/javascript">
			//切换学校
			$('.school').click(function(){
				var schoolFlag = $(this).attr('schoolFlag');
				var dbType = $('#dbType').val();
				window.location.href = '<cms:getProjectBasePath/>backend/org/resource?orgFlag=' +schoolFlag + '&dbType=' + dbType;
			});
			
			$('.dbType').click(function(){
				var dbType = $(this).attr('value');
				var schoolFlag = $('#school').val();
				window.location.href = '<cms:getProjectBasePath/>backend/org/resource?orgFlag=' +schoolFlag + '&dbType=' + dbType;
			});
			
			$('#purchase_add_form').bind('submit',function(e){
				var tar=$(this),name=tar.find('input[name="dbName"]').val(),
				url=tar.find('input[name="url"]').val();
				if(name==''){
					var index=layer.alert('请输入资源名称!',function(){
						layer.close(index);
						tar.find('input[name="dbName"]').focus();
					});
					return false;
				}
				if(url==''){
					var index=layer.alert('请输入网址!',function(){
						layer.close(index);
						tar.find('input[name="url"]').focus();
					});
					return false;
				}
			});
			//翻页事件绑定
			$('.page a.page_action').bind('click', function(e) {
				var href = $(this).attr('href');
				$('#purchasedb_list').load(href);
				e.preventDefault();
				return false;
			});
		</script>
		<!-- URL替换地址 -->
		<div id="modifyUrltick" class="modifytick" data-tit="添加"
			style="height: 200px;">
			<form method="post"
				action="<cms:getProjectBasePath/>backend/org/resource/urlrule/add"
				id="urlrule_add_form">
				<input type="hidden" name="orgFlag" value="${orgFlag }" />
				<ul>
					<li><label class="data-type"> <span class="labt">资源名称：</span>
							<input name="name" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">Google
								Scholar地址：</span> <input name="gsUrl" type="text" class="ip_input1" />
					</label></li>
					<li><label class="data-type"> <span class="labt">本地地址：</span>
							<input name="localUrl" type="text" class="ip_input1" />
					</label></li>
				</ul>
				<div class="tc">
					<input value="确认" type="submit" class="btnEnsure btn"
						class="ip_button1" /> <a href="" class="btnCancle btn">取消</a>
				</div>
			</form>
		</div>
		<script type="text/javascript">
			$('#urlrule_add_form').bind('submit',function(e){
				var tar=$(this),name=tar.find('input[name="name"]').val(),
				url=tar.find('input[name="gsUrl"]').val(),
				localUrl=tar.find('input[name="localUrl"]').val();
				if(name==''){
					var index=layer.alert('请输入资源名称!',function(){
						layer.close(index);
						tar.find('input[name="dbName"]').focus();
					});
					return false;
				}
				if(url==''){
					var index=layer.alert('请输入Google Scholar地址!',function(){
						layer.close(index);
						tar.find('input[name="gsUrl"]').focus();
					});
					return false;
				}
				if(localUrl=='') {
					var index=layer.alert('请输入本地地址!',function(){
						layer.close(index);
						tar.find('input[name="localUrl"]').focus();
					});
					return false;
				}
			});
		</script>
	</div>
</body>
</html>
