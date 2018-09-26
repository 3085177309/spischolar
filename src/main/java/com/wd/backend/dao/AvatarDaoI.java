package com.wd.backend.dao;

import java.util.List;
import java.util.Map;

import com.wd.front.bo.Avatar;

public interface AvatarDaoI {

	public void insert(Avatar avatar);
	
	public List<Avatar> findList(Map<String,Object> params);
	
}
