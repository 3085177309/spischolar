package com.wd.front.interceptor;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wd.service.OrgApiService;
import com.wd.util.IpUtil;
import com.wd.util.LoginUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.bo.ProductEnum;
import com.wd.backend.model.Org;
import com.wd.backend.model.Product;
import com.wd.comm.Comm;
import com.wd.front.module.cache.CacheModuleI;
import com.wd.front.service.OrgInfoServiceI;

/**
 * 检测用户是否有权限使用本产品
 * @author Administrator
 *
 */
public class ProductInterceptor extends HandlerInterceptorAdapter{
    private static final Logger logger=Logger.getLogger(ProductInterceptor.class);
	@Autowired
	private OrgInfoServiceI orgInfoService;

	@Autowired
    private OrgApiService orgApiService;

	
	@Autowired
	private CacheModuleI cacheModule;

	@Value("${crs.path}")
	private String crsPath;


	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,
			Object obj) throws Exception {
        boolean indexShow= false;
        boolean journalShow = false;
        boolean scholarShow = false;
        boolean crsShow =false;
		OrgBO org = (OrgBO) req.getSession().getAttribute(Comm.ORG_SESSION_NAME);
        String ip = IpUtil.getIpAddr(req);
        String zky = "2";
        if (org == null) {//通过ip获取机构信息
            try {
                org = orgApiService.getOrgByIp(ip);
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
        }
        List<Product> products = null;
		if (cacheModule!=null){
            products=cacheModule.getOrgProductList(org.getFlag());
        }

		if(products==null){
			products=orgInfoService.findProductListByOrg(org.getFlag());
			cacheModule.putOrgProductList(org.getFlag(), products);
		}
		//List<Product> products=orgInfoService.findProductListByOrg(org.getFlag());
		String jcryears = org.getJcryear();
		List<String> yearlist = new ArrayList<String>();
		if(jcryears!=null && !"".equals(jcryears)){
			String[] arrys = jcryears.split(";");
			for(String year:arrys){
				yearlist.add(year);
			}
		}
		if(yearlist.size()>0){
			Collections.sort(yearlist,Collections.reverseOrder());//倒排序
		}
		req.getSession().setAttribute("jcrYearList", yearlist);
		String uri=req.getRequestURI();
		boolean validated=false;
		Org deliveryOrgInfo = orgInfoService.getOrgByFlag(org.getFlag());

		//---modify start by hezhigang 2017.11.13------------------
		Short proStatus = 2; //试用

		if (products==null || products.size()<=0){ //如果没有产品，转发到404
			resp.sendRedirect(req.getContextPath() + "/sites/404.jsp");
		}else {
			for(Product pro:products){
				validated = true;
				if(pro.getProductId()==ProductEnum.JournalNav.value() && pro.getStatus()!=0){
					if (pro.getStatus()==1){ //购买,有jcr权限
						zky = "1";
						proStatus = 1;
					}
                    journalShow = true;
					req.getSession().setAttribute("journalShow",journalShow);
				}
				else if(pro.getProductId() == ProductEnum.AcademicDiscovery.value() && pro.getStatus()!=0) {
					if (pro.getStatus()==1){ //购买
						proStatus = 1;
					}
                    scholarShow = true;
					req.getSession().setAttribute("scholarShow",scholarShow);
				}
				else if(pro.getProductId()==ProductEnum.CSR.value()&&pro.getStatus()!=0 && !pro.isSingle()) {
                    crsShow = true;
					req.getSession().setAttribute("crsShow",crsShow);
                    req.getSession().setAttribute("crsPath", crsPath);
				}
			}
            if (journalShow&&scholarShow){
                indexShow = true;
            }
            req.getSession().setAttribute("indexShow",indexShow);
		}
		req.getSession().setAttribute("diliveryCount", deliveryOrgInfo.getDeliveryCount());//游客文献传递数量
		req.getSession().setAttribute("userDeliveryCount", deliveryOrgInfo.getUserDeliveryCount());//用户文献传递数量
		req.getSession().setAttribute("zky", zky);
		req.getSession().setAttribute("proStatus",proStatus);



		return validated;
	}
}
