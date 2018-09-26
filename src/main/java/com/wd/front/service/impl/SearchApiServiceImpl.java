package com.wd.front.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.wd.front.bo.SearchCondition;
import com.wd.front.service.SearchApiServiceI;

@Service("searchAPIService")
public class SearchApiServiceImpl implements SearchApiServiceI {
	
	@Autowired
    private RestTemplate restTemplate;
	
	@Value("${cloud_server_adress}")
	private String cloudServerAdress;
    
    public String getSubjectList(int subjectNameId, int id, String year, String subject) {
    	if(subject == null) {
    		subject = "";
    	}
    	String url = cloudServerAdress + "/search-server/subject/"+subjectNameId +"/"+ id + "/" + year + "?subject=" + subject;
        String result = restTemplate.getForObject(url, String.class);
        return result;
    }
    
    public String getById(String id) {
    	String url = cloudServerAdress + "/search-server/detail/" + id;
        String result = restTemplate.getForObject(url, String.class);
    	return result;
    }
    
    /**
     * 从微服务获取数据
     * @return
     */
    public String searchBywfw(String url,SearchCondition condition) {
    	String result = restTemplate.getForObject(url, String.class, condition);
      	return result;
    }

}
