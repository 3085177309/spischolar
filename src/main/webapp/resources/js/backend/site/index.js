//站点管理首页js

var fileEditor = ace.edit("file_editor");
fileEditor.getSession().setUseWorker(false);
// 设置主题
fileEditor.setTheme("ace/theme/chrome");
// 设置语法
fileEditor.getSession().setMode("ace/mode/jsp");
// 设置字体大小
document.getElementById('file_editor').style.fontSize = '14px';

$('#site_tree_refresh_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		$('#file_editor').show();
		$('#log_content').hide();
		action_target = $.trim(action_target) + $(this).attr('org_id');
		$('#site_list_container').load(action_target);
	}
});
$('#site_tree_refresh_btn').click();

$('#addSiteModal').on('hidden', function() {
	$('#site_form label input').val('');
});

$('#templateUploadModal').on('hide', function() {
	$('#files').text('');
	$('#progress .bar').removeAttr('style');
});

$('#templateUploadModal').on('show', function() {
	var treeObj = $.fn.zTree.getZTreeObj("site_tree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length != 1) {
		alert('请先选择站点!');
		return false;
	}
	$('#file_editor').show();
	$('#log_content').hide();
});

// 新增站点
$('#add_site_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target);
		var data = $('#site_form').serialize();
		var settings = {
			url : action_target,
			dataType : 'JSON',
			type : 'POST',
			data : data,
			success : function(rs) {
				if (null != rs.error) {
					// 添加异常，显示错误信息
					$('#site_add_error span').text(rs.error);
					$('#site_add_error').removeClass('hide');
				} else {
					// 添加成功关闭对话框，重刷站点列表
					$('#site_add_error').addClass('hide');
					$('#addSiteModal').modal('hide');
					$('#site_tree_refresh_btn').click();
				}
			}
		};
		$.ajax(settings);
	}
});

// 查看站点详细
$('#site_detail_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (null != nodes && nodes.length == 1) {
			action_target = $.trim(action_target) + nodes[0].siteId;
			$.ajax({
				url : action_target,
				dataType : 'JSON',
				type : 'GET',
				success : function(rs) {
					console.log(rs);
					if (null != rs.error) {
						alert(rs.error);
					} else {
						$('#_site_name').text(rs.name);
						$('#_site_flag').text(rs.flag);
						$('#_site_template').text(rs.template);
						$('#siteDetailModal').modal('show');
					}
				}
			});
		} else {
			alert('请先选择一个站点!');
		}
	}
});

// 文件上传
$('#fileupload').fileupload({
	url : $('#fileupload').attr('uri'),
	dataType : 'json',
	done : function(e, data) {
		$('#files').html('');
		$.each(data.files, function(index, file) {
			$('<p/>').text(file.name).appendTo('#files');
		});
	},
	success : function(data, status) {
		if (null != data.error) {
			$('#template_upload_error span').text(data.error);
			$('#template_upload_error').removeClass('hide');
		} else {
			$('#template_upload_error').addClass('hide');
			$('#site_tree_refresh_btn').click();
		}
	},
	progressall : function(e, data) {
		var progress = parseInt(data.loaded / data.total * 100, 10);
		$('#progress .bar').css('width', progress + '%');
	}
}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');

$('#myfileupload').bind('click', function() {
	$('#fileupload').click();
	return false;
});

function delSite() {
	var treeObj = $.fn.zTree.getZTreeObj("site_tree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length != 1 || undefined == nodes[0].orgId) {
		alert('请先选择站点!');
		return false;
	}
	$('#file_editor').show();
	$('#log_content').hide();
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		action_target = $.trim(action_target) + nodes[0].orgId + '/' + nodes[0].siteId;
		$('#site_list_container').load(action_target);
	}
}

// 删除站点
$('#del_site_btn').bind('click', delSite);

function saveFileEdit() {
	var treeObj = $.fn.zTree.getZTreeObj("site_tree");
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length != 1) {
		alert('请先选择模版文件!');
		return false;
	}
	if (nodes[0].isTemplatePage) {
		// 获取文件内容
		var data = 'orgFlag=' + nodes[0].orgFlag + '&siteFlag=' + nodes[0].siteFlag + '&templateFlag=' + nodes[0].templateDir + '&fileName=' + nodes[0].name + '&content='
				+ fileEditor.getValue().replace(/%/g, '%25').replace(/&/g, '%26').replace(/\+/g, '%2B');
		$.ajax({
			url : 'backend/site/saveFileContent',
			data : data,
			dataType : 'text',
			type : 'POST',
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				} else {
					alert('修改成功!');
				}
			}
		});
	}
	return false;
}
// 保存修改
$('#save_edit_btn').bind('click', saveFileEdit);

// 站点发布
$('#deploy_site').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length != 1) {
			alert('请先选择一个站点!');
			return false;
		}
		action_target = $.trim(action_target) + nodes[0].siteId;
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
});

// 修改当前使用的模版根目录
$('#use_current_template_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length != 1) {
			alert('请先选择模版根目录!');
			return false;
		}
		action_target = $.trim(action_target) + nodes[0].siteId + '/' + nodes[0].name;
		$.ajax({
			url : action_target,
			dataType : 'JSON',
			type : 'GET',
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				} else {
					alert('设置成功!');
				}
			}
		});
	}
});

// 站点反发布
$('#undeploy_site').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length != 1) {
			alert('请先选择一个站点!');
			return false;
		}
		action_target = $.trim(action_target) + nodes[0].siteId;
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
});

// 删除站点模版
$('#del_template_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length != 1 || undefined == nodes[0].tempateDir) {
			alert('请选择要删除的模版目录!');
			return false;
		}
		action_target = $.trim(action_target);
		$.ajax({
			url : action_target + nodes[0].siteId + '/' + nodes[0].name,
			dataType : 'JSON',
			type : 'GET',
			success : function(rs) {
				if (null != rs.error) {
					alert(rs.error);
				} else {
					$('#site_tree_refresh_btn').click();
				}
			}
		});
	}
});

// 获取站点检索日志
$('#log_btn').bind('click', function() {
	var action_target = $(this).attr('action_target');
	if (null != action_target && '' != $.trim(action_target)) {
		var treeObj = $.fn.zTree.getZTreeObj("site_tree");
		var nodes = treeObj.getSelectedNodes();
		if (null == nodes || nodes.length != 1) {
			alert('请选择一个站点根目录!');
			return false;
		}
		if (null == nodes[0].orgFlag || null == nodes[0].siteFlag) {
			alert('请选择站点根目录!');
			return false;
		}
		var time = $(this).attr('time');
		$('#log_content').load(action_target + nodes[0].orgFlag + '/' + nodes[0].siteFlag + '?time=' + time, function() {
			$('#file_editor').hide();
			$('#log_content').show();
		});
	}
});