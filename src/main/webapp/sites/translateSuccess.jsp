<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<jsp:include page="include/meta.jsp" />
<title>Spis文献翻译</title>
</head>
<body>
        <div class="index-wraper">
            <div class="index-inwraper">
                <div class="index-container">
                    <div class="head sub-head">
                        <jsp:include page="include/navbar.jsp"></jsp:include>
                    </div>
                    

                    <!-- 文件翻译 主体内容 -->
                    <div class="file-wrap">
                        <h3>文件翻译 <a href="/translate/file" class="return_late">继续翻译</a></h3>
                        <div class="file-cont clearfix">
                            <div class="iframe_box">
                                <iframe src="<cms:getProjectBasePath/>resources/generic/web/viewer.html?file=/translate/${sourceFile}" class="late_iframe" frameborder="0">

                                </iframe>
                            </div>
                            <div class="iframe_box right">
                                <iframe src="<cms:getProjectBasePath/>resources/generic/web/viewer.html?file=/translate/${transFile}" class="late_iframe" frameborder="0">

                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="include/footer.jsp"></jsp:include>

    </body>
</html>