/**
 * 权威数据库点击
 * 
 * @returns {Boolean}
 */
function authorityDbItemClick() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		$('#discipline_system_list .boxSrroll').load(encodeURI(action_target),function(){
			$('.boxSrroll').scrollTop(0);
		});
		$('#authority_db_menu a').removeClass('in');
		$(this).addClass('in');
	}
	return false;
}
$('#authority_db_menu .db_item').bind('click', authorityDbItemClick);

$('#authority_db_menu li:eq(0) a').click();