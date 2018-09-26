package com.wd.service;

import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

/**
 * 期刊检索查询服务接口,改接口是提供给学科平台使用的
 * @author Shenfu
 *
 */
@WebService
@SOAPBinding(style = Style.RPC)
public interface WSSearchService {
	
	/**
	 * <params>
	 * 	<subjects>
	 * 		<subject><!--学科查询时可以不要分区(partitiion),但是其他三个同时出现时才能查询到数据-->
	 * 			<name>SCI-E</name><!--体系名-->
	 * 			<value>CHEMISTRY</value><!--学科-->
	 * 			<year>2013</year><!--年份-->
	 * 			<partition>1</partition><!--分区(1-4)-->
	 * 		</subject>
	 * 	</subjects>
	 * 	<field></field> <!-- 检索字段值 all(全部),title(标题中检索),issn,contry(国家) -->
	 * 	<value></value> <!--检索值-->
	 *  <order></order> <!--排序方式(0、表示默认排序 1、年升序 2、年降序 3、刊名升序 4、刊名降序 6、按影响因子排序 7、按评价值排序 8、按学科序号排)-->
	 *  <orderValue></orderValue><!--排序使用到的值,动态获取,order为7或8时有值-->
	 *  <isoa></isoa> <!--是否是OA期刊 是1,否0-->
	 *  <shoulu></shoulu> <!--收录 (SCI-E,SSCI,SJR,CSCD,CSSCI,北大核心,多个以分号分割)-->
	 *  <lang></lang> <!--语言值0(全部),1(中文),2(外文)-->
	 *  <offset></offset><!--整形偏移量(默认0)-->
	 *  <size></size><!--每页显示数量(默认25)-->
	 *  <firstLetter></firstLetter><!--首字母(a-z)-->
	 * </params>
	 * @param requestParam
	 * @return
	 */
	public String search(@WebParam(name = "param") String requestParam);
	
	/**
	 * 获取学科体系
	 * @return
	 */
	public String getSystems();
	
	/**
	 * 查询学科列表
	 * <params>
	 * 	<name>SCI-E</name>
	 * 	<year>2013</year>
	 * </params>
	 * @param requestParam
	 * @return
	 */
	public String getSubjects(@WebParam(name = "param") String requestParam);
	
	/**
	 * 文章搜索
	 * @param requestParam
	 * @return
	 */
	public String articleSearch(@WebParam(name = "param") String requestParam) ;
	
	/**
	 * 查询期刊的地址
	 * @param id
	 * @return
	 */
	public String getLinks(@WebParam(name = "id") String flag);
	
	/**
	 * @param requestParam
	 * @return
	 */
	public String searchMore(@WebParam(name = "param") String requestParam);
	
	/**
	 * @param requestParam
	 * @return
	 */
	public String searchById(@WebParam(name = "id") String id);
	
	
	/**
	 * <params>
	 * 	<value></value> <!--检索值-->
	 *  <order></order> <!--排序方式(0、表示默认排序 1、年升序 2、年降序 3、刊名升序 4、刊名降序 6、按影响因子排序 7、按评价值排序 8、按学科序号排)-->
	 * </params>
	 * @param requestParam
	 * @return
	 */
	public String searchForZHY(@WebParam(name = "param") String requestParam);
	
	
	
	/**
	 * 微服务接口拆分（search，searchMore）
	 * @param requestParam
	 * @return
	 */
	public String find(String requestParam);
	
}
