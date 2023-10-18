package com.project.mapper;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;

public interface UserinfoSecurityMapper {
	int insertUserinfoSecurity(Userinfo userinfo);
	int insertSecurityAuth(SecurityAuth auth);
	Userinfo selectUserinfoSecurityByUserid(String id);
}
