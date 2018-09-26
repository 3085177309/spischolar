<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set scope="request" var="pageTitle" value="期刊导航浏览页"></c:set>
<c:set scope="request" var="navIndex" value="1"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<div class="container container_3" id="minH" minH='330'>
	<div class="sidebar">
		<!-- 展示权威数据库 -->
		<div class="ll_fl" id='db_list'>
			<c:forEach items="${dbAllYearMap }" var="dbYearMap"
				varStatus="status">
				<c:choose>
					<c:when test="${status.first }">
						<a class="in" href="#" value='<c:out value="${dbYearMap.key }"/>'>
							<c:choose>
								<c:when test="${'SJR' eq dbYearMap.key}">
										SCOPUS
									</c:when>
								<c:when test="${'中科院JCR分区(大类)' eq dbYearMap.key }">
										JCR分区表(大类)
									</c:when>
								<c:when test="${'中科院JCR分区(小类)' eq dbYearMap.key }">
										JCR分区表(小类)
									</c:when>
								<c:otherwise>
										${dbYearMap.key }
									</c:otherwise>
							</c:choose>
						</a>
					</c:when>
					<c:otherwise>
						<a href="#" value='<c:out value="${dbYearMap.key }"/>'> <c:choose>
								<c:when test="${'SJR' eq dbYearMap.key}">
										SCOPUS
									</c:when>
								<c:when test="${'中科院JCR分区(大类)' eq dbYearMap.key }">
										JCR分区表(大类)
									</c:when>
								<c:when test="${'中科院JCR分区(小类)' eq dbYearMap.key }">
										JCR分区表(小类)
									</c:when>
								<c:otherwise>
										${dbYearMap.key }
									</c:otherwise>
							</c:choose>
						</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<div class="content">
		<div class="statistics" id='version_panel'>
			<span class="title"> </span> <span class="right"> 版本： <c:forEach
					items="${dbAllYearMap }" var="dbYearMap" varStatus="status">
					<c:choose>
						<c:when test="${status.first }">
							<select db='${dbYearMap.key }'>
								<c:forEach items="${dbYearMap.value }" var="subjectSystem">
									<option value="${subjectSystem.year }"
										url='<cms:dbSubjectUrl db="${dbYearMap.key }" detailYear="${subjectSystem.year }"/>'>${subjectSystem.rangeYear }</option>
								</c:forEach>
							</select>
						</c:when>
						<c:otherwise>
							<select db='${dbYearMap.key }' class='hide'>
								<c:forEach items="${dbYearMap.value }" var="subjectSystem">
									<option value="${subjectSystem.year }"
										url='<cms:dbSubjectUrl db="${dbYearMap.key }" detailYear="${subjectSystem.year }"/>'>${subjectSystem.rangeYear }</option>
								</c:forEach>
							</select>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</span>
		</div>
		<div id='content'></div>


	</div>
	<div class="clear"></div>
</div>
<div class="container_borBot"></div>

<!-- 
	<div class="con_bot_js">
		<div class="js_tab">
			<div class="js_box en">
				<span class="png title">中文期刊</span>
				<span class="text">	
				<cms:firstLetterNavication type="1" />
				</span>
			</div>

			<div class="js_box en">
				<span class="png title">外文期刊</span>
				<span class="text">
				<cms:firstLetterNavication type="2" />
				</span>
			</div>

			<div class="js_box en">
				<span class="png title">O&nbsp;&nbsp;&nbsp;&nbsp;A 刊</span>
				<span class="text">
				<cms:firstLetterNavication type="3" />
				</span>
			</div>
		</div>

	</div> -->
<!---->
<script>
		/*    
		 当异步返回数据时 就调用此函数  
		 如果第一次进入浏览页面 即点击右上角的导航‘浏览’ 进入浏览主页 后台就不要运行下面函数了

		 llShowBox()

		 */
	</script>

<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>
<jsp:include page="common/footer.jsp"></jsp:include>
<script src="resources/<cms:getSiteFlag/>/js/overview.js"></script>
</body>

</html>
