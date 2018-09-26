<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Enumeration"%>
<!DOCTYPE html>
<html  lang="zh-cmn-Hans">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%--<meta http-equiv="X-UA-Compatible" content="IE=7"></meta>--%>
<title>更多分析</title>
<script src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/wdEcharts.js"></script>
<script src="<cms:getProjectBasePath/>resources/js/echartsDataModel.js"></script>
</head>
<body style="height:500px;overflow:auto;">

<div id="ztfwzqs" style="width: 100%;height:300px;"></div>

<div id="fwqk" style="width: 100%;height:500px;"></div>
<script>
var ztfwzqsChart = echarts.init(document.getElementById('ztfwzqs'));
var fwqkChart = echarts.init(document.getElementById('fwqk'));

//窗口大小改变事件
window.onresize=function(){
//  var a=document.body.clientWidth;  //取得iframe框架的实际宽度
//  document.getElementById("ztfwzqs").style.width=a+"px";
  ztfwzqsChart = echarts.init(document.getElementById('ztfwzqs'));
  fwqkChart = echarts.init(document.getElementById('fwqk'));
  ztfwzqsChart.setOption(ztfwzqsOption);
  fwqkChart.setOption(fwqkOption);
}
//获取url参数
function getQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}
var morekey = getQueryString("morekey");
console.log(morekey)
$(document).ready(function(){
	getZtfwzqs("<cms:getProjectBasePath/>ztfx/getMoreFwqsForKey",morekey);
	getFwqk("<cms:getProjectBasePath/>ztfx/getFwqk",morekey);
});


//获取发文总趋势数据
function getZtfwzqs(_url,_key){
	ztfwzqsChart.showLoading();
	$.ajax({
		url:_url,
		data:{key:_key},
		dataType:"json"
	}).done(function(reData){
		ztfwzqsChart.hideLoading();
		for(var i=0;i<reData.lineDatas.length;i++){
			reData.lineDatas[i].type="line";
			reData.lineDatas[i].barWidth=60;
			reData.lineDatas[i].lineStyle={normal:{width:2}};
		}
		ztfwzqsOption.series = reData.lineDatas;
		ztfwzqsChart.setOption(ztfwzqsOption);
	});
}

function getFwqk(_url,_key){
	fwqkChart.showLoading()
	$.ajax({
		url:_url,
		data:{key:_key},
		dataType:"json"
	}).done(function(reData){
		fwqkChart.hideLoading()
		fwqkOption.title.text = '关于'+_key+'的发文期刊';
		fwqkOption.xAxis.data = reData.lenged;
		for (var i=0;i<reData.lineDatas.length;i++){
			reData.lineDatas[i].type = "bar";
		}
		fwqkOption.series = reData.lineDatas;
		fwqkChart.setOption(fwqkOption);
		fwqkChart.on("click",function(params){
			if(params.seriesType == "bar"){
				var name = params.name;
				id = name.substring(name.indexOf("[")+1,name.indexOf("]"));
				window.open("<cms:getProjectBasePath/>journal/detail/"+id);
				window.close();
			}
		});
	});
}




</script>
</body>
</html>