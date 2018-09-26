<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="cms" uri="http://org.pzy.cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>基本信息</title>


<jsp:include page="../head.jsp"></jsp:include>
<!--<script src="<cms:getProjectBasePath/>/resources/js/jquery-ui-1.8.18.custom.min.js"></script>--这里引起冲突了，不知道干嘛的，先隐藏!!-->

<link rel="stylesheet" type="text/css"
      href="<cms:getProjectBasePath/>/resources/css/jquery-ui-1.8.18.custom.css"/>
<script
        src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<jsp:useBean id="now" class="java.util.Date"/>
<!-- 当前时间 -->
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
                              action="<cms:getProjectBasePath/>backend/org/list/updateOrg">
                            <div class="infochoose">
                                <input type="hidden" name="id" value="${org.id }"/> <input
                                    type="hidden" name="template" value="xsfx"> <label
                                    class="list"> <span class="labt">学校：</span> <input
                                    type="text" class="tbSearch" name="name" value="${org.name }">
                            </label> <label class="list"> <span class="labt">机构标识：</span> <input
                                    type="text" name="flag" class="tbSearch" value="${org.flag }"
                                    style="background: #ddd;" readonly="readonly">
                            </label> <label class="list wid53" id="comefrom"> <span
                                    class="labt">地区：</span>
                                <div class="secondary One-third" id="province">
                                    <i class="inc uv21"></i>
                                    <c:if test="${not empty org.province }">
                                        <span>${org.province }</span>
                                    </c:if>
                                    <c:if test="${empty org.province }">
                                        <span>请选择</span>
                                    </c:if>
                                    <div class="sc_selopt" style="display: none;"></div>
                                    <input type="hidden" name="province" value="${org.province }">
                                </div>
                                <div class="secondary One-third" id="city">
                                    <i class="inc uv21"></i>
                                    <c:if test="${not empty org.city }">
                                        <span>${org.city }</span>
                                    </c:if>
                                    <c:if test="${empty org.city }">
                                        <span>请选择</span>
                                    </c:if>
                                    <div class="sc_selopt" style="display: none;"></div>
                                    <input type="hidden" name="city" value="${org.city }">
                                </div>
                            </label>
                                <script
                                        src="<cms:getProjectBasePath/>/resources/back/js/comefrom.js"></script>
                                <label class="list"> <span class="labt">联系人：</span> <input
                                        type="text" name="contactPerson" class="tbSearch"
                                        value="${org.contactPerson }">
                                </label> <label class="list"> <span class="labt">联系方式：</span> <input
                                    type="text" name="contact" class="tbSearch"
                                    value="${org.contact }">
                            </label> <label class="list"> <span class="labt">邮箱：</span> <input
                                    type="text" name="email" id="email" onchange="CheckMail()"
                                    class="tbSearch" value="${org.email }">
                            </label>

                                <div class="clear"></div>
                            </div>
                            <div class="productAll clearfix">
                                <span class="tit">产品：</span>
                                <div class="productchoose">
                                    <!-- 期刊 -->
                                    <c:set var="hasJN" value="0"></c:set>
                                    <c:forEach var="p" items="${org.productList }">
                                        <c:if test="${p.productId==1 }">
                                            <c:set var="hasJN" value="1"></c:set>
                                            <div class="chooseline">
                                                    <%--@declare id=""--%><label><input type="checkbox"
                                                                                        checked="checked"
                                                                                        name="check" class="checkbox">学术期刊指南</label>
                                                <input
                                                        type="hidden" value="学术期刊指南" class="proName"/> <input
                                                    type="hidden" value="1" class="proId"/> <label
                                                    class="list wid30 act"> <span class="labt "
                                                                                  style="*float: left;">状态：</span>
                                                <div class="sc_selbox sc_selboxhalf">
                                                    <i class="inc uv21"></i>
                                                    <c:if test="${p.status==1 }">
                                                        <span id="section_lx">购买</span>
                                                    </c:if>
                                                    <c:if test="${p.status==2 }">
                                                        <span id="section_lx">试用</span>
                                                    </c:if>
                                                    <c:if test="${p.status==0 }">
                                                        <span id="section_lx">停用</span>
                                                    </c:if>
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
                                                                                    id="startTime1"
                                                                                    value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                    onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime1\')}',readOnly:true})">
                                                </div>
                                                <span class="labm">结束日期：</span>
                                                <div class="datebox">
                                                    <i class="inc uv13"></i> <input type="text"
                                                                                    class="tbSearch datechoose endDate"
                                                                                    id="endTime1"
                                                                                    value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                    onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime1\')}',maxDate:'2035-03-13',readOnly:true})">
                                                </div>
                                            </label>
                                                <c:if test="${not empty p.endDate }">
                                                    <c:set var="interval"
                                                           value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                                </c:if>
                                                    <%-- <label for="" class="data-type">
                                                <c:if test="${interval > 0}">
                                                    <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                                </c:if>
                                                <c:if test="${interval <= 0}">
                                                    <span class="labm">剩余有效期：</span>0 天
                                                </c:if>
                                            </label> --%>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${hasJN==0 }">
                                        <div class="chooseline">
                                            <label><input type="checkbox" name="check"
                                                          class="checkbox">学术期刊指南</label> <input type="hidden"
                                                                                                 value="学术期刊指南"
                                                                                                 class="proName"/>
                                            <input type="hidden"
                                                   value="1" class="proId"/> <label class="list wid30 act">
                                            <span class="labt" style="*float: left;">状态：</span>
                                            <div class="sc_selbox sc_selboxhalf">
                                                <i class="inc uv21"></i><span id="section_lx">购买</span>

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
                                                                                id="startTime2"
                                                                                value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime2\')}',readOnly:true})">
                                            </div>
                                            <span class="labm">结束日期：</span>
                                            <div class="datebox">
                                                <i class="inc uv13"></i> <input type="text"
                                                                                class="tbSearch datechoose endDate"
                                                                                id="endTime2"
                                                                                value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime2\')}',maxDate:'2035-03-13',readOnly:true})">
                                            </div>
                                        </label>
                                            <c:if test="${not empty p.endDate }">
                                                <c:set var="interval"
                                                       value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                            </c:if>
                                                <%-- <label for="" class="data-type">
                                                <c:if test="${interval > 0}">
                                                    <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                                </c:if>
                                                <c:if test="${interval <= 0}">
                                                    <span class="labm">剩余有效期：</span>0 天
                                                </c:if>
                                            </label> --%>
                                        </div>
                                    </c:if>
                                    <!-- 文章 -->
                                    <c:set var="hasAC" value="0"></c:set>
                                    <c:forEach var="p" items="${org.productList }">
                                        <c:if test="${p.productId==2 }">
                                            <c:set var="hasAC" value="1"></c:set>
                                            <div class="chooseline">
                                                <label><input type="checkbox" name="check"
                                                              checked="checked" class="checkbox">蛛网学术搜索</label> <input
                                                    type="hidden" value="蛛网学术搜索" class="proName"/> <input
                                                    type="hidden" value="2" class="proId"/> <label
                                                    class="list wid30"> <span class="labt"
                                                                              style="*float: left;">状态：</span>
                                                <div class="sc_selbox sc_selboxhalf">
                                                    <i class="inc uv21"></i>
                                                    <c:if test="${p.status==1 }">
                                                        <span id="section_lx">购买</span>
                                                    </c:if>
                                                    <c:if test="${p.status==2 }">
                                                        <span id="section_lx">试用</span>
                                                    </c:if>
                                                    <c:if test="${p.status==0 }">
                                                        <span id="section_lx">停用</span>
                                                    </c:if>
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
                                                                                    id="startTime3"
                                                                                    value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                    onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime3\')}',readOnly:true})">
                                                </div>
                                                <span class="labm">结束日期：</span>
                                                <div class="datebox">
                                                    <i class="inc uv13"></i> <input type="text"
                                                                                    class="tbSearch datechoose endDate"
                                                                                    id="endTime3"
                                                                                    value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                    onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime3\')}',maxDate:'2035-03-13',readOnly:true})">
                                                </div>
                                            </label>
                                                <c:if test="${not empty p.endDate }">
                                                    <c:set var="interval"
                                                           value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                                </c:if>
                                                    <%-- <label for="" class="data-type">
                                                <c:if test="${interval > 0}">
                                                    <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                                </c:if>
                                                <c:if test="${interval <= 0}">
                                                    <span class="labm">剩余有效期：</span>0 天
                                                </c:if>
                                            </label> --%>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${hasAC==0 }">
                                        <div class="chooseline">
                                            <label><input type="checkbox" name="check"
                                                          class="checkbox">蛛网学术搜索</label> <input type="hidden"
                                                                                                 value="蛛网学术搜索"
                                                                                                 class="proName"/>
                                            <input type="hidden"
                                                   value="2" class="proId"/> <label class="list wid30">
                                            <span class="labt" style="*float: left;">状态：</span>
                                            <div class="sc_selbox sc_selboxhalf">
                                                <i class="inc uv21"></i> <span id="section_lx">购买</span>
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
                                                                                id="startTime4"
                                                                                value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime4\')}',readOnly:true})">
                                            </div>
                                            <span class="labm">结束日期：</span>
                                            <div class="datebox">
                                                <i class="inc uv13"></i> <input type="text"
                                                                                class="tbSearch datechoose endDate"
                                                                                id="endTime4"
                                                                                value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime4\')}',maxDate:'2035-03-13',readOnly:true})">
                                            </div>
                                        </label>
                                            <c:if test="${not empty p.endDate }">
                                                <c:set var="interval"
                                                       value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                            </c:if>
                                                <%-- <label for="" class="data-type">
                                                <c:if test="${interval > 0}">
                                                    <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                                </c:if>
                                                <c:if test="${interval <= 0}">
                                                    <span class="labm">剩余有效期：</span>0 天
                                                </c:if>
                                            </label> --%>
                                        </div>
                                    </c:if>
                                    <!-- CRS -->
                                    <c:set var="hasCRS" value="0"></c:set>
                                    <c:forEach var="p" items="${org.productList }">
                                        <c:if test="${p.productId==4 }">
                                            <c:set var="hasCRS" value="1"></c:set>
                                            <div class="chooseline">
                                            <label><input type="checkbox" name="check"
                                                          checked="checked" class="checkbox">CRS核心论文库</label> <input
                                                type="hidden" value="CRS核心论文库" class="proName"/> <input
                                                type="hidden" value="4" class="proId"/> <label
                                                class="list wid30"> <span class="labt"
                                                                          style="*float: left;">状态：</span>
                                            <div class="sc_selbox sc_selboxhalf">
                                                <i class="inc uv21"></i>
                                                <c:if test="${p.status==1 }">
                                                    <span id="section_lx">购买</span>
                                                </c:if>
                                                <c:if test="${p.status==2 }">
                                                    <span id="section_lx">试用</span>
                                                </c:if>
                                                <c:if test="${p.status==0 }">
                                                    <span id="section_lx">停用</span>
                                                </c:if>
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
                                                                                id="startTime5"
                                                                                value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime5\')}',readOnly:true})">
                                            </div>
                                            <span class="labm">结束日期：</span>
                                            <div class="datebox">
                                                <i class="inc uv13"></i> <input type="text"
                                                                                class="tbSearch datechoose endDate"
                                                                                id="endTime5"
                                                                                value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime5\')}',maxDate:'2035-03-13',readOnly:true})">
                                            </div>
                                        </label>
                                        <label class="crs_check">
                                            <c:choose>
                                                <c:when test="${p.single}">
                                                    <input type="checkbox" checked>是否独立购买
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="checkbox">是否独立购买
                                                </c:otherwise>
                                            </c:choose>
                                            <input type="hidden" value="" class="single">
                                        </label>

                                        <c:if test="${not empty p.endDate }">
                                            <c:set var="interval"
                                                   value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                        </c:if>
                                        <%-- <label for="" class="data-type">
                                    <c:if test="${interval > 0}">
                                        <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                    </c:if>
                                    <c:if test="${interval <= 0}">
                                        <span class="labm">剩余有效期：</span>0 天
                                    </c:if>
                                </label> --%>
                                        </div>
                                    </c:if>
                                    </c:forEach>
                                    <c:if test="${hasCRS==0 }">
                                        <div class="chooseline">
                                            <label><input type="checkbox" name="check"
                                                          class="checkbox">CRS核心论文库</label> <input type="hidden"
                                                                                                   value="CRS核心论文库"
                                                                                                   class="proName"/>
                                            <input type="hidden"
                                                   value="4" class="proId"/> <label class="list wid30">
                                            <span class="labt" style="*float: left;">状态：</span>
                                            <div class="sc_selbox sc_selboxhalf">
                                                <i class="inc uv21"></i> <span id="section_lx">购买</span>
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
                                                                                id="startTime6"
                                                                                value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'2015-03-13',maxDate:'#F{$dp.$D(\'endTime6\')}',readOnly:true})">
                                            </div>
                                            <span class="labm">结束日期：</span>
                                            <div class="datebox">
                                                <i class="inc uv13"></i> <input type="text"
                                                                                class="tbSearch datechoose endDate"
                                                                                id="endTime6"
                                                                                value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>"
                                                                                onclick="WdatePicker({minDate:'#F{$dp.$D(\'startTime6\')}',maxDate:'2035-03-13',readOnly:true})">
                                            </div>
                                        </label>
                                            <label class="crs_check">
                                                <c:choose>
                                                    <c:when test="${p.single}">
                                                        <input type="checkbox" checked>是否独立购买
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="checkbox">是否独立购买
                                                    </c:otherwise>
                                                </c:choose>
                                                <input type="hidden" value="" class="single">
                                            </label>



                                            <c:if test="${not empty p.endDate }">
                                                <c:set var="interval"
                                                       value="${(p.endDate.time - now.time)/1000/60/60/24+1}"/>
                                            </c:if>
                                                <%-- <label for="" class="data-type">
                                                <c:if test="${interval > 0}">
                                                    <span class="labm">剩余有效期：</span><fmt:formatNumber value="${interval}" pattern="#0"/> 天
                                                </c:if>
                                                <c:if test="${interval <= 0}">
                                                    <span class="labm">剩余有效期：</span>0 天
                                                </c:if>
                                            </label> --%>
                                        </div>
                                    </c:if>
                                    <!-- 数据库导航
								<c:set var="hasDN" value="0"></c:set>
								<c:forEach var="p" items="${org.productList }">
								<c:if test="${p.productId==3 }">
								<c:set var="hasDN" value="1"></c:set>
									<div class="chooseline">
										<label><input type="checkbox" checked="checked" name="check" class="checkbox">数据库导航&nbsp&nbsp</label>
										<input type="hidden" value="数据导航"  class="proName"/>
        								<input type="hidden" value="3" class="proId"/>
										<label class="list wid30">
											<span class="labt">状态：</span>
											<div class="sc_selbox sc_selboxhalf">
												<i class="inc uv21"></i>
												<c:if test="${p.status==1 }"><span id="section_lx">购买</span></c:if>
												<c:if test="${p.status==2 }"><span id="section_lx">试用</span></c:if>
												<c:if test="${p.status==0 }"><span id="section_lx">停用</span></c:if>
												<div class="sc_selopt" style="display: none;">
													<p>购买</p>
													<p>试用</p>
													<p>停用</p>
												</div>
												<input type="hidden" value="" class="status">
											</div>
										</label>
										<label for="" class="data-type">
											<span class="labt">开始日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i>
												<input type="text" class="tbSearch datechoose startDate" value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>" onclick="WdatePicker()">
											</div>
											
											<span class="labm">结束日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i>
												<input type="text" class="tbSearch datechoose endDate" value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>" onclick="WdatePicker()">
											</div>
										</label>
									</div>
								</c:if>
									
								</c:forEach>
								<c:if test="${hasDN==0 }">
									<div class="chooseline">
										<label><input type="checkbox" name="check" class="checkbox">数据库导航&nbsp</label>
										<input type="hidden" value="数据导航"  class="proName"/>
        								<input type="hidden" value="3" class="proId"/>
										<label class="list wid30">
											<span class="labt">状态：</span>
											<div class="sc_selbox sc_selboxhalf">
												<i class="inc uv21"></i>
												<span id="section_lx">购买</span>
												<div class="sc_selopt" style="display: none;">
													<p>购买</p>
													<p>试用</p>
													<p>停用</p>
												</div>
												<input type="hidden" value="" class="status">
											</div>
										</label>
										<label for="" class="data-type">
											<span class="labt">开始日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i>
												<input type="text" class="tbSearch datechoose startDate" value="<fmt:formatDate value="${p.startDate }" pattern="yyyy-MM-dd"/>" onclick="WdatePicker()">
											</div>
											
											<span class="labm">结束日期：</span>
											<div class="datebox">
												<i class="inc uv13"></i>
												<input type="text" class="tbSearch datechoose endDate" value="<fmt:formatDate value="${p.endDate }" pattern="yyyy-MM-dd"/>" onclick="WdatePicker()">
											</div>
										</label>
									</div>
								</c:if>
								-->
                                </div>
                                <div class="clear"></div>
                            </div>
                            <div class="infoline zy">
                                <label class="list"> <span class="labt">资源：</span> <input
                                        type="checkbox" name="" style="margin-left: -5px;"
                                        class="checkbox"
                                        <c:if test="${org.zyyx==1}">checked="checked"</c:if>>开放资源优先
                                </label> <input type="hidden" name="zyyx" value="">
                            </div>
                            <div class="infoline jcr">
                                <%--@declare id="today"--%><label class="list"> <span class="labt">数据：</span>中科院JCR数据
                            </label> <label for="today" class="data-type"> <input
                                    type="checkbox" class="tbRadio"
                                    <c:if test="${org.jcryear.contains('2012')}">checked="checked"</c:if>
                                    value="2012"> <span>2012</span>
                            </label> <label for="today" class="data-type"> <input
                                    type="checkbox" class="tbRadio"
                                    <c:if test="${org.jcryear.contains('2013')}">checked="checked"</c:if>
                                    value="2013"> <span>2013</span>
                            </label> <label for="today" class="data-type"> <input
                                    type="checkbox" class="tbRadio"
                                    <c:if test="${org.jcryear.contains('2014')}">checked="checked"</c:if>
                                    value="2014"> <span>2014</span>
                            </label> <label for="today" class="data-type"> <input
                                    type="checkbox" class="tbRadio"
                                    <c:if test="${org.jcryear.contains('2015')}">checked="checked"</c:if>
                                    value="2015"> <span>2015</span>
                            </label> <label for="today" class="data-type"> <input
                                    type="checkbox" class="tbRadio"
                                    <c:if test="${org.jcryear.contains('2016')}">checked="checked"</c:if>
                                    value="2016"> <span>2016</span>
                            </label> <input type="hidden" name="jcryear" value="">
                            </div>
                            <div class="infoline delivery">
                                <label class="list"> <span class="labt">文献互助：</span>登录用户
                                </label> <label class="list"> <input type="text"
                                                                     name="userDeliveryCount" id="userDeliveryCount"
                                                                     class="tbSearch" value="${org.userDeliveryCount }">
                                条
                            </label> <label class="list"> &nbsp;&nbsp;&nbsp;游客 </label> <label
                                    class="list"> <input type="text" name="deliveryCount"
                                                         id="deliveryCount" class="tbSearch"
                                                         value="${org.deliveryCount }"> 条
                            </label>
                            </div>

                            <div class="infochoose">
                                <input type="hidden" name="ipRanges" id="ipRanges"
                                       value="${org.ipRanges }"/> <label class=singleAdd> <span
                                    class="labt">IP地址：</span> <input type="text" name="ip_t1"
                                                                     style="width: 130px" class="tbSearch ip_input1">
                                --- <input
                                        type="text" style="width: 130px" name="ip_t2"
                                        class="tbSearch ip_input1"> <span class="thickBtn add"
                                                                          data-thickcon="schoolTick"> <i></i> 添加
								</span> <a onclick="chooseAdd('1')" class="oprbtn black">批量添加</a>
                            </label> <label class="batchAdd" style="display: none;"> <span
                                    class="labt vert-top">IP地址：</span> <textarea rows="10"
                                                                                 cols="60" id="batchIps"
                                                                                 class="vert-bot"></textarea> <span
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


<script>
    /**
     * 邮箱验证
     */
    function CheckMail() {
        var mail = $('#email').val();
        var filter = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
        if (filter.test(mail)) return true;
        else {
            if (mail == "") {
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
        addType = type;
        if (type == 1) {
            $('.singleAdd').hide();
            $('.batchAdd').show();
        } else {
            $('.batchAdd').hide();
            $('.singleAdd').show();
        }
    }

    /**
     * 提示消息
     * @param text 提示消息
     * @param func 回调函数
     */
    (function ($) {
        $(document).ready(function () {
            //初始化IP范围
            var ipRanges = $('#ipRanges').val(), ipRangesArr;
            if (!ipRanges == "") {
                ipRangesArr = ipRanges.split(";");
                for (var i = 0; i < ipRangesArr.length; i++) {
                    $('.fixedwidth').append('<tr><td class="index" value=' + (i + 1) + '>' + (i + 1) + '</td><td><p class="ips">' + ipRangesArr[i] + '</p><input class="updateInput" type="text" style="display: none;width:100%" value="' + ipRangesArr[i] + '"></td><td><span style="padding-left:10px" class="cd00 update thickBtn">修改</span><span style="padding-left:10px;display: none;" class="cd00 confirms thickBtn">确认</span><span style="padding-left:10px" class="cd00 delete thickBtn">删除</span></td></tr>');
                }
            }
            //点击添加ip
            var Myform = document.forms["qq_form"],
                opi1 = Myform.ip_t1,
                opi2 = Myform.ip_t2;
            $('.add').click(function () {
                var ips = opi1.value + "---" + opi2.value;

                if (addType == 1) {
                    ips = $('#batchIps').val();
                }
                var t01 = $(".fixedwidth tr").length;
                var ipRangesArr = ips.split(";");
                if (t01 > 1) {
                    var vals = $(".fixedwidth tr:last td:eq(0)").html();
                    t01 = (parseInt(vals) + 1);
                }
                for (var i = 0; i < ipRangesArr.length; i++) {
                    var allIp = ipRangesArr[i].split("---");
                    $('input[name=ip_t1]').val(allIp[0]);
                    $('input[name=ip_t2]').val(allIp[1]);
                    if (ipRangesArr[i] == "---" || ipRangesArr[i] == null) {
                        layer.alert("IP地址不能为空");
                        return false;
                    }
                    if (!isIP(ipRangesArr[i]) && !isIPV6(ipRangesArr[i])) {
                        layer.alert("IP地址格式错误!");
                        return false;
                    }
                    ;
                    var flag = false;
                    $('.ips').each(function () {
                        var ipRanges = $(this).text();
                        if (ipRanges == ipRangesArr[i]) {
                            layer.alert(ipRangesArr[i] + "IP地址已经在列表中!");
                            //alert(ipRangesArr[i]+"IP地址已经在列表中!");
                            flag = true;
                        }
                    });
                    if (flag) {
                        return false;
                    }

                    //保存时：IP地址验证
                    var ipRanges = '', index = 0;
                    $('.ips').each(function () {
                        if (index == 0) {
                            ipRanges += $(this).text();
                        } else {
                            ipRanges += ";" + $(this).text();
                        }
                        index++;
                    });
                    ipRanges += ";" + ipRangesArr[i];
                    if (ipRanges == '') {
                        layer.alert('请输入IP范围!');
                        e.preventDefault();
                        return false;
                    }
                    var id = ${org.id };
                    $.get('<cms:getProjectBasePath/>/backend/org/list/checkIpRangesExist', {
                        startIp: opi1.value,
                        endIp: opi2.value,
                        ipRanges: ipRanges,
                        id: id
                    }, function (data) {
                        var rs = eval('(' + data + ')');
                        if (rs.exist && rs.exist == 1) {//检测存在
                            layer.alert(ips + '在其他机构中已经存在!');
                            $("table.fixedwidth tr:last").remove();
                            return false;
                        } else {
                        }
                    });

                    $('.fixedwidth').append('<tr><td>' + (t01 + i) + '</td><td><p class="ips">' + ipRangesArr[i] + '</p><input type="text" class="updateInput" style="display: none;width:100%" value="' + ipRangesArr[i] + '"></td><td><span style="padding-left:10px" class="cd00 update thickBtn">修改</span><span style="padding-left:10px;display: none;" class="cd00 confirms thickBtn">确认</span><span style="padding-left:10px" class="cd00 delete thickBtn">删除</span></td></tr>');
                }
                $('#batchIps').val("");
                opi1.value = "";
                opi2.value = "";
            });

            //判断是否是IP
            function isIP(ip) {
                if (ip.indexOf(":") != -1) {
                    return false;
                }
                var reSpaceCheck = /^(\d+)\.(\d+)\.(\d+)\.(\d+)---(\d+)\.(\d+)\.(\d+)\.(\d+)$/;
                if (reSpaceCheck.test(ip)) {
                    ip.match(reSpaceCheck);
                    if (RegExp.$1 <= 255 && RegExp.$1 >= 0
                        && RegExp.$2 <= 255 && RegExp.$2 >= 0
                        && RegExp.$3 <= 255 && RegExp.$3 >= 0
                        && RegExp.$4 <= 255 && RegExp.$4 >= 0) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }

            //判断是否是IPV6
            function isIPV6(ip) {
                //alert(11);
                var reSpaceCheck = /^([0-9a-fA-F]{1,4}.){7,7}([0-9a-fA-F]{1,4})---([0-9a-fA-F]{1,4}.){7,7}([0-9a-fA-F]{1,4})$/
                if (reSpaceCheck.test(ip)) {
                    //ip.match(reSpaceCheck);
                    //alert(1);
                    return true;
                } else {
                    //alert(2);
                    return false;
                }
            }

            /**
             修改IP
             */
            $('.fixedwidth').on('click', '.update', function () {
                var num = $('.update').index(this);
                $(this).hide();
                $('.confirms').eq(num).show();
                $('.updateInput').eq(num).show();
                $('.ips').eq(num).text("");
            });
            $('.confirms').click(function () {
                var num = $('.confirms').index(this);
                var ips = $('.updateInput').eq(num).val();
                if (!isIP(ips)) {
                    layer.alert("IP地址格式错误!");
                    return false;
                }
                $('.ips').eq(num).text(ips);
                $('.updateInput').eq(num).hide();
                $(this).hide();
                $('.update').eq(num).show();
            });
            //删除ip
            $('.fixedwidth').on('click', '.delete', function () {
                var that = $(this);
                var index = layer.confirm('您确定要删除此IP段吗?', {
                    btn: ['确定', '取消']
                }, function () {
                    var vals = $('.delete').index(that) + 1;
                    $('.fixedwidth tr:eq(' + vals + ')').remove();
                    layer.close(index);
                }, function () {
                    layer.close(index);
                    return false;
                });
            });
            /**
             * 表单提交验证
             */
            $('form[name="qq_form"]').bind('submit', function (e) {
                //机构名称验证
                if ($('input[name="name"]').val() == '') {
                    layer.alert("请输入机构名称!");
                    $('input[name="name"]').focus();
                    e.preventDefault();
                    return false;
                }
                //机构标识验证
                if ($('input[name="flag"]').val() == '') {
                    layer.alert("请输入机构标识!");
                    $('input[name="flag"]').focus();
                    e.preventDefault();
                    return false;
                }

                //购买产品验证
                var size = $('.productchoose input[type="checkbox"]:checked').size();
                if (size == 0) {
                    layer.alert("请选择购买或试用的产品!");
                    e.preventDefault();
                    return false;
                }
                var hasError = false, _ite = 0;
                $('.productchoose input[type="checkbox"]:checked').each(function () {
                    var index = $('input[type="checkbox"]').index(this);
                    var group = $('.chooseline').eq(index);
                    var statustext = group.find('#section_lx').html();
                    if (statustext == "购买") {
                        group.find('input.status').attr('value', '1');
                    } else if (statustext == "试用") {
                        group.find('input.status').attr('value', '2');
                    } else if (statustext == "停用") {
                        group.find('input.status').attr('value', '0');
                    }
                    group.find('input.proName').attr('name', 'productList[' + _ite + '].productName');
                    group.find('input.proId').attr('name', 'productList[' + _ite + '].productId');
                    group.find('input.status').attr('name', 'productList[' + _ite + '].status');
                    if ($('.crs_check input[type="checkbox"]:checked').size() > 0) {
                        group.find('input.single').attr('name', 'productList[' + _ite + '].single');
                        group.find('input.single').attr('value', '1');
                    } else {
                        group.find('input.single').attr('name', 'productList[' + _ite + '].single');
                        group.find('input.single').attr('value', '0');
                    }
                    if (group.find('input.startDate').val() == '') {
                        layer.alert("请选择开始日期!");
                        group.find('input.startDate').focus();
                        hasError = true;
                        return false;
                    } else {
                        group.find('input.startDate').attr('name', 'productList[' + _ite + '].startDate');
                    }
                    if (group.find('input.endDate').val() == '') {
                        layer.alert("请选择结束日期!");
                        group.find('input.endDate').focus();
                        hasError = true;
                        return false;
                    } else {
                        group.find('input.endDate').attr('name', 'productList[' + _ite + '].endDate');
                    }
                    _ite++;
                });
                if (hasError) {
                    e.preventDefault();
                    return false;
                }
                //保存时：IP地址验证
                var ipRanges = '', index = 0;
                $('.ips').each(function () {
                    if (index == 0) {
                        ipRanges += $(this).text();
                    } else {
                        ipRanges += ";" + $(this).text();
                    }
                    index++;
                });
                if (ipRanges == '') {
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
                var jcryear = "";
                $('.jcr input[type="checkbox"]:checked').each(function (i) {
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
        });
    })(jQuery)
    var err = '${error}';
    if (err != '') {
        layer.alert(err);
    }

</script>

</body>
</html>
