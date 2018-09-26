<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<form method="get" action="<cms:getProjectBasePath/>scholar/list">
	<span class="s-input"> <input type="text"
		value="${condition.val }" name="val" id="keyword_text" placeholder=""
		autocomplete="off"> <a href="javascript:void(0)"
		class="clearinput" id="clearInput"></a> <a class="senior-search-btn"
		id="senior-search-btn">高级检索</a>
	</span> <span class="s-submit"><input type="submit"
		id="quick_search_btn"></span>
	<div class="radio_js" id="lan_panel">
		<input type="hidden" id="radio_js" value="${oaFirst }" name="oaFirst" />
		<!--  <input type="hidden" id="radio_js" name="oaFirst" value="0">-->
		<span id="" v="中文V"
			onclick="search_condi(this,&quot;radio_js_in&quot;);return false"
			class="fl" style="margin-left: 0">开放资源</span> <span
			style="margin-left: 0px; background: none; float: left" id="kfzydes">勾选即可获取全部开放资源结果</span>
	</div>
</form>
<script type="text/javascript">

        (function($){
            search_condi=function(btn,inId){
            	var vs = $('#radio_js').val();
            	  if(vs==1){
            	    btn.id="";
            	    $('#radio_js').val(0);
            	  }else if(vs==0){
            	    btn.id=inId;
            	    $('#radio_js').val(1);
            	  }
            	  $('#search_form').submit();
            	}
            $('#quick_search_btn').bind('click', function() {
                var key = $.trim($('#keyword_text').val());
                if ('' == key) {
                    alert('请输入关键词!');
                    return false;
                }
            });
        })(jQuery);
        $("#lan_panel span").eq(0).click(function() {
            //alert("a");
            if($(this).attr("id")=="radio_js_in"){
                $('#kfzydes').html('取消即可获取更多检索结果');
            }else{ 
                $('#kfzydes').html("勾选即可获取全部开放资源结果");
        }
        });
        
</script>
