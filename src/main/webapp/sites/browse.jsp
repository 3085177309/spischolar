<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<script type="text/javascript"
	src="<cms:getProjectBasePath/>resources/js/jquery-1.8.3.min.js"></script>
<meta charset="utf-8">


<title>ECharts</title>
</head>
<body>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
	<div id="main" style="height: 400px"></div>
	<div id="aa" style="height: 400px"></div>
	<!-- ECharts单文件引入 -->
	<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
	<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
                'echarts/chart/bar'
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                	    title : {
                	        text: '未来一周气温变化',
                	        subtext: '纯属虚构'
                	    },
                	    tooltip : {
                	        trigger: 'axis'
                	    },
                	    legend: {
                	        data:['浏览量（PV）','访客数（UV）','IP数','平均访问时长']
                	    },
                	    toolbox: {
                	        show : true,
                	        feature : {
                	            mark : {show: true},
                	            dataView : {show: true, readOnly: false},
                	            magicType : {show: true, type: ['line', 'bar']},
                	            restore : {show: true},
                	            saveAsImage : {show: true}
                	        }
                	    },
                	    calculable : true,
                	    xAxis : [
                	        {
                	            type : 'category',
                	            boundaryGap : false,
                	            data : ['周一','周二','周三','周四','周五','周六','周日']
                	        }
                	    ],
                	    yAxis : [
                	        {
                	            type : 'value',
                	            axisLabel : {
                	                formatter: '{value} °C'
                	            }
                	        }
                	    ],
                	    series : [
                	        {
                	            name:'浏览量（PV）',
                	            type:'line',
                	            data:[110, 110, 150, 130, 120, 130, 100],
                	            markPoint : {
                	                data : [
                	                    {type : 'max', name: '最大值'},
                	                    {type : 'min', name: '最小值'}
                	                ]
                	            },
                	            markLine : {
                	                data : [
                	                    {type : 'average', name: '平均值'}
                	                ]
                	            }
                	        },
                	        {
                	            name:'访客数（UV）',
                	            type:'line',
                	            data:[10, 20, 25, 53, 37, 21, 30],
                	            markPoint : {
                	                data : [
                	                    {name : '周最低', value : -2, xAxis: 1, yAxis: -1.5}
                	                ]
                	            },
                	            markLine : {
                	                data : [
                	                    {type : 'average', name : '平均值'}
                	                ]
                	            }
                	        },
                	        {
                	            name:'IP数',
                	            type:'line',
                	            data:[10, 20, 25, 53, 40, 21, 35],
                	            markPoint : {
                	                data : [
                	                    {name : '周最低', value : -5, xAxis: 4, yAxis: 15}
                	                ]
                	            },
                	            markLine : {
                	                data : [
                	                    {type : 'average', name : '平均值'}
                	                ]
                	            }
                	        },
                	        {
                	            name:'平均访问时长',
                	            type:'line',
                	            data:[22, 50, 45, 71, 120, 101, 91],
                	            markPoint : {
                	                data : [
                	                    {name : '周最低', value : -2, xAxis: 1, yAxis: -1.5}
                	                ]
                	            },
                	            markLine : {
                	                data : [
                	                    {type : 'average', name : '平均值'}
                	                ]
                	            }
                	        }
                	    ]
                	};
                	                    
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>



	<script type="text/javascript">
    var myChart;
    require([
             'echarts',
             'echarts/chart/line', // 使用柱状图就加载bar模块，按需加载
             'echarts/chart/bar'
         ],function(ec){
		myChart = ec.init(document.getElementById('aa')); 
		var option = {
     	tooltip: {
     		trigger: 'axis'
         },
         legend: {
         	data:['','','','']
         },
         toolbox: {
 	        show : true,
 	        feature : {
 	            magicType : {show: true, type: ['line', 'bar']},
 	            restore : {show: true},
 	        }
 	    },
         calculable : true,
         xAxis : [
         	{
             	type : 'category',
             	boundaryGap : false,
             	data : ['1']
             },
         ],
         yAxis : [
          	{
             	type : 'value'
             }
         ],
         series : [
           	{
             	"name":"",
                 "type":"",
                 data:[0]
             },
             {
              	"name":"",
                  "type":"",
                  data:[0]
              },
              {
                	"name":"",
                    "type":"",
                    data:[0]
                },
                {
                  	"name":"",
                      "type":"",
                      data:[0]
                //yAxisIndex: 1,
                  },
         ],
         
     };
		myChart.setOption(option);
		department();
	});
  
    function department(){
    	var option = myChart.getOption();
		$.ajax({
			 type : "post",
			 url : '<cms:getProjectBasePath/>backend/flow/list',
//			 data : {school:school, dateType:"day"},
			 data : $('#inputForm').serialize(),
			 dataType : 'json',
			 success : function(data) {
				data = eval("("+data.message+")");
				
				date = data.dataList; 
				types = data.types;
				option.legend.data = types;
				option.xAxis[0].data = date;
				for(var i=0; i < types.length; i++) {
					var nums;
					if(types[i] == "pv") {
						nums = data.pv;
					} else if(types[i] == "uv") {
						nums = data.uv;
					} else if(types[i] == "ip") {
						nums = data.ip;
					} else if(types[i] == "avgTime") {
						nums = data.avgTime;
					}
					option.series[i].data = nums;
					option.series[i].type = "line";
					option.series[i].name = types[i];
				}

				myChart.hideLoading(); 
				myChart.setOption(option,true);
			 }
    	 });
 	}
    </script>

	<form id="inputForm">
		<select name="school" class="school" id="shcool">
			<option value="all" selected="selected">全部学校</option>
			<option value="纬度科技">纬度科技</option>
			<option value="中南大学">中南大学</option>
			<option value="湖南大学">湖南大学</option>
		</select> <input type="checkbox" value="1" name="time" class="time">今天
		<input type="checkbox" value="7" name="time" class="time"
			checked="checked">7天 <input type="checkbox" value="30"
			name="time" class="time">30天 <select name="type" class="type"
			id="type">
			<option value="-1" selected="selected">全部数据</option>
			<option value="0">原始数据</option>
			<option value="1">添加数据</option>
		</select>
	</form>

</body>
</html>