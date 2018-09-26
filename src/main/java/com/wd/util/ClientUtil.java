package com.wd.util;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.settings.Settings.Builder;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;

public class ClientUtil {

//    private static Builder defaultSettings = Settings.builder()
//            .put("client.transport.sniff", false)
//            .put("client.transport.ignore_cluster_name",true);
//
//    /** 修改hosts文件
//    192.168.1.75	elastic-node1
//    192.168.1.76	elastic-node2
//    192.168.1.77	elastic-node3
//    */
//    private static String[] HOSTS = new String[]{"elastic-node1","elastic-node2","elastic-node3"};
//
//    private static final int PORT = 8300;
//    private static TransportClient CLIENT;
//
//    static {
//        for (String host:HOSTS){
//            try{
//                if (InetAddress.getByName(host).getHostAddress().startsWith("192.168.1.1")){
//                    defaultSettings.put("cluster.name", "wdkj");
//                } else {
//                    defaultSettings.put("cluster.name", "wdkj-test");
//                }
//            }catch (UnknownHostException e) {
//                e.printStackTrace();
//            }
//            break;
//        }
//        CLIENT = new PreBuiltTransportClient(defaultSettings.build());
//    }
//
//    public static Client getClient() {
//        for (String host:HOSTS){
//            try {
//                CLIENT.addTransportAddresses(new InetSocketTransportAddress(InetAddress.getByName(host),PORT));
//            } catch (UnknownHostException e) {
//                e.printStackTrace();
//            }
//        }
//        return CLIENT;
//    }
	 public static Client getClient() {
		 return null;
	 }
	
}
