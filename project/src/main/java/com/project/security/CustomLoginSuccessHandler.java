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

//로그인 성공 후에 실행될 기능을 제공하기 위한 클래스
// => 사용자의 마지막 로그인 날짜를 변경 처리 또는 로그인 실패 횟수 초기화 등의 기능 구현
// => AuthenticationSuccessHandler 인터페이스를 상속받아 작성하거나 AuthenticationSuccessHandler 
//인터페이스를 상속받은 클래스를 상속받아 작성
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	//로그인 계정의 권한을 확인하여 특정 페이지로 이동되도록 설정
	//Authentication 객체 : 인증 및 인가(권한)와 관련된 정보를 저장한 객체
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		//로그인 사용자의 권한의 저장하기 위한 List 객체 생성
		List<String> roleNames=new ArrayList<String>();

		//Authentication.getAuthorities() : 인증된 계정의 모든 권한(GrantedAuthority 객체)을 
		//List 객체로 반환하는 메소드
		//GrantedAuthority 객체 : 사용자에게 부여된 권한에 대한 정보를 저장한 객체
		for(GrantedAuthority authority : authentication.getAuthorities()) {
			//GrantedAuthority.getAuthority() : GrantedAuthority 객체에 저장된 권한을 반환하는 메소드 
			roleNames.add(authority.getAuthority());
		}

		// Collection<T>.contains(T obj): Collection 객체(자료 구조 객체)에 저장된 요소의 존재 유무를 확인하여
		// 요소의 객체가 없는 경우 [false] / 있는 경우 [true] 반환하는 메소드
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect(request.getContextPath() + "/admin/main");
			return;			
		} else {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
	}
}