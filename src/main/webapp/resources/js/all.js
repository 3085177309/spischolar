// JavaScript Document

(function(){
	
var doc=document;

addLoadEvent = function(func){var oldonload=window.onload;if (typeof window.onload !='function'){window.onload=func;}else{window.onload=function(){oldonload();func();}}}
  
//删除这个class
function removeClass(ele,cls) {if(hasClass(ele,cls)){var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');ele.className=ele.className.replace(reg,' ');}} 
//添加class
function addClass(ele,cls) {if(!hasClass(ele,cls)) ele.className += " "+cls;}
//通过class获取元素
function getByClass(classname,ele){
if(typeof ele == 'string'){ele=doc.getElementById(ele)}
var nodes = ele ? ele.getElementsByTagName('*') : doc.getElementsByTagName('*'), 
ret=[];
for(var i=0;i<nodes.length;i++){
if(hasClass(nodes[i],classname)){ret.push(nodes[i]);}
} 
return ret; 
}
//判断是否有这个class
function hasClass(node,className){ 
var names = node.className.split(/\s+/); 
for(var i=0;i<names.length;i++){ 
if(names[i]==className) 
return true; 
}return false; 
} 
//下一个兄弟元素
function getNextSibling(startBrother){endBrother=startBrother.nextSibling;while(endBrother.nodeType!=1){endBrother = endBrother.nextSibling;}return endBrother;}

function isMouseLeaveOrEnter(e,handler,eleName) {if (e.type != 'mouseout' && e.type != 'mouseover') return false;var reltg = e.relatedTarget ? e.relatedTarget : e.type == 'mouseout' ? e.toElement : e.fromElement;while (reltg && reltg != handler && reltg.nodeName!=eleName)reltg = reltg.parentNode;return (reltg != handler);}  
function getDocSize(){
   if(doc.compatMode == 'BackCompat')//BackCompat和CSS1Compat
   return {width:Math.max(doc.body.clientWidth,doc.body.scrollWidth),
           height:Math.max(doc.body.clientHeight,doc.body.scrollHeight)
	   };
   //opare9.0在有滚条时 client 和scroll都是文档高度  没滚条时client为文档高度 scroll为可视区高度 和其他浏览器相反  
   return {width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),
           height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)
	   };
}
function getCoords(el){
  var box = el.getBoundingClientRect(),
  doc = el.ownerDocument,
  body = doc.body,
  html = doc.documentElement,
  clientTop = html.clientTop || body.clientTop || 0,
  clientLeft = html.clientLeft || body.clientLeft || 0,
  top  =Math.floor( box.top  + (self.pageYOffset || html.scrollTop  ||  body.scrollTop ) - clientTop ),
  left =Math.floor( box.left + (self.pageXOffset || html.scrollLeft ||  body.scrollLeft) - clientLeft )
  return { 'top': top, 'left': left };
}
//-----------------------------------------------------------------------------------------------
getViewport = function(){if(window.innerHeight)return {width:window.innerWidth,height:window.innerHeight};if(doc.compatMode == 'BackCompat')return {width:doc.body.clientWidth,height:doc.body.clientHeight};return {width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)};}


css = function(obj, attr, value)
{
	switch (arguments.length)
	{
		case 2:
			if(typeof arguments[1] == "object")
			{
				for (var i in attr) i == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + attr[i] + ")", obj.style[i] = attr[i] / 100) : obj.style[i] = attr[i];
			}else{	//currentStyle ie  getComputedStyle ff 单位始终是 px
			    if(attr == "opacity"){return obj.currentStyle ? obj.currentStyle[attr]*100 : getComputedStyle(obj, null)[attr]*100}
				else{
					return obj.currentStyle ? (function(){
					   //ie下在获取宽高时 是否为auto
					   var v = obj.currentStyle[attr];
					   if(attr.toUpperCase()=='WIDTH' && v=='auto'){
						   var lefBor = parseFloat(obj.currentStyle['borderLeftWidth']),
						       rigBor = parseFloat(obj.currentStyle['borderRightWidth']),
							   borW = lefBor ? lefBor : 0 + rigBor ? rigBor : 0;
					       return v = obj.offsetWidth - parseFloat(obj.currentStyle['paddingLeft']) - parseFloat(obj.currentStyle['paddingRight']) - borW;
					   }
					   else if(attr.toUpperCase()=='HEIGHT' && v=='auto'){
					       var topBor = parseFloat(obj.currentStyle['borderTopWidth']),
						       botBor = parseFloat(obj.currentStyle['borderBottomWidth']),
							   borH = topBor ? topBor : 0 + botBor ? botBor : 0;
					       return  v = obj.offsetHeight - parseFloat(obj.currentStyle['paddingTop']) - parseFloat(obj.currentStyle['paddingBottom']) - borH;
					   }else{return v;}
					})() :  getComputedStyle(obj, null)[attr];
				}
			}
			break;
		case 3:
			attr == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + value + ")", obj.style[attr] = value / 100) : obj.style[attr] = value;
			break;
	}
};

animate = function(obj, sStyleName, nNedV, time, fn){
	var nStartTime = + new Date(),
	    nStartV = parseFloat(css(obj, sStyleName)),
	    sUnit = sStyleName == 'opacity' ? '' : 'px',
        nDistance = nStartV - nNedV;
		
		function easeInOutCubic(pos){
          if ((pos/=0.5) < 1) return 0.5*Math.pow(pos,3);
          return 0.5 * (Math.pow((pos-2),3) + 2);
        }
		
	 if(obj['_' + sStyleName]){clearInterval(obj['_'+sStyleName])};
	 
     obj['_'+sStyleName] = setInterval(function (){
		   var nFraction = easeInOutCubic((+new Date() - nStartTime) / time), 
		       thisV = nStartV - nDistance * nFraction,
		       oCss = {};
		   if(nFraction < 1){
			   oCss[sStyleName] = (thisV) + sUnit;
			   css(obj, oCss);
		   }else if(nFraction > 1){
			   oCss[sStyleName] = (nNedV) + sUnit;
			   css(obj, oCss);
			   if(fn) fn();
			   clearInterval(obj['_' + sStyleName]);
			   obj = null;
		   }
    }, 20);
}    



/////////////////////////////////////////////////index 无缝滚动  
addLoadEvent(function(){
  if(doc.getElementById('picShow_1')){
	 // picShow(doc.getElementById('picShow_1'),6,114,true,true)
  }
  
  if(doc.getElementById('picShow_2')){
	 // setTimeout(function(){ picShow(doc.getElementById('picShow_2'),6,114,true,true) },2000)
  }

});

/*
box    盒子
num    显示几个li
liw    li盒子所占宽度 包括外边距
bAuto  可选 是否自动轮播
b      可选 设置true时 bAuto的值应该为true 鼠标经过ul时是否关闭轮播
*/
picShow = function(box,num,liW,bAuto,b){
	var ul=box.getElementsByTagName('ul')[0],
	    btnL=box.getElementsByTagName('a')[0],
		btnR=box.getElementsByTagName('a')[1],
		allLi=ul.getElementsByTagName('li'),
		minLeft=-(allLi.length)*liW,
		maxLeft=-(num-1)*liW,
		bBtn=false,//当动画运行时 点击事件无效
		addLi='';
	
		if(allLi.length<=num){//alert(0)
			btnL.onclick = btnR.onclick = function(){return false}; 
			return false;
		}
		var k=0;
		for(var i=0;i<2*num-1;i++){
			if(k>=allLi.length){k=0}
		    addLi+='<li>'+allLi[k].innerHTML+'</li>';
			k++;
		}
		ul.innerHTML+=addLi;
		
	btnL.onclick=btnR.onclick=function(){clickFun(this,num);return false;};
		
	if(bAuto&&b){
		 ul.onmouseover=function(){bAuto=false}
	     ul.onmouseout =function(){bAuto=true}
	}
	if(bAuto){
		 setTimeout(cycle,4000);
		 //如果是自动轮播 当鼠标经过两边按钮时关闭自动轮播
		 btnL.onmouseover=btnR.onmouseover=function(){bAuto=false}
	     btnL.onmouseout =btnR.onmouseout =function(){bAuto=true}
	}
	function cycle(){
	  if(!bAuto){setTimeout(cycle,3000);return false;}
	  clickFun(btnR,1);
	  setTimeout(cycle,3000);
    }
	function clickFun(ele,goNum){
		if(minLeft>=0){//alert(0)
		}
		if(minLeft>=0||bBtn){return false;}//这里应该写在注册事件前面的 但是为了兼容ie6的hover a要给# 所以在不需要滚动的时候 a按钮也要false一下
		bBtn=true;
	    var nLeftV=parseFloat(css(ul,'left'));
		//alert(css(ul,'left'))
		if(ele.className=='L'){
			
			if(nLeftV>=maxLeft){
				nLeftV+=minLeft;
				css(ul,'left',nLeftV+'px');
			}
			nLeftV+=goNum*liW;
		}
		else if(ele.className=='R'){
			if(nLeftV<=minLeft){
				nLeftV-=minLeft;
				css(ul,'left',nLeftV+'px');
			}
			nLeftV-=goNum*liW;
		}
		animate(ul,'left',nLeftV,800,function(){bBtn=false});
	
	}
};




addLoadEvent(function(){

	
/*	doc.onclick = function(){
	    search_.style.display='none';
	}
	search_.onclick = function(e){
		e = e||window.event;
	    if(e.stopPropagation){e.stopPropagation();}
		else{e.cancelBubble=true;}
	}
	btn.onclick = function(e){
		e = e||window.event;
	    search_.style.display='block';
		if(e.stopPropagation){e.stopPropagation();}
		else{e.cancelBubble=true;}
	}*/
	
});

/////////////////////////////////////////////////页面最小高度

addLoadEvent(setMinH);
//window.onresize=function(){setMinH('containerH',150+90+12*2)}
function setMinH(){
	var minH = doc.getElementById('minH'),
	    H = minH.getAttribute('minH');
		
	if(!minH && !H){return false;}
    if(!-[1,]&&!window.XMLHttpRequest){//ie6
	    minH.style.height='auto';
		minH.style.height=getViewport().height-H+'px';
	}else{minH.style.minHeight=getViewport().height-H+'px';}//header footer left的padding
}


/*置顶*/
addLoadEvent(goScrollTop);
function goScrollTop(){
	    var doc=document;
        var obj=doc.getElementById("toTop");
			
        function getScrollTop(){
			    return doc.documentElement.scrollTop || window.pageYOffset || doc.body.scrollTop;
            }
        function setScrollTop(value){
                var explorer = window.navigator.userAgent ;
                 switch (true){
                     case explorer.indexOf("Chrome") >= 0:
                     doc.body.scrollTop=value;
                     break;
                case explorer.indexOf("Safari") >= 0:
                     window.pageYOffset=value ;
                     break;
                default:
                     doc.documentElement.scrollTop=value;
                }
        }
		if(getScrollTop()>60)obj.style.display="block";
        window.onscroll=function(){
			var top = getScrollTop(),
			    fixedNode1 = doc.getElementById('fixed_menu'),//用户指南页面
				fixedNode2 = doc.getElementById('goto_fixed');//浏览页面
			top>60?obj.style.display="block":obj.style.display="none";
			if(fixedNode1){top>262?fixedNode1.style.position="fixed":fixedNode1.style.position="absolute";}
			if(fixedNode2){top>204?fixedNode2.className='goto_ goto_fixed':fixedNode2.className='goto_';}
			
			
			
		}
        obj.onclick=function(){
            var goTopM=setInterval(scrollMove,10);
            function scrollMove(){
                    setScrollTop(getScrollTop()/1.3);
                    if(getScrollTop()<1)clearInterval(goTopM);
                }
			return false;
        }
}
/*表格的伸展运动*/
addLoadEvent(function(){
    if(doc.getElementById('pj_table')){
		tableChildH(doc.getElementById('pj_table'));
	}
	if(doc.getElementById('sl_table')){
	    tableChildH(doc.getElementById('sl_table'));	
	}

});
function tableChildH(table){
		var parent = table.parentNode,
			allMore = getByClass('more',table),
			b = false;
		for(var i=allMore.length;i--;){
			var thisMore = allMore[i];
			thisMore.parentNode.getElementsByTagName('div')[0].style.height=thisMore.parentNode.getElementsByTagName('li')[0].offsetHeight+'px';
			thisMore.onclick=function(){f(this);return false;};
		}
		function f(btn){
			    if(b){return false}
			    b = true;
				var box = btn.parentNode.getElementsByTagName('div')[0];
				    boxH = box.offsetHeight,
				    ulH = box.getElementsByTagName('ol')[0].offsetHeight;
			    if(btn.getAttribute('open')=='no'){
					if(parent.className==='boxHide')animate(parent,'height',parent.offsetHeight+ulH-boxH,800);
			        animate(box,'height',ulH,800,function(){b=false});
			        btn.setAttribute('open','yes');
			        btn.firstChild.nodeValue = '收起';
			    }else{
					if(parent.className==='boxHide')animate(parent,'height',parent.offsetHeight-ulH+box.getElementsByTagName('li')[0].offsetHeight,800);
			        animate(box,'height',box.getElementsByTagName('li')[0].offsetHeight,800,function(){b=false});
			        btn.setAttribute('open','no');
					btn.firstChild.nodeValue = '更多';
			    }
		}	
}

tableH = function(table,btn,num){
    var parent = table.parentNode,
	    allTr = table.getElementsByTagName('tr'),
		minH = 0,
		b = false;
    if(num>allTr.length)num=allTr.length;
    for(var i=0;i<num;i++){
        minH += allTr[i].offsetHeight;
    }

	parent.style.height = minH + 'px';
	btn.onclick=function(){
		if(b){return false}
		b = true;
		if(this.getAttribute('open')=='no'){
			animate(parent,'height',table.offsetHeight,800,function(){b=false});
			this.setAttribute('open','yes');
			addClass(this,'btn_close');
		}else{
			minH = 0;
			for(var i=0;i<num;i++){
			    minH += allTr[i].offsetHeight;
			}
		    animate(parent,'height',minH,800,function(){b=false});
			this.setAttribute('open','no');
			removeClass(this,'btn_close');
		}
	}	
}

//////////////////////////////////////////////// 
/*浏览首页 浮层*/
addLoadEvent(function(){llShowBox()});
llShowBox = function(){
   if(!doc.getElementById('ll_nr')){return false}
   var parent=doc.getElementById('ll_nr'),
       liEle=parent.getElementsByTagName('li');
   
   for(var i=0;i<liEle.length;i++){
	   var thisLi=liEle[i];
	   thisLi.onmouseover=function(e){
	      var e=e||window.event,fuEle;
		  var ele=e.target||e.srcElement;
		  
		  if (isMouseLeaveOrEnter(e,this,'LI')) {
		     var showBox=this.getElementsByTagName('div')[0];
			 if(!showBox){return false}
			 this.style.zIndex=3;
			 addClass(this,'Hover');
			 
			 
	      }
	   }
	   thisLi.onmouseout=function(e){
	      var e=e||window.event,fuEle;
		  var ele=e.target||e.srcElement;
		  
		  if (isMouseLeaveOrEnter(e,this,'LI')) {
		     var showBox=this.getElementsByTagName('div')[0];
			 if(!showBox){return false}
			 removeClass(this,'Hover');
			 this.style.zIndex=2;
	      }
	   }
   }
  
}




/*隔行变色*/
addLoadEvent(function(){
	var allTable=doc.getElementsByTagName('table');
	for(var i=allTable.length;i--;){
		if(allTable[i].getAttribute('RunJsBj')!='no'){rowBj(allTable[i],'tr',1,'#FAFAFA',1);}
	}
});
function rowBj(parentNode,nodeName,VerticalNum,color,p){

if(typeof parentNode == 'string'){parentNode=document.getElementById(parentNode);}
	
var allNode=parentNode.getElementsByTagName(nodeName);

var k=(allNode.length)/VerticalNum;
while(Math.floor(k)!=k){
	var newNode=document.createElement(nodeName);
	parentNode.appendChild(newNode);
	allNode=parentNode.getElementsByTagName(nodeName);
	k=(allNode.length)/VerticalNum;
	}

for (var i=0;i<allNode.length;i++){
	var hangshu=Math.floor((i+VerticalNum)/VerticalNum);
	var num=hangshu/2;
	if(p==2&&num==Math.floor(num)){allNode[i].style.background=color}
	else if(p==1&&num!=Math.floor(num)){allNode[i].style.background=color}
	else{allNode[i].style.background=''}
	}
	
}


show_list = function (btn){

	var LB=getNextSibling(btn),
	    parentEle=btn.parentNode;
		
		if(!-[1,]){//ie6
		LB.style.width=btn.offsetWidth+'px';
	    }else{LB.style.minWidth=btn.offsetWidth+'px';}
		
		LB.style.display='block';
		
	parentEle.onmouseout=function(e){
		var e=e||window.event,fuEle;
		var ele=e.target||e.srcElement;
				
		if (isMouseLeaveOrEnter(e,this,parentEle.nodeName)) {
		LB.style.display='none';
	    };		
	}
	return false;
}

index_js_setFl = function(btn,textId,hiddenId){
    
	doc.getElementById(hiddenId).value=btn.getAttribute('v');
	doc.getElementById(textId).firstChild.nodeValue=btn.firstChild.nodeValue;

}
search_lang = function(btn,hiddenId,inId){
	doc.getElementById(inId).id='';
	btn.id=inId;
	doc.getElementById(hiddenId).value=btn.getAttribute('v');

}


/*列表页 视图与表格的切换*/

addLoadEvent(function(){
  var selectEle = doc.getElementById('qk_LB_show');
  if(!selectEle){return false}
  var view = doc.getElementById('qk_LB_view'),
      table = doc.getElementById('qk_LB_table');
  selectEle.onchange = function(){
      if(this.value=='qk_LB_view'){
		  table.style.display = 'none';
		  view.style.display = 'block';
	  }else if(this.value=='qk_LB_table'){
	      view.style.display = 'none';
		  table.style.display = 'block';
	  }
	  if(!-[1,]&&!window.XMLHttpRequest){setMinH()}
  }
});

})();


