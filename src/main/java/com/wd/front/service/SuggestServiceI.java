package com.wd.front.service;

import java.util.List;

public interface SuggestServiceI {
	
	public List<String> getSuggest(String value);
	
	public List<String> getSuggest(String value,int size);

}
