<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<div class="serch-wrap">
	<div class="lg">
		<div width="300" height="80">
			<img src="<cms:getProjectBasePath/>resources/images/logo.png"
				width="300" height="80" />
		</div>
	</div>

	<div class="search-form">
		<div class="tab" id="search-tab-btn">
			<a href="javascript:void(0)" class="active">期刊</a> <a
				href="javascript:void(0)">文章</a>
		</div>
		<div id="search-tab-box">
			<dd class="stab" style="display: block">
				<form method="get"
					action="<cms:getProjectBasePath/>journal/search/list">
					<input type="hidden" name="batchId" value="<cms:batchId />" /> <span
						class="s-input"> <input type="text"
						placeholder="请输入刊名/ISSN/学科名" value="" autocomplete="off"
						name="value" id="jounal_kw" /> <a href="javascript:void(0)"
						class="clearinput" onclick="" id="clear-qk-sech"></a>
					</span> <span class="s-submit"><input type="submit" value=""
						id="journal_search_btn"></span>
					<div class="radio_js" id="lan_panel1">
						<a href="<cms:getProjectBasePath/>journal" class="b-journal">浏览期刊</a>
						<input type="hidden" name="lan" id="radio_js1" value="0">
						<span id="radio_js_in1" v="0"
							onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
							value='0'>全部</span> <span v="1"
							onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
							value="0">中文</span> <span v="2"
							onclick='search_lang(this,"radio_js1","radio_js_in1");return false'
							value="1">外文</span>
					</div>
				</form>
			</dd>
			<dd class="stab" style="display: none">
				<form method="get" action="<cms:getProjectBasePath/>scholar/list">
					<input type="hidden" name="batchId" value="<cms:batchId />" /> <span
						class="s-input"> <input type="text" name="val" value=""
						id="keyword_text" placeholder="" autocomplete="off" /> <a
						href="javascript:void(0)" class="clearinput" id="clearInput"></a>
						<a class="senior-search-btn" id="senior-search-btn">高级检索</a>
					</span> <span class="s-submit"><input type="submit"
						id="quick_search_btn"></span>
					<div class="radio_js" id="lan_panel">
						<input type="hidden" id="radio_js" name="oaFirst"
							value="${oaFirst }">
						<!--<input type="hidden" id="radio_js" name="oaFirst" value="0">-->
						<span onclick='search_condi(this,"radio_js_in");return false'
							class="fl" style="margin-left: 0">开放资源</span>
					</div>
				</form>
				<div class="senior-search" id="senior-search">
					<jsp:include page="asearch.jsp"></jsp:include>
				</div>
			</dd>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
        (function($){
        	var vs = $('#radio_js').val();
        	if(vs==0){
        		$('.fl').attr("id","");
        	}else if(vs==1){
        		$('.fl').attr("id","radio_js_in");
        	}
            $('#quick_search_btn').bind('click', function() {
                var key = $.trim($('#keyword_text').val());
                if ('' == key) {
                	alert('请输入关键词!');
                    return false;
                }
            });
            $('#journal_search_btn').bind('click',function(){
            	var key=$.trim($('#jounal_kw').val());
            	if(key == '' || key == '请输入刊名/ISSN/学科名'){
            		alert('请输入关键词!');
            		return false;
            	}
            });
            //期刊也要提示词 ==！
        })(jQuery);
    </script>
</div>