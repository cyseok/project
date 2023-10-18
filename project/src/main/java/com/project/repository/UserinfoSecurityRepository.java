package com.project.repository;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;

public interface UserinfoSecurityRepository {
	int insertUserinfoSecurity(Userinfo userinfo);
	int insertSecurityAuth(SecurityAuth auth);
	Userinfo selectUserinfoSecurityByUserid(String id);
}
