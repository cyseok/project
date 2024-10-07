package com.project.security;

import java.io.IOException; 
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

// 로그인 성공 후에 실행될 기능을 제공하기 위한 클래스
// => 사용자의 마지막 로그인 날짜를 변경 처리 또는 로그인 실패 횟수 초기화 등의 기능 구현
// => AuthenticationSuccessHandler 인터페이스를 상속받아 작성하거나 AuthenticationSuccessHandler 인터페이스를 상속받은 클래스를 상속받아 작성

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	//로그인 계정의 권한을 확인하여 특정 페이지로 이동되도록 설정
	//Authentication 객체 : 인증 및 인가(권한)와 관련된 정보를 저장한 객체
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request
								, HttpServletResponse response
								, Authentication authentication) throws IOException, ServletException {
		// 로그인 사용자의 권한의 저장하기 위한 List 객체 생성
		List<String> roleNames=new ArrayList<String>();

		// GrantedAuthority 객체 : 사용자에게 부여된 권한에 대한 정보를 저장한 객체
		// Authentication.getAuthorities() : 인증된 계정의 모든 권한(GrantedAuthority 객체)을 List 객체로 반환
		// GrantedAuthority.getAuthority() : GrantedAuthority 객체에 저장된 권한을 반환하는 메소드 
		for(GrantedAuthority authority : authentication.getAuthorities()) {
			roleNames.add(authority.getAuthority());
		}

		if(roleNames.contains("ROLE_MASTER")) {
			response.sendRedirect(request.getContextPath() + "/admin");
			return;			
		} else {
			response.sendRedirect(request.getContextPath() + "/post");
			return;
		}
	}
}