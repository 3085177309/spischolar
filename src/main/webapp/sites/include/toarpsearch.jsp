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
				<form method="get" action="<cms:getProjectBasePath/>scholar/list">
					<div class="article-search">
						<input type="text" class="textInput" value="" name="val"
							autocomplete="off"> <input type="submit"
							class="article_hide_btn"> <i class="c-i"></i>
					</div>
				</form>
			</div>
			<div class="search-btn">
				<button class="s-ar s-btn article_search_btn active">搜文章</button>
			</div>
		</div>
	</div>
</div>