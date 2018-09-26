<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpiScholar学术期刊导航</title>
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no,email=no" name="format-detection">
<meta property="qc:admins" content="45000505434630133074126375727526147" />
<meta property="wb:webmaster" content="11cac6407a9988ee" />
<link rel="apple-touch-icon" href="favicon.png">
<link rel="Shortcut Icon" href="favicon.png" type="image/x-icon">
<script src="<cms:getProjectBasePath/>resources/mobile/js/flexible.js"></script>
<link rel="stylesheet"
	href="<cms:getProjectBasePath/>resources/mobile/css/iconfont.css">
<link rel="stylesheet" type="text/css"
	href="<cms:getProjectBasePath/>resources/mobile/css/m.css" />
<%-- <script src="<cms:getProjectBasePath/>resources/mobile/js/lib/zepto.min.js"></script>
	<script src="<cms:getProjectBasePath/>resources/mobile/js/frozen.js"></script> --%>
</head>
<body>
	<div class="page-view">
		<div class="userSelectbox">
			<i class="uparrow"></i>
			<ul>
				<li><a href="#">文献互助</a></li>
				<li><a href="#">检索历史</a></li>
				<li><a href="#">我的收藏</a></li>
				<li><a href="#">我的反馈</a></li>
				<li><a href="#">登录</a></li>
			</ul>
		</div>
		<div class="searchfix">
			<div class="searchHead">
				<div class="searchinHead">
					<div class="search-inputwrap">
						<input type="button" class="searchCancle" value="取消">
					</div>
				</div>
			</div>
			<div class="searchBody">
				<p class="texthistory">搜索历史</p>
				<ul class="usersetting-list mt0" id="serchDatalist">
					<!-- <li><a href="">大数据研究</a></li>
					<li><a href="">火焰原子吸收光谱法</a></li>
					<li><a href="">矩形截面高层建筑</a></li> -->
				</ul>
			</div>
		</div>
		<div class="mui-content">
			<div class="scroller-container">
				<header>
					<div class="headwrap">
						<a class="return-back" href="#pageHome" data-rel="back"> <i
							class="icon iconfont">&#xe610;</i> <span>返回</span>
						</a>
						<div class="userbox">
							<div class="userSelect">
								<i class="icon iconfont">&#xe600;</i>
							</div>
						</div>
					</div>
				</header>
				<div class="item-section">
					<div class="article-single">
						<h2>服务条款</h2>
						<p>欢迎您注册成为Spischolar学术资源导航用户！</p>
						<p>请仔细阅读下面的协议，只有接受协议才能继续进行注册。</p>

						<h3>1．服务条款的确认和接纳</h3>
						<p>Spischolar学术资源导航系统用户服务的所有权和运作权归湖南纬度信息科技有限公司所有。Spischolar学术资源导航所提供的服务将按照有关章程、服务条款和操作规则严格执行。用户通过注册程序勾选“我已经阅读并同意《用户服务条款》”，即表示用户与Spischolar学术资源导航达成协议并接受所有的服务条款。</p>

						<h3>2． 服务内容</h3>
						<p>要成为系统服务用户必须：</p>
						<ul>
							<li>（1）自行配备上网的所需设备，包括个人电脑、调制解调器或其他必备上网装置。</li>
							<li>（2）自行负担个人上网所支付的与此服务有关的电话费用、 网络费用。</li>
						</ul>
						<p>为提高系统服务信息服务的准确性，用户应同意：</p>
						<ul>
							<li>（1）提供详尽、准确的公司或个人资料。</li>
							<li>（2）不断更新注册资料，符合及时、详尽、准确的要求。</li>
						</ul>
						<p>本服务不公开用户的电子邮箱和笔名， 除以下情况外：</p>
						<ul>
							<li>（1）用户授权透露这些信息。</li>
							<li>（2）相应的法律及程序要求提供用户的个人资料。</li>
						</ul>
						<p>如果用户提供的资料包含有不正确的信息，本服务系统保留结束用户使用网络服务资格的权利。</p>

						<h3>3． 服务条款的修改和服务修订</h3>
						<p>Spischolar学术资源导航有权在必要时修改服务条款，服务条款一旦发生变动，将会在相关页面上提示修改内容。如果不同意所改动的内容，用户可以主动取消获得的网络服务。
							如果用户继续享用网络服务，则视为接受服务条款的变动。本服务系统保留随时修改或中断服务而不需知照用户的权利。本服务系统行使修改或中断服务的权利，不需对用户或第三方负责。</p>

						<h3>4．用户隐私制度</h3>
						<p>尊重用户个人隐私是Spischolar学术资源导航的
							基本政策。Spischolar学术资源导航不会公开、编辑或透露用户的邮件内容，除非有法律许可要求，或Spischolar学术资源导航在诚信的基础上认为透露这些信件在以下三种情况是必要的：
						</p>
						<ul>
							<li>（1）遵守有关法律规定，遵从合法服务程序。</li>
							<li>（2）保持维护Spischolar学术资源导航的商标所有权。</li>
							<li>（3）在紧急情况下竭力维护用户个人和社会大众的隐私安全。</li>
							<li>（4）符合其他相关的要求。</li>
						</ul>

						<h3>5．用户的帐号，密码和安全性</h3>
						<p>用户一旦注册成功，成为本服务系统的合法用户，将得到一个用户名和密码。
							用户将对用户名和密码安全负全部责任。另外，每个用户都要对以其帐号进行的所有活动和事件负全责。您可随时根据指示改变您的密码。用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本服务系统。</p>

						<h3>6．拒绝提供担保</h3>
						<p>用户对网络服务的使用承担风险。本服务系统对此不作任何类型的担保，不论是明确的或隐含的。本服务系统不担保服务一定能满足用户的要求，也不担保服务不会受中断，对服务的及时性，安全性，出错发生都不作担保。本服务系统对用户得到的任何信息、商品购物服务或交易进程，不作担保。</p>

						<h3>7．有限责任</h3>
						<p>Spischolar学术资源导航对任何直接、间接、偶然、特殊及继起的损害不负责任，这些损害来自：不正当使用邮件服务，在网上购买商品或服务，在网上进行交易，非法使用邮件服务或用户传送的信息所变动。</p>

						<h3>8．用户责任</h3>
						<p>用户单独承担传输内容的责任。用户必须遵循：</p>
						<ul>
							<li>（1）从中国境内向外传输技术性资料时必须符合中国有关法规。</li>
							<li>（2）使用邮件服务不作非法用途。</li>
							<li>（3）不干扰或混乱网络服务。</li>
							<li>（4）不在建议反馈及管理后台中发表任何与政治相关的信息。</li>
							<li>（5）遵守所有使用邮件服务的网络协议、规定、程序和惯例。
							<li>（6）不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益。
							<li>（7）不得利用本站制作、复制和传播下列信息：
								<ul>
									<li>①煽动抗拒、破坏宪法和法律、行政法规实施的；</li>
									<li>②煽动颠覆国家政权，推翻社会主义制度的；</li>
									<li>③煽动分裂国家、破坏国家统一的；</li>
									<li>④煽动民族仇恨、民族歧视，破坏民族团结的；</li>
									<li>⑤捏造或者歪曲事实，散布谣言，扰乱社会秩序的；</li>
									<li>⑥宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；</li>
									<li>⑦公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；</li>
									<li>⑧损害国家机关信誉的；</li>
									<li>⑨其他违反宪法和法律行政法规的；</li>
									<li>⑩进行商业广告行为的。</li>
								</ul>
							</li>
						</ul>

						<h3>9．发送通告</h3>
						<p>所有发给用户的通告都可通过电子邮件或常规的信件传送。Spischolar学术资源导航会通过邮件服务发报消息给用户，告诉他们服务条款的修改、服务变更、或其它重要事情。</p>

						<h3>10．网站内容的所有权</h3>
						<p>Spischolar学术资源导航定义的内容包括：文字、数据、图表、软件；在广告中全部内容；电子邮件的全部内容；所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在Spischolar学术资源导航和广告商授权下才能使用这些内容，而不能擅自复制、篡改这些内容、或创造与内容有关的派生产品。</p>

						<h3>11．附加信息服务</h3>
						<p>用户在享用Spischolar学术资源导航提供的免费服务的同时，同意接受Spischolar学术资源导航提供的各类附加信息服务。



						
						<h3>12．解释权</h3>
						<p>本注册协议的解释权归Spischolar学术资源导航所有。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。

						
						<p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>