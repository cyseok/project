package com.project.dao;

import java.util.List;
import java.util.Map;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;


public interface UserinfoDAO {
   /*회원가입*/
   int insertUserinfo(Userinfo userinfo);//회원정보삽입(회원가입)

   
   /*로그인*/
   Userinfo userinfoLogin(Userinfo userinfo);//로그인 
   
   /*아이디 찾기*/
   Userinfo findUserByEmail(String email);
   
   /*마이페이지*/
   Userinfo selectUserinfoById(String id);//아이디로 유저 정보 검색
   
   /*관리자*/
   Userinfo selectUserinfo(String id);//조건에 따른 유저 정보 검색

   
   /*Auth*/
   int insertSecurityAuth(SecurityAuth auth);
   SecurityAuth selectSecurityAuthById(String id);
}