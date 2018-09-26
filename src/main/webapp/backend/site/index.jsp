<!-- 站点管理首页 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms" %>

<%
	String projectRootPath = request.getContextPath();
%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是http://localhost:8080/MyApp/）:
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<div id='site_index_panel'>
	<div class="alert site_deploy_error hide"
		style="position: absolute; right: 0; bottom: 0;">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>警告!</strong> <span></span>
	</div>
	
	<!-- 该区域展示站点树 -->
	
	<div id='site_list_container'></div>

	<!-- 站点模版编辑区域 -->
	<div id='site_edit_container'>
		<div style="display: block; float: right; clear: both;">
			<cms:permissionTag flag="site_detail">
				<button class='btn btn-small' id='site_detail_btn' action_target='backend/site/detail/'>站点详细</button>
			</cms:permissionTag>
			<cms:permissionTag flag="load_site_tree">
				<button class='btn btn-small' action_target='backend/site/list/' org_id='${orgId }' id='site_tree_refresh_btn'>刷新站点树</button>
			</cms:permissionTag>
			<cms:permissionTag flag="add_site">
				<button class='btn btn-small' data-toggle="modal" role="button"
				data-target='#addSiteModal'>新建站点</button>
			</cms:permissionTag>
			<cms:permissionTag flag="index_site_search_log">
				<button class='btn btn-small' action_target='backend/log/index/' org_id='${orgId }' id='log_btn' time='-1'>检索日志</button>
			</cms:permissionTag>
			<cms:permissionTag flag="upload_template">
				<button class='btn btn-small' data-target='#templateUploadModal'
				data-toggle="modal" role="button">上传模版</button>
			</cms:permissionTag>
			<cms:permissionTag flag="use_current_template">
				<button class='btn btn-small' id='use_current_template_btn' action_target='backend/site/editSiteTemplateRoot/'>使用当前模版</button>
			</cms:permissionTag>
			<cms:permissionTag flag="deploy_site">
				<button class='btn btn-small' id='deploy_site' action_target='backend/site/deploy/'>站点发布</button>
			</cms:permissionTag>
			<cms:permissionTag flag="undeploy_site">
				<button class='btn btn-small' id='undeploy_site' action_target='backend/site/undeploy/'>站点反发布</button>
			</cms:permissionTag>
			<cms:permissionTag flag="save_file_change">
				<button class='btn btn-small btn-success' id='save_edit_btn'>保存修改</button>
			</cms:permissionTag>
			<cms:permissionTag flag="del_site">
				<button class='btn btn-small btn-warning' id='del_site_btn'
				action_target='backend/site/del/'>删除站点</button>
			</cms:permissionTag>
			<cms:permissionTag flag="del_site_template">
				<button class='btn btn-small btn-warning' id='del_template_btn' action_target='backend/site/templateDel/'>删除模版文件夹</button>
			</cms:permissionTag>
		</div>
		
		<pre id='file_editor'>
		</pre>
		
		<div id='log_content'></div>
	</div>

</div>

<!-- 站点详细对话框 -->
<div id="siteDetailModal" class="modal hide fade" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>站点详细</h3>
	</div>
	<div class="modal-body">
		<div style="width: 200px;margin:auto;">
		<label>
			<span>站点名:</span><span id='_site_name'></span>
		</label> 
		<label>
			<span>站点标识:</span><span id='_site_flag'></span>
		</label>
		<label>
			<span>模版根目录:</span><span id='_site_template'></span>
		</label>
		</div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
	</div>
</div>

<!-- 新建站点对话框 -->
<div id="addSiteModal" class="modal hide fade" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>新建站点</h3>
	</div>
	<div class="modal-body">
		<div class="alert hide" id='site_add_error'>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>警告!</strong> <span></span>
		</div>
		<form id='site_form'>
			<label><span>站点名:</span><input type='text' name='name' /></label> <label><span>站点标识:</span><input
				type='text' name='flag' /></label> <input type="hidden" name="orgId"
				value='${orgId }' />
		</form>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<cms:permissionTag flag="add_site">
			<button class="btn btn-primary" id='add_site_btn'
			action_target='backend/site/add'>确定</button>
		</cms:permissionTag>
	</div>
</div>


<!-- 模版上传对话框 -->
<div id="templateUploadModal" class="modal hide fade" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>模版上传</h3>
	</div>
	<div class="modal-body">
		<div class="alert hide" id='template_upload_error'>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<strong>警告!</strong> <span></span>
		</div>
		<form id='template_upload_form'>
			<ul>
				<li><label> <span>请选择zip压缩包(压缩包大小不能超过20M)</span>
				<cms:permissionTag flag="upload_template">
					<input
							type='button' class='btn btn-info' id='myfileupload' value='文件选择' />
							<input id="fileupload" class='hide' type="file" name="files[]"
							uri='backend/site/upload/template' />
				</cms:permissionTag> 
				</label></li>
				<li><input type='hidden' name='siteFlag' id='site_flag' /><input
					type='hidden' name='orgFlag' id='org_flag' /></li>
			</ul>
		</form>
		<div id="files" class="files"></div>
		<div id="progress" class="progress progress-striped active">
			<div class="bar"></div>
		</div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
	</div>
</div>

<script
	src="resources/plugins/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
<script
	src="resources/plugins/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>

<script type="text/javascript"
	src="<%=projectRootPath%>/resources/js/backend/site/index.js"></script>