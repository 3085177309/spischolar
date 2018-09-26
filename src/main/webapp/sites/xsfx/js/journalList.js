(function($){
	$('#journal_doc_paginatin li a').bind('click', function(e) {
		$('#doc_container').load($(this).attr('href'),function(response,status){
			  if (status == "error"){//加载内容出错!
				  $('#doc_container').html('没有找到相关数据!');
			  }else{
				  $("html,body").animate({scrollTop:$("#thisTop").offset().top},'fast');
			  }
		});
		e.preventDefault();
		return false;
	});
	var endY=$('#articlesSF').find('input[name="end_y"]');
	if(!endY.val()){
		var year=(new Date()).getFullYear();
		endY.val(year);
	}
	var val=$('#articlesSF').find('input[name="val"]');
	if(!val.val()){
		val.val('请输入关键字');
	}
	val.focus(function(){
		if($(this).val()=='请输入关键字'){
			$(this).val('');
		}
	}).blur(function(){
		if($(this).val()==''){
			$(this).val('请输入关键字');
		}
	});
	$('#articlesSFBtn').bind('click',function(e){
		var tar=$('#articlesSF');
		var action=tar.attr('action'),
			journal=encodeURIComponent(tar.find('input[name="journal"]').val()),
			startY=tar.find('input[name="start_y"]').val(),
			endY=tar.find('input[name="end_y"]').val(),
			val=encodeURIComponent(tar.find('input[name="val"]').val()),
			sort=tar.find('input[name="sort"]').val();
		var _v=tar.find('input[name="val"]').val();
		if(!_v||_v=='请输入关键字'){
			alert('请输入关键词!');
			e.preventDefault();
			return false;
		}
		if(!!startY&&!startY.match(/\d{4}/)){
			alert('请输入4位有效的年份');
			e.preventDefault();
			return false;
		}
		if(!!endY&&!endY.match(/\d{4}/)){
			alert('请输入4位有效的年份');
			e.preventDefault();
			return false;
		}
		var href=action+"?journal="+journal+"&start_y="+startY+"&end_y="+endY+"&val="+val+"&sort="+sort;
		$('#doc_container').load(href,function(response,status){
			  if (status == "error"){//加载内容出错!
				  $('#doc_container').html('没有找到相关数据!');
			  }
		});
		e.preventDefault();
		return false;
	});
})(jQuery);