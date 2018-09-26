package com.wd.util;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.elasticsearch.action.DocWriteRequest.OpType;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.wd.backend.model.BrowseCount;
import com.wd.comm.Comm;

/**
 * 浏览信息存储elasticsearch
 * @author Administrator
 *
 */
@Component
@Scope("singleton")
public class BrowseInfoUtil {
	
	public static void insertBrowseInfo(BrowseCount browseCount) {
		Map<String,Object> map = toMap(browseCount);
		try {
			insert(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void insertAll(List<Map<String,Object>> list) {
		for(int i=0; i<list.size();i++) {
			try {
				insert(list.get(i));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void insert(Map<String,Object> data) throws Exception {
		Client client = ClientUtil.getClient();
		XContentBuilder contentBuilder =  XContentFactory.jsonBuilder().startObject();
		for(Map.Entry<String, Object> entry :data.entrySet()){
			contentBuilder=contentBuilder.field(entry.getKey(), entry.getValue());
		}
		contentBuilder=contentBuilder.endObject();
		try{
			client.prepareIndex(Comm.BROWSE_INDEX, "periodical")
										.setOpType(OpType.INDEX)
										.setSource(contentBuilder).get();
		} catch (RuntimeException e){
			throw new Exception(e);
		}
	}
	
	
	/**
	 * 将Model装换为Map
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String,Object> toMap(BrowseCount browseCount){
		JsonConfig config=new JsonConfig();
		config.setJsonPropertyFilter(new PropertyFilter() {
	        @Override
            public boolean apply(Object source, String name, Object value) {
	            if ("id".equals(name)) {//装换成Map时，不考虑id字段
	                return true;
	            }
	            return false;
	        }
	    });
		
		JSONObject obj=JSONObject.fromObject(browseCount,config);
		return obj;
	}
	

}
