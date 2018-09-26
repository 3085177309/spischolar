<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>学术期刊指南首页</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<div class="page-view">
		<div class="qkchosen subject">
			<div class="inqkchosen-subject inqkchosen">
				<ul>
					<c:forEach var="subject" items="${subjectList }" varStatus="s">
						<c:if test="${empty subject.url }">
							<li><p subject_name="${subject.name }" class="ll_no">${subject.name }</p></li>
						</c:if>
						<c:if test="${not empty subject.url }">
							<li><p
									onclick="chooseSubject('<cms:getProjectBasePath/>${subject.url }','${subject.name }','${subject.id }')"
									url="<cms:getProjectBasePath/>${subject.url }"
									subject_name="${subject.name }">${subject.name }</p></li>
						</c:if>
					</c:forEach>
					<input type="hidden" id="subjectNameId" value="1">
					<input type="hidden" id="subjectName" value="人文社科类">
				</ul>
			</div>
		</div>
		<div class="qkchosen db" style="display: none">
			<div class="inqkchosen">
				<ul>
					<c:forEach var="db" items="${authDbs }">
						<c:if test="${db.flag!='EI' }">
							<li>
								<p id="p${db.id }">
									<span id='${db.id }'>${db.flag }</span><i
										class="icon iconfont fr">&#xe60f;</i>
								</p>
								<ul class="qkyearsel">
									<c:forEach var="y" items="${db.yearList }">
										<c:choose>
											<c:when
												test="${(db.id==2||db.id==3)&&cms:formatYear(y)!=db.lastYear&&zky!=1 }"></c:when>
											<c:otherwise>
												<li><a dbflag="${db.flag }"
													dbYear='<c:out value="${cms:formatYear(y)}" />'
													href="javascript:choose('<c:out value="${db.id }" />','<c:out value="${cms:formatYear(y)}" />')"
													class="fristSubject year_${db.id }">${y }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<div class="return-back"></div>
						<div class="w-logo"></div>
					</div>
				</header>
				<div class="common-search mlr0">
					<dd class="stab" style="display: block;">
						<form method="get"
							action="<cms:getProjectBasePath/>journal/search/list"
							id="journal_search_form">
							<div class="search-inputwrap">
								<input type="hidden" name="batchId" value="<cms:batchId />" />
								<input type="text" class="input-text" value=""
									autocomplete="off" name="value" id="jounal_kw"
									placeholder="请输入刊名/ISSN">
								<button type="submit" class="input-submit" id="quick_search_btn"
									value="检索">
									<i class="icon iconfont">&#xe604;</i>
								</button>
								<input type="button" class="searchCancle" value="取消">
							</div>
							<div class="radio_js" id="lan_panel">
								<label class="ui-radio" for="radio"><input type="radio"
									value="0" name="lan" checked>全部</label> <label class="ui-radio"
									for="radio"><input type="radio" value="1" name="lan">中文</label>
								<label class="ui-radio" for="radio"><input type="radio"
									value="2" name="lan">外文</label>
							</div>
						</form>
						<!-- </dd> -->
				</div>
				<div class="curentsubdata">
					<div class="curent-chosen subject">
						<em>人文社科类</em><i class="icon iconfont">&#xe610;</i>
					</div>
					<div class="curent-chosen db">
						<em>SCI-E(2016)</em><i class="icon iconfont">&#xe610;</i>
					</div>
				</div>

				<div class="item-section">
					<div class="subject-search">
						<div>
							<input type="hidden" id="current_url" /> <input type="text"
								class="subject-input sc_put" placeholder="学科筛选"> <input
								type="submit" class="icon iconfont search" value="&#xe604;">
						</div>
					</div>
					<div class="adta-list border" id="subject_list"></div>
				</div>
			</div>
		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>
	<script type="text/javascript">
//默认加载
var fristHref = $('.inqkchosen-subject.inqkchosen ul li p').eq(0).attr("url");
$.ajax({ 
	type: "post", 
	url: fristHref, 
	cache:false, 
	async:false,
	success: function(data){
		$('#subject_list').html(data);
		if($('.letter-list').length>1){
			$('.letter-list').remove();
		}
		$('body').append($("#goto_fixed"));
		fixedLetterScroll();
	},
	error:function(data){
		$('#subject_list').html(data);
	}
}); 

function fixedLetterScroll(){
	$('#goto_fixed a').live('tap',function(e){
		var elId=$(this).attr('data-href').split('#')[1];
		myScroll.scrollToElement(document.querySelector('#'+elId), 1000, null, null, IScroll.utils.ease.elastic  );
		
	})
	
}


$('#current_url').val(fristHref);
$('.sc_put').val('');
//更改期刊subject
var subjectList = '${subjectListJson}';
function chooseSubject(href,subjectName,subjectNameId){
	$.ajax({ 
		type: "post", 
		url: href,
		success: function(data){
			$('#subject_list').html(data);
			if($('.letter-list').length>1){
				$('.letter-list').eq(1).remove();
			}
			$('body').append($("#goto_fixed"));
			myScroll.refresh();
		} 
	}); 
	$('#subjectName').val(subjectName);
	$('#subjectNameId').val(subjectNameId);
	var db = href.substring(href.length-7,href.length-5);
	db = db.replace('/','');
	var dbName = $('#'+db+'').text();
	var year = href.substring(href.length-4,href.length);
	

	$('#current_url').val(href);
	$('.sc_put').val('');
	
	//切换选择
	$('.curent-chosen.subject em').html(subjectName);
	$('.curent-chosen.db em').html(dbName+'('+year+')');
	
	$('.inqkchosen ul li').removeClass("in");
	$('.inqkchosen ul li a').removeClass("in");
	$('#'+db).parent().parent().addClass("in");
	$('.inqkchosen ul li a[dbflag="'+dbName+'"][dbyear="'+year+'"]').addClass("in");
	$('div.inqkchosen p').removeClass('li_no');
	
	$('.qkchosen.subject').hide();
	$('.lay_bj_div').hide();
	$('.mui-content').unbind();
	
	var dataObj= eval("("+subjectList+")");
	for(var i=0;i<dataObj.length;i++) {
		if(subjectNameId == dataObj[i].id) {
			for(var j=0;j<dataObj[i].list.length;j++) {
				var dbSystem = dataObj[i].list[j].flag;
				var hasContent = dataObj[i].list[j].hasContent;
				if(hasContent == false) {
					$('div.inqkchosen p[id="p'+dbSystem+'"]').addClass('li_no');
				}
			}
		}
	}
}
//更改期刊类型和年份
function choose(db,year){
	var subjectNameId = $('#subjectNameId').val();
	var subjectName = $('#subjectName').val();
	var href = '<cms:getProjectBasePath/>journal/subject/'+subjectNameId+'/'+db+'/'+year;
	$.ajax({ 
		type: "post", 
		url: href,
		success: function(data){
			$('#subject_list').html(data);
			if($('.letter-list').length>1){
				$('.letter-list').eq(1).remove();
			}
			$('body').append($("#goto_fixed"));
			myScroll.refresh();
		} 
	}); 
	
	var dbName = $('#'+db+'').text();
	$('.curent-chosen.subject em').html(subjectName);
	$('.curent-chosen.db em').html(dbName+'('+year+')');
	
	$('#current_url').val(href);
	$('.sc_put').val('');
	/*切换选择*/
	var $this=$('.qkyearsel').find('a[value="'+href+'"]');
	
	$('.qkchosen').hide();
	$('.lay_bj_div').hide();
	$('.mui-content').unbind();
}
$('.sc_put').bind('keyup',function(){
	var v=$(this).val();
	var href=$('#current_url').val();
	$('#subject_list').load(href,{'subject':v});
})
//构建学科url
function buildSubjUrl(evt) {
    var liDom = $(evt).parent('li');
    var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
    var year = $('#year').val();
    var discRepEncode = $(liDom).attr('discRepEncode');
    var discEncode = $(liDom).attr('discEncode');
    var siteFlag = $('#siteFlag').val();
    var sort = $(liDom).attr('sort');

    var key = authorityDatabaseEncode + "%5E" + year + "%5E" + discRepEncode + '&viewStyle=list&authorityDb=' + authorityDatabaseEncode + '&subject=' + discEncode;
    var url = SITE_URL+"journal/category/list?queryCdt=shouLuSubjects_3_1_" + key + sort+'&detailYear='+year;
    $(evt).attr('href', url);
}
window.buildSubjUrl=buildSubjUrl;
//构建分区url
function buildPartitionUrl(evt) {
    var liDom = $(evt).parent().parent().parent('li');
    var authorityDatabaseEncode = $('#authorityDatabaseEncode').val();
    var year = $('#year').val();
    var discRepEncode = $(liDom).attr('discRepEncode');
    var discEncode = $(liDom).attr('discEncode');
    var siteFlag = $('#siteFlag').val();
    var sort = $(liDom).attr('sort');
    var partition = $(evt).attr('partition');

    var partitionUrl = "&authorityDb=" + authorityDatabaseEncode + "&subject=" + discEncode + "&queryCdt=partition_3_1_" + authorityDatabaseEncode + "%5E" + year + "%5E" + discRepEncode;
    var url =  SITE_URL + "journal/search/list?" + partitionUrl + "%5E" + partition + "&partition=" + partition + sort + "&viewStyle=list&detailYear=" + year;
    $(evt).attr('href', url);
}
window.buildPartitionUrl=buildPartitionUrl;


$(function(){
	
	myScroll.on('beforeScrollStart',function(){
		$('.input-text').blur();
		if(myScroll.y<-280){
			$("#goto_fixed").show()
		}else{
			
			$("#goto_fixed").hide();
		}
	})
	myScroll.on('scrollEnd',function(){
		if(myScroll.y<-280){
			$("#goto_fixed").show()
		}else{
			
			$("#goto_fixed").hide();
		}
	})
})

/**
 * 期刊，学科类别选择
 */
;(function(){
	var subject_btn = $(".curentsubdata .subject"), // 学科选择按钮
		subject_popup = $(".qkchosen.subject"), // 学科选择弹窗
		db_btn = $(".curentsubdata .db"), // 类别选择按钮
		db_popup = $(".qkchosen.db"), // 类别选择弹窗
		db_popup_list = $(".qkchosen.db .qkyearsel"), // 类别选择弹窗内的列表
		db_popup_p = $(".qkchosen.db .inqkchosen li p"),// 类别选择弹窗内的p
		db_popup_a = $(".qkchosen.db .inqkchosen li ul a");// 类别选择弹窗内的a

	if(!db_popup.find('li.in').length){
		db_popup_list.eq(0).find("a").eq(0)
			.addClass("in").parents(".qkyearsel")
			.parent("li").addClass("in")
	}

	subject_btn.on('touchend',function(){
		setTimeout(function(){
			subject_popup.show();
		},20)
	})

	db_btn.on('touchend',function(){
		setTimeout(function(){
			db_popup.show();
		},20)
	})

	db_popup_p.on("touchend",function(){
		var $this = $(this); 
		setTimeout(function(){
			var parent_li = $this.parent("li");
			if($this.hasClass("li_no")){
				return
			}
			db_popup_list.hide();
			$this.siblings(".qkyearsel").show();
		},20)
	})

	db_popup_a.on('click',function(){
		var $this = $(this); 
		setTimeout(function(){
			db_popup_a.removeClass("in");
			$this.addClass("in");
			$this.parents(".qkyearsel").parent("li").addClass("in")
				 .siblings("li.in").removeClass("in")
		},20)
	})
}())

</script>
</body>
</html>
