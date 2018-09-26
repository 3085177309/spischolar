//站点列表页js

//树节点单机
function zTreeOnClick(event, treeId, treeNode) {
	$('#site_flag').val(treeNode.siteFlag);
	$('#org_flag').val(treeNode.orgFlag);
	if (treeNode.isTemplatePage) {
		$('#file_editor').show();
		$('#log_content').hide();
		// 获取文件内容
		var data = 'orgFlag=' + treeNode.orgFlag + '&siteFlag='
				+ treeNode.siteFlag + '&templateFlag=' + treeNode.templateDir
				+ '&fileName=' + treeNode.name;
		$.ajax({
			url : 'backend/site/loadFileContent',
			data : data,
			dataType : 'text',
			type : 'POST',
			success : function(rs) {
				fileEditor.setValue(rs);
			}
		});
	}
	event.stopPropagation();
}

var treeSetting = {
	callback : {
		onClick : zTreeOnClick
	}
};

$.fn.zTree.init($("#site_tree"), treeSetting, ztreeJson);