package com.project.service;

import java.util.Map;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;
import com.project.exception.ExistsUserinfoException;
import com.project.exception.LoginAuthFailException;
import com.project.exception.UserinfoNotFoundException;

public interface UserinfoService {
	
	/*회원가입*/
	void registerUser(Userinfo userinfo, String userinfoRole) throws ExistsUserinfoException;//회원정보삽입(회원가입)
	int idCheck(String id) throws Exception;//아이디 중복 검사
	int emailCheck(String email) throws Exception;//아이디 중복 검사


	/*로그인*/
	Userinfo userLogin(Userinfo userinfo) throws LoginAuthFailException;//로그인
	void updateUserLogindate(String id);//마지막 로그인 시간



	/*아이디 찾기*/
	Userinfo findUserByEmail(String email);

	/*마이페이지*/
	Userinfo getUserinfoById(String id) throws UserinfoNotFoundException;//아이디로 유저 검색 

	/*관리자*/
	Userinfo getUserinfo(String id) throws UserinfoNotFoundException;//아이디로 전달값을 제공받아 회원정보 받음
	Map<String, Object> getUserinfoList(int pageNum, int pageSize);//회원목록 출력


	
	/*Auth*/
	void addSecurityAuth(SecurityAuth auth);
	SecurityAuth getSecurityAuthById(String id);

}