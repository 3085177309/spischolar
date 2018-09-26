<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>

<title>校外访问申请</title>
</head>
<body>
	<jsp:include page="../head.jsp"></jsp:include>

	<script src="<cms:getProjectBasePath/>resources/js/jquery.validate.js"
		type="text/javascript"></script>
	<div id="content">
		<!-- 左侧栏目：开始 -->
		<div class="col-left left-menue" id="side-menue">
			<h3>
				<span class="inc uv12"></span> <span class="inc uv80"></span> 系统管理
			</h3>
			<ul class="side-nav">
				<c:forEach items="${permission.xtgl }" var="xtgl" varStatus="status">
					<li><a href="<cms:getProjectBasePath/>${xtgl.url}"
						<c:if test="${xtgl.id == 33 }">class="in"</c:if>>${xtgl.columnName }</a></li>
				</c:forEach>
			</ul>
		</div>
		<!-- 左侧栏目：结束 -->

		<div class="col-left col-auto">
			<div class="crumb">
				<span class="inc uv02"></span> <a
					href="<cms:getProjectBasePath/>backend/index">首页</a>> <a
					href="<cms:getProjectBasePath/>backend/org/list">系统管理</a>> <a
					href="<cms:getProjectBasePath/>backend/member/list" class="in">校外访问申请</a>
			</div>
			<div class="iframe-con" id="rightMain">
				<div class="scroll">
					<div class="imgholder">
						<img src="/user/showFile?filename=${user.identification }" alt="">
					</div>
					<div class="">
						<ul class="user-info-data">
							<li><span>邮箱：</span>${user.email }</li>
							<li><span>用户名：</span>${user.username }</li>
							<li><span>真实姓名：</span>${user.nickname }</li>
							<li><span>学校：</span>${user.school }</li>
							<li><span>院系：</span>${user.department }</li>
							<li><span>身份类别：</span> <c:choose>
									<c:when test="${user.identity ==1 }">学生</c:when>
									<c:when test="${user.identity ==2 }">老师</c:when>
									<c:when test="${user.identity ==3 }">其他</c:when>
								</c:choose></li>
							<li><span>职工号/学号：</span>${user.studentId }</li>
							<li><span>学历：</span> <c:choose>
									<c:when test="${user.education ==1 }">大专</c:when>
									<c:when test="${user.education ==2 }">本科</c:when>
									<c:when test="${user.education ==3 }">硕士</c:when>
									<c:when test="${user.education ==4 }">博士</c:when>
									<c:when test="${user.education ==5 }">其他</c:when>
								</c:choose></li>
							<li><span>性别：</span> <c:if test="${user.sex == 1 }">男</c:if>
								<c:if test="${user.sex == 2 }">女</c:if></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../foot.jsp"></jsp:include>
	<script type="text/javascript">
            
        var err = '${error}';
        if(err!='') {
       	 alert(err); 
        }
        var addUsers = '${addUsers}';
        if(addUsers!='') {
          	 alert(addUsers); 
        }
        <%
        session.removeAttribute("addUsers"); 
        %>
    </script>
	</div>
</body>
</html>
