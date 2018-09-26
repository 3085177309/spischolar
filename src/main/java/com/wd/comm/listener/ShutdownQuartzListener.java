package com.wd.comm.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.context.ApplicationContext;

import com.wd.util.SpringContextUtil;

/**
 * 销毁启动的job
 * 
 * @author Administrator
 * 
 */
public class ShutdownQuartzListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ApplicationContext applicationContext = SpringContextUtil.getApplicationContext();
		Scheduler scheduler = (Scheduler) applicationContext.getBean("pollingFaction");
		try {
			scheduler.shutdown(true);
			Thread.sleep(1000);
		} catch (SchedulerException | InterruptedException e) {
			e.printStackTrace();
		}
	}

}
