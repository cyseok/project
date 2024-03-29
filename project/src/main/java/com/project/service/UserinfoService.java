package com.project.service;


import com.project.dto.Userinfo;
import com.project.dto.UserinfoAuth;
import com.project.exception.ExistsUserinfoException;
import com.project.exception.LoginAuthFailException;

public interface UserinfoService {
	
	/* 회원가입 */
	void addUserinfo(Userinfo userinfo, String userinfoRole) throws ExistsUserinfoException;
	void addUserinfoAuth(UserinfoAuth auth) throws ExistsUserinfoException;
	int idCheck(String id) throws Exception;
	int emailCheck(String email) throws Exception;

	/* 로그인 */
	Userinfo getUserinfoLogin(String id) throws LoginAuthFailException;//로그인
	void updateUserLogindate(String id);//마지막 로그인 시간

	/* 아이디 찾기 */
	Userinfo findUserinfo(String name, String email);

	/* 마이페이지 */
	Userinfo getUserinfoById(String id);
	
	// 닉네임 변경
    void modifyNickname(Userinfo userinfo);

}