<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>添加学校</title>
<jsp:include page="../head.jsp"></jsp:include>

<%-- <script src="<cms:getProjectBasePath/>/resources/js/jquery-ui-1.8.18.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="<cms:getProjectBasePath/>/resources/css/jquery-ui-1.8.18.custom.css" /> --%>

<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv80"></span> 学校管理
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.xxgl }" var="xxgl" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${xxgl.url}"
					<c:if test="${xxgl.id == 19 }">class="in"</c:if>>${xxgl.columnName }</a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-left col-auto">

		<div class="crumb">
			<span class="inc uv02"></span> <a
				href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list">学校管理</a>> <a
				href="<cms:getProjectBasePath/>backend/org/list" class="in">基本信息</a>
		</div>
		<div class="iframe-con" id="rightMain">
			<div class="scroll">
				<div class="radius">
					<div class="data-table databody">
						<form name="qq_form" method="post"
							action="<cms:getProjectBasePath/>backend/org/list/addin">
							<div class="infochoose">
								<input type="hidden" name="template" value="xsfx"> <label
									class="list"> <span class="labt"><em>*</em>学校：</span> <input
									type="text" class="tbSearch" id="orgName" name="name">
								</label> <label class="list"> <span class="labt"><em>*</em>机构标识：</span>
									<input type="text" name="flag" id="orgFlag" class="tbSearch">
								</label>
								<div class="list wid53 " id="comefrom">
									<span class="labt">地区：</span>
									<div class="secondary One-third" id="province"
										style="*float: left; *margin-right: 10px;">
										<i class="inc uv21"></i> <span>请选择省份</span>
										<div class="sc_selopt" style="display: none;"></div>
										<input type="hidden" name="province" value="">
									</div>
									<div class="secondary One-third" id="city"
										style="*float: left; z-index: 99">
										<i class="inc uv21"></i> <span>请选择城市</span>
										<div class="sc_selopt" style="display: none;"></div>
										<input type="hidden" name="city" value="">
									</div>
								</div>
								<div class="clear"></div>
								<label class="list"> <span class="labt">联系人：</span> <input
									type="text" name="contactPerson" class="tbSearch">
								</label> <label class="list"> <span class="labt">联系方式：</span> <input
									type="text" name="contact" class="tbSearch">
								</label> <label class="list"> <span class="labt">邮箱：</span> <input
									type="mail" name="email" id="email" class="tbSearch">
								</label>
								<div class="clear"></div>
							</div>
							<div class="productAll clearfix">
								<span class="tit"><em>*</em>产品：</span>
								<div class="productchoose">
									<!-- 期刊 -->
									<div class="chooseline" style="*z-index: 100;">
										<label><input type="checkbox" name="check"
											class="checkbox">学术期刊指南</label> <input type="hidden"
											value="学术期刊指南" class="proName" /> <input type="hidden"
											value="1" class="proId" /> <label class="list wid30"
											style="*z-index: 100;"> <span class="labt"
											style="*float: left; *margin-top: 4px; *z-index: 100;">状态：</span>
											<div class="sc_selbox sc_selboxhalf"
												style="*float: left; *z-index: 100;">
												<i class="inc uv21"></i><span class="section_lx"
													id="section_lx">购买</span>
												<div class="sc_selopt" style="display: none;">
													<p>购买</p>
													<p>试用</p>
													<p>停用</p>
												</div>
												<input type="hidden" value="" class="status">
											</div>
										</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose startDate" 
													id="beginTime" value=""
													onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})">
											</div> <span class="labm">结束日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose endDate" 
													id="endTime" value=""
													onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginTime\')}',readOnly:true})">
											</div>
										</label>
									</div>
									<!-- 文章 -->
									<div class="chooseline">
										<label><input type="checkbox" name="check"
											class="checkbox">蛛网学术搜索</label> <input type="hidden"
											value="蛛网学术搜索" class="proName" /> <input type="hidden"
											value="2" class="proId" /> <label class="list wid30">
											<span class="labt" style="*float: left; *margin-top: 4px;">状态：</span>
											<div class="sc_selbox sc_selboxhalf">
												<i class="inc uv21"></i> <span class="section_lx"
													id="section_lx">购买</span>
												<div class="sc_selopt" style="display: none;">
													<p>购买</p>
													<p>试用</p>
													<p>停用</p>
												</div>
												<input type="hidden" value="" class="status">
											</div>
										</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose startDate" id="searchBeginTime"
													onclick="WdatePicker({maxDate:'#F{$dp.$D(\'searchBeginTime\')}',readOnly:true})">
											</div> <span class="labm">结束日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input type="text"
													class="tbSearch datechoose endDate" id="searchEndTime"
													onclick="WdatePicker({minDate:'#F{$dp.$D(\'searchBeginTime\')}',readOnly:true})">
											</div>
										</label>
									</div>
									<!-- CRS核心论文库 -->
									<div class="chooseline">
										<label><input type="checkbox" name="check"
											class="checkbox">CRS核心论文库</label> <input type="hidden"
											value="CRS核心论文库" class="proName" /> <input type="hidden"
											value="4" class="proId" /> <label class="list wid30">
											<span class="labt" style="*float: left; *margin-top: 4px;">状态：</span>
											<div class="sc_selbox sc_selboxhalf">
												<i class="inc uv21"></i> <span class="section_lx"
													id="section_lx">购买</span>
												<div class="sc_selopt" style="display: none;">
													<p>购买</p>
													<p>试用</p>
													<p>停用</p>
												</div>
												<input type="hidden" value="" class="status">
											</div>
										</label> <label for="" class="data-type"> <span class="labt">开始日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input readonly="readonly"
													type="text" class="tbSearch datechoose startDate"
													id="searchBeginTime" 
													onclick="WdatePicker({maxDate:'#F{$dp.$D(\'searchBeginTime\')}',readOnly:true})">
											</div> <span class="labm">结束日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i> <input readonly="readonly"
													type="text" class="tbSearch datechoose endDate"
													id="searchEndTime" 
													onclick="WdatePicker({minDate:'#F{$dp.$D(\'searchBeginTime\')}',readOnly:true})">
											</div>
										</label>
										<label class="crs_check">
											<input type="checkbox" checked>是否独立购买
                                            <input type="hidden" value="1" class="single">
										</label>
									</div>

								</div>
								<div class="clear"></div>
							</div>
							<div class="infoline zy">
								<label class="list"> <span class="labt">资源：</span> <input
									type="checkbox" name="" class="checkbox"
									style="margin-left: -5px;">开放资源优先
								</label> <input type="hidden" name="zyyx" value="">
							</div>
							<div class="infoline jcr">
								<label class="list"> <span class="labt">数据：</span>中科院JCR数据
								</label> <label for="today" class="data-type"> <input
									type="checkbox" class="tbRadio" value="2012"> <span>2012</span>
								</label> <label for="today" class="data-type"> <input
									type="checkbox" class="tbRadio" value="2013"> <span>2013</span>
								</label> <label for="today" class="data-type"> <input
									type="checkbox" class="tbRadio" value="2014"> <span>2014</span>
								</label> <label for="today" class="data-type"> <input
									type="checkbox" class="tbRadio" value="2015"> <span>2015</span>
								</label> <input type="hidden" name="jcryear" value="">
							</div>
							<div class="infoline delivery">
								<label class="list"> <span class="labt"><em>*</em>文献互助：</span>登录用户
								</label> <label class="list"> <input type="text"
									name="userDeliveryCount" id="userDeliveryCount"
									class="tbSearch" value=""> 条
								</label> <label class="list"> &nbsp;&nbsp;&nbsp;游客 </label> <label
									class="list"> <input type="text" name="deliveryCount"
									id="deliveryCount" class="tbSearch" value=""> 条
								</label>
							</div>

							<div class="infochoose">
								<input type="hidden" name="ipRanges" id="ipRanges" value="" />
								<label class=singleAdd> <span class="labt"><em>*</em>IP地址：</span>
									<input type="text" name="ip_t1" style="width: 130px"
									class="tbSearch ip_input1"> --- <input type="text"
									style="width: 130px" name="ip_t2" class="tbSearch ip_input1">
									<span class="add oprbtn thickBtn"> <i></i> 添加
								</span> <a onclick="chooseAdd('1')" class="oprbtn black">批量添加</a>
								</label> <label class="batchAdd" style="display: none;"> <span
									class="labt vert-top">IP地址：</span> <textarea rows="10"
										cols="60" id="batchIps" class="vert-bot"></textarea> <span
									class="thickBtn add" data-thickcon="schoolTick"> <i></i>
										添加
								</span> <a onclick="chooseAdd('2')" class="oprbtn black">单个添加</a>
								</label>
								<div class="clear"></div>
								<table class="fixedwidth">
									<tr>
										<th width="50px">序号</th>
										<th>IP地址</th>
										<th width="150px">操作</th>
									</tr>

								</table>
							</div>
							<div class="tl clearfix">
								<input type="submit" class="downOut fr" value="保存">
							</div>
							<div class="clear"></div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
</div>


<script src="<cms:getProjectBasePath/>/resources/back/js/comefrom.js"></script>
<script>
/**
 * 邮箱验证
 */
function CheckMail() {
	var mail = $('#email').val();
	 var filter  = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
	 if (filter.test(mail)) return true;
	 else {
		 if(mail == "") {
			 return true;
		 }
		 layer.alert('您的电子邮件格式不正确');
	 	//$('#email').val('');
	 	return false;
	 }
}
/**
 * 选择批量添加还是单个添加IP
 */
var addType;
	function chooseAdd(type) {
		addType=type;
		if(type == 1) {
			$('.singleAdd').hide();
			$('.batchAdd').show();
		} else {
			$('.batchAdd').hide();
			$('.singleAdd').show();
		}
	}
/**
 * 提示消息
 */
var err = '${error}';
if(err!='') {
	 alert(err); 
}



(function($){
 	//$(document).ready(function(){
 		//初始化IP范围
 		var ipRanges=$('#ipRanges').val(),ipRangesArr;
 		if(!ipRanges==""){
 			ipRangesArr=ipRanges.split(";");
 	 		for(var i=0;i<ipRangesArr.length;i++){
 	 			$('.fixedwidth').append('<tr><td class="index" value='+(i+1)+'>'+(i+1)+'</td><td><p class="ips">'+ ipRangesArr[i]+'</p><input class="updateInput" type="text" style="display: none; width:100%" value="'+ipRangesArr[i]+'"></td><td><span style="padding-left:10px" class="cd00 update thickBtn">修改</span><span style="padding-left:10px;display: none;" class="cd00 confirms thickBtn">确认</span><span style="padding-left:10px" class="cd00 delete thickBtn">删除</span></td></tr>');
 	 	 	}
 		}
 		//点击添加ip
 		var Myform=document.forms["qq_form"],
               opi1=Myform.ip_t1,
               opi2=Myform.ip_t2;
 		$('.add').click(function(){
 			var ips = opi1.value+"---"+opi2.value;
 			if(addType ==1) {
 				ips = $('#batchIps').val();
 			}
 			var t01 = $(".fixedwidth tr").length;
 			var ipRangesArr=ips.split(";");
 			if(t01>1){
 				var vals=$(".fixedwidth tr:last td:eq(0)").html();
 	 			t01 = (parseInt(vals)+1);
 			}
 			for(var i=0;i<ipRangesArr.length;i++){
 				var allIp = ipRangesArr[i].split("---");
 				$('input[name=ip_t1]').val(allIp[0]);
 				$('input[name=ip_t2]').val(allIp[1]);
 				if(ipRangesArr[i] == "---" || ipRangesArr[i] ==null) {
 					layer.alert("IP地址不能为空");
 					return false;
 				}
		 		if(!isIP(ipRangesArr[i])){
		 			layer.alert("IP地址格式错误!");
		 			return false;
		 		};
		 		var flag = false;
				$('.ips').each(function(){
					var ipRanges = $(this).text();
					if(ipRanges == ipRangesArr[i]) {
						layer.alert(ipRangesArr[i]+"IP地址已经在列表中!");
						flag = true;
					}
				});
				if(flag) {
					return false;
				}
				
				//保存时：IP地址验证
				var ipRanges='',index=0;
				$('.ips').each(function(){
					if(index==0){
						ipRanges+=$(this).text();
					}else{
						ipRanges+=";"+$(this).text();
					}
					index++;
				});
				if(ipRanges == '') {
					ipRanges += ipRangesArr[i];
				} else {
					ipRanges += ";" + ipRangesArr[i];
				}
				
				if(ipRanges==''){
					layer.alert('请输入IP范围!');
					e.preventDefault();
					return false;
				}
				 var id = "${org.id }"; 
				 $.get('<cms:getProjectBasePath/>/backend/org/list/checkIpRangesExist',{startIp:opi1.value,endIp:opi2.value,ipRanges:ipRanges},function(data){
					var rs=eval('('+data+')');
	   				  if(rs.exist&&rs.exist==1){//检测存在
	   					layer.alert(ips+'在其他机构中已经存在!');
	   				 	$("table.fixedwidth tr:last").remove();
	   				  	return false;
	   				  }else{
	   					 $('#ipRanges').val(ipRanges);
	   				  }
	   			  }); 
	 			$('.fixedwidth').append('<tr><td>'+(t01+i)+'</td><td><p class="ips">'+ ipRangesArr[i]+'</p><input type="text" class="updateInput" style="display: none;width:100%" value="'+ipRangesArr[i]+'"></td><td><span style="padding-left:10px" class="cd00 update thickBtn">修改</span><span style="padding-left:10px;display: none;" class="cd00 confirms thickBtn">确认</span><span style="padding-left:10px" class="cd00 delete thickBtn">删除</span></td></tr>');
	 		}
 			opi1.value="";
 			opi2.value="";
 		});
 		//判断是否是IP
 		function isIP(ip){ 
 		    var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)---(\d+)\.(\d+)\.(\d+)\.(\d+)$/;  
 		    if (reSpaceCheck.test(ip)){  
 		        ip.match(reSpaceCheck);  
 		        if(RegExp.$1<=255&&RegExp.$1>=0  
 		          &&RegExp.$2<=255&&RegExp.$2>=0  
 		          &&RegExp.$3<=255&&RegExp.$3>=0  
 		          &&RegExp.$4<=255&&RegExp.$4>=0){  
 		            return true;   
 		        }else{  
 		            return false;  
 		        }  
 		    }else{  
 		        return false;  
 		    }  
 		} 
 		/**
 		修改IP
 		*/
 //		$('.update').click(function() {
 		$('.fixedwidth').on('click','.update',function(){
 			var num = $('.update').index(this);
 			$(this).hide();
 			$('.confirms').eq(num).show();
 			$('.updateInput').eq(num).show();
 			$('.ips').eq(num).text("");
 		});
 		$('.confirms').click(function() {
 			var num = $('.confirms').index(this);
 			var ips = $('.updateInput').eq(num).val();
 			$('.ips').eq(num).text(ips);
 			$('.updateInput').eq(num).hide();
 			$(this).hide();
 			$('.update').eq(num).show();
 		});
 		
 		//删除ip
 		$('.fixedwidth').on('click','.delete',function(){
 			var index=layer.confirm('您确定要删除此IP段吗?', {
			    btn: ['确定','取消'] 
			}, function(){
				var vals=$('.delete').index(this)+1;
	 			$('.fixedwidth tr:eq('+vals+')').remove();
				layer.close(index);
			}, function(){
				layer.close(index);
			    return false;
			});
 			/* var vals=$('.delete').index(this)+1;
 			$('.fixedwidth tr:eq('+vals+')').remove(); */
 		});
 		
 		$('#orgName').blur(function(){
 			//验证机构名称
			var orgName = $('#orgName').val();
			$.get('<cms:getProjectBasePath/>/backend/org/list/checkOrgNameExist',{orgName:orgName},function(data){
				var rs=eval('('+data+')');
   				  if(rs.exist&&rs.exist==1){//检测存在
   					layer.alert(orgName+'已经存在!');
   					$('#orgName').val("");
   				  	return false;
   				  }else{
   				  }
   			  });
 		})
 		$('#orgFlag').blur(function(){
 			//验证机构标识
			var orgFlag = $('#orgFlag').val();
			$.get('<cms:getProjectBasePath/>/backend/org/list/checkFlagExist',{flag:orgFlag},function(data){
				var rs=eval('('+data+')');
   				  if(rs.exist&&rs.exist==1){//检测存在
   					layer.alert(orgFlag+'已经定义!');
   					$('#orgFlag').val("");
   				  	return false;
   				  }else{
   				  }
   			  });
 		})
 		
		$('form[name="qq_form"]').bind('submit',function(e){
			//机构名称验证
			if($('input[name="name"]').val()==''){
				//message('请输入机构名称!',function(){
				//	$('input[name="name"]').focus();
				//});
				layer.alert("请输入学校名称!");
				$('input[name="name"]').focus();
				e.preventDefault();
				return false;
			}
			//机构标识验证
			if($('input[name="flag"]').val()==''){
				layer.alert("请输入机构标识!");
				$('input[name="flag"]').focus();
				e.preventDefault();
				return false;
			}
			
			//购买产品验证
			var size=$('.productchoose input[type="checkbox"]:checked').size();
			if(size==0){
				//message('请选择购买或试用的产品!');
				layer.alert("请选择购买或试用的产品!");
				e.preventDefault();
				return false;
			}
			var hasError=false,_ite=0;

			$('.productchoose input[type="checkbox"]:checked').each(function(){
				var index=$('input[type="checkbox"]').index(this);
				var group=$('.chooseline').eq(index);
				var statustext=group.find('#section_lx').html();
				if(statustext=="购买"){
					group.find('input.status').attr('value','1');
				}else if(statustext=="试用"){
					group.find('input.status').attr('value','2');
				}else if(statustext=="停用"){
					group.find('input.status').attr('value','0');
				}
				group.find('input.proName').attr('name','productList['+_ite+'].productName');
				group.find('input.proId').attr('name','productList['+_ite+'].productId');
				group.find('input.status').attr('name','productList['+_ite+'].status');
                if ($('.crs_check input[type="checkbox"]:checked').size()>0){
                    group.find('input.single').attr('name','productList['+_ite+'].single');
                    group.find('input.single').attr('value','1');
                }else{
                    group.find('input.single').attr('name','productList['+_ite+'].single');
                    group.find('input.single').attr('value','0');
                }
				/* group.find('input.single').attr(); */
				if(group.find('input.startDate').val()==''){
					layer.alert("请选择开始日期!");
					group.find('input.startDate').focus();
					hasError=true;
					return false;
				}else{
					group.find('input.startDate').attr('name','productList['+_ite+'].startDate');	
				}
				if(group.find('input.endDate').val()==''){
					layer.alert("请选择结束日期!");
					group.find('input.endDate').focus();
					hasError=true;
					return false;
				}else{
					group.find('input.endDate').attr('name','productList['+_ite+'].endDate');	
				}
				_ite++;
			});
			if(hasError){
				e.preventDefault();
				return false;
			}
			//文献互助验证
			var userDeliveryCount = $('#userDeliveryCount').val();
			var deliveryCount = $('#deliveryCount').val();
			if(userDeliveryCount==undefined || userDeliveryCount=="" || userDeliveryCount==null){  
			     alert("请输入文献互助！文献互助可输入0！");  
			     return false;
			}
			if(deliveryCount==undefined || deliveryCount=="" || deliveryCount==null){  
			     alert("请输入文献互助！文献互助可输入0！");  
			     return false;
			}
			var re = /^[0-9]*[0-9][0-9]*$/; //判断字符串是否为数字 //判断正整数 /^[1-9]+[0-9]*]*$/ 
		　　if (!re.test(userDeliveryCount)) {
				alert("请输入非负正整数");
			 	$('#userDeliveryCount').val("");
		　　　　	return false;
		　　}
			if (!re.test(deliveryCount)) {
				alert("请输入非负正整数");
			 	$('#deliveryCount').val("");
		　　　　	return false;
		　　}
			//IP地址验证
			var ipRanges='',index=0;
			$('.ips').each(function(){
				if(index==0){
					ipRanges+=$(this).text();
				}else{
					ipRanges+=";"+$(this).text();
				}
				index++;
			});
			if(ipRanges==''){
				layer.alert('请输入IP范围!');
				e.preventDefault();
				return false;
			}
			$('#ipRanges').val(ipRanges);
			var province = $('#province span').text();
			$('input[name="province"]').val(province);
			var city = $('#city span').text();
			$('input[name="city"]').val(city);
			var zy = $('.zy input[type="checkbox"]:checked').size();
			$('input[name="zyyx"]').val(zy);
			var jcryear="";
			$('.jcr input[type="checkbox"]:checked').each(function(i){
				if (0 == i) {
					jcryear = $(this).val();
                } else {
                	jcryear += (";" + $(this).val());
                }
			});
			$('input[name="jcryear"]').val(jcryear);
			//邮箱验证
			return CheckMail();
		})
 	//}); 
 })(jQuery); 
</script>

</body>
</html>
