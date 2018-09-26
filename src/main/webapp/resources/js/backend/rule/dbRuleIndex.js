// 数据库规则首页js

$('#db_rule_list_btn').bind('click',function(){
	var action_target = $(this).attr('action_target') ;
	if(null!=action_target && ''!=$.trim(action_target)){
		var orgId = $(this).attr('orgId') ;
		var dbId = $(this).attr('dbId') ;
		action_target = $.trim(action_target)+dbId+'/'+orgId ;
		$('#rule_list_container').load(action_target) ;
	}
	return false ;
}) ;

$('#db_rule_list_btn').click();

$('#prepare_db_rule_add_btn').bind('click',function(){
	var action_target = $(this).attr('action_target') ;
	if(null!=action_target && ''!=$.trim(action_target)){
		var orgId = $(this).attr('orgId') ;
		var dbId = $(this).attr('dbId') ;
		action_target = $.trim(action_target)+orgId+'/'+dbId ;
		$('#rule_list_container').load(action_target) ;
	}
	return false ;
}) ;