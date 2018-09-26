<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Enumeration"%>
<!--[if lt IE 9]>
<script src="<cms:getProjectBasePath/>resources/js/respond.min.js"></script>
<![endif]-->

<script>
	(function() {
		if (!
		/*@cc_on!@*/
		0)
			return;
		var e = "abbr, article, aside, audio, canvas, datalist, details, dialog, eventsource, figure, footer, header, hgroup, mark, menu, meter, nav, output, progress, section, time, video"
				.split(', ');
		var i = e.length;
		while (i--) {
			document.createElement(e[i]);
		}
	})()
</script>
<!--[if IE 8]>
<script>
var DEFAULT_VERSION = "8.0";
var ua = navigator.userAgent.toLowerCase();
var isIE = ua.indexOf("msie")>-1;
var safariVersion;
if(isIE){
safariVersion =  ua.match(/msie ([\d.]+)/)[1];
}
if(safariVersion <= DEFAULT_VERSION ){
console.log("您当前浏览器版本过低, 建议升级您的浏览器，以获得最佳体验。");
}
</script>
<![endif]-->
<div class="artlist-iframe container">
	<!-- ============================主题频次DIV================================================== -->
	<div class="artlist-bb clearfix" id="ztpc">
		<div class="artlist-title ztpc">主题频次</div>
		<div class="ztpc-warp">
			<div id="ztpcSelectDiv" class="ztpcSelectDiv clearfix" hidden>
				<div class="sc_selbox sc_selbox_n sc_selbox_n_star">
					<i></i> <span id="section_qk"></span>
					<div class="sc_selopt">
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());" selected="selected">2012</a> 
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2013</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2014</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2015</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2016</a>
					</div>
					<input type="hidden" id="startYear" value="2012" />
				</div>
				<span style="float: left; padding: 0 4px;">-</span>
				<div class="sc_selbox sc_selbox_n sc_selbox_n_end">
					<i></i> <span id="section_qk"></span>
					<div class="sc_selopt">
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2012</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2013</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2014</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());">2015</a>
						<a href="javascript:ztpcYearChange($('#startYear').val(),$('#endYear').val());" selected="selected">2016</a>
					</div>
					<input type="hidden" id="endYear" value="2016" />
				</div>
				<span style="float: left; padding: 0 4px;">年</span>
			</div>
			<div class="ztpc-r-warp clearfix">
				<div class="ztpcSize">
					<div class="sc_selbox sc_selbox_n" style="width: 66px;">
						<i></i> <span id="section_qk"></span>
						<div class="sc_selopt">
							<a href="javascript:zptcSizeChange($('#ztpcSize').val());" selected="selected">10</a> 
							<a href="javascript:zptcSizeChange($('#ztpcSize').val());">20</a> 
							<a href="javascript:zptcSizeChange($('#ztpcSize').val());">50</a>
						</div>
						<input type="hidden" id="ztpcSize" value="10" />
					</div>
				</div>
				<div class="sjjd">
					数据解读
					<div class="sjjd-poin">
						<div class="sjjd-poin-n">
							<i></i>
							<p>
								主题频次和弦图：<br>
								揭示本刊统计时间内，主题发文频次及与其他主题词共现频次； <br>
								外层为圆环图，圆环大小体现发文频次高低； <br>
								内层为各个扇形间相互连接的弦，线条粗细可体现关键词同时发文的频次高低（共现频次）。
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="ztpcDiv" class="ztpcDiv" style="width: 100%; height: 600px;"></div>
	</div>
	<!-- ============================发文趋势DIV================================================== -->
	<div id="fwqs" class="artlist-bb ztfwqs-warp">
		<div class="artlist-title ztfwqs">主题发文趋势</div>
		<div id="fwqsSizeDiv" class="tool clearfix">
			<div class="sel-box">
				<div class="sc_selbox sc_selbox_n" style="width: 66px;">
					<i></i> <span id="section_qk"></span>
					<div class="sc_selopt">
						<a href="javascript:fwqsSizeChange($('#fwqsSize').val());" selected="selected">10</a> 
						<a href="javascript:fwqsSizeChange($('#fwqsSize').val());">20</a> 
						<a href="javascript:fwqsSizeChange($('#fwqsSize').val());">50</a>
					</div>
					<input type="hidden" id="fwqsSize" value="10" />
				</div>
			</div>
			<div class="sjjd">
				数据解读
				<div class="sjjd-poin">
					<div class="sjjd-poin-n">
						<i></i>
						<p>
							主题发文趋势图： <br> 揭示本刊主题词在不同年份的发文频次。
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="more clearfix" hidden id='moreDiv'>
			<input id="morekey" type="text" style="display: none" /> <a
				href="javascript:void(0);" onclick="openMore()">查看更多分析结果>></a>
		</div>
		<div id="ztfwqsDiv" class="fwqsSize" style="width: 100%"></div>
	</div>
	<!-- ============================突发主题DIV================================================== -->
	<div class="artlist-bb tfzt-warp" id="tfzt">
		<div class="artlist-title tuzt">突发主题</div>
		<div class="tf-top-t clearfix">
			<div class="tfztYear">
				<div class="sc_selbox sc_selbox_n">
					<i></i> <span id="section_qk"></span>
					<div class="sc_selopt">
						<a href="javascript:tfztYearChange();">2013</a> 
						<a href="javascript:tfztYearChange();">2014</a> 
						<a href="javascript:tfztYearChange();">2015</a> 
						<a href="javascript:tfztYearChange();" selected="selected">2016</a>
					</div>
					<input type="hidden" id="tfztYear" value="2016" />
				</div>
			</div>
			<span class="nnn">年</span> <span class="ppo" id="tfztsumsize">共有10个突发主题</span>
			<div class="sjjd">
				数据解读
				<div class="sjjd-poin">
					<div class="sjjd-poin-n">
						<i></i>
						<p>
							突发主题词表： <br>
							以年为统计单位，计算主题频次在不同年份的突发强度系数，揭示相较于前一年，当年的发文频次增长较多的突发主题。
						</p>
					</div>
				</div>
			</div>
			<div class="tfztSize">
				<div class="sc_selbox sc_selbox_n" style="width: 66px;">
					<i></i> <span id="section_qk"></span>
					<div class="sc_selopt">
						<a href="javascript:tfztSizeChange();" selected="selected">10</a>
						<a href="javascript:tfztSizeChange();">20</a> <a
							href="javascript:tfztSizeChange();">50</a>
					</div>
					<input type="hidden" id="tfztSize" value="10" />
				</div>
			</div>
		</div>
		<div id="tfztDiv" class="tfzt-box"></div>
		<div class="rest-b">更新时间：2017年9月28日</div>
	</div>
</div>
<!-- ============================================================================================ -->
<script>

	var id = $("#favorites").attr("docId");
	var graghData;
	var lineData;
	var tfztData;
	var nodeColor;
	var startYear = $('#startYear').val();
	var endYear = $('#endYear').val();
	var ztpcSize = $('#ztpcSize').val();
	var fwqsSize = $('#fwqsSize').val();
	var tfztYear = $('#tfztYear').val();
	var tfztSize = $('#tfztSize').val();
	//echart必须使用getElementById方式获取容器对象，$('#')不可以用
	var ztpcDiv = document.getElementById('ztpcDiv');
	var ztpcChar;
	var ztfwqsDiv = document.getElementById('ztfwqsDiv');
	var ztfwqsChar;
	var tfztDiv = document.getElementById('tfztDiv');
	var tfztChar;
	var aname;
	//动态设置发文趋势的容器高度
	function setZftwqsDivHeight(_fwqsSize) {
		if (_fwqsSize == 10) {
			$('#ztfwqsDiv').height("400px");
			lineOption.grid.bottom = "10%";
		}
		if (_fwqsSize == 20) {
			$('#ztfwqsDiv').height("500px");
			lineOption.grid.bottom = "12%";
		}
		if (_fwqsSize == 50) {
			$('#ztfwqsDiv').height("800px");
			lineOption.grid.bottom = "18%";
		}
		$('#ztfwqsDiv').html('');
		ztfwqsChar = echarts.init(ztfwqsDiv);
	}
	$(document).ready(
			function() {
				//获取主题频次数据
				getZtpc("<cms:getProjectBasePath/>ztfx/getZtpc", id, startYear,
						endYear, ztpcSize);
				//获取发文趋势数据
				getFwqs("<cms:getProjectBasePath/>ztfx/getFwqs", id, fwqsSize);
				//获取突发主题数据
				getTfzt("<cms:getProjectBasePath/>ztfx/getTfzt", id, tfztYear,
						tfztSize);
			});
	

	function ztpcYearChange(startYear, entYear) {
		if (entYear >= startYear) {
			getZtpc("<cms:getProjectBasePath/>ztfx/getZtpc", id,
					$('#startYear').val(), $('#endYear').val(), $('#ztpcSize')
							.val());
		}
	}

	function zptcSizeChange(size) {
		changeZtpcSize(size, graghData)
	}

	function fwqsSizeChange(size) {
		changeFwqsSize(size, lineData)
	}

	function tfztSizeChange() {
		tfztChange($('#tfztYear').val(), $('#tfztSize').val());
	}

	function tfztYearChange() {
		tfztChange($('#tfztYear').val(), $('#tfztSize').val());
	}

	function changeZtpcSize(_size, reData) {
		$('#ztpcDiv').html('');
		if (reData.nodes.length > 0) {
			ztpcChar = echarts.init(ztpcDiv);
			var pageData = createZtpcDatas(_size, reData);
			graphOption.series[0].nodes = pageData.nodes;
			ztpcChar.setOption(graphOption, true);
			clickNode();
			ztpcRestore();
		} else {
			$('#ztpcDiv')
					.html('<div style="text-align:center;width:100;height:600px;background:url(<cms:getProjectBasePath/>resources/images/nosearchztc.png) no-repeat center center"></div>');
		}
	}

	function createZtpcDatas(_size, reData) {
		var pageData = {};
		var size;
		var symbolSize = 0.0;
		var nodes;
		var edges = reData.edges;
		if (_size > reData.nodes.length) {
			size = reData.nodes.length;
		} else {
			size = _size;
		}
		nodes = reData.nodes.slice(0, size);
		//node节点样式
		for (var i = 0; i < size; i++) {
			var value = nodes[i].value;
			if (symbolSize <= 0) {
				symbolSize = 60.0 / value;
			}
			var nodesize = (symbolSize * value) < 1 ? 1 : (symbolSize * value);
			nodes[i].symbolSize = nodesize;
			nodes[i].itemStyle = {
				normal : {
					color : defaultColor[i]
				}
			}
			//如果提示组件需要显示subkeys，则放开注释。
			//var res = "";
			//for (var j=0;j<nodes[i].subkeys.length;j++){
			//  res += '<p style="line-height:14px"><span style="display:inline-block;margin-right:3px;border-radius:3px;width:7px;height:7px;background-color:' + defaultColor[i] + '"></span>'+nodes[i].subkeys[j].name+" : "+nodes[i].subkeys[j].value+'</p>';
			//}
			//res = '<p style="line-height:14px"><span style="display:inline-block;margin-right:3px;border-radius:3px;width:7px;height:7px;background-color:' + defaultColor[i] + '"></span>'+nodes[i].name+" : "+nodes[i].value+'</p>';
			//nodes[i].tooltip = {formatter:res }
		}
		//edges连线样式
		for (var i = 0; i < edges.length; i++) {
			//设置线宽比例显示，现注释，保持原value值显示
			//var lineWidth = (edges[i].value * symbolSize) <1?1:(edges[i].value * symbolSize);
			edges[i].lineStyle = {
				normal : {
					width : edges[i].value
				},
				emphasis : {
					width : (parseInt(edges[i].value) + 5)
				}
			};
		}
		pageData.nodes = nodes;
		pageData.edges = edges;
		return pageData;
	}

	function changeFwqsSize(_fwqsSize, reData) {
		setZftwqsDivHeight(_fwqsSize);
		$('#ztfwqsDiv').html('');
		ztfwqsChar = echarts.init(ztfwqsDiv);
		$('.artlist-title.ztfwqs').text("发文趋势");
		var createData = createLineData(_fwqsSize, reData);
		lineOption.legend.data = createData.legend;
		lineOption.series = createData.lineDatas;
		ztfwqsChar.setOption(lineOption, true);
		
		$("#fwqsSizeDiv").show();
		$("#moreDiv").hide();
		fwqsRestore();
		legendselectchanged(createData.legend);
	}

	function createLineData(_size, reData) {
		var size;
		var nodes;
		if (_size > reData.legend.length) {
			size = reData.legend.length;
		} else {
			size = _size;
		}
		var legend = reData.legend.slice(0, size);
		legend.reverse();
		var lineDatas = reData.lineDatas.slice(0, size);
		for (var i = 0; i < lineDatas.length; i++) {
			lineDatas[i].type = "line";
			lineDatas[i].stack = "keyword";
			lineDatas[i].areaStyle = {
				normal : {
					opacity : 1,
					opacity : 0.3
				}
			};
			lineDatas[i].lineStyle = {
				normal : {
					width : 1.5
				}
			};
			lineDatas[i].symbol = "emptyCircle";
			lineDatas[i].symbolSize = 6;
			lineDatas[i].hoverAnimation = true;
			lineDatas[i].legendHoverLink = true;
		}
		return {
			lineDatas : lineDatas,
			legend : legend
		};
	}
	/**
	 * 获取主题频次数据方法
	 */
	function getZtpc(_url, _id, _startYear, _endYear, _size) {
		$('#ztpcDiv').html('');
		ztpcChar = echarts.init(ztpcDiv);
		ztpcChar.showLoading();
		$
				.ajax({
					url : _url,
					data : {
						id : _id,
						startYear : _startYear,
						endYear : _endYear
					},
					dataType : "json"
				})
				.done(
						function(reData) {
							graghData = $.extend(true, {}, reData);
							ztpcChar.hideLoading();
							if (reData.nodes != null && reData.nodes.length > 0) {
								//graphOption.visualMap = [{}];
								//graphOption.visualMap[0].show = false;
								//graphOption.visualMap[0].inRange = {};
								//graphOption.visualMap[0].inRange.color = ['#FC8983', '#E82400']; //节点颜色范围
								//graphOption.visualMap[0].min = reData.nodes[reData.nodes.length-1]!=null?reData.nodes[reData.nodes.length-1].value:1;
								//graphOption.visualMap[0].max = reData.nodes[0]!=null?reData.nodes[0].value:1;
								graphOption.animationDurationUpdate = 1500;
								graphOption.series[0].name = '主题词：频次';
								graphOption.series[0].layout = 'circular'; //环形布局
								graphOption.series[0].circular = {};
								graphOption.series[0].circular.rotateLabel = true; //环形布局相关配置,旋转标签
								var pages = createZtpcDatas(_size, reData);
								graphOption.series[0].nodes = pages.nodes;
								graphOption.series[0].edges = pages.edges;
								ztpcChar.setOption(graphOption, true);
								$("#ztpcSelectDiv").show();
								
								clickNode();
								ztpcRestore();
							} else {
								$('#ztpcDiv').html('<div style="text-align:center;width:100%;height:600px;background:url(<cms:getProjectBasePath/>resources/images/nosearchztc.png) no-repeat center center"></div>');
							}
						});
	};

	function clickNode() {
		//节点点击事件
		ztpcChar.on('click', function(params) {
			nodeColor = params.color;
			var clickNodeName = params.data.name;
			if (params.dataType == 'node' && aname != clickNodeName) { //如果点击的是节点
				getFwqsForKey(clickNodeName);
				aname = clickNodeName; //锚点，用来判断是否重复点击同一点
			} else if (params.dataType == 'node' && aname == clickNodeName) {
				changeZtpcSize($('#ztpcSize').val(), graghData);
				changeFwqsSize($('#fwqsSize').val(), lineData);
				aname = "";
			}
		});
	}

	function ztpcRestore() {
		ztpcChar.on("restore",
				function(params) {
			

					$('#ztpcSize').val(10);
					$('#startYear').val(2012);
					$('#endYear').val(2016);
					scSelboxN($('.ztpc-warp .sc_selbox_n'));
					aname = "";
					getZtpc("<cms:getProjectBasePath/>ztfx/getZtpc", id, 2012,
							2016, 10);
					changeFwqsSize($('#fwqsSize').val(), lineData);
				});
	}
	/**
	 * 图例切换
	 */
	function legendselectchanged(legend) {
		//初始化图例选择状态
		var selectedArr = new Object();
		for ( var j in legend) {
			selectedArr[legend[j]] = true;
		}
		//图例选择事件
		ztfwqsChar.on('legendselectchanged', function(params) {
			var before = true;
			var after = true;
			for ( var i in params.selected) {
				if (false != params.selected[i]) { //点击之后只要还有一个是选中状态，after就是false。
					after = false;
				}
				if (true != selectedArr[i]) { //点击之前只要还有一个是未选中状态，before就是false.
					before = false;
				}
			}
			if (before || after) { //如果点击之前全部是选中状态或者点击之后全部为未选中状态，则取反
				for ( var i in params.selected) {
					selectedArr[i] = !params.selected[i];
				}
			} else {
				selectedArr = params.selected;
			}
			var selecteds = 0;
			for ( var lengedname in selectedArr) {
				if (selectedArr[lengedname] == true) {
					selecteds++;
					$("#morekey").val(lengedname);
				}
			}
			if (selecteds == 1) {
				$("#fwqsSizeDiv").hide();
				$("#moreDiv").show();
			} else {
				$("#fwqsSizeDiv").show();
				$("#moreDiv").hide();
			}
			ztfwqsChar.setOption({
				legend : {
					selected : selectedArr
				}
			});
		});
	}
	/**
	 * 获取发文趋势数据方法
	 */
	function getFwqs(_url, _id, _fwqsSize) {
		setZftwqsDivHeight(_fwqsSize);
		ztfwqsChar.showLoading();
		$.ajax({
			url : _url,
			data : {
				id : _id
			},
			dataType : "json"
		}).done(
				function(reData) {
					lineData = $.extend(true, {}, reData);
					ztfwqsChar.hideLoading();
					if (reData.lineDatas.length > 0) {
						$('.artlist-title.ztfwqs').text("发文趋势");
						lineOption.legend.show = true;
						lineOption.toolbox.feature.magicType.type = new Array(
								'stack', 'tiled');
						//lineOption.color = gradientColor('#e82400','#13e200',_fwqsSize);
						lineOption.xAxis.boundaryGap = false;
						lineOption.xAxis.data = reData.xAxisData;
						var createData = createLineData(_fwqsSize, reData);
						lineOption.legend.data = createData.legend;
						lineOption.series = createData.lineDatas;
						ztfwqsChar.setOption(lineOption, true);
						$("#fwqsSizeDiv").show();
						$("#moreDiv").hide();
						
						//重置数据
						fwqsRestore();
						legendselectchanged(createData.legend);
					}
				});
	}

	function fwqsRestore() {
		ztfwqsChar.on("restore", function(params) {
			$('#fwqsSize').val(10);
			scSelboxN($('.ztfwqs-warp .sc_selbox_n'));
			aname = "";
			changeFwqsSize(10, lineData);
		});
	}
	/**
	 * 获取单个关键字发文趋势方法
	 */
	function getFwqsForKey(_key) {
		$('.artlist-title.ztfwqs').text(_key + "在本刊中的发文趋势");
		fwqsforkeyOption = $.extend(true, {}, lineOption);
		fwqsforkeyOption.toolbox.feature.magicType.type = new Array('bar',
				'line');
		fwqsforkeyOption.xAxis.boundaryGap = true;
		var nodeData;
		for (var i = 0; i < lineData.lineDatas.length; i++) {
			if (lineData.lineDatas[i].name == _key) {
				nodeData = $.extend(true, {}, lineData.lineDatas[i]);
				nodeData.type = "bar";
				nodeData.barWidth = 60;
				nodeData.lineStyle = {
					normal : {
						width : 2
					}
				};
				break;
			}
		}
		fwqsforkeyOption.series = [ nodeData ];
		fwqsforkeyOption.legend.show = false;
		fwqsforkeyOption.color = [ nodeColor ]; //将颜色设置为点击的节点颜色
		//重新设置图表大小
		$("#ztfwqsDiv").html('');
		$("#ztfwqsDiv").height("420px");
		ztfwqsChar = echarts.init(ztfwqsDiv, true);
		ztfwqsChar.setOption(fwqsforkeyOption);
		$("#fwqsSizeDiv").hide();
		$("#moreDiv").show();
		$("#morekey").val(_key);
		
		//重置数据
		ztfwqsChar.on("restore", function(params) {
			changeFwqsSize($('#fwqsSize').val(), lineData);
			changeZtpcSize($('#ztpcSize').val(), graghData);
		});
	}

	function tfztChange(_tfztYear, _tfztSize) {
		$('#tfztDiv').width("auto");
		$('#tfztDiv').height("auto");
		tfztChar.hideLoading();
		$('#tfztsumsize').text("共有" + tfztData[_tfztYear].sumsize + "个突发主题");
		if (tfztData[_tfztYear].tfztData.length > 0) {
			$('#tfztDiv').html(createTfzt(tfztData[_tfztYear], _tfztYear));
			$('#tfzt').show();
		} else {
			$('#tfztDiv')
					.html(
							'<div style="text-align:center;width:100%;height:300px;background:url(<cms:getProjectBasePath/>resources/images/nosearchztc.png) no-repeat center center"></div>');
			$('#tfzt').show();
		}
	}
	//获取突发主题数据方法
	function getTfzt(_url, _id, _tfztYear, _tfztSize) {
		$('#tfztDiv').width("100%");
		$('#tfztDiv').height("100px");
		tfztChar = echarts.init(tfztDiv, true);
		tfztChar.showLoading();
		$
				.ajax({
					url : _url,
					data : {
						id : _id
					},
					cache : true,
					dataType : "json",
					cache : true
				})
				.done(
						function(reData) {
							tfztData = reData;
							$('#tfztDiv').width("auto");
							$('#tfztDiv').height("auto");
							tfztChar.hideLoading();
							$('#tfztsumsize').text(
									"共有" + reData[_tfztYear].sumsize + "个突发主题");
							if (reData[_tfztYear].tfztData.length > 0) {
								$('#tfztDiv').html(
										createTfzt(reData[_tfztYear],_tfztYear));
								$('#tfzt').show();
							} else {
								$('#tfztDiv')
										.html(
												'<div style="text-align:center;width:100%;height:300px;background:url(<cms:getProjectBasePath/>resources/images/nosearchztc.png) no-repeat center center"></div>');
								$('#tfzt').show();
							}
						});
	}
	//动态生产突发主题表格数据
	function createTfzt(data,_tfztYear) {
		var tableData = data.tfztData;
		var table = '<table><tbody><tr>' + '<th width="7%">序号</th>' + '<th>突发主题</th>'
				+ '<th width="15%">'+(_tfztYear-1)+'年频次</th>' + '<th width="15%">'+_tfztYear+'年频次</th>' + '<th width="13%">突发强度</th>' + '</tr>';
		var index = 1;
		var size = 0;
		if ($("#tfztSize").val() > data.sumsize) {
			size = data.sumsize;
		} else {
			size = $("#tfztSize").val();
		}
		for (var i = 0; i < size; i++) {
			table += '<tr>' + '<td>' + index + '</td>' + '<td>'
					+ tableData[i].key + '</td>' + '<td>'
					+ tableData[i].startYearCount + '</td>' + '<td>'
					+ tableData[i].endYearCount + '</td>' + '<td>'
					+ tableData[i].value + '</td>' + '</tr>';
			index++;
		}
		table += '</tbody></table>';
		return table;
	}

	function openMore() {
		layer.open({
			type : 2,
			title : '更多分析内容',
			shadeClose : true,
			shade : 0.8,
			area : [ '800px', '500px' ],
			content : '<cms:getProjectBasePath/>resources/frame/more.jsp?morekey='+$("#morekey").val()
		});
	}
</script>