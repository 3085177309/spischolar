package com.wd.util;

import javax.servlet.http.HttpSession;

import com.wd.backend.model.Member;
import com.wd.comm.Comm;
/**
 * 从session中获取用户ID
 * @author Administrator
 *
 */
public class MemberIdFromSession {
	
	public static Integer getMemberId(HttpSession session){
		int memberId = 0;
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		String id = (String) session.getAttribute("spischolarID");
		if(user != null){
			memberId= user.getId();
		} else if(id != null) {
			memberId= Integer.parseInt(id);
		}
		return memberId;
	}
	
	public static String getMemberEmail(HttpSession session){
		String email = null;
		Member user=(Member)session.getAttribute(Comm.MEMBER_SESSION_NAME);
		if(user != null){
			email= user.getEmail();
		}
		return email;
	}

}
