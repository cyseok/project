package com.project.mapper;


import org.apache.ibatis.annotations.Param;

import com.project.dto.UserinfoAuth;
import com.project.dto.Userinfo;

public interface UserinfoMapper {
	
   /* 회원가입 */
   int insertUserinfo(Userinfo userinfo);
   int insertSecurityAuth(UserinfoAuth auth);
   int idCheck(String id);  //아이디 중복검사
   int emailCheck(String id);  // 이메일 중복검사

   /* 로그인, 로그인 날짜 갱신 */
   Userinfo selectUserinfoLogin(String id);
   int updateLogdate(String id); 

   /* 아이디 찾기 */
   Userinfo findUserinfo(@Param("name") String name,@Param("email") String email);
   
   /* 마이페이지 */
   Userinfo selectUserinfoById(String id);
   
   /* 닉네임 변경 */
   int updateNickname(Userinfo userinfo);

   
}