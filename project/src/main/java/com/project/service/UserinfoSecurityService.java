package com.project.service;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;

public interface UserinfoSecurityService {
	void addUserinfoSecurity(Userinfo userinfo);
	void addSecurityAuth(SecurityAuth auth);
	Userinfo getUserinfoSecurity(String id);

}
