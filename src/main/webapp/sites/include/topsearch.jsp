<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<div class="as-shelter" id="shelter"></div>
<div class="top-search" id="top-search">
	<div class="top-search-wrap clearfix">
		<a class="top-logo" href="<cms:getProjectBasePath/>">spischolar</a>
		<div class="search-box">
			<div class="search-tab">
				<form method="get"
					action="<cms:getProjectBasePath/>journal/search/list">
					<div class="qk-search">
						<input type="text" class="textInput" name="value"
							placeholder="请输入刊名/ISSN/学科名" value="" autocomplete="off">
						<input type="submit" class="journal_hide_btn"> <input
							type="hidden" name="batchId"
							value="8715f31e-20f5-40cb-87c3-1527ce736a5b"> <i
							class="c-i"></i>
					</div>
				</form>
			</div>
			<div class="search-btn">
				<button class="s-qk s-btn active journal_search_btn">搜期刊</button>
			</div>
		</div>
	</div>
</div>