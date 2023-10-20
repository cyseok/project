package com.project.service;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.dao.UserinfoDAO;
import com.project.dto.SecurityAuth;
import com.project.dto.Userinfo;
import com.project.exception.UserinfoNotFoundException;
import com.project.utill.Pager;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserinfoServiceImpl implements UserinfoService {
	private final UserinfoDAO userinfoDAO;
	private final BCryptPasswordEncoder pwEncoder;

	/* 회원가입 */

	// 회원가입
	@Override
	public void registerUser(Userinfo userinfo, String userinfoRole) {
		String rawPw = userinfo.getPw(); // 사용자가 입력한 원래의 비밀번호
		String encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		userinfo.setPw(encodePw); // 인코딩된 비밀번호를 설정

		userinfoDAO.insertUserinfo(userinfo);
		
		if(userinfoRole.equals("ROLE_USER")) {
			userinfoDAO.insertSecurityAuth(new SecurityAuth(userinfo.getId(),"ROLE_USER"));
		}
	}

	/* 로그인 */
	@Override
	public Userinfo userLogin(Userinfo userinfo) {
		return userinfoDAO.userinfoLogin(userinfo);
	}

	/* 아이디 찾기 */
	@Override
	public Userinfo findUserByEmail(String email) {
		return userinfoDAO.findUserByEmail(email);
	}

	// 아이디 중복 검사
	@Override
	public int idCheck(String id) throws Exception {
		return userinfoDAO.idCheck(id);
	}

	// 이메일 중복 검사
	@Override
	public int emailCheck(String email) throws Exception {
		return userinfoDAO.emailCheck(email);
	}

	
	/* 마이페이지 */

	
	/* 로그인 */
	// 아이디로 유저 정보 검색
	@Override
	public Userinfo getUserinfoById(String id) throws UserinfoNotFoundException {
		Userinfo userinfo = userinfoDAO.selectUserinfoById(id);
		// 검색된 회원정보가 없는 경우
		if (userinfo == null) {
			throw new UserinfoNotFoundException("아이디의 회원정보가 존재하지 않습니다.");
		}
		return userinfo;
	}
	// 마지막 로그인 시간
	@Override
	public void updateUserLogindate(String id) {
		userinfoDAO.updateLogdate(id);
	}


	/* 관리자 */
	//회원 정보 조회 기능
	@Override
	public Userinfo getUserinfo(String id) throws UserinfoNotFoundException {
		Userinfo userinfo = userinfoDAO.selectUserinfo(id);
		if (userinfo == null) {
			throw new UserinfoNotFoundException("아이디의 회원 정보가 존재하지 않습니다.");
		}
		return userinfo;
	}

	/* Auth */
	@Override
	public void addSecurityAuth(SecurityAuth auth) {
		userinfoDAO.insertSecurityAuth(auth);
	}

	@Override
	public SecurityAuth getSecurityAuthById(String id) {
		return userinfoDAO.selectSecurityAuthById(id);
	}	
		
}