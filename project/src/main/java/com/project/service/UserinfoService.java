package com.project.service;

import java.util.Map;

import com.project.dto.Userinfo;
import com.project.dto.UserinfoAuth;
import com.project.exception.ExistsUserinfoException;
import com.project.exception.LoginAuthFailException;
import com.project.exception.UserinfoNotFoundException;

public interface UserinfoService {
	
	/*회원가입*/
	void addUserinfo(Userinfo userinfo, String userinfoRole) throws ExistsUserinfoException;
	void addUserinfoAuth(UserinfoAuth auth) throws ExistsUserinfoException;
	int idCheck(String id) throws Exception;
	int emailCheck(String email) throws Exception;

	/*로그인*/
	Userinfo getUserinfoLogin(String id) throws LoginAuthFailException;//로그인
	void updateUserLogindate(String id);//마지막 로그인 시간

	/*아이디 찾기*/
	Userinfo findUserByEmail(String email);

	/*마이페이지*/
	Userinfo getUserinfoById(String id) throws UserinfoNotFoundException;//아이디로 유저 검색 

	/*관리자*/
	Userinfo getUserinfo(String id) throws UserinfoNotFoundException;//아이디로 전달값을 제공받아 회원정보 받음
	Map<String, Object> getUserinfoList(int pageNum, int pageSize);//회원목록 출력

}