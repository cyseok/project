package com.project.dao;


import com.project.dto.UserinfoAuth;
import com.project.dto.Userinfo;

public interface UserinfoDAO {
	
   /* 회원가입 */
   int insertUserinfo(Userinfo userinfo);
   int insertSecurityAuth(UserinfoAuth auth);
   int idCheck(String id);
   int emailCheck(String email);
   
   /* 로그인, 로그인 날짜 갱신 */
   Userinfo selectUserinfoLogin(String id);
   int updateLogdate(String id);  
   
   /* 아이디 찾기 */
   Userinfo findUserinfo(String name, String email);
   
   /* 마이페이지 */
   Userinfo selectUserinfoById(String id);
   
   /* 닉네임 변경 */
   int updateNickname(Userinfo userinfo);
   
   
}