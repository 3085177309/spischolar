<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>添加机构</title>
	<script src="<%=path%>/resources/js/jquery-1.7.1.min.js"></script>  
	<script src="<%=path%>/resources/js/jquery-ui-1.8.18.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/jquery-ui-1.8.18.custom.css" />
	<link href="<%=path%>/resources/css/all-backend.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/resources/js/all-backend.js"></script>
	<script type="text/javascript">
	//判断是否是IP
	function isIP(ip){  
	    var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;  
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
	</script>
	<style>
	input.red{
		border: 1px solid red !important;
	}
	input.green{
		border :1px solid green !important;
	}
	</style>
</head>

<body>
<div class="wxcl_qq">
 <h4 style="color: red" id="msg">&nbsp;${error }</h4>
  <form name="qq_form" method="post" action="backend/org/add">
    <ul>
      <li class="tjxq_li1"><span>学&#12288;&#12288;校：</span>
        <input name="name" type="text" value="${org.name }"/>
      </li>
      <li class="tjxq_li1"><span>机构标识：</span>
        <input name="flag" type="text" value="${org.flag }"/>
      </li>
      <li class="tjxq_li1"><span>选择模版：</span>
        <select name="template">
        <c:forEach var="t" items="${tmpls }">
       		<option value="${t }">${ t}</option> 
        </c:forEach>
        </select>
      </li>
      <li class="tjxq_li1"><span>&#12288;联系人：</span>
        <input name="contactPerson" type="text" value="${org.contactPerson }"/>
      </li>
      <li class="tjxq_li1"><span>联系方式：</span>
        <input name="contact" type="text" value="${org.contact }"/>
      </li>
      <li class="tjxq_li1"><span>邮&#12288;&#12288;箱：</span>
        <input name="email" type="text" value="${org.email }"/>
      </li>
      <li class="tjxq_li2"><span>产&#12288;&#12288;品：</span>
        <p><input name="" type="checkbox" value="期刊导航" />期刊导航</p>
        <div class="group"><span>使&#12288;&#12288;用：</span>
        <input type="hidden" value="期刊导航" class="proName"/>
        <input type="hidden" value="1" class="proId"/>
        <select style="float:left" class="status">
        	<option value="1">购买</option>
        	<option value="2">试用</option>
        	<option value="0">停用</option>
        </select>
        <span class="ml_">开始日期：</span><input type="text" class="startDate" />
		<span class="ml_">结束日期：</span><input type="text" class="endDate"/>
		<div class="clear"></div>
		</div>
        <p><input name="" type="checkbox" value="轻学术发现" />轻学术发现</p>
        <div class="group"><span>使&#12288;&#12288;用：</span>
        <input type="hidden" value="轻学术发现" class="proName"/>
        <input type="hidden" value="2" class="proId"/>
        <!-- <div class="select_ png"> <a href="javascript:void(0)" onclick="show_list(this)" class="png select_box" id="select_box1">购买</a>
          <p style="display: none;"> <a href="javascript:void(0)" v='试用V' onclick='index_js_setFl(this,"select_box1","Language1");return false'>试用</a> <a href="javascript:void(0)" v='购买V' onclick='index_js_setFl(this,"select_box1","Language1");return false'>购买</a></p>
        </div> -->
        <select style="float:left" class="status">
        	<option value="1">购买</option>
        	<option value="2">试用</option>
        	<option value="0">停用</option>
        </select>
        <span class="ml_">开始日期：</span><input type="text" class="startDate"/>
		<span class="ml_">结束日期：</span><input type="text" class="endDate"/>
		<div class="clear"></div>
		</div>
        <p><input name="" type="checkbox" value="数据导航" />数据导航</p>
        <div class="group"><span>使&#12288;&#12288;用：</span>
        <input type="hidden" value="数据导航"  class="proName"/>
        <input type="hidden" value="3" class="proId"/>
        <select style="float:left" class="status">
        	<option value="1">购买</option>
        	<option value="2">试用</option>
        	<option value="0">停用</option>
        </select>
        <span class="ml_">开始日期：</span><input type="text" class="startDate"/>
		<span class="ml_">结束日期：</span><input type="text" class="endDate"/>
		<div class="clear"></div>
		</div>
      </li>
      <li class="tjxq_li5" ><span>IP地址:</span>
      	<input name="ip_t1" type="text" class="ip_input1" />
      	<input name="ip_t2" type="text" class="ip_input1"/>
      	<input  type="button" class="ip_button1" name="ip_insert"/>
      	<select size="2" name="ip_select"></select>
      	<div class="clear"></div>
      	<input type="hidden" name="ipRanges" id="ipRanges" value="${org.ipRanges }"/>
      	<input name="ip_delect" type="button" class="ip_button2"  value="删除"/>
        <script>
         $(function(){
        	 /**
        	 * 检测IP地址是否重复
        	 */
        	 function chechRepeat(val){
        		 var hasRepeat=false;
        		 $('select[name="ip_select"]').find('option').each(function(){
        			if( $(this).text()==val){
        				hasRepeat=true;
        			}
        		 });
        		 return hasRepeat;
        	 }
              var Myform=document.forms["qq_form"],
                opi1=Myform.ip_t1,
                opi2=Myform.ip_t2,
                oselect=Myform.ip_select,
                insert=Myform.ip_insert,
                delect=Myform.ip_delect;
              var text=
                insert.onclick=function(){
                    if(opi1.value==""||opi2.value==""){
                    	if(opi1.value==""){
                         	opi1.value="不允许为空";
                         	opi1.select();
                    	}else{
                    		opi2.value="不允许为空";
                    		opi2.select();
                    	}
                        return false;
                    }else if(!isIP(opi1.value)||!isIP(opi2.value)){
                    	message("IP格式错误!",function(){
                    		if(!isIP(opi1.value)){
                        		opi1.select();
                        	}else{
                        		opi2.select();
                        	}
                    	});
                    	return false;
                    }else if(chechRepeat(opi1.value+"---"+opi2.value)){
                    	message("IP地址已经在列表中!");
                    }else{
                        var options=new Option(opi1.value+"---"+opi2.value,"22222");
                        var ips=opi1.value+"---"+opi2.value;
                        oselect.options[oselect.length]=options;
                        $.get('backend/org/checkIpRangesExist',{startIp:opi1.value,endIp:opi2.value},function(data){
           				  var rs=eval('('+data+')');
           				  if(rs.exist&&rs.exist==1){//检测存在
           					 $('#msg').text(ips+'在其他机构中已经存在!');
           				  }else{
           					 if( $('#msg').text()==(ips+'在其他机构中已经存在!')){
           						 $('#msg').html('&nbsp;');
           					 }
           				  }
           			  });
                        opi1.value="";
                        opi2.value="";
                    }
                }
                oselect.onchange=function(){
                    delect.onclick=function(){
                         oselect.options[oselect.selectedIndex]=null;
                    }
                } 
                $('select[name="ip_select"]').bind('click',function(){
                	var line=$('select[name="ip_select"]').find('option:selected').text();
                	if(line!=''&&$('input[name="ip_t1"]').val()==''&&$('input[name="ip_t2"]').val()==''){
                		var items=line.split('---');
                		if(items.length==2){
                			$('input[name="ip_t1"]').val(items[0]);
                			$('input[name="ip_t2"]').val(items[1]);
                		}
                	}
                })
         }); 
        </script>
      </li>
      <li>
        <div class="qx_bc"><input type="submit" class="aaniu1"/><input type="reset" value="重置" class="aaniu2"/></div>
      </li>
    </ul>
  </form>
  <div class="clear"></div>
</div>
<script>
/**
 * 提示消息
 * @param text 提示消息
 * @param func 回调函数
 */
function message(text,func) {
    $("#spanmessage").text(text);
    $("#message").dialog({
        title:"学术资源管理后台，提示您",
        modal: true,
        buttons: {
            "确定": function() {
                $(this).dialog("close");
                if(func){
                	func.call();
                }
            }
        }
    });
}
(function($){
 	$(document).ready(function(){ 
 		//初始化IP范围
 		var ipRanges=$('#ipRanges').val(),ipRangesArr;
 		ipRangesArr=ipRanges.split(";");
 		for(var i=0;i<ipRangesArr.length;i++){
 			$('select[name="ip_select"]').append('<option value="">'+ipRangesArr[i]+'</option>');
 		}
 		//添加消息提示框
 		var boardDiv = "<div id='message' style='display:none;'><span id='spanmessage'></span></div>";
 	   	$(document.body).append(boardDiv);
 	   	//日历控件
 	   	$('.group').each(function(){
 	   		var tar=$(this);
 	   		tar.find('input.startDate').datepicker({
 	        	"dateFormat":"yy-mm-dd",
 	        	changeMonth: true,
 	            changeYear: true,
 	        	onSelect:function(dateText,inst){
 	            	tar.find('input.endDate').datepicker("option","minDate",dateText);
 	        	}
 	        }); 
 	   		tar.find('input.endDate').datepicker({
        		"dateFormat":"yy-mm-dd",
        		changeMonth: true,
            	changeYear: true,
        		onSelect:function(dateText,inst){
        			tar.find('input.startDate').datepicker("option","maxDate",dateText);
        		}
        	}); 
 	   	});
 	   //机构名称重复检测
 	   $('input[name="name"]').bind('blur',function(e){
 		  var name=$(this).val();
 		  if(!!name){
 			  $.get('backend/org/checkOrgNameExist',{orgName:name},function(data){
 				  var rs=eval('('+data+')');
 				  if(rs.exist&&rs.exist==1){//检测存在
 					 $('#msg').text('该机构已经存在!');
 					$('input[name="name"]').focus();
 					$('input[name="name"]').removeClass('green').addClass('red');
 				  }else{
 					 if( $('#msg').text()=='该机构已经存在!'||$('#msg').text()=='请输入机构名称!'){
 						 $('#msg').html('&nbsp;');
 					 }
 					 $('input[name="name"]').removeClass('red').addClass('green');
 				  }
 			  });
 		  }else{
 			 $('#msg').text('请输入机构名称!');
 			$('input[name="name"]').removeClass('green').addClass('red');
 		  }
 	   });
 	   //机构标识
 	  $('input[name="flag"]').bind('blur',function(e){
 		  var flag=$(this).val();
 		  if(!!flag){
 			  $.get('backend/org/checkFlagExist',{flag:flag},function(data){
 				  var rs=eval('('+data+')');
 				  if(rs.exist&&rs.exist==1){//检测存在
 					 $('#msg').text('该机构标识已经存在!');
 					$('input[name="flag"]').focus();
 					$('input[name="flag"]').removeClass('green').addClass('red');
 				  }else{
 					 if( $('#msg').text()=='该机构标识已经存在!'||$('#msg').text()=='请输入机构标识!'){
 						 $('#msg').html('&nbsp;');
 					 }
 					 $('input[name="flag"]').removeClass('red').addClass('green');
 				  }
 			  });
 		  }else{
 			 $('#msg').text('请输入机构标识!');
 			$('input[name="flag"]').removeClass('green').addClass('red');
 		  }
 	   });
 	   //IP范围检测
 	   
		$('form[name="qq_form"]').bind('submit',function(e){
			//机构名称验证
			if($('input[name="name"]').val()==''){
				message('请输入机构名称!',function(){
					$('input[name="name"]').focus();
				});
				e.preventDefault();
				return false;
			}
			//机构标识验证
			if($('input[name="flag"]').val()==''){
				message('请输入机构标识!',function(){
					$('input[name="flag"]').focus();
				});
				e.preventDefault();
				return false;
			}
			//购买产品验证
			var size=$('input[type="checkbox"]:checked').size();
			if(size==0){
				message('请选择购买或试用的产品!');
				e.preventDefault();
				return false;
			}
			var hasError=false,_ite=0;
			$('input[type="checkbox"]:checked').each(function(){
				var index=$('input[type="checkbox"]').index(this);
				var group=$('.group').eq(index);
				group.find('input.proName').attr('name','productList['+_ite+'].productName');
				group.find('input.proId').attr('name','productList['+_ite+'].productId');
				group.find('select.status').attr('name','productList['+_ite+'].status');
				if(group.find('input.startDate').val()==''){
					message('请选择开始日期!',function(){
						group.find('input.startDate').focus();
					});
					hasError=true;
					return;
				}else{
					group.find('input.startDate').attr('name','productList['+_ite+'].startDate');	
				}
				if(group.find('input.endDate').val()==''){
					message('请选择结束日期!',function(){
						group.find('input.endDate').focus();
					});
					hasError=true;
					return ;
				}else{
					group.find('input.endDate').attr('name','productList['+_ite+'].endDate');	
				}
				_ite++;
			});
			if(hasError){
				e.preventDefault();
				return false;
			}
			//IP地址验证
			var ipRanges='',index=0;
			$('select[name="ip_select"]').find('option').each(function(){
				if($(this).text()!=''){
					if(index==0){
						ipRanges+=$(this).text();
					}else{
						ipRanges+=";"+$(this).text();
					}
					index++;
				}
			});
			if(ipRanges==''){
				message('请输入IP范围!');
				e.preventDefault();
				return false;
			}
			$('#ipRanges').val(ipRanges);
		})
    }); 
 })(jQuery) 
</script>
</body>
</html>