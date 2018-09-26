<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://org.pzy.cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<c:set scope="request" var="pageTitle" value="期刊导航--帮助页"></c:set>
<c:set scope="request" var="navIndex" value="0"></c:set>
<jsp:include page="./common/header.jsp"></jsp:include>
<jsp:include page="./common/search.jsp"></jsp:include>
<div class="container container_help" id="minH" minH='280'>
	<div class="fixed_menu" id="fixed_menu">
		<h3 class="T_5">
			<span class="title">用户指南</span>
		</h3>
		<ul class="left_menu">
			<li class="menu_1"><a href="<cms:getProjectBasePath/>help#go_1">概
					述</a></li>
			<li class="menu_1"><a href="<cms:getProjectBasePath/>help#go_2">功
					能</a></li>
			<li class="menu_1"><a href="<cms:getProjectBasePath/>help#go_3">评价指标</a></li>
			<li class="menu_2"><a
				href="<cms:getProjectBasePath/>help#go_3_1">JCR与期刊影响因子</a></li>
			<li class="menu_2"><a
				href="<cms:getProjectBasePath/>help#go_3_2">中科院JCR期刊分区</a></li>
			<li class="menu_2"><a
				href="<cms:getProjectBasePath/>help#go_3_3">Eigenfactor</a></li>
			<li class="menu_2"><a
				href="<cms:getProjectBasePath/>help#go_3_4">SJR</a></li>
			<li class="menu_1"><a href="<cms:getProjectBasePath/>help#go_4">主要参考网站</a></li>
		</ul>
	</div>
	<div class="content">
		<div class="subpage_nr">

			<div class="doc_help">
				<h3 class="title_1" id="go_1">概 述</h3>
				<p class="ind_2">纬度期刊导航系统在乌利西国际期刊指南基础上，整合Web of
					Science与Scopus、EI、CA等国际著名的索引和文摘数据库收录的期刊；同时添加CSCD、CSSCI来源期刊和CNKI
					、维普、万方等全文数据库的收录期刊，将分散在不同数据库和网站系统的中外文期刊重新组织，为用户提供集发现、获取、评价一体化期刊导航服务。



				
				<h3 class="title_1" id="go_2">功 能</h3>
				<h3 class="title_2">1 灵活有效的浏览和检索</h3>

				<p class="ind_2">
					<span>浏览：</span>按照不同分类体系的学科来查看整个学科的所有期刊，且提供简单、有效的OA期刊筛选；也提供首字母浏览期刊。
				</p>
				<p class="ind_2">检索：使用期刊全称、简称、ISSN(print)、ISSN(online)查找期刊；使用关键词查找学科；还可以通过刊名或标题直接检索期刊最新发表的相关文章。</p>

				<h3 class="title_2">2 丰富期刊扩展信息</h3>

				<p class="ind_2">不仅提供期刊刊名、ISSN，还提供主编、国家、语种、介绍、出版商、收录与评价、维基百科、百度百科等信息</p>

				<h3 class="title_2">3 完整的期刊获取途径</h3>

				<p class="ind_2">中外文期刊提供主页链接地址，可访问期刊主页了解期刊最新动态；同时提供全文数据库的访问链接，直接链接到数据库的期刊内容页，获取期刊原文。</p>

				<h3 class="title_2">4 呈体系的期刊收录与评价</h3>
				<p class="ind_2">系统的核心就是呈体系整合主流的期刊收录与评价体系，在期刊详细页面以非常直观的方式展现每本期刊最近5年内的主流收录与评价信息。方便用户了解最高品质的学术信息和最前沿的学术动态。</p>

				<h3 class="title_2">5 便捷的文章推送与检索</h3>
				<p class="ind_2">系统整合多套成熟学术搜索引擎的内容，
					为用户提供从期刊到内容的延生服务。用户既可以检索一篇文章，也可以查看一本期刊的所有文章。</p>

				<h3 class="title_1" id="go_3">评价指标</h3>

				<h3 class="title_2" id="go_3_1">JCR与期刊影响因子:</h3>
				<p class="ind_2">汤姆森路透每年发布JCR(Journal Citation
					Reports，期刊引证报告）。JCR对包括SCI收录的3800种核心期刊(光盘版)在内的8000多种期刊(网络版)之间的引用和被引用数据进行统计、运算，并针对每种期刊定义了影响因子（Impact
					Factor）等指数加以报道。影响因子，期刊前2年发表论文在当年获得总被引频次与前2年发表论文数量的比值，通俗讲，就是一定时域内期刊论文的平均被引用次数。一种刊物的影响因子越高，也即其刊载的文献被引用率越高，一方面说明这些文献报道的研究成果影响力大，另一方面也反映该刊物的学术水平高。因此，JCR以其大量的期刊统计数据及计算的影响因子等指数，而成为主要期刊评价工具。</p>
				<h3 class="title_2" id="go_3_2">中科院JCR期刊分区:</h3>

				<p class="ind_2">JCR期刊分区是对相应年度的期刊引证报告(JCR)中全部期刊分为4个区。JCR期刊分区表包括大类分区和小类分区，大类分区是将期刊按照13个比较粗的学科类目所做的分区，而小类分区是将期刊按照JCR提供的176个比较细的学科类目所做的分区。</p>
				<p class="ind_2">JCR期刊分区认为科技期刊的影响因子（IF）、总被引频次（CI）可以从不同角度反映期刊的显示度：IF可以测度期刊在最近两年中的篇均被引频次；CI可以从历史发展的角度测度期刊自创刊以来在学术界的显示水平。此外，本方法的主要理论基础是布拉德福的文献集中定律。布拉德福的文献集中定律在期刊影响因子和被引频次的分布中体现为少数期刊集中了相对较高的影响因子和被引频次。因此，JCR期刊分区主要是基于影响因子和被引频次两个指标，利用ISI出版的JOURNAL
					CITATION REPORTS（JCR）中的数据进行统计后得到的结果。</p>
				<blockquote>
					<p class="ind_2">-金碧辉,汪寿阳.SCI期刊等级区域的划分及其中国论文的分区[J].1999,20(2):1-7</p>
					<p class="ind_2">
						-期刊分区简介[OL].<a href="http://www.fenqubiao.com/User/Help.aspx"
							target="_blank">http://www.fenqubiao.com/User/Help.aspx</a>,2013-8-25
					</p>
				</blockquote>
				<h3 class="title_2" id="go_3_3">Eigenfactor:</h3>

				<p class="ind_2">Pinski等人提出以引用某论文的论文被引频次作为权，计算引文加权重要性的思想。其思想类似于Brain和Page提出的PageRank，但是早于PageRank，但受限于计算的复杂性，鲜见实际运用。2007年，美国华盛顿大学和加州大学的Bergstrom等人组成研究小组发布一个新的期刊引文评价指标——Eigenfactor（特征因子）。Eigenfactor认为，期刊越多地被高影响力的期刊所引用则其影响力也越高。它以期刊影响力为权，以更贴近实际的权重网络形式重构了最早由Price提出的引文网络。</p>
				<p class="ind_2">Eigenfactor使用汤姆森路透的JCR作为数据源，够哦件提出自引的期刊5年期引文矩阵，以类似于PageRank的算法迭代计算出期刊的权重影响值，实现引文数量与质量的综合评价。Eigenfactor分为Eigenfactor
					Score(特征因子分值)与Article Influence Score(论文影响分值)两部分：Eigenfactor
					Score计算基于过去5年中期刊发表论文在JCR统计当年的被引用情况；Article Influence
					Score旨在基于每篇论文测度期刊的相对重要性。系统中出现的Eigenfactor为Eigenfactor Score。</p>

				<blockquote>
					<p class="ind_2">-Carl T. Bergstrom, Jevin D. West, and Marc A.
						Wiseman.The Eigenfactor™ Metrics[J].The Journal of Neuroscience,
						November 5, 2008 • 28(45):11433–11434</p>
					<p class="ind_2">-赵星.期刊引文评价新指标Eigenfactor的特性研究[J].情报理论与实践,2009,32(8):53-56</p>
					<p class="ind_2">-任胜利.特征因子(Eigenfactor):基于引证网络分析期刊和论文的重要性[J].中国科技期刊研究,
						2009, 20(3):415-418</p>
				</blockquote>
				<h3 class="title_2" id="go_3_4">SCImago Journal Rank(SJR):</h3>

				<p class="ind_2">SJR由西班牙Extremadura大学Scimago Group团队的Félix de
					Moya教授等三人提出，其核心概念源自Google的PageRank算法，即被声望高的期刊所引用，对声望的提升应被一般期刊引用来的显著。SJR计算的时间窗为3年，即某期刊当年的评价值，是计算其前3年间发表论文在当年的被引用次数。因考量期刊自引因素，SJR将期刊自引的门槛限定在33%，超过阈值的自引数不予计算。</p>
				<p class="ind_2">2008年，Nature报到了基于Scopus数据库的期刊评价SJR，认为SJR衡量了期刊的学术声望，还具有免费、刊源范围广等诸多优点，将会有力挑战JCR在国际期刊评价上的垄断。</p>
				<blockquote>
					<p class="ind_2">-Vicente P. Guerrero-Bote a , Félix
						Moya-Anegón. A further step forward in measuring journals'
						scientific prestige: The SJR2 indicator</p>
					<p class="ind_2">
						-SJR-Scopus期刊评价指标[OL].<a
							href="http://tul.blog.ntu.edu.tw/archives/3061" target="_blank">http://tul.blog.ntu.edu.tw/archives/3061</a>，2012-01-12
					</p>
					<p class="ind_2">-Butler D.Free.Journal-ranking tool enters
						citation market.Nature,2008,451(7174):6</p>
				</blockquote>

				<h3 class="title_1" id="go_4">主要参考网站</h3>
				<p class="ind_2">
					1 乌利西国际期刊指南: &nbsp;<a
						href="http://www.ulrichsweb.serialssolutions.com" target="_blank">http://www.ulrichsweb.serialssolutions.com</a>
				</p>
				<p class="ind_2">
					2 Web of Science: &nbsp;<a href="http://webofknowledge.com"
						target="_blank">http://webofknowledge.com</a>
				</p>
				<p class="ind_2">
					3 Scopus: &nbsp;<a href="http://www.scopus.com" target="_blank">http://www.scopus.com</a>
				</p>
				<p class="ind_2">
					4 EI: &nbsp;<a href="http://www.engineeringvillage.com"
						target="_blank">http://www.engineeringvillage.com</a>
				</p>
				<p class="ind_2">
					5 CA: &nbsp;<a href="http://www.cas.org" target="_blank">http://www.cas.org
					</a>
				</p>
				<p class="ind_2">
					6 JCR: &nbsp;<a href="http://webofknowledge.com/jcr"
						target="_blank">http://webofknowledge.com/jcr</a>
				</p>
				<p class="ind_2">
					7 Eigenfactor: &nbsp;<a href="http://eigenfactor.org"
						target="_blank">http://eigenfactor.org </a>
				</p>
				<p class="ind_2">
					8 SJR: &nbsp;<a href="http://www.scimagojr.com/journalrank.php"
						target="_blank">http://www.scimagojr.com/journalrank.php</a>
				</p>
				<p class="ind_2">
					9 中科院JCR分区: &nbsp;<a href="http://www.fenqubiao.com"
						target="_blank">http://www.fenqubiao.com </a>
				</p>
				<p class="ind_2">
					10 CSCD: &nbsp;<a href="http://sciencechina.cn" target="_blank">http://sciencechina.cn</a>
				</p>
				<p class="ind_2">
					11 CCSCI: &nbsp;<a href="http://cssci.com.cn" target="_blank">http://cssci.com.cn</a>
				</p>
				<p class="ind_2">
					12 CNKI: &nbsp;<a href="http://www.cnki.net" target="_blank">http://www.cnki.net
					</a>
				</p>
				<p class="ind_2">
					13 维普: &nbsp;<a href="http://www.cqvip.com/journal" target="_blank">http://www.cqvip.com/journal</a>
				</p>
				<p class="ind_2">
					14 万方: &nbsp;<a href="http://g.wanfangdata.com.cn" target="_blank">http://g.wanfangdata.com.cn
					</a>
				</p>

			</div>
		</div>
		<!--end subpage_nr-->
	</div>
	<div class="clear"></div>
</div>
<!--footer-->
<div class="tool" id="tool">
	<span class="toTop"><a id="toTop" href="#" title='返回顶部'></a></span>
</div>
<jsp:include page="common/footer.jsp"></jsp:include>
<script src="resources/<cms:getSiteFlag/>/js/index.js"></script>
</body>
</html>

