<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>权限设置</title>
<jsp:include page="../head.jsp"></jsp:include>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uvA0"></span> 系统管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
					<c:if test="${xtgl.id == 26 }">class="in"</c:if>>${xtgl.columnName }</a></li>
			</c:forEach>
		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/delivery/list">系统管理</a>> <a
				href="<cms:getProjectBasePath/>backend/system/powers" class="in">权限设置</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="dataTabC radius">
					<!--  
						<div class="datatab Tabjs">
							<a href="<cms:getProjectBasePath/>backend/system/powers" class="in">栏目显示</a>
							<a href="#">流量指标显示</a>
							<a href="#">用户类型权限</a>
						</div>-->
					<div class="datatab">
						<a href="<cms:getProjectBasePath/>backend/system/powers"
							class="in">栏目显示</a> <a
							href="<cms:getProjectBasePath/>backend/system/powers/quota">流量指标显示</a>
						<a href="<cms:getProjectBasePath/>backend/system/powers/delivery">文献互助请求</a>
					</div>
					<div class="dataTabNr" style="display: block">
						<div class="databody">
							<div class="mb10">
								<form id="change_form" name="column_form" method="get"
									action="<cms:getProjectBasePath/>backend/system/powers/powerSerach">
									<label class="common"> <input type="text"
										class="tbSearch keyword" name="name" placeholder="请输入学校名称或栏目"
										value="${name }"> <%-- <input id="name" type="hidden" value="${name }"/> --%>
										<button class="tbBtn" type="submit">查询</button>
									</label>
								</form>
							</div>
							<c:if
								test="${empty resutlmap.schools && empty resutlmap.columnList && empty resutlmap.orgs}">
								<div class="nosearchesult">找不到相关结果</div>
							</c:if>
							<c:if test="${not empty resutlmap.orgs }">
								<div class="nosearchesult">
									找不到结果，是否新建下列相关学校的栏目权限？
									<div>
										<c:forEach items="${resutlmap.orgs }" var="org" varStatus="st">
											<label id="${org.flag}"><a
												onclick="build(${org.id},'${org.flag}','${org.name}')">${org.name}</a></label>
										</c:forEach>
									</div>
								</div>
							</c:if>
							<!-- 检索学校结果 -->
							<c:if test="${not empty resutlmap.schools }">
								<table id="result_schools" class="jurisdiction">
									<tr>
										<th width="15%">学校</th>
										<th style="text-align: center">所选栏目</th>
										<th width="50%">是否应用到其他学校</th>
									</tr>
									<c:forEach items="${resutlmap.schools }" var="powMaps"
										varStatus="status">
										<c:forEach items="${powMaps.power.nodes }" var="pows"
											varStatus="statu">
											<tr>
												<c:if test="${statu.index==0}">
													<td class="tc" rowspan="${powMaps.total }"><span>${powMaps.schoolName }</span></td>
												</c:if>
												<td class="tc"><span style="margin-left: -55px">${pows.columnName}</span><input
													type="hidden" name="${powMaps.flag }" value="${pows.id}" />
												</td>
												<c:if test="${statu.index==0}">
													<td class="tc rowschool" rowspan="${powMaps.total }"
														style="vertical-align: top;">
														<div style="vertical-align: top; position: relative">
															<c:forEach items="${powMaps.orgs }" var="org"
																varStatus="stat">
																<span class="widthseting"><a id="${org.flag}"
																	class="enabledelete" href="#"
																	onclick="delBySchool('${org.flag}')">${org.name }<i></i></a></span>
																<%-- <div><a href="#" class="enabledelete">${org.name }<i></i></a></div> --%>
															</c:forEach>

															<div
																style="position: absolute; top: 0; right: 0px; width: 100px; height: 23px;">
																<span class="thickBtn addschool"
																	data-thickcon="addAccount"
																	onclick="getOldFlag('${powMaps.flag }')"> <i></i>
																	添加学校
																</span>
															</div>
														</div>
													</td>
												</c:if>
											</tr>
											<c:forEach items="${pows.nodes }" var="pow" varStatus="sta">
												<tr>

													<td class="tl clumnpl" style="text-align: center;"><span
														style="margin-left: -55px">${pow.columnName}</span><input
														type="hidden" name="${powMaps.flag }" value="${pow.id}" /></td>
												</tr>
											</c:forEach>
										</c:forEach>
									</c:forEach>
								</table>
							</c:if>
							<!-- 检索栏目结果 -->
							<c:if test="${not empty resutlmap.columnList }">
								<input id="add_id" type="hidden"
									value="${resutlmap.columnList.get(0).id}" />
								<input id="add_pid" type="hidden"
									value="${resutlmap.columnList.get(0).pid}" />
								<table class="jurisdiction">
									<tr>
										<th width="15%">栏目名称</th>
										<th width="15%" style="text-align: center">地区</th>
										<th width="80px">操作</th>
										<th>学校</th>
									</tr>
									<c:forEach items="${resutlmap.columnList }" var="column"
										varStatus="st">
										<tr>
											<c:if test="${st.index==0}">
												<td class="tc" rowspan="${resutlmap.columnList.size() }"><span>${column.columnName }</span></td>
											</c:if>
											<td class="tc"><span>${column.province }</span></td>
											<td class="tc"><a class="opradded"
												data-thickcon="addAccount"></a></td>
											<td><c:forEach items="${column.orglist }" var="og"
													varStatus="s">
													<span class="widthseting"><a id="${og.flag}"
														class="enabledelete"
														onclick="del(${column.id},${column.pid},${og.id},'${og.flag}')">${og.name }<i></i></a></span>
												</c:forEach></td>
										</tr>
									</c:forEach>
								</table>
							</c:if>
							<!--新建栏目权限 -->
							<div class="newjurisdiction" hidden="hidden"
								style="display: none">
								<table class="jurisdiction">
									<tr>
										<th colspan="3" class="tl"><span class="pl10 fb"
											id="schoolname">长沙理工大学</span></th>
									</tr>
									<c:forEach items="${powers.nodes }" var="pows"
										varStatus="status">
										<tr>
											<td class="tc"><c:if test="${status.index==0}">
													<span>所选栏目</span>
												</c:if></td>
											<td width="10%"><span><input type="checkbox"
													class="checkboxSig" name="${pows.id}" value="${pows.pid }">${pows.columnName}</span></td>
											<td><c:forEach items="${pows.nodes }" var="pow"
													varStatus="stat">
													<span class="zhibiao"><input type="checkbox"
														class="checkboxSig" name="${pow.id }" value="${pow.pid }">${pow.columnName}</span>
												</c:forEach></td>
										</tr>
									</c:forEach>
								</table>
								<input id="flag" name="flag" type="hidden" hidden="hidden"
									value="" /> <input id="orgId" name="orgId" type="hidden"
									hidden="hidden" value="" />
								<div class='databottom clearfix'>
									<a class='downOut fl'>新建</a>
								</div>
							</div>
						</div>
					</div>
					<div class="dataTabNr">
						<div class="databody">
							<div>
								<label class="common"> <input type="text"
									class="tbSearch" placeholder="请输入学校名称或IP">
									<button class="tbBtn">查询</button>
								</label>
							</div>
						</div>
					</div>
					<div class="dataTabNr">
						<div class="databody">
							<div>
								<label class="common"> <input type="text"
									class="tbSearch" placeholder="请输入学校名称或IP">
									<button class="tbBtn">查询</button>
								</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="tickbox">
		<div id="addAccount" class="schoolTick" data-tit="选择学校<em>(可多选)</em>">
			<div class="">

				<div class="schoolChecked">
					<span class="hd">已选学校：</span>
					<div class="list"></div>
				</div>
				<div class="provinceBox">
					<c:forEach items="${pList }" var="p" varStatus="status">
						<span>${p.province }</span>
					</c:forEach>
				</div>
				<div class="schoolselect">
					<c:forEach items="${pList }" var="p" varStatus="status">
						<ul>
							<c:forEach items="${orgList }" var="org" varStatus="status">
								<c:if test="${p.province==org.province}">
									<%-- <li onclick="compareSchool('${org.name }','${org.flag }')">${org.name }</li> --%>
									<li v="${org.flag }">${org.name }</li>
								</c:if>
							</c:forEach>
						</ul>
					</c:forEach>
				</div>
			</div>
			<div class="tc">
				<a class="btnEnsure btn" id="enSureSchool">确认</a> <a
					class="btnCancle btn">取消</a>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script>
		function build(schoolid,flag,name){
			$("#schoolname").html(name);
			$(".newjurisdiction").show();
			$("#flag").val(flag);
			$("#orgId").val(schoolid);
			$(".newjurisdiction input:checked").each(function(i) {
				$(this).attr("checked",false);
	        });
			docSet();
		}
		var oldFlag="";
		function getOldFlag(oldflag){
			oldFlag=oldflag;
		}
		$(".databottom").on("click", function() {
			var flag = $("#flag").val();
			var orgId=$("#orgId").val();
			var ids='',pids='';
			$(".newjurisdiction input:checked").each(function(i) {
	        	if(0 == i){
	        		pids = $(this).val();
	        		ids = $(this).attr("name");
	            }else{
	            	pids += (";" + $(this).val());
	            	ids += (";" + $(this).attr("name"));
	            }
	        });
			if(ids==''){
				alert("请选择栏目!");
				return false;
			}
			$.ajax({
            	async : true,
            	cache : false,
            	type : 'POST',
            	url : "<cms:getProjectBasePath/>backend/system/powers/build",
            	data : {"flag":flag,"ids":ids,"pids":pids,"orgId":orgId},
            	success : function(data) {
              		data = eval("("+data.message+")");
              		if(data==1){
              			alert("新建成功!");
              			window.location.href='<cms:getProjectBasePath/>backend/system/powers';
              		}else{
              			alert("新建失败!");
              		}
            	}
        	});
		});
		
		function del(cid,parid,schoolid,flag){
    		var id = cid;
    		var pid=parid;
    		var flags = flag;
    		//alert(schoolid);
    		
    		var index=layer.confirm('确定要删除?', {
    		    btn: ['确定','取消']
    		}, function(){
    			$.ajax({
                    async : true,
                    cache : false,
                    type : 'POST',
                    url : "<cms:getProjectBasePath/>backend/system/powers/del",
                    data : {"id":id,"pid":pid,"flag":flags,"orgId":schoolid},
                    success : function(data) {
                      data = eval("("+data.message+")");
                      //$("#"+flag+"").hide();
                      window.location.reload();
                    }
                });
    			layer.close(index);
    		}, function(){
    			layer.close(index);
    		    return false;
    		});
    		
    		/* var gnl=confirm("确定要删除?");
    		if (gnl!=true){
    			return false;
    		} */
    	} 
    	
		function delBySchool(flag){
    		//var flags = flag;
    		alert(1);
    		var index=layer.confirm('确定要删除?', {
    		    btn: ['确定','取消']
    		}, function(){
    			$.ajax({
                    async : true,
                    cache : false,
                    type : 'POST',
                    url : "<cms:getProjectBasePath/>backend/system/powers/del",
                    data : {"flag":flag},
                    success : function(data) {
                      data = eval("("+data.message+")");
                      //$("#"+flag+"").hide();
                      window.location.reload();
                    }
                });
    			layer.close(index);
    		}, function(){
    			layer.close(index);
    		    return false;
    		});
    		
    		/* var gnl=confirm("确定要删除?");
    		if (gnl!=true){
    			return false;
    		} */
    	}
		
		$(".checkboxSig").on("click", function() {
			var id = $(this).attr("name");
			var pid = $(this).val();
			if(pid==1){
				$("input[value='"+id+"']").attr("checked",$(this).prop("checked"));
			}else{
				var size = $(".newjurisdiction input[value='"+pid+"']:checked").length;
				if(size>=1){
					$("input[name='"+pid+"']").attr("checked",true);
				}else{
					$("input[name='"+pid+"']").attr("checked",false);
				}
			}
        });
		(function($){
	    	var schoolselect=$(".schoolselect"),
	    		provinceBox=$(".provinceBox"),
	    		schoolChecked=$(".schoolChecked .list");
	    	schoolselect.find("ul").eq(0).show();
	    	provinceBox.find("span").eq(0).addClass("in");
	    	tab(provinceBox[0].getElementsByTagName("span"),schoolselect[0].getElementsByTagName("ul"));
	    	
	    	schoolselect.find("ul li").bind("click",function(){
	    		var text=$(this).html(),
	    		    flag=$(this).attr("v"),
	    		    compareSchoolVal=$('.compareSchool');
	    		var repChecked=repMaxnumCheck(text);
	    		var selected=schoolChecked.append(function(){
	    			return repChecked ? '<span class="schbtn" v='+flag+'>'+text+'<i></i></span>': false;
	    		});
	    		removeContrast(text);
	    	})
	    	
	    	$("#enSureSchool").click(function(){
	    		thickdepartment();
	    		removeContrast();
	    	});
	    	//点击取消
	    	$(".btnCancle").click(function(){
	    		$(".thickWarp").hide();
	    	});
	    	function repMaxnumCheck(text){//重复检查
	    		var checkEle=schoolChecked.find("span"),
	    			chk=true;
	    		checkEle.each(function(){
	    			if($(this).text()==text){
	    				alert("不可重复选择！")
	    				chk=false;
	    			}
	    		})
	    		return chk;
	    	}
	    	function removeContrast(){ //删除当前已选
	    		$(".schbtn").find("i").click(function(){
	    			$(this).parents("span").remove();
	    		})
	    	}
	    	function thickdepartment(){//弹窗确认提交
				department();
			}
	    	
	    	function department(){
	    		var flags="";
	    		$(".schoolChecked .list span").each(function(i){
	    			if(0==i){
	    				flags =$(this).attr("v");
	    			}else{
	    				flags += ("," + $(this).attr("v"));
	    			}
	    		});
	    		if(flags==""){
	    			alert("请选择学校");
	    			return false;
	    		}
	    		var result_schools=${resutlmap.schools.size()};
	    		var result_column=${resutlmap.columnList.size()};
	    		if(result_schools!=0){
	    			var cids="";
	    			$("#result_schools input[name='"+oldFlag+"']").each(function(q){
	    				if(q==0){
	    					cids=$(this).val();
	    				}else{
	    					cids += ","+$(this).val();
	    				}
	    			});
	    			$.ajax({
		                async : true,
		                cache : false,
		                type : 'POST',
		                url : "<cms:getProjectBasePath/>backend/system/powers/mapped",
		                data : {"cids":cids,"flags":flags},
		                success : function(data) {
		                	data = eval("("+data.message+")");
		                	$("form input[name='name']").val($("#name").val());
			              	$("form[name='column_form']").submit(); 
		                }
		            });
	    		}
	    		if(result_column!=0){
	    			var id=$("#add_id").val();
	    			var pid=$("#add_pid").val();
	    			add(id,pid,flags);
	    		}
	    	}
	    	
	    	function add(id,pid,flags){
	    		$.ajax({
	                async : true,
	                cache : false,
	                type : 'POST',
	                url : "<cms:getProjectBasePath/>backend/system/powers/add",
	                data : {"id":id,"pid":pid,"flags":flags},
	                success : function(data) {
	                  data = eval("("+data.message+")");
	                  $("form input[name='name']").val($("#name").val());
	                  $("form[name='column_form']").submit();
	                }
	            });
	    	}
	    })(jQuery);
		
		//（关键字查询）
		$('#change_form').submit(function(){
			var val=$('.keyword').val();
			if(val ==''||val==$('.keyword').attr("placeholder")) {
				window.location.href="<cms:getProjectBasePath/>backend/system/powers"; 
				return false;
				/* $('.keyword').focus();
				return false; */
			}
		});
		//已存在学校置灰
		$(".opradded").click(function(){
    		$("div.schoolselect ul li").each(function(){
    			$(this).removeAttr("class");
    		});
    		var data = $(this).parent().parent().parent().find("span a");
    		var orgids,orgflag;
    		for(var i=0; i<data.length; i++){
    			orgids=data.eq(i).attr("id");
    			$("div.schoolselect ul li").each(function(){
    				orgflag = $(this).attr("v");
    				if(orgids==orgflag){
    					$(this).attr("class","schdisable");
    				}
        		});
    		}
    	});
		$(".addschool").click(function(){
    		$("div.schoolselect ul li").each(function(){
    			$(this).removeAttr("class");
    		});
    		var data = $(this).parent().parent().parent().find("span a");
    		var orgNmae = '${name}';
    		var orgids,orgflag,orgname;
    		for(var i=0; i<data.length; i++){
    			orgids=data.eq(i).attr("id");
    			$("div.schoolselect ul li").each(function(){
    				orgflag = $(this).attr("v");
    				if(orgids==orgflag){
    					$(this).attr("class","schdisable");
    				}
    				orgname = $(this).text();
    				if(orgname==orgNmae){
    					$(this).attr("class","schdisable");
    				}
        		});
    		}
    	});
	</script>
	</body>
	</html>