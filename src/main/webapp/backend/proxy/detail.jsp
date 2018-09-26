<!-- 站点管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms" %>

<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="modal" id="addModel" style="display:none;">
		<div class="modal-header">
			<h3>添加代理</h3>
		</div>
		<div class="modal-body">
			<input type="hidden" name="host"  id="host"/>
			<table>
				<tr>
					<td>IP地址</td><td><input type="text" name="ip" /></td>
				</tr>
				<tr>
					<td>端口</td><td><input type="text" name="port" /></td>
				</tr>
				<tr>
					<td>账号</td><td><input type="text" name="account" /></td>
				</tr>
				<tr>
					<td>密码</td><td><input type="text" name="pwd" /></td>
				</tr>
			</table>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn btn-primary" id="addBtn" >确定</a>
			<a href="#" class="btn btn-primary" id="hideModel">取消</a>
		</div>
	</div>
<div>
	<div>
		<h4>192.126.119.62(美国主机)</h4>
		<a href="http://192.126.119.62/web-search/searchWS?wsdl" class="btn btn-small" target="_blank">查看WSDL</a>
		<button class="btn btn-small" id="add1">添加代理</button>
		<button class="btn btn-small" onclick="reload()">重新加载</button>
		<button class="btn btn-small" onclick="status()">查看状态</button>
		<div style="clear:both"></div><br />
		<table class="table" id="table1">
			<tr>
				<th>ID</th>
				<th>IP地址</th>
				<th>端口</th>
				<th>账号</th>
				<th>密码</th>
				<th>操作</th>
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
	var querStr='http://%s/web-search/command?name=%s';//请求地址
	function listCallback(data){
		var d;
		for(var i=0;i<data.length;i++){
			d=data[i];
			$('#table1').append('<tr><td>'+d.id+'</td><td>'+d.ip+'</td><td>'+d.port+'</td><td></td><td></td><td><a href="#">删除</a></td></tr>');
		}
	}
	function addCallback(data){
		if(data.error==0){
			
		}
		alert(data.msg);
	}
	function reloadCallback(data){
		alert(data.msg);
	}
	function statusCallback(data){
		alert(data.msg);
	}
	function status(){
		$.ajax({
        	url: 'http://192.126.119.62/web-search/command?name=status',
        	dataType: "jsonp",
        	jsonp: "callback",
        	success: function (data) {
            	console.log(data)
        	}
        });	
	}
	function reload(){
		$.ajax({
        	url: 'http://192.126.119.62/web-search/command?name=reload',
        	dataType: "jsonp",
        	jsonp: "callback",
        	success: function (data) {
            	console.log(data)
        	}
        });	
	}
	function remove(id){
		$.ajax({
        	url: 'http://192.126.119.62/web-search/command?name=remove',
        	dataType: "jsonp",
        	jsonp: "callback",
        	data:{'id':id},
        	success: function (data) {
            	console.log(data)
        	}
        });
	}
	$(function(){
		$('#add1').bind('click',function(e){
			$('#addModel').show();
			//$('#host').val('192.126.119.62');
			e.preventDefault();
		})
		$('#addBtn').bind('click',function(){
			var ip=$('input[name="ip"]').val(),port=$('input[name="port"]').val(),
			account=$('input[name="account"]').val().pwd=$('input[name="pwd"]').val();
		});
		$('#hideModel').bind('click',function(e){
			$('#addModel').hide();
			e.preventDefault();
		})
		$.ajax({
        	url: 'http://192.126.119.62/web-search/command?name=list',
        	dataType: "jsonp",
        	jsonp: "callback",
        	success: function (data) {
        	}
        });
	});
</script>