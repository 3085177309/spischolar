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
/***获取class****/
function getByClass2(oparent,oclass){
    try{
        return oparent.querySelectorAll("."+oclass);
    }catch (ex){
            var reset = [];
            var reg = new RegExp("\\b" + oclass + "\\b");
            var oCur = oparent.all;
            for (var i = 0; i < oCur.length; i++) {
                if (reg.test(oCur[i].className)) {
                    reset.push(oCur[i]);
                }
            };
          return reset;
    }
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
function getViewport(){if(window.innerHeight)return {width:window.innerWidth,height:window.innerHeight};if(doc.compatMode == 'BackCompat')return {width:doc.body.clientWidth,height:doc.body.clientHeight};return {width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)};}


function css(obj, attr, value)
{
	switch (arguments.length)
	{
		case 2:
			if(typeof arguments[1] == "object")
			{
				for (var i in attr) i == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + attr[i] + ")", obj.style[i] = attr[i] / 100) : obj.style[i] = attr[i];
			}
			else
			{	
			    if(attr == "opacity"){return obj.currentStyle ? obj.currentStyle[attr]*100 : getComputedStyle(obj, null)[attr]*100}
				else{return obj.currentStyle ? obj.currentStyle[attr] : getComputedStyle(obj, null)[attr]}
			}
			break;
		case 3:
			attr == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + value + ")", obj.style[attr] = value / 100) : obj.style[attr] = value;
			break;
	}
};

function animate(obj, sStyleName, nNedV, time, fn){
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
//-----------------------------------------------------------------------------------------------




/////////////////////////////////////////////////页面最小高度

addLoadEvent(function(){setMinH('contentH',60)});
addLoadEvent(function(){setMinH('start_wk',0)});
//window.onresize=function(){setMinH('containerH',150+90+12*2)}
function setMinH(eleId,H){
	if(!doc.getElementById(eleId)){return false;}
	var ele=doc.getElementById(eleId)
    if(!-[1,]&&!window.XMLHttpRequest){//ie6
		ele.style.height=getViewport().height-H+'px';
	}else{ele.style.minHeight=getViewport().height-H+'px';}//header footer left的padding
}

addLoadEvent(function(){
	var otj=document.getElementById('tj_con'),
		ocH=document.getElementById('contentH'); 
		
		if(otj){
			var oheight=ocH.style.minHeight;
			otj.style.height=parseInt(oheight)-75+"px";}
    else{return false}
   
		

	})
addLoadEvent(function (){

	var otj=doc.getElementById('start_conter'),
		ocH=doc.getElementById('start_wk'); 
		
		if(otj){
			var oheight=ocH.style.minHeight;
			otj.style.height=parseInt(oheight)+"px";}
    
   	

	})

//下拉
show_list = function (btn){
	var LB=getNextSibling(btn),
	    parentEle=btn.parentNode;
		
		
		
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
	if(hiddenId)doc.getElementById(hiddenId).value=btn.getAttribute('v');
	doc.getElementById(textId).firstChild.nodeValue=btn.firstChild.nodeValue;
}

/***登陆弹窗****/
 // var oclassn=getByClass(document.body,"Account")[0].className;
 pat=new show(false,"Account");
 function op(){
     if(!getByClass2(document.body,"p1")[0]){return false;}
     var ops=getByClass2(document.body,"p1");
     for (var i = 0; i < ops.length; i++) {
         ops[i].onclick=function(){
             pat.animati();

         }
     };
 }
op();
function show(Bstops,win){
    if(Bstops||!document.getElementById(win)){return false;}
    var _this=this;
        this.Winbj=getByClass2(document.body,win)[0];
        this.showins=this.Winbj.parentNode;
        this.iclose=this.Winbj.getElementsByTagName("i")[0];
        this.oclose=(!getByClass2(this.Winbj,"close")[0])?(this.Winbj.getElementsByTagName("i")[0]):(getByClass2(this.Winbj,"close")[0]);
       // this.Agent=navigator.userAgent;
        if(win=="Account"){
          this.opclass="Win_bj Account";
        }else{
          this.opclass=this.Winbj.className;
        }
        //alert(this.Winbj.className);
     if(!-[1,]&&!window.XMLHttpRequest){
        this.showins.style.height=document.documentElement.clientHeight+"px";
     }  
    // document.getElementById(obj).onclick=function(){
    //            _this.animati();
    //           // alert(_this.Winbj);
    //      };

    this.iclose.onclick=function(){_this.out()};
    this.oclose.onclick=function(){_this.out()};
 } 
 show.prototype.out=function(){
    var _this=this;
       _this.swtime(0);
         return false;
 } 
 show.prototype.swtime=function(time){
   var _this=this;
   timers=setTimeout(function(){
           _this.Winbj.style.display="none";
           _this.showins.style.display="none";
    }, time);
   return false;
 }
show.prototype.animati=function(){
    var _this=this;
    _this.showins.style.display="block";
    _this.Winbj.style.display="block";
    return false;
 }
window.show=show;
})();