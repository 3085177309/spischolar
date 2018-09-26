<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	request.setAttribute("basePath", basePath);
%>
<div class="sidebar">
    <div class="bg_top"></div>
    <ul>
      <li><a href="#"><span><img src="<%=path%>/resources/backend/images/icon1.png" width="12" height="12" /></span>首页<i></i></a></li>
      <li><a href="backend/org/list" <c:if test="${menu=='org' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon2.png" width="12" height="12" /></span>学校管理<i></i></a></li>
      <li><a href="backend/org/jnav/list" <c:if test="${menu=='jnav' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>期刊导航<i></i></a></li>
      <li><a href="backend/org/dnav/list" <c:if test="${menu=='dnav' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon4.png" width="12" height="12" /></span>数据库导航<i></i></a></li>
      <li><a href="backend/org/academic/list" <c:if test="${menu=='academic' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon5.png" width="12" height="12" /></span>轻学术发现<i></i></a></li>
	  <li><a href="backend/delivery/list" <c:if test="${menu=='dilivery' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon6.png" width="12" height="12" /></span>文献传递<i></i></a></li>
	  <li><a href="backend/updatelog/list" <c:if test="${menu=='updatelog' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>系统日志<i></i></a></li>
	  <li><a href="backend/news/list" <c:if test="${menu=='news' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>公告<i></i></a></li>
	  <li><a href="backend/member/list" <c:if test="${menu=='member' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>用户列表<i></i></a></li>
	  <li><a href="backend/feedback/list" <c:if test="${menu=='feedback' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>建议<i></i></a></li>
      <li><a href="backend/page/list" <c:if test="${menu=='page' }">class="in"</c:if>><span><img src="<%=path%>/resources/backend/images/icon3.png" width="12" height="12" /></span>单页管理<i></i></a></li>
      <li><a href="backend/logout"><span><img src="<%=path%>/resources/backend/images/icon2.png" width="12" height="12" /></span>退出登录<i></i></a></li>
    </ul>
  </div>
  <div class="sidebar_bot_line"></div>