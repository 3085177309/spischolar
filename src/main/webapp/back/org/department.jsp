<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>院系信息</title>
<jsp:include page="../head.jsp"></jsp:include>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 20 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/org/department" class="in">院系管理</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="pageTopbar clearfix">
					<form
						action="<cms:getProjectBasePath/>backend/org/department/addDep"
						method="post" id="addDep" enctype="multipart/form-data">
						<c:if test="${org.flag=='wdkj' }">
							<label class="data-type"> <!-- <span class="labt">:</span> -->
								<div class="sc_selbox">
									<i class="inc uv21"></i>
									<c:if test="${schoolId == null }">
										<span id="section_lx">${org.name }</span>
									</c:if>
									<c:if test="${schoolId != null }">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<c:if test="${org.id == schoolId }">
												<span id="section_lx">${org.name }</span>
											</c:if>
										</c:forEach>
									</c:if>
									<div class="sc_selopt" style="display: none;">
										<c:forEach items="${orgList }" var="org" varStatus="status">
											<p class="school" schoolId="${org.id }">${org.name }</p>
										</c:forEach>
									</div>

								</div>
							</label>
							<input type="hidden" id="schoolId" name="schoolId"
								value="${schoolId}">

							<input type="text" name="departmentName" id="department"
								style="*margin-top: 1px; margin-right: 5px"
								class="tbSearch subselect" placeholder="请输入您要添加的院系" value="">

							<span class="thickBtn addschool" data-thickcon="弹窗内容id"
								style="*vertical-align: top; *margin-top: 3px"> <i></i>
								添加
							</span>
							<span class="uploadfile modify"
								style="*vertical-align: top; *margin-top: 3px; margin-left: 10px"><i></i>上传</span>
							<input style="display: none;" onchange="submits()" type="file"
								id="up-filebox" name="file" class="uploadfile" />
						</c:if>
					</form>
					<script type="text/javascript">
					$('.thickBtn').click(function(){
						var val = $('#department').val();
						if(val == ''||val==$('#department').attr("placeholder")) {
							alert("您还未输入要添加的院系！");
							return false;
						}
						var txt = $('#divTable span.departmentNames');
						for(var i=0;i<txt.length;i++) {
							var department = txt[i].innerHTML;
							if(department == val) {
								alert("院系已存在！");
								return false;
							}
						}
						/* if(txt.indexOf(val) != -1) {
							//alert("院系已存在！");
							return false;
						} */
						$('#addDep').submit();
					});
					$('.modify').click(function(){
						$('#up-filebox').trigger('click');
					});
					function submits() {
						var file = $('#up-filebox').val();
						$('#addDep').submit();
					}
				</script>
					<!--  -->
					<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="area">
						<table class="tc" id="divTable">
							<tr>
								<td>序号</td>
								<td>学院</td>
								<td>学校</td>
								<td>用户数</td>
								<td>操作</td>
							</tr>
						</table>
					</div>
				</div>

				<div class="tickbox">
					<div class="confirm" id="confirm" data-tit="提示框">
						<div class="checkok"></div>
						<div class="firmcon">
							<p class="b">您确定要进行此操作吗？</p>
							<p>如果是请点确定，不是请点击取消退出</p>
						</div>
						<div class="tc">
							<a href="" class="btnEnsure btn">确认</a> <a href=""
								class="btnCancle btn">取消</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
		var schoolFlag = '${org.flag }';
		$(document).ready(function(){ 
			var schoolId = '${schoolId}';
			$.get('<cms:getProjectBasePath/>backend/org/department/findDepBySchool?schoolId='+schoolId,function(data){
				data = eval("("+data.message+")");
				createTr(data);
			});
		})	
		//切换学校
		$('.school').click(function(){
			var schoolId = $(this).attr('schoolId');
			$('#schoolId').val(schoolId);
			var org=$(this).html();
			$.get('<cms:getProjectBasePath/>backend/org/department/findDepBySchool?schoolId='+schoolId,function(data){
				
				data = eval("("+data.message+")");
				createTr(data);
			});
		});
		//删除
		$('#divTable').on('click','.cd00.delete',function(){
			var num = $(this).attr("num");
			if(num>0) {
				layer.alert('用户数不为0!不能删除此院系！');
				return false;
			}
			var number = $('.confirms').index(this);
			var that=$(this)
			var index=layer.confirm('您确定要删除此院系吗？', {
			    btn: ['确定','取消'] 
			}, function(){
				var id = that.attr("value");
				var schoolId = $('#schoolId').val();
				//var org = $('#section_lx').html();
				var departmentName =encodeURI($('.updateInput').eq(num).val(),"UTF-8"); 
				$.get('<cms:getProjectBasePath/>backend/org/department/deleteDepartment?departmentId='+id+'&schoolId='+schoolId+'&departmentName='+departmentName,function(data){
					data = eval("("+data.message+")");
					if(data !='已成功发送给管理员审核！') {
						createTr(data); 
					} else {
	            		alert(data);
					}
				});
				layer.close(index);
			}, function(){
				layer.close(index);
			    return false;
			});
		})
		
		function createTr(data){
			$("#divTable").empty();
			var jsAr ="";
			jsAr = "<tr><th width='60px'><span>序号</span></th><th><span>学院</span></th><th><span>学校</span></th><th><span>用户数</span></th>";
			if(schoolFlag == 'wdkj') {
				jsAr += "<th><span>操作</span></th>";
			}
			jsAr += "</tr>";
			for(var i=0; i<data.length; i++){
				jsAr = jsAr + "<tr><td><span>"+(i+1)+"</span></td><td><span class='departmentNames'>"+data[i].departmentName+"</span><input class='updateInput' type='text' style='display: none;width:100%' value='"+data[i].departmentName+"'></td><td><span>"+data[i].schoolName+"</span></td><td><span>"+data[i].number+"</span></td>";
				if(schoolFlag == 'wdkj') {
					jsAr += "<td><span><a class='cd00 update thickBtn' >修改</a></span><span style='display: none;' class='cd00 confirms thickBtn' value='"+data[i].departmentId+"'>确认</span><span><a class='cd00 delete thickBtn' num='"+data[i].number+"' value='"+data[i].departmentId+"'>删除</a></span></td>";
				}
				jsAr += "</tr>";
			}
			$("#divTable").append(jsAr);
		}
		
//		$('.update').click(function() {
 		$('#divTable').on('click','.update',function(){
 			var num = $('.update').index(this);
 			$(this).hide();
 			$('.confirms').eq(num).show();
 			$('.updateInput').eq(num).show();
 			$('.departmentNames').eq(num).text("");
 		});
 //		$('.confirms').click(function() {
 		$('#divTable').on('click','.confirms',function(){
 			var that=$(this)
 			var num = $('.confirms').index(this);
			var index=layer.confirm('您确定要修改此院系吗？', {
			    btn: ['确定','取消'] 
			}, function(){
				var id = that.attr("value");
	 			var schoolId = $('#schoolId').val();
	 			var departmentNames =$('.updateInput').eq(num).val();
	 			$('.departmentNames').eq(num).text(departmentNames);
	 			$('.updateInput').eq(num).hide();
	 			that.hide();
	 			$('.update').eq(num).show();
	 			$.get('<cms:getProjectBasePath/>backend/org/department/updateDepartment?departmentId='+id+'&schoolId='+schoolId+'&departmentName='+encodeURI(departmentNames,"UTF-8"),function(data){
	 				if(data.message == '已成功发送给管理员审核！') {
						alert(data.message);
					} else {
		 				data = eval("("+data.message+")");
		 				console.log(data)
						createTr(data);
					}
				});
	 			
				layer.close(index);
			}, function(){
				layer.close(index);
			    return false;
			});
 			
 			
 			
 		});
 		 var err = '${error}';
 		 if(err!='') {
 			 alert(err); 
 		 }
	</script>
	</body>
	</html>