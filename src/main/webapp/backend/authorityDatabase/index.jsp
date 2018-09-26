<!-- 权威数据库分区管理 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<div id='dbPartition_index_panel'>
	<ul class="breadcrumb">
		<li><a href="#" action_target='backend/authorityDatabase/list/' id='authority_db_list_btn'>权威数据库分区列表</a></li>
		<li style='float: right'><input type='text' id='db_partition_key'/>
		<button class='btn btn-small' id='db_partition_search_btn' action_target='backend/authorityDatabase/list/'>检索</button>&nbsp;&nbsp;
		<button class='btn btn-small btn-primary' data-target="#addDbPartitionModal" role="button" data-toggle="modal">新增</button></li>
	</ul>

	<div id='dbPartition_list_container'></div>

</div>

<div id="addDbPartitionModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">新增权威数据库分区信息</h3>
  </div>
  <div class="modal-body">
  	<form id='db_partition_form'>
	  	<label><span>数据库标识:</span><input type='text' name='flag'/></label>
	    <label><span>分区名:</span><input type='text' name='partitionName'/></label>
	    <label><span>所有分区:</span><input type='text' name='allPartition'/>(多个分区使用;号分割)</label>
	    <label><span>分区前缀:</span><input type='text' name='prefix'/></label>
	    <label><span>分区后缀:</span><input type='text' name='suffix'/></label>
	    <label><span>优先级:</span><input type='text' name='priority'/></label>
	    <!-- <label>
	    	<span>排序方式:</span>
	    	<select name="sortType">
	    		<option value='1'>影响因子排序</option>
	    		<option value='2'>学科序号排序</option>
	    		<option value='3'>评价值排序</option>
	    		<option value='4'>其它排序方式</option>
	    	</select>
	    </label> -->
  	</form>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button class="btn btn-primary" id='add_db_partion_btn' action_form='backend/authorityDatabase/add'>确定</button>
  </div>
</div>

<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/authorityDatabase/index.js"></script>