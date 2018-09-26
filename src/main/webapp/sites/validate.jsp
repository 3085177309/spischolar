<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/meta.jsp" />
<title>${title }</title>
</head>
<body>
	<div class="index-wraper">
		<div class="index-inwraper">
			<div class="index-container">
				<div class="head sub-head">
					<jsp:include page="include/navbar.jsp"></jsp:include>
				</div>
				<div class="qksearch">
					<div class="qksearch">
						<%-- <c:if test="${title == '期刊详情页面'}">   
	    <div class="qksearch-form"> 
	        <dd class="stab">
	            <form method="get" action="http://spischolar.com:80/journal/search/list" id="journal_search_form">
	                <input type="hidden" name="batchId" value="e6c4de16-6cc0-45c5-a8ee-8374116bd3bb">
	                <span class="s-input">
	                    <input type="text" placeholder="请输入刊名/ISSN/学科名" id="keyword_text" name="value" value="">
	                    <a href="javascript:void(0)" class="clearinput" id="clearInput"></a>
	                </span>
	                <span class="s-submit"><input type="submit" id="quick_search_btn"></span>
	                <div class="radio_js" id="lan_panel1">
	                    <input type="hidden" id="radio_js1" value="0" name="lan">
	                    <span id="radio_js_in1" onclick="search_lang(this,&quot;radio_js1&quot;,&quot;radio_js_in1&quot;);return false" v="0">全部</span> 
	                    <span onclick="search_lang(this,&quot;radio_js1&quot;,&quot;radio_js_in1&quot;);return false" v="1">中文</span> 
	                    <span onclick="search_lang(this,&quot;radio_js1&quot;,&quot;radio_js_in1&quot;);return false" v="2">外文</span>
	                </div>
	            </form>
	        </dd>
	    </div>
	    </c:if>
	    
	     <c:if test="${title == '蛛网学术搜索结果列表' }">  
	     	 <div class="qksearch">
			    <div class="qksearch-form articlelg"> 
			        <dd class="stab" style="display: block;">   
			            <form id="search_form" method="get" action="<cms:getProjectBasePath/>scholar/list">
			            	<input type="hidden" name="batchId" value="<cms:batchId />" />
			            	<span class="s-input">
			                	<input type="text" value='${searchKey }' id="keyword_text" name="val" placeholder="" autocomplete="off">
			                	<a href="javascript:void(0)" class="clearinput" id="clearInput"></a>
			                	<a class="senior-search-btn" id="senior-search-btn">高级检索</a>
			            	</span>
			            	<span class="s-submit"><input type="submit" id="quick_search_btn"></span>
			            	<div class="radio_js" id="lan_panel">
			                	<input type="hidden" id="radio_js" value="${condition.oaFirst }" name="oaFirst"> 
			                	<span id="radio_js_in" v="0" onclick="search_condi(this,&quot;radio_js_in&quot;);return false" value="0" class="fl" style="margin-left:0">开放资源</span>
			                	<span style="margin-left:0px;background:none;float:left" id="kfzydes">取消即可获取更多检索结果</span>
			            	</div>
			            </form>
			            <div class="senior-search" id="senior-search" style="display: none;">
			            	<jsp:include page="include/asearch.jsp"></jsp:include>
			            </div>
			        </dd>
			    </div>
			</div>
	     </c:if>
	 --%>
						<jsp:include page="include/qksearch.jsp"></jsp:include>
					</div>
					<script type="text/javascript">
	$(function(){
	    $('#journal_search_form').submit(function(e){
	        var val=$('#keyword_text').val();
	        if(!val || val =='请输入刊名/ISSN/学科名'){
	            alert('请输入关键词!');
	            e.preventDefault();
	        }
	    });
	});
	</script>
				</div>
				<div class="statistics-box"></div>
				<div id="qkH" style="overflow: hidden">

					<div class="fvalidate" style="margin-top: 10px;">
						<form method="post" id="fb_form"
							action="<cms:getProjectBasePath/>user/img">
							<div class="Win-pannel" style="text-align: center">

								<div class="cont-T">请输入验证码</div>
								<div class="cont-B">
									<label>验证码：</label> <input type="text" name="verify"
										class="verify" placeholder="请输入验证码">
								</div>
								<div class="cont-C">输入下图中的字符，不区分大小写</div>
								<div class="cont-C">
									<a href="#" title="点击切换图片"><img
										src="<cms:getProjectBasePath/>backend/img" id="valImg"
										width="110px" /></a> <span><a
										href="javascript:changeValiyCodes()">看不清楚，换一个</a></span>
									<script type="text/javascript">
                            function changeValiyCodes(){
                                $('#valImg').attr('src','<cms:getProjectBasePath/>backend/img?__time='+(new Date()).getTime());
                            }
                        </script>
								</div>
								<div class="cont-B tc" style="text-align: center">
									<input type="submit" value="提交" class="submit-btn fb_form_sbts">
								</div>
							</div>
						</form>
						<script type="text/javascript">
            $(function(){
                $('#valImg').bind('click',function(){
                    var src=$(this).attr('src');
                    src+="?time="+new Date();
                    $(this).attr('src',src);
                });
            });
            
            $(function(){
                $('.fb_form_sbts').click(function(e){
                    if($('.verify').val() == "" || $('.verify').val() == null) {
                        alert("请输入正确的验证码！");
                        return false;
                    }
                    $('#fb_form').ajaxSubmit(function(data){
                        if(data.message == "验证码错误!") {
                            alert(data.message);
                            location.reload();
                        } else {
                        	alert(data.message);
                            $('.Win-close').click();
                            location.reload();
                        }
                    });
                    e.preventDefault();
                });
            });
            </script>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="include/float.jsp"></jsp:include>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>
