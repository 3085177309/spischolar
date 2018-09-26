<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set var="pageTitle" value="权威数据库编辑" scope="request"></c:set>
<c:set var="title" value="权威数据库编辑" scope="request"></c:set>
<jsp:include page="/backend/common/header.jsp"></jsp:include>
<jsp:include page="/backend/common/nav.jsp"></jsp:include>
<div class="row">
<div class="col-md-8 col-md-offset-2">
<form class="form-horizontal" role="form">
	<div class="form-group">
    	<label for="inputFlag" class="col-sm-2 control-label">数据库标识</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="flag" id="inputFlag" value="${authorityDatabase.flag }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="alias" class="col-sm-2 control-label">别名</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="alias" id="alias" value="${authorityDatabase.alias }">
    	</div>
  	</div>
	<div class="form-group">
    	<label for="partitionName" class="col-sm-2 control-label">分区名</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="partitionName" id="partitionName" value="${authorityDatabase.partitionName }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="allPartition" class="col-sm-2 control-label">所有分区</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="allPartition" id="allPartition" value="${authorityDatabase.allPartition }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="prefix" class="col-sm-2 control-label">分区前缀</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="prefix" id="prefix" value="${authorityDatabase.prefix }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="suffix" class="col-sm-2 control-label">分区后缀</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="suffix" id="suffix" value="${authorityDatabase.suffix }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="priority" class="col-sm-2 control-label">优先级</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="priority" id="priority" value="${authorityDatabase.priority }">
    	</div>
  	</div>
  	<div class="form-group">
    	<label for="years" class="col-sm-2 control-label">所有的收录年份</label>
    	<div class="col-sm-10">
      		<input type="text" class="form-control" name="years" id="years" value="${authorityDatabase.years }">
    	</div>
  	</div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-info">修改</button>
    </div>
  </div>
</form>
</div>
</div>
<jsp:include page="/backend/common/footer.jsp"></jsp:include>