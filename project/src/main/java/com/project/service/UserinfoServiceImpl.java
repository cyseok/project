package com.project.service;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.dao.UserinfoDAO;
import com.project.dto.UserinfoAuth;
import com.project.dto.Userinfo;
import com.project.exception.LoginAuthFailException;
import com.project.exception.UserinfoNotFoundException;
import com.project.util.Pager;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserinfoServiceImpl implements UserinfoService {
	private final UserinfoDAO userinfoDAO;
	private final BCryptPasswordEncoder pwEncoder;

	/* 회원가입 */
	@Override
	public void addUserinfo(Userinfo userinfo, String userinfoRole) {
		String rawPw = userinfo.getPw(); // 사용자가 입력한 원래의 비밀번호
		String encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		userinfo.setPw(encodePw); // 인코딩된 비밀번호를 설정

		userinfoDAO.insertUserinfo(userinfo);
		
		/* 권한 설정 */
		if(userinfoRole.equals("ROLE_USER")) {
			userinfoDAO.insertSecurityAuth(new UserinfoAuth(userinfo.getId(),"ROLE_USER"));
		}
		if(userinfoRole.equals("ROLE_ADMIN")) {
			userinfoDAO.insertSecurityAuth(new UserinfoAuth(userinfo.getId(),"ROLE_ADMIN"));
		}
	}

	@Override
	public void addUserinfoAuth(UserinfoAuth auth) {
		userinfoDAO.insertSecurityAuth(auth);
	}
	
	/* 로그인 */
	@Override
	public Userinfo getUserinfoLogin(String id) throws LoginAuthFailException{
		return userinfoDAO.selectUserinfoLogin(id);
	}

	/* 아이디 찾기 */
	@Override
	public Userinfo findUserinfo(String name, String email) {
		return userinfoDAO.findUserinfo(name, email);
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
	@Override
	public Userinfo getUserinfoById(String id) throws UserinfoNotFoundException {
		Userinfo userinfo = userinfoDAO.selectUserinfoById(id);
		// 검색된 회원정보가 없는 경우
		if (userinfo == null) {
			throw new UserinfoNotFoundException("아이디의 회원정보가 존재하지 않습니다.");
		}
		return userinfo;
	}
	
	// 마지막 로그인 시간 갱신 
	@Override
	public void updateUserLogindate(String id) {
		userinfoDAO.updateLogdate(id);
	}

	//회원 리스트 조회 기능
	@Override
	public Map<String, Object> getUserinfoList(int pageNum, int pageSize) {
		int totalBoard = userinfoDAO.selectUserinfoCount();
		int blockSize = 10;
		Pager pager = new Pager(pageNum, totalBoard, pageSize, blockSize);

		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("startRow", pager.getStartRow());
		pageMap.put("endRow", pager.getEndRow());

		List<Userinfo> userinfoList = userinfoDAO.selectUserinfoList(pageMap);

		Map<String, Object> userinfoMap = new HashMap<String, Object>();
		userinfoMap.put("userinfoList", userinfoList);
		userinfoMap.put("pager", pager);

		return userinfoMap;
	}
		
}