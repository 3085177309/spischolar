<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<title>行为分析</title>
<jsp:include page="../head.jsp"></jsp:include>
<script
	src="<cms:getProjectBasePath/>/resources/back/js/My97DatePicker/WdatePicker.js"></script>
<div id="content">
	<div class="col-left left-menue" id="side-menue">
		<h3>
			<span class="inc uv12"></span> <span class="inc uv00"></span> 内容分析
		</h3>
		<ul class="side-nav">
			<c:forEach items="${permission.nrfx }" var="nrfx" varStatus="status">
				<li><a href="<cms:getProjectBasePath/>${nrfx.url}"
					<c:if test="${nrfx.id == 18 }">class="in"</c:if>>${nrfx.columnName }</a></li>
			</c:forEach>

		</ul>
		<!-- 	<div class="side-statics">
			<p>期刊首页网址链接</p>
			<div class="side-Homelink"><a href="http://www.spischolar.com">http://www.spischolar.com/</a></div>
		</div>
 -->
	</div>
	<div class="col-left col-auto">
		<div class="crumb">
			<span class="inc uv02"></span> <a href="#">首页</a>> <a href="#">内容分析</a>>
			<a href="#" class="in">行为分析</a>
		</div>
		<div class="iframe-con">
			<div id="rightMain">
				<div class="pageTopbar clearfix">
					<label class="access-pro"> <span class="labt">访问概况:</span>
						<div class="sc_selbox">
							<i class="inc uv21"></i> <span id="section_lx">访问全部</span>
							<div class="sc_selopt" style="display: none;">
								<a href="javascript:void(0);">访问全部</a> <a
									href="javascript:void(0);">中南大学</a> <a
									href="javascript:void(0);">湖南大学</a> <a
									href="javascript:void(0);">长沙理工大学</a> <a
									href="javascript:void(0);">中南林业科技大学</a> <a
									href="javascript:void(0);">长沙学院</a>
							</div>
							<input type="hidden" name="" value="">
						</div>
					</label> <label class="data-type"> <span class="labt">数据类型:</span>
						<div class="sc_selbox">
							<i class="inc uv21"></i> <span id="section_lx">原始数据</span>
							<div class="sc_selopt" style="display: none;">
								<a href="javascript:void(0);">访问全部</a> <a
									href="javascript:void(0);">中南大学</a> <a
									href="javascript:void(0);">湖南大学</a> <a
									href="javascript:void(0);">长沙理工大学</a> <a
									href="javascript:void(0);">中南林业科技大学</a> <a
									href="javascript:void(0);">长沙学院</a>
							</div>
							<input type="hidden" name="" value="">
						</div>
					</label>
					<div class="clear"></div>
				</div>
				<div class="radius">
					<div class="databox">
						<h3 class="datahead">期刊关键词</h3>
						<div class="databody">
							图标内容
							<div class="echart" id="echart" style="height: 400px"></div>
						</div>
					</div>
				</div>
				<div class="radius">
					<div class="databox">
						<h3 class="datahead">文章关键词</h3>
						<div class="databody">图标内容</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../foot.jsp"></jsp:include>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    // 路径配置
    require.config({
        paths: {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });
    var myChart;
    require([
             'echarts',
             'echarts/chart/tree', // 使用柱状图就加载bar模块，按需加载
         ],
        function(ec){
		myChart = ec.init(document.getElementById('echart')); 
		option = {
			    title : {
			        text: '冰桶挑战'
			    },
			   tooltip : {
			        trigger: 'item',
			        formatter: "{b}: {c}"
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    series : [
			        {
			            name:'树图',
			            type:'tree',
			            orient: 'horizontal',  // vertical horizontal
			            rootLocation: {x: 100,y: 230}, // 根节点位置  {x: 100, y: 'center'}
			            nodePadding: 8,
			            layerPadding: 200,
			            hoverable: false,
			            roam: true,
			            symbolSize: 10,
			            itemStyle: {
			                normal: {
			                    color: '#4883b4',
			                    label: {
			                        show: true,
			                        position: 'right',
			                        formatter: "{b}",
			                        textStyle: {
			                            color: '#000',
			                            fontSize: 10
			                        }
			                    },
			                    lineStyle: {
			                        color: '#ccc',
			                        type: 'curve' // 'curve'|'broken'|'solid'|'dotted'|'dashed'

			                    }
			                },
			                emphasis: {
			                    color: '#4883b4',
			                    label: {
			                        show: true
			                    },
			                    borderWidth: 10
			                }
			            },
			            
			            data: 
			                ${js}
			                
			        }
			    ]
		};
		myChart.setOption(option);
    	})
    
	</script>
</body>
</html>
