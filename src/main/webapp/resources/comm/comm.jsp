<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String projectRootPath = request.getContextPath();
%>
<!-- Le styles -->
<link rel="stylesheet" type="text/css" href="<%=projectRootPath%>/resources/plugins/bsie-master/bootstrap/css/bootstrap.css">
<!--[if lte IE 6]>
    <link rel="stylesheet" type="text/css" href="<%=projectRootPath%>/resources/plugins/bsie-master/bootstrap/css/bootstrap-ie6.css">
    <![endif]-->
<!--[if lte IE 7]>
    <link rel="stylesheet" type="text/css" href="<%=projectRootPath%>/resources/plugins/bsie-master/bootstrap/css/ie.css">
    <![endif]-->
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="<%=projectRootPath%>/resources/js/html5shiv.js"></script>
    <![endif]-->


<script type="text/javascript" src="<%=projectRootPath%>/resources/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=projectRootPath%>/resources/plugins/bsie-master/bootstrap/js/bootstrap.js"></script>
<!--[if lte IE 6]>
    <script type="text/javascript" src="<%=projectRootPath%>/resources/plugins/bsie-master/js/bootstrap-ie.js"></script>
    <![endif]-->
<script type="text/javascript">
	(function($) {
		$(document).ready(function() {
			if ($.isFunction($.bootstrapIE6))
				$.bootstrapIE6($(document));
		});
	})(jQuery);
</script>