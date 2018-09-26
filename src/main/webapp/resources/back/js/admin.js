/* HTML5 Placeholder jQuery Plugin - v2.3.1*/
!function (a) {
    "function" == typeof define && define.amd ? define(["jquery"], a) : a("object" == typeof module && module.exports ? require("jquery") : jQuery)
}(function (a) {
    function b(b) {
        var c = {}, d = /^jQuery\d+$/;
        return a.each(b.attributes, function (a, b) {
            b.specified && !d.test(b.name) && (c[b.name] = b.value)
        }), c
    }

    function c(b, c) {
        var d = this, f = a(this);
        if (d.value === f.attr(h ? "placeholder-x" : "placeholder") && f.hasClass(n.customClass)) if (d.value = "", f.removeClass(n.customClass), f.data("placeholder-password")) {
            if (f = f.hide().nextAll('input[type="password"]:first').show().attr("id", f.removeAttr("id").data("placeholder-id")), b === !0) return f[0].value = c, c;
            f.focus()
        } else d == e() && d.select()
    }

    function d(d) {
        var e, f = this, g = a(this), i = f.id;
        if (!d || "blur" !== d.type || !g.hasClass(n.customClass)) if ("" === f.value) {
            if ("password" === f.type) {
                if (!g.data("placeholder-textinput")) {
                    try {
                        e = g.clone().prop({type: "text"})
                    } catch (j) {
                        e = a("<input>").attr(a.extend(b(this), {type: "text"}))
                    }
                    e.removeAttr("name").data({
                        "placeholder-enabled": !0,
                        "placeholder-password": g,
                        "placeholder-id": i
                    }).bind("focus.placeholder", c), g.data({"placeholder-textinput": e, "placeholder-id": i}).before(e)
                }
                f.value = "", g = g.removeAttr("id").hide().prevAll('input[type="text"]:first').attr("id", g.data("placeholder-id")).show()
            } else {
                var k = g.data("placeholder-password");
                k && (k[0].value = "", g.attr("id", g.data("placeholder-id")).show().nextAll('input[type="password"]:last').hide().removeAttr("id"))
            }
            g.addClass(n.customClass), g[0].value = g.attr(h ? "placeholder-x" : "placeholder")
        } else g.removeClass(n.customClass)
    }

    function e() {
        try {
            return document.activeElement
        } catch (a) {
        }
    }

    var f, g, h = !1, i = "[object OperaMini]" === Object.prototype.toString.call(window.operamini),
        j = "placeholder" in document.createElement("input") && !i && !h,
        k = "placeholder" in document.createElement("textarea") && !i && !h, l = a.valHooks, m = a.propHooks, n = {};
    j && k ? (g = a.fn.placeholder = function () {
        return this
    }, g.input = !0, g.textarea = !0) : (g = a.fn.placeholder = function (b) {
        var e = {customClass: "placeholder"};
        return n = a.extend({}, e, b), this.filter((j ? "textarea" : ":input") + "[" + (h ? "placeholder-x" : "placeholder") + "]").not("." + n.customClass).not(":radio, :checkbox, [type=hidden]").bind({
            "focus.placeholder": c,
            "blur.placeholder": d
        }).data("placeholder-enabled", !0).trigger("blur.placeholder")
    }, g.input = j, g.textarea = k, f = {
        get: function (b) {
            var c = a(b), d = c.data("placeholder-password");
            return d ? d[0].value : c.data("placeholder-enabled") && c.hasClass(n.customClass) ? "" : b.value
        }, set: function (b, f) {
            var g, h, i = a(b);
            return "" !== f && (g = i.data("placeholder-textinput"), h = i.data("placeholder-password"), g ? (c.call(g[0], !0, f) || (b.value = f), g[0].value = f) : h && (c.call(b, !0, f) || (h[0].value = f), b.value = f)), i.data("placeholder-enabled") ? ("" === f ? (b.value = f, b != e() && d.call(b)) : (i.hasClass(n.customClass) && c.call(b), b.value = f), i) : (b.value = f, i)
        }
    }, j || (l.input = f, m.value = f), k || (l.textarea = f, m.value = f), a(function () {
        a(document).delegate("form", "submit.placeholder", function () {
            var b = a("." + n.customClass, this).each(function () {
                c.call(this, !0, "")
            });
            setTimeout(function () {
                b.each(d)
            }, 10)
        })
    }), a(window).bind("beforeunload.placeholder", function () {
        var b = !0;
        try {
            "javascript:void(0)" === document.activeElement.toString() && (b = !1)
        } catch (c) {
        }
        b && a("." + n.customClass).each(function () {
            this.value = ""
        })
    }))
});


$(function () {


    /*
    ///////////// 解决placeholder 兼容问题 ///////////
    */

    /* HTML5 Placeholder jQuery Plugin - v2.3.1*/
    $('input, textarea').placeholder();


    /*
    ////////  后台窗口高度设置  //////////
    */

    var viewH = $(window).height();
    var headerH = $(".header").outerHeight();
    var copyrightH = $(".copyright").outerHeight();
    var crumbH = $(".crumb").outerHeight();
    var scrollH = viewH - headerH - copyrightH - crumbH - 10;

    $(".iframe-con .scroll").css("height", scrollH);

    /*系统管理-用户反馈-左 高度设置*/
    $(".sug-list").css("height", scrollH - 2);


    /*
    ///////// 总后台-下拉框效果模拟 //////////
    */

    /*添加搜索框*/
    $(".sc_selbox").find("p.school").parent(".sc_selopt").prepend('<div class="input-sd"><input class="se-val" type="text" value=""/></div>');

    /*显隐效果*/
    $(".sc_selbox").click(function () {
        $(this).find(".sc_selopt").show();
    }).mouseleave(function () {
        $(this).find(".sc_selopt").hide();
        var p_val = $(this).find("p");
        if (p_val == "") {
            p_val.show();
        }
    });

    /*查询*/
    $(".sc_selbox .se-val").live("keyup", function () {
        var se_val = $(this).val();
        var t_p = $(this).parents(".sc_selopt").find("p");
        $(this).parents(".sc_selopt").find("p").hide();

        if (se_val == "") {
            t_p.show();
        } else {
            t_p.hide();
            $(this).parents(".sc_selopt").find("p:contains(" + se_val + ")").show();
        }
    });

    /*点击传值*/
    $(".sc_selbox p").live("click", function () {
        var pp_val = $(this).text();
        $(this).parents(".sc_selbox").find("#section_lx").text(pp_val);
    });


    /*
    /////////////// 去掉所有input的autocomplete, 显示指定的除外  /////////
    */
    $('input:not([autocomplete]),textarea:not([autocomplete]),select:not([autocomplete])').attr('autocomplete', 'off');


});
/*end*/

(function () {
    var doc = document;
    var addLoadEvent = (function () {
        var b = false;
        var c = {
            fn: [], bReady: false, push: function (a) {
                c.bind();
                if (c.bReady) {
                    a.call(document)
                } else {
                    c.fn.push(a)
                }
            }, ready: function () {
                var a, i = 0, fns;
                c.bReady = true;
                fns = c.fn;
                while ((a = fns[i++])) {
                    a.call(document)
                }
                fns = null
            }, bind: function () {
                if (b) return;
                b = true;
                if (document.readyState === "complete") {
                    return setTimeout(c.ready, 0)
                }
                if (document.addEventListener) {
                    document.addEventListener("DOMContentLoaded", function () {
                        document.removeEventListener("DOMContentLoaded", arguments.callee, false);
                        c.ready()
                    }, false)
                } else {
                    var a = false;
                    try {
                        a = window.frameElement == null
                    } catch (e) {
                    }
                    if (document.documentElement.doScroll && a) {
                        (function () {
                            try {
                                document.documentElement.doScroll('left')
                            } catch (e) {
                                return setTimeout(arguments.callee, 0)
                            }
                            c.ready()
                        })()
                    }
                }
            }
        };
        return c.push
    })();


    function addEvent(node, type, listener) {
        if (node.addEventListener) {
            // W3C method
            node.addEventListener(type, listener, false);
            return true;
        } else if (node.attachEvent) {
            // MSIE method
            node['e' + type + listener] = listener;
            node[type + listener] = function () {
                node['e' + type + listener](window.event);
            }
            node.attachEvent('on' + type, node[type + listener]);
            return true;
        }

        // Didn't have either so return false
        return false;
    };

    function removeEvent(node, type, listener) {

        if (node.removeEventListener) {
            node.removeEventListener(type, listener, false);
            return true
        } else if (node.detachEvent) {
            //MSIE方法
            node.detachEvent('on' + type, node[type + listener]);
            node[type + listener] = null;
            return true;
        }
        //两种方法都不具备则返回false
        return false;
    };

    //删除这个class
    function removeClass(ele, cls) {
        if (hasClass(ele, cls)) {
            var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
            ele.className = ele.className.replace(reg, ' ');
        }
    }

    //添加class
    function addClass(ele, cls) {
        if (!hasClass(ele, cls)) ele.className += " " + cls;
    }

    //通过class获取元素
    function getByClass(classStr, tagName) {
        if (document.getElementsByClassName) {
            return document.getElementsByClassName(classStr)
        } else {
            var nodes = document.getElementsByTagName(tagName), ret = [];
            for (i = 0; i < nodes.length; i++) {
                if (hasClass(nodes[i], classStr)) {
                    ret.push(nodes[i])
                }
            }
            return ret;
        }
    }

    window.getByClass = getByClass;

    //判断是否有这个class
    function hasClass(node, className) {
        var names = node.className.split(/\s+/);
        for (var i = 0; i < names.length; i++) {
            if (names[i] == className)
                return true;
        }
        return false;
    }

    //下一个兄弟元素
    function getNextSibling(startBrother) {
        endBrother = startBrother.nextSibling;
        while (endBrother.nodeType != 1) {
            endBrother = endBrother.nextSibling;
        }
        return endBrother;
    }

    function sibling(elem) {
        var r = [];
        var n = elem.parentNode.firstChild;
        for (; n; n = n.nextSibling) {
            if (n.nodeType === 1) {
                r.push(n);
            }
        }
        return r;
    }

    function isMouseLeaveOrEnter(e, handler, eleName) {
        if (e.type != 'mouseout' && e.type != 'mouseover') return false;
        var reltg = e.relatedTarget ? e.relatedTarget : e.type == 'mouseout' ? e.toElement : e.fromElement;
        while (reltg && reltg != handler && reltg.nodeName != eleName)
            reltg = reltg.parentNode;
        return (reltg != handler);
    }

    function getDocSize() {
        if (doc.compatMode == 'BackCompat')//BackCompat和CSS1Compat
            return {
                width: Math.max(doc.body.clientWidth, doc.body.scrollWidth),
                height: Math.max(doc.body.clientHeight, doc.body.scrollHeight)
            };
        //opare9.0在有滚条时 client 和scroll都是文档高度  没滚条时client为文档高度 scroll为可视区高度 和其他浏览器相反
        return {
            width: Math.max(doc.documentElement.clientWidth, doc.documentElement.scrollWidth),
            height: Math.max(doc.documentElement.clientHeight, doc.documentElement.scrollHeight)
        };
    }

    function getCoords(el) {
        var box = el.getBoundingClientRect(),
            doc = el.ownerDocument,
            body = doc.body,
            html = doc.documentElement,
            clientTop = html.clientTop || body.clientTop || 0,
            clientLeft = html.clientLeft || body.clientLeft || 0,
            top = Math.floor(box.top + (self.pageYOffset || html.scrollTop || body.scrollTop) - clientTop),
            left = Math.floor(box.left + (self.pageXOffset || html.scrollLeft || body.scrollLeft) - clientLeft)
        return {'top': top, 'left': left};
    }

    //-----------------------------------------------------------------------------------------------
    getViewport = function () {
        if (window.innerHeight)
            return {width: window.innerWidth, height: window.innerHeight};
        if (doc.compatMode == 'BackCompat')
            return {width: doc.body.clientWidth, height: doc.body.clientHeight};
        return {
            width: Math.max(doc.documentElement.clientWidth, doc.documentElement.scrollWidth),
            height: Math.max(doc.documentElement.clientHeight, doc.documentElement.scrollHeight)
        };
    }


    css = function (obj, attr, value) {
        switch (arguments.length) {
            case 2:
                if (typeof arguments[1] == "object") {
                    for (var i in attr) i == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + attr[i] + ")", obj.style[i] = attr[i] / 100) : obj.style[i] = attr[i];
                } else {  //currentStyle ie  getComputedStyle ff 单位始终是 px
                    if (attr == "opacity") {
                        return obj.currentStyle ? obj.currentStyle[attr] * 100 : getComputedStyle(obj, null)[attr] * 100
                    }
                    else {
                        return obj.currentStyle ? (function () {
                            //ie下在获取宽高时 是否为auto
                            var v = obj.currentStyle[attr];
                            if (attr.toUpperCase() == 'WIDTH' && v == 'auto') {
                                var lefBor = parseFloat(obj.currentStyle['borderLeftWidth']),
                                    rigBor = parseFloat(obj.currentStyle['borderRightWidth']),
                                    borW = lefBor ? lefBor : 0 + rigBor ? rigBor : 0;
                                return v = obj.offsetWidth - parseFloat(obj.currentStyle['paddingLeft']) - parseFloat(obj.currentStyle['paddingRight']) - borW;
                            }
                            else if (attr.toUpperCase() == 'HEIGHT' && v == 'auto') {
                                var topBor = parseFloat(obj.currentStyle['borderTopWidth']),
                                    botBor = parseFloat(obj.currentStyle['borderBottomWidth']),
                                    borH = topBor ? topBor : 0 + botBor ? botBor : 0;
                                return v = obj.offsetHeight - parseFloat(obj.currentStyle['paddingTop']) - parseFloat(obj.currentStyle['paddingBottom']) - borH;
                            } else {
                                return v;
                            }
                        })() : getComputedStyle(obj, null)[attr];
                    }
                }
                break;
            case 3:
                attr == "opacity" ? (obj.style["filter"] = "alpha(opacity=" + value + ")", obj.style[attr] = value / 100) : obj.style[attr] = value;
                break;
        }
    };

    animate = function (obj, sStyleName, nNedV, time, fn) {
        var nStartTime = +new Date(),
            nStartV = parseFloat(css(obj, sStyleName)),
            sUnit = sStyleName == 'opacity' ? '' : 'px',
            nDistance = nStartV - nNedV;

        function easeInOutCubic(pos) {
            if ((pos /= 0.5) < 1) return 0.5 * Math.pow(pos, 3);
            return 0.5 * (Math.pow((pos - 2), 3) + 2);
        }

        if (obj['_' + sStyleName]) {
            clearInterval(obj['_' + sStyleName])
        }
        ;

        obj['_' + sStyleName] = setInterval(function () {
            var nFraction = easeInOutCubic((+new Date() - nStartTime) / time),
                thisV = nStartV - nDistance * nFraction,
                oCss = {};
            if (nFraction < 1) {
                oCss[sStyleName] = (thisV) + sUnit;
                css(obj, oCss);
            } else if (nFraction > 1) {
                oCss[sStyleName] = (nNedV) + sUnit;
                css(obj, oCss);
                if (fn) fn();
                clearInterval(obj['_' + sStyleName]);
                obj = null;
            }
        }, 20);
    }

    var dailog = function (message) {
        if (typeof message == "object") {
            var newobj = JSON.parse(JSON.stringify(message));
            for (var i in message) {
                newobj[i] = message[i];
            }
            message = newobj["msg"];
        } else if (typeof message == "String") {

        }
        var alertdom = document.createElement("div");
        alertdom.innerHTML = '<div class="thickWarp">'
            + '<span class="thickBj"></span>'
            + '<div class="thickinWrap">'
            + '<span class="closeThick"></span>'
            + '<div class="thickhead">'
            + '<h3 class="thickheadTit">提示框</h3>'
            + '</div>'
            + '<div class="thickbody">'
            + '<div class="thickContent">'
            + message
            + '</div>'
            + '</div>'
            + '<div class="thickbottom tr">'
            + '<a class="btnEnsure btn" id="enSureSchool">确认</a>'
            + '</div>'
            + '</div>'
            + '</div>';
        document.body.appendChild(alertdom);
        var thickBj = alertdom.getElementsByClassName("thickBj")[0];
        var closeThick = alertdom.getElementsByClassName("closeThick")[0];
        var btnEnsure = alertdom.getElementsByClassName("btnEnsure")[0];
        btnEnsure.onclick = closeThick.onclick = thickBj.onclick = function () {
            try {
                alertdom.removeNode(true);
            } catch (err) {
                alertdom.remove();
            }
        }
    }


    //window.alert=dailog;

    /////////////////////////////////////////////////第一个子元素
    function getFirstChild(startBrother) {
        endBrother = startBrother.firstChild;
        while (endBrother.nodeType != 1) {
            endBrother = endBrother.nextSibling;
        }
        return endBrother;
    }

    ////////////////////////////////////////js节流
    var throttle = function (func, wait, options) {
        /* options的默认值
         *  表示首次调用返回值方法时，会马上调用func；否则仅会记录当前时刻，当第二次调用的时间间隔超过wait时，才调用func。
         *  options.leading = true;
         * 表示当调用方法时，未到达wait指定的时间间隔，则启动计时器延迟调用func函数，若后续在既未达到wait指定的时间间隔和func函数又未被调用的情况下调用返回值方法，则被调用请求将被丢弃。
         *  options.trailing = true;
         * 注意：当options.trailing = false时，效果与上面的简单实现效果相同
         */
        var context, args, result;
        var timeout = null;
        var previous = 0;
        if (!options) options = {};
        var later = function () {
            previous = options.leading === false ? 0 : _.now();
            timeout = null;
            result = func.apply(context, args);
            if (!timeout) context = args = null;
        };
        return function () {
            var now = _.now();
            if (!previous && options.leading === false) previous = now;
            // 计算剩余时间
            var remaining = wait - (now - previous);
            context = this;
            args = arguments;
            // 当到达wait指定的时间间隔，则调用func函数
            // 精彩之处：按理来说remaining <= 0已经足够证明已经到达wait的时间间隔，但这里还考虑到假如客户端修改了系统时间则马上执行func函数。
            if (remaining <= 0 || remaining > wait) {
                // 由于setTimeout存在最小时间精度问题，因此会存在到达wait的时间间隔，但之前设置的setTimeout操作还没被执行，因此为保险起见，这里先清理setTimeout操作
                if (timeout) {
                    clearTimeout(timeout);
                    timeout = null;
                }
                previous = now;
                result = func.apply(context, args);
                if (!timeout) context = args = null;
            } else if (!timeout && options.trailing !== false) {
                // options.trailing=true时，延时执行func函数
                timeout = setTimeout(later, remaining);
            }
            return result;
        };
    };

    addLoadEvent(function () {
        docSet();
        sidebar("side-menue");
        /*_selects();*/
        _thick("thickBtn", "span");
        //_thick("thickBtn","a");
        _thick("delete", "a");
        tabletrToggle();
        _thick("modifythick", "a");
        _thick("modifyUrltick", "a");
        _thick("oprbtn", "a");
        _thick("opradded", "a")
    })

    function docSet() {
        var docSeted = function () {
            /*var Viewport=document.documentElement.clientHeight;
            if(!document.getElementById("content")) return false;
            document.getElementById("content").style.height=Viewport-115+'px';
            document.getElementById("side-menue").style.height=Viewport-115+"px";
            document.getElementById("rightMain").style.height=Viewport-115-43-43+"px";*/
            /*if(navigator.userAgent.indexOf("MSIE")>0){
              if(navigator.userAgent.indexOf("MSIE 7.0")>0){

              }
              else if(navigator.userAgent.indexOf("MSIE 8.0")>0 && !window.innerWidth){//这里是重点，你懂的
                 document.getElementById("rightMain").style.height=Viewport.height-115-80+"px";
              }
            else{
                document.getElementById("rightMain").style.height=Viewport.height-115-43-46+"px";
            }
            }else{
                document.getElementById("rightMain").style.height=Viewport.height-115-43-46+"px";
            } */
        }
        docSeted();
        window.onresize = function () {
            throttle(docSeted(), 200, {
                leading: true,
                trailing: true
            })
        }
    }

    window.docSet = docSet;

    function sidebar(ele) {
        if (!document.getElementById(ele)) return false
        var sidenav = document.getElementById(ele).getElementsByTagName("ul")[0];
        sidenavLink = sidenav.getElementsByTagName("a");
        navLength = sidenav.getElementsByTagName("a").length;
        //alert(navLength)
        var conTab = getByClass("conTab", "div");

        for (var i = 0; i < sidenavLink.length; i++) {
            sidenavLink[i].onclick = function () {
                resetClassName(sidenavLink)
                this.className = "in";
                //createTabbtn(this,conTab[0])
            }
        }
        ;

        function resetClassName(elements) {
            for (var i = 0; i < elements.length; i++) {
                elements[i].className = ""
            }
            ;
        }

        function createTabbtn(ele, targetBox) {
            var span = document.createElement("span");
            span.className = "inc uv01";
            var newEle = ele.cloneNode(true);
            newEle.appendChild(span);
            var flag = targetBox.getElementsByTagName("a");
            var flagLen = flag.length;
            if (flagLen > 0 && flagLen < navLength) {
                for (var x = 0; x < flag.length; x++) {
                    flag[x].className = "";
                    if (flag[x].text == newEle.text) return false
                }
                newEle.className = "in";
                targetBox.appendChild(newEle);
            } else if (flagLen == navLength) {
                for (var i = 0; i < flag.length; i++) {
                    flag[i].className = "";
                    if (flag[i].text == newEle.text) {
                        flag[i].className = "in"
                    }
                }
                ;
            } else {
                newEle.className = "in";
                targetBox.appendChild(newEle);
            }
            addEvent(flag, "click", function () {

            })
        }
    }

    /**
     * [select下拉模拟]
     * @return {[type]} [description]
     */

    /*var _selects=function(){
        var ele=getByClass("sc_selbox","div");
        for(var i=0;i<ele.length;i++){
            /*console.log(ele[i].getElementsByTagName("div").length)
            if(ele[i].getElementsByTagName("div").length>1){

            }else{
                _select(ele[i]);
            }

        }

    }
    var _select=function(ele){

        var selectOptBox=ele.getElementsByTagName('div')[0];
        var selectOptValue=ele.getElementsByTagName("span")[0].innerHTML;
        var selectOpt=ele.getElementsByTagName('p');
        var that=this;
        if(selectOpt.length>10){
            setSelectHtml(selectOpt,selectOptBox);
        }
        ele.onclick=function(event){
            var event=event||window.event;
            var target=event.target||event.srcElement;
            var targetType=target.nodeName.toLocaleLowerCase();
                switch(target.nodeName.toLocaleLowerCase()){
                    case 'div':
                    case 'span':
                    case 'i':
                        if(selectOptBox.style.display=="none"){
                            selectOptBox.style.display="block";
                        }else{
                            selectOptBox.style.display="none";
                        }
                        break;
                    case 'input':

                        break;
                    case 'p':
                        selectOptBox.style.display="none";
                        //alert(2);
                        ele.getElementsByTagName("span")[0].innerHTML=target.innerHTML;
                        break;
                }

            return false
        }

        ele.onmouseout=function(event){
            var eventobj=event||window.event;
            if(isMouseLeaveOrEnter(eventobj,this,'div')){
                this.getElementsByTagName("div")[0].style.display="none";
            }
        }

        function setSelectHtml(selectOpt,selectOptBox){
            var searchDom=document.createElement("div");
                searchDom.className="chosen-search";
            var secInput=document.createElement("input");
                secInput.className="selSecInput";
                searchDom.appendChild(secInput);
                selectOptBox.appendChild(searchDom);

            var optbox=document.createElement("div");
            selectOptBox.appendChild(optbox);
            var optHeight=css(selectOpt[0],"height");

            optbox.style.maxHeight=parseInt(optHeight)+"px";

            //console.log(css(optbox,"height"))

            optbox.style.overflowX="hidden";
            for(var i=0;i<selectOpt.length;i++){
                var optsmove=selectOptBox.getElementsByTagName("p");
                optbox.appendChild(optsmove[0])
            }
            if(css(optbox,"height")<10*parseInt(optHeight)){
                optbox.style.overflowY="auto";
            }else{
                optbox.style.overflowY="scroll";
                //alert(1)
            }
            var data=dataInit(selectOptBox);
            addEvent(secInput,"keyup",function(){
                var value=this.value;
                if(value){
                    inputSearch(selectOptBox,data,value)
                }else if(value==""){
                    datareset(selectOptBox);
                }
            })
        }

        function datareset(eles){
            var opts=eles.getElementsByTagName("p");
            for(var x=0;x<opts.length;x++){
                opts[x].style.display="block";
            }
        }
        function dataInit(eles){
            var optArray=[];
            var searchRes=null;
            var opts=eles.getElementsByTagName("p");
            for(var i=0;i<opts.length;i++){
                optArray.push(opts[i]);
            }
            return optArray;
        }
        function inputSearch(eles,data,value){
            var sindex=[];
            var str=value.toLocaleLowerCase();
            for(var x=0;x<data.length;x++){
                if(data[x].innerHTML.indexOf(str)!="-1"){
                    sindex.push(x);
                }
            }
            showResult(eles,sindex);
        }
        function showResult(eles,arrayIndex){
            var opts=eles.getElementsByTagName("p");
            if(arrayIndex.length>0){
                for(var x=0;x<opts.length;x++){
                    opts[x].style.display="none";
                }
                for(var i=0;i<arrayIndex.length;i++){
                    opts[arrayIndex[i]].style.display="block";
                }
            }
        }
    }
    window._select=_select;
    */
    /**
     * [_thick 弹窗]
     * @return {[type]} [description]
     */
    var _thick = function (className, tag) {
        var eleBtn = getByClass(className, tag);
        var parent = window.parent;
        var btnCancle = getByClass("btnCancle", "a");
        if (className != 'oprbtn') {
            for (var i = 0; i < eleBtn.length; i++) {
                addEvent(eleBtn[i], "click", eventFun)
            }
            ;
        } else if (getByClass('oprbtn', tag).length) {
            delegate("data-table", "onclick", 'oprbtn', eventFun)
        }

        function eventFun() {
            if (this.getAttribute("data-thickcon") && document.getElementById(this.getAttribute("data-thickcon"))) {
                setHtml();
                var eleid = this.getAttribute("data-thickcon")
                var thickCon = document.getElementById(eleid);
                thickheadTit.innerHTML = thickCon.getAttribute("data-tit");

                var thickConparent = document.getElementById(eleid).parentNode;
                thickCon.style.display = "block";
                thickbody.appendChild(document.getElementById(eleid));
                var height = thickCon.offsetHeight,
                    width = thickCon.offsetWidth;
                if (height > 506) {
                    height = 506;
                    thickbody.style.maxHeight = "506px";
                    thickbody.style.overflowY = "auto";
                }
                thickinWrap.style.height = (height + 36) + "px";
                thickinWrap.style.width = width + "px";
                thickinWrap.style.marginTop = -(height + 46) / 2 + "px";
                thickinWrap.style.marginLeft = -width / 2 + "px";
                $('#' + eleid).find(".btnCancle")[0].onclick = closeThick.onclick = thickBj.onclick = function () {
                    $('.self-chuli').removeClass('self-chuli');
                    thickConparent.appendChild(parent.document.getElementById(eleid));
                    thickClose(thickWrap);
                    thickCon.style.display = "none";
                    return false
                }
            }
        }

        function setHtml() {

            /*创建元素*/
            thickWrap = document.createElement("div");
            thickBj = document.createElement("span"),
                thickinWrap = document.createElement("div"),
                closeThick = document.createElement("span"),
                thickhead = document.createElement("div"),
                thickheadTit = document.createElement("h3"),
                thickbody = document.createElement("div");
            /*设置样式*/
            thickWrap.className = "thickWarp";
            thickBj.className = "thickBj";
            thickinWrap.className = "thickinWrap";
            closeThick.className = "closeThick";
            thickhead.className = "thickhead";
            thickheadTit.className = "thickheadTit";
            thickbody.className = "thickbody";
            /*添加到DOM*/
            thickhead.appendChild(thickheadTit);
            thickinWrap.appendChild(closeThick);
            thickinWrap.appendChild(thickhead);
            thickWrap.appendChild(thickBj);
            thickWrap.appendChild(thickinWrap);
            thickinWrap.appendChild(thickbody);

            parent.document.body.appendChild(thickWrap);
        }

        function thickClose(ele) {
            parent.document.body.removeChild(ele)
        }
    }
    window["_thick"] = _thick;
    var tabletrToggle = function () {
        var toggle = getByClass("toggle", "span");
        if (toggle) {
            for (var x = 0; x < toggle.length; x++) {
                addEvent(toggle[x], 'click', function () {
                    var parent = this.parentNode.parentNode
                    var targetEle = getNextSibling(parent);
                    if (targetEle.className == "none") {
                        targetEle.className = "";
                        this.className = "toggleUp"
                    } else if (targetEle.className == "") {
                        targetEle.className = "none";
                        this.className = "toggle"
                    }
                })
            }
        }
    }

    /*addLoadEvent(function(){
        var btnBox=getByClass("Tabjs","div");
        if(btnBox.length){
            var dataTabNr=getByClass("dataTabNr","div");
            var btn=btnBox[0].getElementsByTagName("a");
            if(btn){
                _tab(btn,dataTabNr);
            }
        };
    })*/

    function _tab(btn, nr) {
        if (!btn) return false;
        btn[0].className = 'in';
        nr[0].style.display = 'block';
        for (var i = 0; i < btn.length; i++) {
            var thisBtn = btn[i];
            thisBtn.onmouseover = (function (j) {
                return function () {
                    reset(btn, nr);
                    this.className = "in";
                    seting(btn, nr, j)
                }
            })(i)
        }
    }

    function reset(btn, nr) {
        for (var i = 0; i < btn.length; i++) {
            btn[i].className = "";
            nr[i].style.display = "none"
        }
    }

    function seting(btn, nr, index) {
        btn[index].className = "in";
        nr[index].style.display = "block"
    }

    window["tab"] = _tab;

    function delegate(parent, eventType, selector, fn) {
        if (typeof parent === 'string') {
            var parent = document.getElementById(parent);
            !parent && alert('parent not found');
        }
        if (typeof selector !== 'string') {
            alert('selector is not string');
        }
        if (typeof fn !== 'function') {
            alert('fn is not function');
        }

        function handle(e) {
            var evt = window.event ? window.event : e;
            var target = evt.target || evt.srcElement;
            var currentTarget = e ? e.currentTarget : this;
            if (target.id === selector || target.className.indexOf(selector) != -1) {
                fn.call(target);
            }
        }

        parent[eventType] = handle;
    }

    /*addLoadEvent(function(){
        var opradded=getByClass("opradded","a");
        for(var i=0;i<opradded.length;i++){
            _thick()
        }
    })*/
    addLoadEvent(showText);

    function showText() {

        var showBox = doc.getElementById('showBox'),
            btn = getByClass('textC', doc.getElementById('table_textC'));
        if (btn.length < 1 && !showBox) return false;
        var showBoxNr = showBox.getElementsByTagName('p')[0];
        for (var i = btn.length; i--;) {
            var thisBtn = btn[i];
            thisBtn.onmouseover = function () {
                var LT = getCoords(this),
                    docH = docH = getDocSize().height;
                showBoxNr.firstChild.nodeValue = this.getAttribute('allText');
                showBox.style.width = this.offsetWidth + 'px';
                showBox.style.display = 'block';

                var thisBtnH = this.offsetHeight,
                    showBoxH = showBox.offsetHeight + 10 + 2;//加速箭头的高度 和 渐显窗口与textC之间2px的距离

                if (docH <= LT.top + showBoxH + thisBtnH + 12) {//底部最少留12像素间距
                    addClass(showBox, 'showBox_jt_lb');
                    showBox.style.top = LT.top - showBoxH - 12 + 'px';
                } else {
                    removeClass(showBox, 'showBox_jt_lb');
                    showBox.style.top = LT.top + thisBtnH + 10 + 'px';
                }

                showBox.style.left = LT.left + 'px';
                animate(showBox, 'opacity', 100, 300);
            }
            thisBtn.onmouseout = function () {
                showBox.style.top = '-9999px';
                showBox.style.left = '-9999px';
                showBoxNr.firstChild.nodeValue = '';
                css(showBox, 'opacity', 0);
                showBox.style.display = 'none';
            }
        }


    }
})(window);