package com.wd.task;

import org.springframework.stereotype.Component;

import com.wd.util.ClientUtil;

/**
 * 在指定的间隔时间内，不停的向es发送请求，保持客户端的可用性
 * 
 * @author pan
 * 
 */
@Component("esClientLiveTask")
public class EsClientLiveTask {
//
//	public void execute() {
//		ClientUtil.getClient().admin().cluster().prepareClusterStats().execute().actionGet();
//	}
}
