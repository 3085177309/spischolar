//首页js

/**
 * 菜单项点击事件监听
 * 
 * @param evt
 *            被点击的元素(事件对象)
 * @param pageLoadAreaJqSelector
 *            结果将会被加载到的页面区域(值为jquery的选择器)
 * @url 执行加载的url,如果该值为null，则尝试获取本元素的action_target属性值做为url
 * 
 * @returns
 */
function menuItemClickListener(evt, pageLoadAreaJqSelector, url) {

	var action_target = url;
	if (null == action_target || undefined == action_target)
		action_target = $(evt).attr('action_target');

	console.log('action_target--->' + action_target);

	// 获取需要执行的操作地址
	if (null == action_target || '' == $.trim(action_target)) {
		// 该菜单项，无action_target属性，不做任何操作
		return false;
	}

	action_target = $.trim(action_target);// 去除多余的空格
	$(pageLoadAreaJqSelector).load(action_target);

	// 阻止事件向下传递
	return false;
}

$('#backend_index_nav_panel li a').bind('click', function() {
	if ('reload_overall_situation_cache_btn' != $(this).attr('id')) {
		return menuItemClickListener(this, '#center_panel');
	}
});

$('#reload_overall_situation_cache_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		$.ajax({
			url : action_target,
			dataType : 'JSON',
			type : 'GET',
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				}
			}
		});
	}
	return false;
});

// 自动点击第一个菜单
$('#backend_index_nav_panel li a:eq(0)').click();

$('#prepare_change_pwd_btn').bind('click', function() {
	$('#change_pwd_dialog').modal('show');
});

$('#change_pwd_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) ;
		var data = $('#pwd_change_form').serialize();
		$.ajax({
			url : action_target,
			dataType : 'JSON',
			type : 'POST',
			data : data,
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				} else {
					$('#change_pwd_dialog').modal('hide');
					$('#pwd_change_form label input').val('');
				}
			}
		});
	}
	return false ;
});