// JavaScript Document
(function(){  
var doc=document;

var addLoadEvent=(function(){var b=false;var c={fn:[],bReady:false,push:function(a){c.bind();if(c.bReady){a.call(document)}else{c.fn.push(a)}},ready:function(){var a,i=0,fns;c.bReady=true;fns=c.fn;while((a=fns[i++])){a.call(document)}fns=null},bind:function(){if(b)return;b=true;if(document.readyState==="complete"){return setTimeout(c.ready,0)}if(document.addEventListener){document.addEventListener("DOMContentLoaded",function(){document.removeEventListener("DOMContentLoaded",arguments.callee,false);c.ready()},false)}else{var a=false;try{a=window.frameElement==null}catch(e){}if(document.documentElement.doScroll&&a){(function(){try{document.documentElement.doScroll('left')}catch(e){return setTimeout(arguments.callee,0)}c.ready()})()}}}};return c.push})();


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
window.getByClass2=getByClass2;
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
function sibling( elem ) {
  var r = [];
  var n = elem.parentNode.firstChild;
  for ( ; n; n = n.nextSibling ) {
   if ( n.nodeType === 1 ) {
    r.push( n );
   }
  }
  return r;
 }
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
getViewport = function(){
	if(window.innerHeight){
		return {
			width:window.innerWidth,
			height:window.innerHeight
		}
	}
	if(doc.compatMode == 'BackCompat'){
		return {width:doc.body.clientWidth,height:doc.body.clientHeight}
	}
		
	return {
		width:Math.max(doc.documentElement.clientWidth,doc.documentElement.scrollWidth),
		height:Math.max(doc.documentElement.clientHeight,doc.documentElement.scrollHeight)
	}
}

function getScrollbarWidth() {
    var oP = document.createElement('p'),
        styles = {
            width: '100px',
            height: '100px',
            overflowY: 'scroll'
        }, i, scrollbarWidth;
    for (i in styles) oP.style[i] = styles[i];
    document.body.appendChild(oP);
    scrollbarWidth = oP.offsetWidth - oP.clientWidth;
    oP.style.display="none";
    if(oP.remove){
    	oP.remove()
    }else{
    	oP.removeNode();
    }
   
    return scrollbarWidth;
}


css = function(obj, attr, value)
{
    switch (arguments.length)
    {
        case 2:
            if(typeof arguments[1] == "object")
            {
                for (var i in attr) i == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + attr[i] + ")", obj.style[i] = attr[i] / 100) : obj.style[i] = attr[i];
            }else{  //currentStyle ie  getComputedStyle ff 单位始终是 px
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
/////////////////////////////////////////////////第一个子元素
function getFirstChild(startBrother){
  endBrother=startBrother.firstChild;
  while(endBrother.nodeType!=1){
    endBrother = endBrother.nextSibling;
  }
  return endBrother;
}
/////////////////////////////////////////////////首页页面最小高度

addLoadEvent(function(){
//  window.onresize=function(){
 //     setMinH("minH","67");
//      setMinH("qkminH","150");
//  }
  setMinH("minH","67");
  setMinH("qkminH","163");
  setMinH("qkH","230");
})

function setMinH(id,outHeight){
    var HeightId=id;
    var setHeight=outHeight;
    set()
    function set(){
        if(document.getElementById(HeightId)){ 
  	      var minHeight=document.getElementById(HeightId);
  	      //var h=(minHeight.currentStyle? minHeight.currentStyle : window.getComputedStyle(minHeight, null)).height;
  	      var h=minHeight.offsetHeight;
  	      if(parseInt(h)<getViewport().height/*-outHeight*/){
  	        minHeight.style.minHeight=getViewport().height-outHeight+"px";
  	        //minHeight.style.overflow="hidden"
  	      }else{
  	          return false
  	      }
        }
    } 
}

////////////////////////////////////////////////首页公告
addLoadEvent(affiche);
function affiche(){
    if(doc.getElementById('affiche')){
	  var list=doc.getElementById('affiche').getElementsByTagName('ul')[0],
	      num=list.getElementsByTagName('li').length,
	      mOut=true;
	  if(list.getElementsByTagName('li')[0]){;
		  var  H=list.getElementsByTagName('li')[0].offsetHeight;
		    
		  list.style.position='absolute';
		  list.style.left='0';
		  list.style.top='0';
		  if (num > 1){
		    setTimeout(cycle,3000); 
		  }else{
		    
		  }
	  }
	  list.onmouseover=function(){mOut=false}
	  list.onmouseout=function(){mOut=true}
	}
  function cycle(){
      if(list.Y){clearTimeout(this.Y);}
      //alert(list.Y)
    animate(list, 'top', -H, 1000);
    //alert("a");
    setTimeout(ting,3000);
    }
  function ting(){
    if(parseInt(list.style.top)==-H&&mOut==true){
    var thisList=getFirstChild(list),
        newList=doc.createElement('li');
    newList.innerHTML=thisList.innerHTML;
    list.appendChild(newList);
      
    list.removeChild(thisList);
    list.style.top='0';
    cycle();
    return false;
    }
    setTimeout(ting,200);
  }
  
}

//////////////////////////////////////全站导航下拉
addLoadEvent(userList);
function userList(){
    var obg=document.getElementById("user-name");
    if(!obg) return false;
    var thisDiv=obg.getElementsByTagName("div")[0];
        obg.onmouseover=function(e){
            var e=e||window.event;
            if (isMouseLeaveOrEnter(e,this,'div')) {
              thisDiv.style.display="block";    
            };         
        }
        obg.onmouseout=function(e){
            var e=e||window.event;
                //ele=e.target||e.srcElement;
                if (isMouseLeaveOrEnter(e,this,'div')) {
                  thisDiv.style.display="none"; 
                };
               
        }
}
addLoadEvent(seniorSearch);
function seniorSearch(){
  if(!document.getElementById("senior-search-btn")) return false;
  var senior=document.getElementById("senior-search-btn");
  var seniorBox=document.getElementById("senior-search");
  //console.log(senior.getElementsByTagName('i')[0]);
  senior.onclick=function(event){
          //var target=event.target||event.srcElement;
            if(document.getElementById("senior-search").style.display==''||document.getElementById("senior-search").style.display=='none'){
              document.getElementById("senior-search").style.display="block"        
            }else{
              document.getElementById("senior-search").style.display="none"
            }
    }
    
    seniorBox.onmouseover=function(e){
      var e  =  e  ||  window.event;
      if (isMouseLeaveOrEnter(e,this,'div')) {
        this.style.display="block";
      }
    }
    seniorBox.onclick=function(event){
      event  =  event  ||  window.event;
      var target =  event.target || event.srcElement;  
      //var id = target.getAttribute('id');
      /*switch(id){
        case "section_sy":select_("section_sy","value_cyv","v");
              break;
        case "section_lx":select_("section_lx","value_lx","v1");
              break;
      }*/
      if (window.event) {
        event.cancelBubble=true;// ie下阻止冒泡
       } else {
        //e.preventDefault();
        event.stopPropagation();// 其它浏览器下阻止冒泡
       }

    }
    document.body.onclick=function(event){
          event  =  event  ||  window.event;  
          var target =  event.target || event.srcElement;  
          var id = target.id?target.getAttribute('id'):null
          //alert(id)  
          if(id!='senior-search-btn'){
            document.getElementById("senior-search").style.display="none"
          }
    }
}
addLoadEvent(clearInput);
function clearInput(){
    if(!doc.getElementById("clearInput")) return false
    var clearBtn=getByClass("clearinput","search-tab-box");

    for (var i = 0; i < clearBtn.length; i++) {
        clearBtn[i].onclick=function(){
            var clearinput=this.parentNode;
            clearinput.getElementsByTagName("input")[0].value="";
      }
    }
}

addLoadEvent(function(){
  select_("section_sy","value_sy");
  select_("section_lx","value_lx");
  select_("section_gjc","value_gjc");
  select_("section_fknr","value_fknr");
  select_("section_xx","value_xx");
  select_("section_yx","value_yx");
  select_("section_sf","value_sf");
  select_("section_xl","value_xl");
  select_("section_bb","value_bb");
  select_("section_px","value_px");
  select_("section_qk","value_qk");
  select_("section_sj","value_sj");
  select_("section_s1","value_s1");
  select_("section_s2","value_s2");
  select_("section_s3","value_s3");
  select_("section_s4","value_s4");
  select_("section_ti","section_ti");
})

/***获取下一个同级****/
function get_nextsibling(n){
    var x=n.nextSibling;
    while (x.nodeType!=1)
      {
      x=x.nextSibling;
      }
    return x;
}
function select_(id,hider,values){
   if(!document.getElementById(id)){return false;}
   var Red=document.getElementById(id),
       inhide=document.getElementById(hider),
       Redparent=Red.parentNode,
       iEle=Redparent.getElementsByTagName("i"),
       times=Red.nextElementSibling?Red.nextElementSibling:get_nextsibling(Red),
      timea=times.getElementsByTagName("a");
      if(Redparent.className.indexOf('disabled')>0){
        alert(Redparent.className.indexOf('disabled'));
        return false;
      }
      Red.onclick=function(event){
          times.style.display="block";

          if (window.event) {
            event.cancelBubble=true;
           } else {
            //e.preventDefault();
            event.stopPropagation();
          }
          return false;
      }
      iEle[0].onclick=function(event){
          times.style.display="block";
          if (window.event) {
            event.cancelBubble=true;// ie下阻止冒泡
           } else {
            //e.preventDefault();
            event.stopPropagation();
           }
          return false;
      }
      for (var i = 0; i < timea.length; i++) 
          timea[i].onclick=function(){
              Red.innerHTML="";
              Red.innerHTML=this.innerHTML;
              if(values){
                 inhide.value=this.getAttribute(values);
              }else{
                if(inhide){
                  inhide.value=this.innerHTML;
                }
              }
              times.style.display="none";
          }
      Redparent.onmouseout=function(e){
          var e=e||window.event,fuEle;
          var ele=e.target||e.srcElement;
          if (isMouseLeaveOrEnter(e,this,'div')) {
                times.style.display="none";
           }     
      }
}

  

//////////////////////////////////////设为首页 
//设为首页 <a onclick="SetHome(this,window.location)">设为首页</a>

/*SetHome=function(obj,vrl){
        try{
                obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
        }
        catch(e){
                if(window.netscape) {
                        try {
                                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                        }
                        catch (e) {
                                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                        }
                        var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                        prefs.setCharPref('browser.startup.homepage',vrl);
                 }
        }
}*/
/////////////////////////////////////////首页搜索选择
index_js_setFl = function(btn,textId,hiddenId){
  doc.getElementById(hiddenId).value=btn.getAttribute('v');
  doc.getElementById(textId).firstChild.nodeValue=btn.firstChild.nodeValue;
}
search_condi=function(btn,inId){
  var vs = $('#radio_js').val();
    if(vs==0){
      btn.id=inId;
      $('#radio_js').val(1);
    }else if(vs==1){
      btn.id="";
      $('#radio_js').val(0);
    }
}
search_lang = function(btn,hiddenId,inId){
  doc.getElementById(inId).id='';
  btn.id=inId;
  doc.getElementById(hiddenId).value=btn.getAttribute('v');
}

/////////////////////////////////////////tab
addLoadEvent(function(){
  if(doc.getElementById('search-tab-btn')){
    _tab(doc.getElementById('search-tab-btn').getElementsByTagName('a'),
    doc.getElementById('search-tab-box').getElementsByTagName('dd'),0)
  }
  
  if(doc.getElementById('search-tab-btn')){
    if(!doc.getElementById('s-content')) return false;
  var siblings=sibling(doc.getElementById('s-content').getElementsByTagName('div')[0])
    _tab(doc.getElementById('menus-wraper').getElementsByTagName('a'),
    siblings,0
    )
  }

  /*if(doc.getElementById('data-tab')){
    var dataSiblings=sibling(doc.getElementById('chart-box').getElementsByTagName('div')[0])
    _tab2(doc.getElementById('data-tab').getElementsByTagName('a'),
    dataSiblings,0)
  }*/
  if(doc.getElementById('history-tab')){
    var dataSiblings=getByClass2(doc.getElementById('history-tab'),"history-box")
    _tab(doc.getElementById('history-tab').getElementsByTagName('div')[0].getElementsByTagName("a"),
    dataSiblings,0)
  }
  if(doc.getElementById('qk-favrited')){
	    var dataSiblings=getByClass2(doc.getElementById('qk-favrited'),"history-box")
	    _tab(doc.getElementById('qk-favrited').getElementsByTagName('div')[0].getElementsByTagName("a"),
	    dataSiblings,0)
  }
})
function _tab(btn,nr,i){
  var oldBtn=btn[i],
      oldNr=nr[i],
    stopChange=false;
  oldNr.style.display='block';
  
  for(var i=0;i<btn.length;i++){
      var thisBtn=btn[i];
    thisBtn.index=i;
    thisBtn.onmouseover=function(){
      var newBtn=this;
      stopChange=false;
        window.setTimeout(function(){if(!stopChange){changeTab(newBtn)}},200)
    }
    thisBtn.onmouseout=function(){stopChange=true;}
    thisBtn.onclick   =function(){return false;}
  }
  function changeTab(newBtn){
        if(newBtn.className=='in'){return true;}
      var newNr=nr[newBtn.index];
      //alert(newBtn.index)
      oldNr.style.display='none';
      newBtn.className='';
      newNr.style.display='block';
      oldNr=newNr
      
      oldBtn.className='';
      newBtn.className='active';
      oldBtn=newBtn;
      
      return false;
  }
}

function _tab2(btn,nr,i){
    var oldBtn=null,oldNr=null,stopChange=false;
    for(var j=0;j<nr.length;j++){
       var oldnr = nr[j];
       var text = oldnr.getAttribute("style");
       if(text=="padding: 3px; display: block;"){
         oldNr=oldnr;
       }
    }
    if(oldNr==null){
      oldNr=nr[0];
      oldNr.style.display='block'; 
    }
    for(var i=0;i<btn.length;i++){
        var res=btn[i];
        if(res.className=="active"){
          oldBtn=res;
        }
    }
    if(oldBtn==null){
      oldBtn=btn[0];
      oldBtn.className='active'; 
    }
    for(var i=0;i<btn.length;i++){
        var thisBtn=btn[i];
      thisBtn.index=i;
      thisBtn.onmouseover=function(){
        var newBtn=this;
        stopChange=false;
          window.setTimeout(function(){if(!stopChange){changeTab(newBtn)}},200)
      }
      thisBtn.onmouseout=function(){stopChange=true;}
      thisBtn.onclick   =function(){return false;}
    }
    function changeTab(newBtn){
        if(newBtn.className=='in'){return true;}
        var newNr=nr[newBtn.index];
        //alert(newBtn.index)
        oldNr.style.display='none';
        newBtn.className='';
        newNr.style.display='block';
        oldNr=newNr;
        oldBtn.className='';
        newBtn.className='active';
        oldBtn=newBtn;
        return false;
    }
  }

//////////////////////////////////////首页期刊切换
addLoadEvent(function(){
  boxSlider("j-list","p-list");
  boxSlider("j-hwordBox","j-hword")
});
function boxSlider(boxId,listBobId){
  if(!document.getElementById(boxId)){return false}
  var t=5000,
      box=document.getElementById(boxId),
      boxUl=box.getElementsByTagName("ul"),
      oldUl=boxUl[0],
      listBob=document.getElementById(listBobId),
      parentbox=box.parentNode,
      allList=listBob.getElementsByTagName("a"),
      oldList=allList[0],
      bAuto=true,
      sIndex=-1,
      timeoutId=null;
      bBtn=false;
      for (var i = 0; i < boxUl.length; i++) {
        var thisUl=boxUl[i];
        if(i==0){css(thisUl,'opacity',100);thisUl.style.zIndex=1;}
        else{css(thisUl,'opacity',0);thisUl.style.zIndex=0;}
      };
      if(bAuto){cycle(-1);} 
      parentbox.onmouseover=function(){
        bAuto=false;
      }
      parentbox.onmouseout=function(){
        bAuto=true;   
      }
      for (var i = 0; i < allList.length; i++) {
        allList[i].index=i;
        allList[i].onmouseover=function(){
          slide(this.index);
          bBtn=true;
        }
      }
      function cycle(index){
        //if(!bBtn){setTimeout(cycle(index),t);return false}
        index=sIndex;
        index++;
        index=index==boxUl.length?0:index;
        if (bAuto) {
            timeoutId=window.setTimeout(function(){
                cycle(index);
            },t);
            slide(index); 
        }
        else if(!bAuto){
          setTimeout(function(){
                cycle(index);
            },t);

        }
        else if(!bAuto&&bBtn){
          setTimeout(function(){
                cycle(index);
            },t);
        }
        
      }
      function slide(indexs){
        //alert("a");
        animate(oldUl,"opacity",0,1000);
        animate(boxUl[indexs],"opacity",100,1000);
        oldUl.style.zIndex=0;
        oldList.className=" ";

        boxUl[indexs].style.zIndex="1";
        allList[indexs].className="active";
        oldUl=boxUl[indexs];
        oldList=allList[indexs];
        if(!allList[indexs].index){
          index=sIndex=0;

        }
        else{
           sIndex=indexs;
        }
        
      }



}


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

/*意见弹窗*/
addLoadEvent(function(){
  var note=new show(false,"fkWin");
      if(!note){return false; } 
  var tops=getByClass2(document.body,"advice")[0]; 
      if(!tops){return false; } 
        tops.onclick=function(){
           note.animati();
        }
 })
/*登陆弹窗 0*/
/*
* IE9下无法使用 弃用原先方法 smr 201.04.06
*/

/*addLoadEvent(function(){
  var note=new show(false,"lgWin");

    if(!note){return false; }
    if(!doc.getElementById("login-btn")){return false; }  
    var tops=doc.getElementById("login-btn");
    if(tops){ 
      tops.onclick=function(){
        note.animati();
      }
    }
});
addLoadEvent(function(){
  var note=new show(false,"lgWin");
      if(!note){return false; }
  if(!doc.getElementById("login-btn1")){return false; }  
  var tops=doc.getElementById("login-btn1") 
        tops.onclick=function(){
           note.animati();
        }
 });*/



	








 
/*服务条款弹窗  2016-10-24修改新窗口打开 
addLoadEvent(function(){
  var note=new show(false,"fwWin");
      if(!note){return false; } 
  var tops=getByClass2(document.body,"fwLink")[0]; 
      if(!tops){return false; } 
        tops.onclick=function(){
           note.animati();
        }
 });
 */
/*相关学科 */
addLoadEvent(function(){
  var note=new show(false,"rel-subj");
      if(!note){return false; }
  if(!doc.getElementById("relate-subject")){return false; }  
  var tops=doc.getElementById("relate-subject") 
        tops.onclick=function(){
           note.animati();
        }
 })
 /*校外访问 */
// addLoadEvent(function(){
//   if(!doc.getElementById("infthick")){return false; } 
//   var note=new show(false,"infthick");
//   var tops=getByClass2(document.body,"btn-c")[0]; 
//       if(!tops){return false; } 
//         tops.onclick=function(){
//            note.animati();
//         }
//  });
function show(Bstops,win){
    if(Bstops||!document.getElementById(win)){return false;}
    var _this=this,bodyClass= document.body.className
        this.Winbj=getByClass2(document.body,win)[0];
        //console.log(this.Winbj);
        this.showins=this.Winbj;
        this.iclose=this.Winbj.getElementsByTagName("span")[0];
        this.oclose=(!getByClass2(this.Winbj,"close")[0])?(this.Winbj.getElementsByTagName("span")[0]):(getByClass2(this.Winbj,"close")[0]);
       // this.Agent=navigator.userAgent;
        this.opclass=this.Winbj.className;
        this.bgclose=getByClass2(this.Winbj,"Win-bj")[0];
        
     if(!-[1,]&&!window.XMLHttpRequest){
        this.showins.style.height=document.documentElement.clientHeight+"px";
     }
     
    // document.getElementById(obj).onclick=function(){
    //            _this.animati();
    //           // alert(_this.Winbj);
    //      };
    this.bgclose.onclick=function(event){
      _this.out();
      document.body.className=bodyClass;
      var event=window.event||event; 
      if(event.stopPropagation){
        event.stopPropagation();
      }else{
        event.cancelBubble = true;
      }
    }
    this.iclose.onclick=function(){

      _this.out();
      document.body.className=bodyClass;
    };
    this.oclose.onclick=function(){
      _this.out();
      document.body.className=bodyClass;
    };
 } 
 show.prototype.out=function(){
    var _this=this;
       _this.swtime(0);
         return false;
 } 
 show.prototype.swtime=function(time){
   var _this=this;
   timers=setTimeout(function(){
    if(!history.pushState){
      css(_this.showins,'display','none');
      css(_this.Winbj,'display','none');
      _this.showins.style.visibility="visible";
      _this.Winbj.style.visibility="visible";

    }else{
        css(_this.showins,'opacity',0);
        css(_this.Winbj,'opacity',0);
        _this.showins.style.visibility="hidden";
        _this.Winbj.style.visibility="hidden";
    }
          
    }, time);
   return false;
 }
show.prototype.animati=function(){
    var _this=this,bodyClass= document.body.className
    document.body.className=bodyClass+" modal-open ";
    if(!history.pushState){
      css(_this.showins,'display','block');
      css(_this.Winbj,'display','block');
      _this.showins.style.visibility="visible";
      _this.Winbj.style.visibility="visible";
      css(_this.showins,'opacity',100);
      css(_this.Winbj,'opacity',100);

    }else{
      css(_this.showins,'opacity',100);
      css(_this.Winbj,'opacity',100);
      _this.showins.style.visibility="visible";
      _this.Winbj.style.visibility="visible";
    }
    
    return false;
 }

window.show=show;
/*置顶*/
window.onresize=function(){
	addLoadEvent(goScrollTop);
}
addLoadEvent(goScrollTop);
function goScrollTop(){
        var obj=doc.getElementById("totop");
        if(!obj) return false
        function getScrollTop(){
          return doc.documentElement.scrollTop || window.pageYOffset || doc.body.scrollTop;
            }
        function setScrollTop(value){
                var explorer = window.navigator.userAgent ;
                 switch (true){
                     case explorer.indexOf("Chrome") >= 0:
                     doc.body.scrollTop=value;
                     $(document).scrollTop(value);
                     break;
                case explorer.indexOf("Safari") >= 0:
                     window.pageYOffset=value ;
                     break;
                default:
                     doc.documentElement.scrollTop=value;
                }
        }
        var View=getViewport();
        var docW=getDocSize();
        if(window.innerHeight||doc.compatMode == 'BackCompat'){
        	var scrollWidth=getScrollbarWidth();
        }else{
        	scrollWidth=0;
        }
        var navbar=getByClass2(doc.body,"navbar")[0],
        qksearch=getByClass2(doc.body,"qksearch")[0];
        //statistics=getByClass2(doc.body,"statistics-box")[0];
        
        if(!(navbar&&qksearch)){return false} 
        var sidefix=doc.getElementById('sidefix'),
	      	topsearch=doc.getElementById('top-search'),
	      	shelter=doc.getElementById('shelter');
      	
      		//console.log(typeof doc.body.remove)
        window.onscroll=function(){
      var top = getScrollTop();
      var fixedNode2=doc.getElementById('goto_fixed');
                
          if(top>204){
            obj.className='sug sug-top show';

        	  //console.log(doc.getElementById("fixedNodeBg"))
            if(fixedNode2){
              fixedNode2.className='letter-list letter-list-fixed border';
              document.getElementById("ll_nr").style.marginTop="45px";
            }
          }
          else{
            obj.className='sug sug-top';
            if(fixedNode2){
              fixedNode2.className='letter-list border';
              document.getElementById("ll_nr").style.marginTop="0";
            }
             
          } 

      	if(sidefix){
      		if(top>180){
      			sidefix.className="sidebar border sidefix";
      			if(docW.width>View.width){
      				sidefix.style.left="0";
      			}else{
              if(View.width>1440){
                sidefix.style.left=(View.width-1190-scrollWidth)/2+"px";
              }else{
                sidefix.style.left=(View.width-1024-scrollWidth)/2+"px";
              }
      				
      			}
      		}else{
      			sidefix.className="sidebar border";
      			sidefix.style.left="auto";
      		}
      	}
      	if(topsearch){
      		navbar.style.position="relative";
      		qksearch.style.top=0;
      		//statistics.style.display="none";
      		if(top>200){
      			shelter.className="as-shelter show";
      			topsearch.className="top-search show";
      		}else{
      			
      			shelter.className="as-shelter";
      			topsearch.className="top-search";
      		}
      	}
      	
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



/*期刊展开收缩运动*/
addLoadEvent(toggle)
function toggle(){
  if(!doc.getElementById("qkdetail")) return false;
  var allShow=getByClass("toggle","qkdetail");
  if(!allShow[0]) return false
  var containBox=allShow[0].parentNode.getElementsByTagName("ul")[0];
  var    H=containBox.getElementsByTagName("li")[0].offsetHeight;
  s=containBox.getElementsByTagName("li").length;
  he = containBox.getElementsByTagName("li")[s-1].offsetHeight;
      animate(containBox.getElementsByTagName("li")[s-1], 'height', 0, 0);    
      allShow[0].onclick=function(event){
        if(this.innerHTML=="收起"){
        	
          animate(containBox.getElementsByTagName("li")[s-1], 'height', 0, 1000);
          this.innerHTML="展开";
        }else{
          if(s <= 6) {
            animate(containBox, 'height', 3*H+he, 1000);
                this.innerHTML="收起";
          } else {
          animate(containBox.getElementsByTagName("li")[s-1], 'height', he, 1000);
          this.innerHTML="收起";
          }
        }
      }
}
/* 上传文件input */
addLoadEvent(upfileF)
function upfileF(){
  if(!document.getElementById("up-filebox")) return false
  var upfile = document.getElementById("up-filebox");
    
upfile.onchange = function() {
    updateFilename(this.value);
};

function extractFilename(path) {
  var x;
  x = path.lastIndexOf('\\');
  if (x >= 0) // 基于Windows的路径
    return path.substr(x+1);
  x = path.lastIndexOf('/');
  if (x >= 0) // 基于Unix的路径
    return path.substr(x+1);
  return path; // 仅包含文件名
}
 function updateFilename(path) {
   var name = extractFilename(path);
   var nameStr=name.substring(name.lastIndexOf(".")+1,name.length )
   if(nameStr!=="jpg"&&nameStr!=="jpeg"&&nameStr!=="gif"&&nameStr!=="png"&&nameStr!=="bmp"){
    alert("请上传正确的图片格式文文件");
    return false;
   }
   document.getElementById('filename').textContent = name;
 };
}
/*复选框*/
//addLoadEvent(checkbox)
function checkbox(){

  if(!document.getElementById("checkbox-con")) return false;
  var checkbox=document.getElementById("checkbox-con"),
      checkLable=checkbox.getElementsByTagName("li");
      for (var i = 0; i < checkLable.length; i++) {
        checkLable[i].onclick=function(){
          var checkinput=this.getElementsByTagName('input')[0];
          if(checkinput.attributes["checked"]=="checked"||checkinput.attributes["checked"].checked=="true"){
            checkinput.attributes["checked"]="";
            checkinput.attributes["checked"].checked="false"

            this.getElementsByTagName("label")[0].className="checkbox";
          }else{
            checkinput.attributes["checked"]="checked";
            checkinput.attributes["checked"].checked="true";  
            this.getElementsByTagName("label")[0].className="checkbox cur";
            return false;
          }
        }
      };
}
//addLoadEvent(qkload)
function qkload(){
      if(!document.getElementById("loadalllist")) return false;
      document.getElementById("loadalllist").onclick=function(){
            if(document.getElementById("all-data").style.display=="none"||document.getElementById("all-data").style.display==""){
                document.getElementById("all-data").style.display="block";
                document.getElementById("qkminH").style.height="auto"
            }else{
                document.getElementById("all-data").style.display="none";
                document.getElementById("qkminH").style.height="auto"
            }
        }
}

addLoadEvent(banner);
function banner(){
  if(!document.getElementById('banner')){return false;}
var t=5000,
    allPIC=document.getElementById('banner').getElementsByTagName('a'),
  listSpan=document.getElementById('banner').getElementsByTagName('span'),
  oldPIC=allPIC[0],
  oldList=listSpan[0];

for(var i=0;i<allPIC.length;i++){
var thisImg=allPIC[i];
if(i==0){css(thisImg,'opacity',100);thisImg.style.zIndex=1;}
else{css(thisImg,'opacity',0);thisImg.style.zIndex=0;}
}

for(var i=0;i<listSpan.length;i++){
listSpan[i].index=i;
listSpan[i].onmouseover=function(){
cycle(this.index-1);
}}
cycle(-1);
function cycle(index){
if(this.Y){clearTimeout(this.Y);}
index++;
index=index==allPIC.length?0:index;
jihuo(index);
this.Y=window.setTimeout(function(){
cycle(index);
},t);
}
function jihuo(index){
  
  animate(oldPIC, 'opacity', 0, 1000);
  animate(allPIC[index], 'opacity', 100, 1000);
  
  oldPIC.className=''
  oldPIC.style.zIndex=0;
  oldList.className=''
  
  allPIC[index].className='in'
  allPIC[index].style.zIndex=1;
  listSpan[index].className='in'
  oldPIC=allPIC[index]
  oldList=listSpan[index]
}
}

})();
/**===表单验证====*/
/**
 * 只能输入正整数
 */
function clearNotInt(obj){
  obj.value = obj.value.replace(/[^\d]/g,"");
  if(obj.value.length > 4) {
    obj.value = obj.value.substring(0,4);
  }
}
/**
 * 只能输入正实数
 * @param obj
 */
function clearNotNum(obj){
  //先把非数字的都替换掉，除了数字和.
  obj.value = obj.value.replace(/[^\d.]/g,"");
  //必须保证第一个为数字而不是.
  obj.value = obj.value.replace(/^\./g,"");
  //保证只有出现一个.而没有多个.
  obj.value = obj.value.replace(/\.{2,}/g,".");
  //保证.只出现一次，而不能出现两次以上
  obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}


/////////////////////////////////////////////////登陆切换

//抖动函数
function shake(el){
      var style=el.style;
      p=[3,7,3,0,-3,-7,-3,0]
      fx=function(){
          style.marginLeft = p.shift() + 'px';
          if (p.length <= 0) {
                  style.marginLeft = 0;
                  clearInterval(timerId);
          };
      }
      p = p.concat(p.concat(p));
      timerId = setInterval(fx, 13);
      p=[];
  }

/*
*获取复制内容
*/
function getCopyText(event,CopyText){
  var CopyText =CopyText?CopyText:'';
  event=event || window.event;
  //阻止浏览器默认事件 
  event.preventDefault?event.preventDefault():event.returnValue = false;
  //chorme ie9
  if(window.getSelection){
    var c=window.getSelection();
  }else if(document.getSelection){
    //ie7 8
    var c=document.selection.createRange().text;
  }
  //chorme
  if(event.clipboardData){
    event.clipboardData.setData('text/plain',c);
  }else if(window.clipboardData){
    //ie
    window.clipboardData.setData("text".c)
  }
}

$(".showWin-new .regTabbox input").each(function(){
    $(this).on({
        keydown:function(){
            if(event.keyCode == 32){
                return false;
            }
        },
        keyup:function(){
            var va =$(this).val().replace(/[\s]/g,"");
            $(this).val(va);
        }
    })
})
