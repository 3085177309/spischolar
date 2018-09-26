package com.wd.util;

import java.util.List;

import com.wd.backend.model.AuthorityDatabase;

public class AuthorityDbUtil {

	public static AuthorityDatabase findPartition(List<AuthorityDatabase> allDbPartitionList, String db) {
		if (null != allDbPartitionList) {
			for (AuthorityDatabase tmp : allDbPartitionList) {
				if (db.equals(tmp.getFlag())) {
					return tmp;
				}
			}
		}
		return null;
	}
}
