<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib prefix="cms"
	uri="http://org.pzy.cms"%>
<div class="sidebar" style="*padding-bottom: 0; *margin-bottom: 0">
	<div class="com-condi">
		<form method="get"
			action="<cms:getProjectBasePath/>journal/category/list"
			id="filter_form">
			<input type="hidden" name="sort" value="${cdt.sort }" />
			<input type="hidden" name="viewStyle" value="${cdt.viewStyle }" />
			<div class="sc_selbox" style="margin-top: 10px; z-index: 9">
				<i></i> <span id="section_qk">${cdt.authorityDb }</span>
				<div class="sc_selopt" style="z-index: 9">
					<c:forEach var="db" items="${authDbs }">
						<c:if test="${db.flag == cdt.authorityDb }">
							<c:set var="dbId" value="${db.id }" />
							<c:set var="hasPt"
								value="${not empty db.prefix or not empty db.suffix }" />
						</c:if>
						<%-- <c:if test="${db.flag!='EI' }"> --%>
							<a href="javascript:filterYears(${db.id },'${db.flag }','${db.prefix }','${db.suffix }')">${db.flag }</a>
						<%-- </c:if> --%>
					</c:forEach>
				</div>
				<input type="hidden" id="value_qk" name="authorityDb"
					value="${cdt.authorityDb }">
			</div>
			<script type="text/javascript">
            	function filterYears(id,name,prefix,suffix){
            		$('.sc_selopt a[class^="year_"]').hide();
            		$('.sc_selopt a.year_'+id).show();
            		var text=$($('.sc_selopt a.year_'+id).get(0)).text();
            		$('#section_sj').text(text);
            		$('#filter_form input[name="authorityDb"]').val(name);
            		$('#filter_form input[name="detailYear"]').val($($('.sc_selopt a.year_'+id).get(0)).attr('year'));
            		if(!!prefix && prefix != ''){
            			$('#partidion_selbox').show();
            			var i=1;
            			$('a.p_name').each(function(){
            				$(this).text(prefix+i);
            				i++;
            			});
            		}else if(!!suffix && suffix != ''){
            			var i=1;
            			$('#partidion_selbox').show();
            			$('a.p_name').each(function(){
            				$(this).text(i+suffix);
            				i++;
            			});
            		}else{
            			$('#partidion_selbox').hide();
            		}
            		$('#section_s2').html("全部");
            		$('#filter_form input[name="partition"]').val('');
            		loadSubjectJSON();
            	}
            	function chooseYear(y){
            		$('#filter_form input[name="detailYear"]').val(y);
            		loadSubjectJSON();
            	}
            	function choosePart(y){
            		$('#filter_form input[name="partition"]').val(y);
            	}
            	$("#filter_form").submit(function(e){
            		var db=$('#filter_form input[name="authorityDb"]').val(),year=$('#filter_form input[name="detailYear"]').val(),part=$('#filter_form input[name="partition"]').val();
            		var subject=$('#filter_form select[name="subject"]').val();
            		if(!subject){
            			alert('请输入学科');
            			e.preventDefault();
            		}
            		subject=subject.replace(/\,/g, "%320").replace(" ", "%310");
            		var queryCdt="";
            		if(!!part){
            			queryCdt="partition_3_1_"+db+"^"+year+"^"+subject+"^"+part;
            		}else{
            			queryCdt="shouLuSubjects_3_1_"+db+"^"+year+"^"+subject;
            		}
            		$('#filter_form').append('<input type="hidden" name="queryCdt" value="'+queryCdt+'" />');
            	});
            	function loadSubjectJSON(){
            		var db=$('#filter_form input[name="authorityDb"]').val();
            		var year=$('#filter_form input[name="detailYear"]').val();
            		$.get('http://cloud.test.hnlat.com/search-server/subjectJSON',{'db':db,'year':year},function(data){
            			$('.subject_select').empty();
            			data = data.body;
            			for(var i=0;i<data.length;i++){
            				var name=data[i].discipline;
            				if(!!data[i].name){
            					name+="( "+data[i].name+" )";
            				}
            				$('.subject_select').append('<option value="'+data[i].discipline+'">'+name+"</option>");
            			}
            			$(".subject_select").trigger("chosen:updated");
            			//$('.subject_select').trigger("liszt:updated");
            		});
            	}
           </script>
			<div class="sc_selbox" style="z-index: 8">
				<i></i> <span id="section_sj">${cdt.detailYear }</span>
				<div class="sc_selopt" style="z-index: 8">
					<c:forEach var="db" items="${authDbs }">
						<c:forEach var="y" items="${db.yearList }" varStatus="years">
							<c:choose>
								<c:when test="${(db.id==2||db.id==3)&&cms:formatYear(y)!=db.lastYear&&zky!=1 }"></c:when>
								<c:otherwise>
									<a class="year_${db.id }"
										href="javascript:chooseYear('${cms:formatYear(y) }')"
										year="${cms:formatYear(y) }">${y }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:forEach>
				</div>
				<script type="text/javascript">
                	$(function(){
                		$('.sc_selopt a[class^="year_"]').hide();
                		$('.sc_selopt a.year_${dbId}').show();
                		$('.sc_selopt a.year_${dbId}').each(function(){
                			if($(this).attr('year')=='${cdt.detailYear }'){
                				$('#section_sj').text($(this).text());
                			}
                		});
                		if('${cdt.partition }' != ''){
                			$('a.p_name').each(function(){
                				var text=$(this).text();
                				if(text=='Q${cdt.partition }' || text=='${cdt.partition }区'){
                					$('#section_s2').text(text);
                				}
                			});
                		}
                		$.get('http://cloud.test.hnlat.com/search-server/subjectJSON',{'db':'${cdt.authorityDb }','year':'${cdt.detailYear }'},function(data){
                			$('.subject_select').empty();
                			data = data.body;
                			for(var i=0;i<data.length;i++){
                				var name=data[i].discipline;
                				if(!!data[i].name){
                					name+="( "+data[i].name+" )";
                				}
                				if(data[i].discipline=='${cdt.subject }'){
                					$('.subject_select').append('<option value="'+data[i].discipline+'" selected="selected">'+name+"</option>");
                				}else{
                					$('.subject_select').append('<option value="'+data[i].discipline+'">'+name+"</option>");
                				}
                			}
                			$(".subject_select").trigger("chosen:updated");
                		});
                		$('.subject_select').chosen({
            				no_results_text:'没有找到!'
            			});
                		
                		$('.sc_put').bind('keyup',function(){
            				var v=$(this).val();
            				var href=$('#current_url').val();
            				$('#subject_list').load(href,{'subject':v});
            			})
                	})
                </script>
				<input type="hidden" name="detailYear" value="${cdt.detailYear }">
			</div>
			<div class="chosen_box">
				<select class="subject_select nobg" name="subject">
				</select>

			</div>
			<div class="sc_selbox" id="partidion_selbox"
				<c:if test="${hasPt==false }">style="display: none"</c:if>>
				<i></i> <span id="section_s2">全部</span>
				<c:choose>
					<c:when
						test="${(cdt.authorityDb eq '中科院JCR分区(大类)'|| cdt.authorityDb eq '中科院JCR分区(小类)') }">
						<div class="sc_selopt">
							<a href="javascript:choosePart()">全部</a> <a
								href="javascript:choosePart(1)" class="p_name">1区</a> <a
								href="javascript:choosePart(2)" class="p_name">2区</a> <a
								href="javascript:choosePart(3)" class="p_name">3区</a> <a
								href="javascript:choosePart(4)" class="p_name">4区</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="sc_selopt">
							<a href="javascript:choosePart()">全部</a> <a
								href="javascript:choosePart(1)" class="p_name">Q1</a> <a
								href="javascript:choosePart(2)" class="p_name">Q2</a> <a
								href="javascript:choosePart(3)" class="p_name">Q3</a> <a
								href="javascript:choosePart(4)" class="p_name">Q4</a>
						</div>
					</c:otherwise>
				</c:choose>

				<input type="hidden" id="value_s2" name="partition"
					value="${cdt.partition }">
			</div>
			<input type="submit" class="btn-blue fr" value="确认" />
			<div class="clear"></div>
		</form>
	</div>
	<c:if test="${not empty hasImpact and hasImpact==true }">
		<div class="affectoi">
			<form method="get"
				action="<cms:getProjectBasePath/>journal/category/list"
				id="impact_form">
				<input type="hidden" name="sort" value="${cdt.sort }" /> <input
					type="hidden" name='docType' value='9' /> <input type="hidden"
					name='field' value='${cdt.field }' /> <input type="hidden"
					name='value' value='<c:out value="${cdt.value }"></c:out>' /> <input
					type="hidden" name='lan' value='${cdt.lan }' /> <input
					type="hidden" name='effectSort' value='${cdt.effectSort }' />
				<c:forEach items="${cdt.queryCdt }" var="queryCdt">
					<input type="hidden" name='queryCdt' value="${queryCdt }" />
				</c:forEach>
				<c:forEach items="${cdt.filterCdt }" var="filterCdt">
					<c:if
						test="${cms:getField(filterCdt) != 'impact' && cms:getField(filterCdt) != 'impactTo' }">
						<input type="hidden" name='filterCdt' value='${filterCdt }' />
					</c:if>
					<c:if test="${cms:getField(filterCdt) == 'impact'}">
						<c:set var="from" value="${cms:getValue(filterCdt) }"></c:set>
					</c:if>
					<c:if test="${cms:getField(filterCdt) == 'impactTo'}">
						<c:set var="to" value="${cms:getValue(filterCdt) }"></c:set>
					</c:if>
				</c:forEach>
				<input type="hidden" name="partition" value="${cdt.partition }" />
				<input type='hidden' name="sortField" value='${cdt.sortField }' />
				<input type="hidden" value="${cdt.authorityDb }" name='authorityDb' />
				<input type="hidden" value="${cdt.subject }" name='subject' /> <input
					type="hidden" value="${cdt.limit }" name='limit' /> <input
					type="hidden" name='detailYear' value='${cdt.detailYear }' /> <input
					type="hidden" name="viewStyle" value="${cdt.viewStyle }" />
				<!-- <div class="affectoi-hd">影响因子</div> -->
				<div class="affectoi-bd">
					<span>影响因子</span> <input type="text" id="from" value="${from }"
						onkeyup="clearNotNum(this)" /> <i></i> <input type="text"
						id="to" value="${to }" onkeyup="clearNotNum(this)" />
					<input type="submit" class="btn-blue fr"
					style="width: 52px; height: 25px; float: left;margin-left:16px;" value="确认" />
				</div>
			</form>
			<script type="text/javascript">
        		$('#impact_form').submit(function(){
        			var from=$('#from').val(),to=$('#to').val();
        			if ($('#from').val()>$('#to').val()){
        				$('#from').val(to);
        				$('#to').val(from);
        			}
        			if(!!$('#from').val()){
        				$(this).append('<input type="hidden" name="filterCdt" value="impact_3_${field}_'+$('#from').val()+'" />');
        			}
        			if(!!$('#to').val()){
        				$(this).append('<input type="hidden" name="filterCdt" value="impactTo_3_${field}_'+$('#to').val()+'" />');
        			}
        		});
        	</script>
		</div>
	</c:if>
</div>