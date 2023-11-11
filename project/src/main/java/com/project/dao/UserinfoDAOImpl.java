package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.dto.UserinfoAuth;
import com.project.dto.Userinfo;
import com.project.mapper.UserinfoMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserinfoDAOImpl implements UserinfoDAO {
   private final SqlSession sqlSession;

   /* 회원가입 */
   @Override
   public int insertUserinfo(Userinfo userinfo) {
      return sqlSession.getMapper(UserinfoMapper.class).insertUserinfo(userinfo);
   }
   
   @Override
   public int insertSecurityAuth(UserinfoAuth auth) {
	   return sqlSession.getMapper(UserinfoMapper.class).insertSecurityAuth(auth);
   }
   
   // 아이디 중복검사
   @Override
   public int idCheck(String id) {
      return sqlSession.getMapper(UserinfoMapper.class).idCheck(id);
   }
   // 이메일 중복 검사
   @Override
   public int emailCheck(String email) {
      return sqlSession.getMapper(UserinfoMapper.class).emailCheck(email);
   }

   /* 로그인 */
   @Override
   public Userinfo selectUserinfoLogin(String id) {
      return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoLogin(id);
   }

   @Override
   public int updateLogdate(String id) {
      return sqlSession.getMapper(UserinfoMapper.class).updateLogdate(id);
   }
   
   /* 아이디 찾기 */
   @Override
   public Userinfo findUserByEmail(String email) {
      //return sqlSession.selectOne("userinfoMapper.findUserByEmail", email);
      return sqlSession.getMapper(UserinfoMapper.class).findUserByEmail(email);
   }

   /* 마이페이지 */
   @Override
   public Userinfo selectUserinfoById(String id) {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoById(id);
   }
   
   /* 관리자 */
   @Override
   public int selectUserinfoCount() {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoCount();
   }

   // 전체 유저 검색
   @Override
   public List<Userinfo> selectUserinfoList(Map<String, Object> map) {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoList(map);
   }

   // 아이디로 유저 검색
   @Override
   public Userinfo selectUserinfo(String id) {
	   return sqlSession.getMapper(UserinfoMapper.class).selectUserinfoById(id);
   }


}