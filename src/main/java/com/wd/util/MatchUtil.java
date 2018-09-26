package com.wd.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MatchUtil {
	
	
	public static String getMatcher(String managers, String patternString) {
		String val = null;
        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(managers);
        while(matcher.find()) {
            val = matcher.group();
        }
        return val;
		
	}

}
