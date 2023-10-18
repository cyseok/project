package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;
import com.project.mapper.UserinfoMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserinfoDAOImpl implements UserinfoDAO {
   private final SqlSession sqlSession;

   /* 회원가입 */

   // 회원가입
   @Override
   public int insertUserinfo(Userinfo userinfo) {
      return sqlSession.getMapper(UserinfoMapper.class).insertUserinfo(userinfo);
   }

   /* 로그인 */

   @Override
   public Userinfo userinfoLogin(Userinfo userinfo) {
      return sqlSession.getMapper(UserinfoMapper.class).userinfoLogin(userinfo);
   }

   /* 아이디 찾기 */
   @Override
   public Userinfo findUserByEmail(String email) {
      //return sqlSession.selectOne("userinfoMapper.findUserByEmail", email);
      return sqlSession.getMapper(UserinfoMapper.class).findUserByEmail(email);
   }

   /* 마이페이지 */


   // 아이디로 유저 검색
   @Override
   public Userinfo selectUserinfoById(String id) {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoById(id);
   }
   /* 관리자 */



   // 아이디로 유저 검색
   @Override
   public Userinfo selectUserinfo(String id) {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoById(id);
   }


	/* Auth */
	@Override
	public int insertSecurityAuth(SecurityAuth auth) {
		return sqlSession.getMapper(UserinfoMapper.class).insertSecurityAuth(auth);
	}

	@Override
	public SecurityAuth selectSecurityAuthById(String id) {
		return sqlSession.getMapper(UserinfoMapper.class).selectSecurityAuthById(id);
	}
}