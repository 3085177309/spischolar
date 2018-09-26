<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>SpiScholar学术资源在线</title>
<jsp:include page="include/meta.jsp"></jsp:include>
</head>
<body>
	<c:set scope="request" var="mindex" value="0"></c:set>
	<div class="page-view indexbg">
		<img
			src="<cms:getProjectBasePath/>resources/mobiles/images/spisbg.jpg"
			class="indexbgimg">
		<div class="userbox">
			<a href="<cms:getProjectBasePath/>user/login"><i
				class="icon iconfont">&#xe603;</i>登录</a>
		</div>
		<div class="mui-content" id="mui-content">
			<div class="scroller-container">

				<div class="lg">
					<img
						src="<cms:getProjectBasePath/>resources/mobiles/images/logo1.png">
				</div>
				<div class="search-form">
					<div class="tab" id="search-tab-btn">
						<span>期刊</span><i></i>
						<p>
							<a href="javascript:void(0)" class="search active">期刊</a> <a
								href="javascript:void(0)" class="search">文章</a>
						</p>
					</div>
					<div id="search-tab-box">
						<dd class="stab journal" style="display: block;">
							<div class="search-inputwrap">
								<form method="get"
									action="<cms:getProjectBasePath/>journal/search/list">
									<div class="">
										<input type="hidden" name="batchId" value="<cms:batchId />" />
										<input type="text" class="input-text" value="" name="value"
											id="jounal_kw" placeholder="请输入刊名/ISSN">
										<button type="submit" class="input-submit search"
											id="quick_search_btn" value="检索">
											<i class="icon iconfont">&#xe604;</i>
										</button>
										<input type="button" class="searchCancle" value="取消">
									</div>
									<div class="radio_js" id="lan_panel">
										<label class="ui-radio" for="radio"><input
											type="radio" value="0" name="lan" checked>全部</label> <label
											class="ui-radio" for="radio"><input type="radio"
											value="1" name="lan">中文</label> <label class="ui-radio"
											for="radio"><input type="radio" value="2" name="lan">外文</label>
									</div>
								</form>
							</div>
						</dd>
						<dd class="stab scholar" style="display: none;">
							<div class="search-inputwrap">
								<form method="get"
									action="<cms:getProjectBasePath/>scholar/list">
									<div class="">
										<input type="hidden" name="batchId" value="<cms:batchId />" />
										<input type="text" class="input-text" value='${searchKey }'
											id="keyword_text" autocomplete="off" name="val"
											placeholder="">
										<button type="submit" class="input-submit"
											id="quick_search_btn" value="检索">
											<i class="icon iconfont">&#xe604;</i>
										</button>
										<input type="button" class="searchCancle" value="取消">
									</div>
									<div class="radio_js" id="lan_panel">
										<div class="ui-checkbox-s">
											<input type="checkbox" name="oaFirst" value="1"
												<c:if test="${condition.oaFirst ==1 }">checked="checked"</c:if>>
											<em>开放资源</em>
										</div>
										<i class="ftnm">勾选即可获取全部开放资源结果</i>
									</div>
								</form>
							</div>
						</dd>
					</div>
				</div>
			</div>

		</div>
		<jsp:include page="include/footer.jsp"></jsp:include>
	</div>
	<script
		src="<cms:getProjectBasePath/>resources/mobiles/js/spisMoible.js"></script>

	<script>
		/**
		 * 首页，切换期刊检索和文章检索
		 */
		var tabTxt = $("#search-tab-btn span"),
			tabBox = $("#search-tab-btn p"),
			tabOpt = $("#search-tab-btn p a"),
			journalSrch = $("#search-tab-box .journal"),
			scholarSrch = $("#search-tab-box .scholar");
		tabTxt.on("touchstart",function(){
			tabBox.toggle()
		})
		tabOpt.on("touchstart",function(){
			$(this).addClass("active").siblings().removeClass("active");
			var text = $(this).text();
			if(text == "期刊"){
				journalSrch.show();
				scholarSrch.hide();
			}else if(text == "文章"){
				scholarSrch.show();
				journalSrch.hide();
			}
			tabTxt.text(text);
			tabBox.hide();
		})


		/**
		 * 首页，期刊input  和 文章input 值同步
		 */
		;(function(){
			var isInputZh = false;
			var textInputSerh = $("#search-tab-box input.input-text");
			textInputSerh.val(textInputSerh.val());
			
			textInputSerh.on({
				compositionstart:function(){
					isInputZh = true;
				},
				compositionend:function(){
					isInputZh = false;
					textInputSerh.val($(this).val());
				},
				input:function(){
					var $this = $(this);
					setTimeout(function(){
						if (isInputZh) return;
						textInputSerh.val($this.val());
					},20)
				}
			})
		}())

	</script>
</body>
</html>