package com.wd.service;

import com.wd.backend.bo.OrgBO;
import com.wd.backend.model.Org;

public interface OrgApiService {
	
	public OrgBO getOrgByIp(String ip);
	
	public Org getOrgByFlag(String flag);

}
