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
    }else{minH.style.minHeight=getViewport().height-94+'px';}//header footer left的padding
}

////////////////////////////////////////////////首页公告
addLoadEvent(affiche);
function affiche(){
    if(!doc.getElementById('affiche')){return false;}
  var list=doc.getElementById('affiche').getElementsByTagName('ul')[0],
      num=list.getElementsByTagName('li').length,
      H=list.getElementsByTagName('li')[0].offsetHeight,
      mOut=true;
    
  list.style.position='absolute';
  list.style.left='0';
  list.style.top='0';
  
  setTimeout(cycle,3000);
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
  list.onmouseover=function(){mOut=false}
  list.onmouseout=function(){mOut=true}
}
//////////////////////////////////////全站导航下拉
addLoadEvent(userList);
function userList(){
    var obg=document.getElementById("user-name");
    var thisDiv=obg.getElementsByTagName("div")[0];
        obg.onmouseover=function(e){
            var e=e||widndow.event,
                ele=e.target||e.srcElement;
            thisDiv.style.display="block";    
        }
        obg.onmouseout=function(e){
            var e=e||widndow.event,
                ele=e.target||e.srcElement;
            thisDiv.style.display="none";    
        }
}
//////////////////////////////////////设为首页 
//设为首页 <a onclick="SetHome(this,window.location)">设为首页</a>

SetHome=function(obj,vrl){
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
}
/////////////////////////////////////////首页搜索选择
index_js_setFl = function(btn,textId,hiddenId){
    
  doc.getElementById(hiddenId).value=btn.getAttribute('v');
  doc.getElementById(textId).firstChild.nodeValue=btn.firstChild.nodeValue;

}
search_condi=function(btn,hiddenId,inId){
  if(btn.id==inId){
    btn.id="";
    doc.getElementById(hiddenId).value=0;
  }else if(btn.id==""){
    btn.id=inId;
    doc.getElementById(hiddenId).value=1;
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
    doc.getElementById('search-tab-box').getElementsByTagName('dd'))
  }
})
function _tab(btn,nr){
  var oldBtn=btn[1],
      oldNr=nr[1],
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
/*//////////////////////////////////////输入内容清楚
addLoadEvent(clearInput)
function clearInput(ele){
  var searchBox=doc.getElementById("search-tab-box"),
      searchInput=searchBox.getElementsByTagName("input");
      for (var i = 0; i < searchInput.length; i++) {
        //alert(searchInput.length)
        searchInput[i].focus(function(event) {
          key=searchInput[i].value;
          //alert(key)
        })
      }
}

function clInputShow(ele) {
  alert("a");
  var nextEle=getNextSibling(ele);
    alert(nextEle)
      nextEle.style.display="none"
}*/
//////////////////////////////////////首页期刊切换
addLoadEvent(function(){
  boxSlider("j-list","p-list");
  boxSlider("j-hwordBox","j-hword")
});
function boxSlider(boxId,listBobId){
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
      //alert(parentbox.innerHTML)
      parentbox.onmouseover=function(){
        bAuto=false;
        //timeoutId=null
        //alert(this.index);
      }
      parentbox.onmouseout=function(){
        bAuto=true;   
      }
      // listBob.onmouseover=function(){
      //   bAuto=false;
      // }
      for (var i = 0; i < allList.length; i++) {
        allList[i].index=i;
        allList[i].onmouseover=function(){
          slide(this.index);
          bBtn=true;
        }
        // allList[i].onmouseout=function(){
        //   sIndex=this.index;
        // }
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


})();