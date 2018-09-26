var defaultColor = ["#5d8ecf","#ec6359","#8d96d5","#01b1ae","#b7986a","#02b194","#543723","#ea5e79","#028380","#9a6a6b","#ea575f","#904a3b","#5d7c48","#d17d51","#2b5cab","#3588b2","#49a8c9","#6d4937","#607b87","#4d4f38","#515556","#2b5cab","#369558","#266b3f","#788e47","#7c7c54","#7e694a","#ab6b45","#528982","#82695e","#4d7f5c","#865541","#476c96","#7e9350","#8ba038","#b65334","#d24581","#624f8c","#42241a","#a92624","#882c68","#1d1a67","#1c4356","#5d723c","#c35b3c","#ce4568","#2b869c","#1b5982","#187358","#387526"];//关系图数据框架
var graphOption = {
	title : {
		text : ''
	},
	tooltip : { //提示框组件。
		show : true, //是否显示提示框组件，包括提示框浮层和 axisPointer。
		trigger : 'item', //触发类型。'item'数据项图形触发，主要在散点图，饼图等无类目轴的图表中使用,'axis'坐标轴触发，主要在柱状图，折线图等会使用类目轴的图表中使用,'none'不触发
		alwaysShowContent : false, //是否永远显示提示框内容
		triggerOn : 'mousemove|click', //提示框触发的条件
		showDelay : 0, //浮层显示的延迟，单位为 ms，默认没有延迟，也不建议设置。在 triggerOn 为 'mousemove' 时有效。
		hideDelay : 100, //浮层隐藏的延迟，单位为 ms，在 alwaysShowContent 为 true 的时候无效。
		enterable : false, //鼠标是否可进入提示框浮层中，默认为false，如需详情内交互，如添加链接，按钮，可设置为 true
		confine : false, //是否将 tooltip 框限制在图表的区域内。当图表外层的 dom 被设置为 'overflow: hidden'，或者移动端窄屏，导致 tooltip 超出外界被截断时，此配置比较有用。
		transitionDuration : 0.4 //提示框浮层的移动动画过渡时间，单位是 s
		//formatter : '{b}:{c}'
	},
	toolbox : { //工具栏。内置有导出图片，数据视图，动态类型切换，数据区域缩放，重置五个工具。
		show : true, //是否显示工具栏组件。
		orient : 'horizontal', //工具栏 icon 的布局朝向。
		itemSize : 20, //工具栏 icon 的大小。
		itemGap : 15, //工具栏 icon 每项之间的间隔。横向布局时为水平间隔，纵向布局时为纵向间隔。
		showTitle : true, //是否在鼠标 hover 的时候显示每个工具 icon 的标题
		//left : 'right', //工具栏组件离容器左侧的距离。
		top : 'auto', //工具栏组件离容器上侧的距离。
		right : '1.5%', //工具栏组件离容器右侧的距离。
		bottom : 'auto', //工具栏组件离容器下侧的距离。
		width : 'auto', //工具栏组件的宽度。默认自适应。
		height : 'auto', //工具栏组件的高度。默认自适应。
		iconStyle:{
			emphasis:{
				color:"#0698ff"
			}
		},
		feature : {
			restore : {}	//重置工具
		}
	},
//	visualMap:[{
//		show:false,
//		min:1,
//		max:10,
//		inRange:{
//			width:[1,10]
//		}
//	}],
	animationDurationUpdate : function(idx) { //数据更新动画的时长。1000ms或回调函数
		// 越往后的数据延迟越大
		return idx * 100;
	},
	animationEasingUpdate : 'quinticInOut', //数据更新动画的缓动效果。
	series : [ {
		type : 'graph',
		name : '', //系列名称
		legendHoverLink : true, //是否启用图例 hover 时的联动高亮。
		coordinateSystem : null, //该系列使用的坐标系,null,'cartesian2d','polar','geo'
		hoverAnimation : true, //是否开启鼠标 hover 节点的提示动画效果
		layout : 'none', //图的布局'none','circular','force'
		symbol : 'circle', //ECharts 提供的标记类型包括 'circle', 'rect', 'roundRect', 'triangle', 'diamond', 'pin', 'arrow'
		symbolSize : 10,	//关系图节点标记的大小，可以设置成诸如 10 这样单一的数字，也可以用数组分开表示宽和高，例如 [20, 10] 表示标记宽为20，高为10。支持回调函数。
		symbolRotate : 180, //关系图节点标记的旋转角度
		edgeSymbol : [ 'none', 'none' ], //边两端的标记类型，可以是一个数组分别指定两端，也可以是单个统一指定。默认不显示标记，常见的可以设置为箭头，如下：edgeSymbol: ['circle', 'arrow']
		edgeSymbolSize : 10,	//边两端的标记大小，可以是一个数组分别指定两端，也可以是单个统一指定。
		itemStyle : {		//图形样式，有 normal 和 emphasis 两个状态。normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
			normal : {},	//普通样式
			emphasis :{}	//高亮样式
		},
		lineStyle : { //关系边的公用线条样式。其中 lineStyle.normal.color 支持设置为'source'或者'target'特殊值，此时边会自动取源节点或目标节点的颜色作为自己的颜色。
			normal : { //普通样式
				//width : 2,
				curveness : 0.2,	//边的曲度，支持从 0 到 1 的值，值越大曲度越大。
				//opacity : 0.8,	//图形透明度，1为不透明
				color : "source"
			},
			emphasis :{}	//高亮样式
		},
		label : { //图形上的文本标签
			normal : {
				position : 'right',
				show : true//,
				//formatter : '{b} : {c}'
			},
			emphasis : {
				position : 'right',
				show : true//,
				//formatter : '{b} : {c}'
			}
		},
		left : '10%',
		right : '10%',
		top : '20%',
		bottom : '20%',
		roam : false, //是否开启鼠标缩放和平移漫游
		focusNodeAdjacency : true, //是否在鼠标移到节点上的时候突出显示节点以及节点的边和邻接节点。
		nodes : [],
		edges : []
	} ]
};

//折线图数据框架
var lineOption = {
	title : {
		text : ''
	},
	tooltip : {
		trigger : 'axis',
		enterable: false,
		axisPointer : {
			type : 'line',
			snap:true,
			label : {
				show:true,
				backgroundColor : '#6a7985'
			},
			lineStyle:{
				opacity: 0.5,
				width: 1
			},
			shadowStyle:{
				shadowBlur:5
			}
		},
		//confine:true,
		formatter: function(params){
			var result = '<p>'+params[0].axisValue + '</p>';
			for(var i=params.length-1;i>=0;i--) {
		        result += '<p style="line-height:14px"><span style="display:inline-block;margin-right:3px;border-radius:3px;width:7px;height:7px;background-color:' + params[i].color + '"></span>'+params[i].seriesName+" : "+params[i].value+'</p>';
		    };
		    return result;
		},
		textStyle:{
			fontSize:13
		},
		position:function (pos, params, dom, rect, size) {
	        // 鼠标在左侧时 tooltip 显示到右侧，鼠标在右侧时 tooltip 显示到左侧。
	        var obj = {};
	        if(pos[0] < size.viewSize[0]-size.contentSize[0]){
	    	    obj['left'] = pos[0]+5;
	        }else if(pos[0] > size.viewSize[0]-size.contentSize[0]){
	       	    obj['left'] = pos[0]-size.contentSize[0]-5;
	        }
	        // 鼠标在下面时 tooltip 显示到上侧，鼠标在上侧时 tooltip 显示到下侧。
	        if(pos[1] > size.viewSize[1] / 2){
	    	    obj['bottom'] = size.viewSize[1]-pos[1];
	        }else if(pos[1] < size.viewSize[1] / 2){
	    	    obj['top'] = 60;
	        }
	        return obj;
	    }
	},
	legend : {
		formatter : function(name) {
			return echarts.format.truncateText(name, 60,
					'14px Microsoft Yahei', '…');
		},
		tooltip : {
			show : true
		},
		//inactiveColor:"#E82400",
		width : "90%",
		right : "center",
		selectedMode : 'multiple',
		bottom : 10,
		data : []	//图例数据
	},
	toolbox : {
		show : true,
		iconStyle:{
			emphasis:{
				color:"#0698ff"
			}
		},
		itemSize:20,
		itemGap:16,
		left:25,
		feature : {
			magicType : {
				show : true,
				type : [ 'line', 'bar', 'stack', 'tiled' ]	//线图，柱图，堆叠图和平铺切换
			},
			dataView : { //表格数据视图
				readOnly : true, //表格数据只读
				optionToContent : function(opt) {
					return tableView(opt); //调用动态生成表格数据的方法
				}
			},
			restore : {}//重置按钮
		}
	},
	color:defaultColor,
	grid : {
		show:true,
		containLabel:true,
		left : '2%',
		right : '2%',
		bottom : '15%',
		containLabel : true
	},
	xAxis : {
		type : 'category',
		boundaryGap : false,
		axisLine:{
			lineStyle:{
				color:'#4488BB',
				width:2
			}
		},
		axisLabel:{
			textStyle:{
				color:'#000'
			}
		},
		data : [ '2012', '2013', '2014', '2015', '2016' ]
	
	},
	yAxis : {
		type : 'value',
		axisLine:{
			lineStyle:{
				color:'#4488BB',
				width:2
			}
		},
		axisLabel:{
			textStyle:{
				color:'#000'
			}
		}
	},
	series : []
};

//数据视图表格
function tableView(opt) {
	var axisData = opt.xAxis[0].data;
	var series = opt.series;
	var table = '<table style="width:100%;text-align:center"><tbody><tr>'
			+ '<th>关键字</th>' + '<th>' + axisData[0] + '年</th>' + '<th>'
			+ axisData[1] + '年</th>' + '<th>' + axisData[2] + '年</th>' + '<th>'
			+ axisData[3] + '年</th>' + '<th>' + axisData[4] + '年</th>'
			+ '<th>总次数 </th>' + '</tr>';
	for (var i = 0, l = series.length; i < l; i++) {
		table += '<tr>'
				+ '<td>'
				+ series[i].name
				+ '</td>'
				+ '<td>'
				+ series[i].data[0]
				+ '</td>'
				+ '<td>'
				+ series[i].data[1]
				+ '</td>'
				+ '<td>'
				+ series[i].data[2]
				+ '</td>'
				+ '<td>'
				+ series[i].data[3]
				+ '</td>'
				+ '<td>'
				+ series[i].data[4]
				+ '</td>'
				+ '<td>'
				+ (series[i].data[0] + series[i].data[1] + series[i].data[2]
						+ series[i].data[3] + series[i].data[4]) + '</td>'
				+ '</tr>';
	}
	table += '</tbody></table>';
	return table;
}


var ztfwzqsOption={
		title: {
	        text: '主题发文总趋势'
	    },
	    tooltip : {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'cross',
	            label: {
	                backgroundColor: '#6a7985'
	            },
	            animation: false
	        }
	    },
	    legend: {
	        tooltip: {
	            show: true
	        },
	        left:"right",
	        top: 10,
	        data:[]
	    },
	    grid: {
	        left: '10%',
	        right: '10%',
	        top: '15%',
	        containLabel: true
	    },
	    xAxis : {
            type : 'category',
            boundaryGap : true,
            data : ['2012','2013','2014','2015','2016']
        },
	    yAxis : {
            type : 'value'
        },
	    series : []	
};


var fwqkOption={
		title: {
	        text: ''
	    },
	    tooltip : {
	    	show: true,
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        },
	        formatter:function(params){
	        	var name = params[0].name;
	        	var value = params[0].value;
	        	return name.substring(0,name.indexOf("["))+":"+value;
	        }
	    },
	    grid: {
	        left: '10%',
	        right: '10%',
	        top: '10%',
	        bottom: '30%',
	        containLabel: true
	    },
	    xAxis : {
            type : 'category',
            boundaryGap : true,
            data : [],
            triggerEvent:true,
            axisLabel:{
            	interval:0,
            	rotate:45,
            	formatter:function(value, index){
            		value = value.substring(0,value.indexOf("["));
            		return echarts.format.truncateText(value, 160,
        					'14px Microsoft Yahei', '…');
            	}
            },
            axisTick:{
            	length:5,
            	alignWithLabel:true
            }
        },
	    yAxis : {
            type : 'value'
        },
	    series : []
};



//===================================================================//
/*
// startColor：开始颜色hex
// endColor：结束颜色hex
// step:几个阶级（几步）
*/
function gradientColor(startColor,endColor,step){
   startRGB = colorToRgb(startColor);//转换为rgb数组模式
   startR = startRGB[0];
   startG = startRGB[1];
   startB = startRGB[2];

   endRGB = colorToRgb(endColor);
   endR = endRGB[0];
   endG = endRGB[1];
   endB = endRGB[2];

   sR = (endR-startR)/step;//总差值
   sG = (endG-startG)/step;
   sB = (endB-startB)/step;

   var colorArr = [];
   for(var i=0;i<step;i++){
       //计算每一步的hex值
       var hex = colorToHex('rgb('+parseInt((sR*i+startR))+','+parseInt((sG*i+startG))+','+parseInt((sB*i+startB))+')');
       colorArr.push(hex);
   }
   return colorArr;
}

// 将hex表示方式转换为rgb表示方式(这里返回rgb数组模式)
function colorToRgb(sColor){
   var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
   var sColor = sColor.toLowerCase();
   if(sColor && reg.test(sColor)){
       if(sColor.length === 4){
           var sColorNew = "#";
           for(var i=1; i<4; i+=1){
               sColorNew += sColor.slice(i,i+1).concat(sColor.slice(i,i+1));
           }
           sColor = sColorNew;
       }
       //处理六位的颜色值
       var sColorChange = [];
       for(var i=1; i<7; i+=2){
           sColorChange.push(parseInt("0x"+sColor.slice(i,i+2)));
       }
       return sColorChange;
   }else{
       return sColor;
   }
};

// 将rgb表示方式转换为hex表示方式
function colorToHex(rgb){
   var _this = rgb;
   var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
   if(/^(rgb|RGB)/.test(_this)){
       var aColor = _this.replace(/(?:\(|\)|rgb|RGB)*/g,"").split(",");
       var strHex = "#";
       for(var i=0; i<aColor.length; i++){
           var hex = Number(aColor[i]).toString(16);
           hex = hex<10 ? 0+''+hex :hex;// 保证每个rgb的值为2位
           if(hex === "0"){
               hex += hex;
           }
           strHex += hex;
       }
       if(strHex.length !== 7){
           strHex = _this;
       }
       
       return strHex;
   }else if(reg.test(_this)){
       var aNum = _this.replace(/#/,"").split("");
       if(aNum.length === 6){
           return _this;
       }else if(aNum.length === 3){
           var numHex = "#";
           for(var i=0; i<aNum.length; i+=1){
               numHex += (aNum[i]+aNum[i]);
           }
           return numHex;
       }
   }else{
       return _this;
   }
}


var detailOption = {
        tooltip : {
        	trigger : 'axis',
    		enterable: false,
    		axisPointer : {
    			type : 'line',
    			snap:true,
    			label : {
    				show:true,
    				backgroundColor : '#6a7985'
    			},
    			lineStyle:{
    				color:'#4488BB',
    				width: 2
    			},
    			shadowStyle:{
    				shadowBlur:5
    			}
    		}		
        },
        legend: {
        	top: '18px',
        	data:['影响因子']
        },
        xAxis : [
        	{
            	type : 'category',
                data : [],
                axisLine:{
        			lineStyle:{
        				color:'#4488BB',
        				width:2
        			}
        		},
        		axisLabel:{
        			textStyle:{
        				color:'#000'
        			}
        		},
        		splitLine:{  
                    show: true
                }
            }
        ],
        yAxis : [
         	{
         		splitNumber:4,
            	type : 'value',
                axisLine:{
        			lineStyle:{
        				color:'#4488BB',
        				width:2
        			}
        		},
        		axisLabel:{
        			textStyle:{
        				color:'#000'
        			}
        		},
        		splitLine:{  
                    show: true
                }
            }
        ],
        series : [
          	{
            	name:"影响因子",
                type:"line",
                data: "${item.value.zkyNewDate}",
                lineStyle:{normal:{color:"#FF7F50"}},
                itemStyle:{normal:{color:"#FF7F50"}}
            }
        ]
    };
