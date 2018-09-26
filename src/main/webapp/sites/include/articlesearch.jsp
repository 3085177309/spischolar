<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <div class="qksearch">
    <div class="qksearch-form"> 
    	<dd class="stab">   
        	<form method="get" action="<cms:getProjectBasePath/>journal/search/list" id="journal_search_form">
        		<input type="hidden" name="batchId" value="<cms:batchId />" />
            	<span class="s-input">
                	<input type="text" placeholder="请输入刊名/ISSN/学科名" id="keyword_text" name="value" value="${cdt.value }">
                  	<a href="javascript:void(0)" class="clearinput" id="clearInput"></a>
                </span>
                <span class="s-submit"><input type="submit" id="quick_search_btn"></span>
                <div class="radio_js" id="lan_panel1">
                	<input type="hidden" id="radio_js1" <c:choose><c:when test="${empty cdt.lan }">value="0"</c:when><c:otherwise>value="${cdt.lan }"</c:otherwise></c:choose> name="lan">
                    <span <c:if test="${cdt.lan==0 || empty cdt.lan }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v='0'>全部</span> 
                    <span <c:if test="${cdt.lan==1 }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v="1">中文</span> 
                    <span <c:if test="${cdt.lan==2 }">id="radio_js_in1"</c:if> onclick='search_lang(this,"radio_js1","radio_js_in1");return false' v="2">外文</span>
                </div>
            </form>
        </dd>
    </div>
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
</script> --%>
<div class="qksearch-wrap">
	<div class="search-box">

		<div class="search-tab docindex-search mim-senior-search"
			style="display: block">
			<form method="get" action="<cms:getProjectBasePath/>scholar/list">
				<div class="article-search">
					<input type="text" class="textInput" value="${searchKey }"
						name="val" autocomplete="off" type_index="2"> <input
						type="submit" class="article_hide_btn"> <i class="c-i"></i>
				</div>
			</form>
			<div class="i-senior-box" id="senior-search-btn"></div>
			<div class="senior-search" id="senior-search">

				<div class="senior-search-box">
					<form action="<cms:getProjectBasePath/>scholar/list" method="get"
						id="advance-search-form">
						<input type="hidden" name="batchId"
							value="9c2c4d6d-d1e1-49ba-a843-c675b0d5f11c">
						<div class="sc_line_box">
							<span class="sc_s">检索：</span>
							<div class="sc_selbox">
								<i></i> <span id="section_sy"> 模糊搜索 </span>
								<div class="sc_selopt">
									<a href="javascript:chooseQueryType(0)">模糊搜索</a> <a
										href="javascript:chooseQueryType(1)">精确搜索</a>
								</div>
								<input type="hidden" name="queryType" value="0">
							</div>
							<div class="clear"></div>
						</div>

						<div class="sc_line_box box_group">
							<span class="sc_s"><select name="field" class="select fr"
								style="width: 70px;">
									<option value="keyword">关键词</option>
								<c:if test="${source == 0 }">
									<option value="author">作者</option>
								</c:if>
									<option value="title">标题</option>
							</select></span> <input type="text" name="value" class="txt sc_put"
								value="${searchKey }"> <a href="javascript:;;"
								class="addsenior-con z" source="${source}" title="添加"></a>
							<div class="clear"></div>
						</div>


						<div class="sc_line_box">
							<span class="sc_s">年份：</span> <input type="text" name="start_y"
								class="txt sc_put time" value="" onkeyup="clearNotInt(this)">
							<span class="sc_line">--</span> <input type="text" name="end_y"
								class="txt sc_put time" value="" onkeyup="clearNotInt(this)">
							<a href="" class="t" title="在指定出版物中检索文章"></a>
							<div class="clear"></div>
						</div>
					<c:if test="${source == 0 }">
						<div class="sc_line_box">
							<span class="sc_s">出版物：</span> <input type="text" name="journal"
								class="txt sc_put" value=""> <a href="" class="t"
								title="在指定出版物中检索文章"></a>
							<div class="clear"></div>
						</div>
						<div class="sc_line_box">
							<span class="sc_s">来源网站：</span> <input type="text"
								name="sites[0]" class="txt sc_put" value=""> <a href=""
								class="t" title="在指定出版物中检索文章"></a>
							<div class="clear"></div>
						</div>
						<div class="sc_line_box">
							<span class="sc_s">文档类型：</span>
							<div class="sc_selbox">
								<i></i> <span id="section_lx">所有类型</span>
								<div class="sc_selopt">
									<a href="javascript:chooseFileType('')">所有类型</a> <a
										href="javascript:chooseFileType('pdf')">PDF</a> <a
										href="javascript:chooseFileType('doc')">DOC</a> <a
										href="javascript:chooseFileType('txt')">TXT</a> <a
										href="javascript:chooseFileType('xls')">XLS</a> <a
										href="javascript:chooseFileType('ppt')">PPT</a>
								</div>
								<input type="hidden" name="fileType" value="20">
								<script type="text/javascript">
							function chooseFileType(v){
								jQuery('#advance-search-form input[name="fileType"]').val(v);
							}
							function chooseQueryType(v){
								jQuery('#advance-search-form input[name="queryType"]').val(v);
							}
							</script>
							</div>
							<div class="clear"></div>
						</div>
					</c:if>
						<script type="text/javascript">
						function chooseField(field){
							var selbox=$(target).parent().parent();
							selbox.find('input[name="field"]').val(field);
						}
						function chooseLogic(logic,target){
							var selbox=$(target).parent().parent();
							selbox=selbox.find('input[name="logic"]').val(logic);
						}
					</script>


						<div class="sc_line_box">
							<span class="sc_s" style="text-indent: -9999px;">&nbsp;&nbsp;</span>
							<input type="submit" class="submit-btn" value="检索"
								style="display: block; float: left">
							<div class="clear"></div>
						</div>
					</form>
					<script type="text/javascript">
				$(function(){
					$('#advance-search-form').submit(function(e){
						var i=0;
						var falg = false;
						$('.box_group').each(function(){
							$(this).find('select[name$="logic"]').attr('name','groups['+i+'].logic');
							$(this).find('select[name$="field"]').attr('name','groups['+i+'].field');
							$(this).find('input[name$="value"]').attr('name','groups['+i+'].value');
							i++;
						});
						$('.txt.sc_put').each(function(){
							var txt = $(this).val();
							if(txt != "") {
								falg = true;
							}
						});
						if(!falg) {
							shake();
						}
						return falg;
					});
					
					function shake(){
					    var style=document.getElementById("senior-search").style;
					    p=[3,7,3,0,-3,-7,-3,0]
					    fx=function(){
					        style.marginLeft = p.shift() + 'px';
					        if (p.length <= 0) {
					                style.marginLeft = 0;
					                clearInterval(timerId);
					        };
					    }
					    p = p.concat(p.concat(p));
					    timerId = setInterval(fx, 13);
					}

				});
				</script>
				</div>
			</div>
		</div>
		<div class="search-tab" style="display: none">
			<form method="get"
				action="<cms:getProjectBasePath/>journal/search/list">
				<div class="qk-search">
					<input type="text" class="textInput" name="value"
						placeholder="请输入刊名/ISSN/学科名" value="${searchKey }"
						autocomplete="off" type_index="2"> <input type="submit"
						class="journal_hide_btn"> <input type="hidden"
						name="batchId"> <i class="c-i"></i>
				</div>
			</form>
		</div>
		<div class="search-btn">
			<button
				class="s-ar s-btn article_search_btn <c:if test="${mindex==1 }">active</c:if>">搜文章</button>
			<button
				class="s-qk s-btn  journal_search_btn <c:if test="${mindex==2 }">active</c:if>">搜期刊</button>

		</div>
		<div class="search-history"></div>
	</div>
</div>