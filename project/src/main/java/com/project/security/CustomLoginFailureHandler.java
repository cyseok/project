package com.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

//로그인 실패 후에 실행될 기능을 제공하기 위한 클래스x
// => 로그인 실패 횟수 누적, 계정 비활성화 처리 등의 기능 구현
// => AuthenticationFailureHandler 인터페이스를 상속받아 작성하거나 AuthenticationFailureHandler 
//인터페이스를 상속받은 클래스를 상속받아 작성
public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
	        AuthenticationException exception) throws IOException, ServletException {

	    String errorMessage = "ID와 PW가 올바르지 않습니다."; 
	    
	    if (exception instanceof BadCredentialsException) {
	        errorMessage = "ID와 PW가 올바르지 않습니다.";
	    } else if (exception instanceof DisabledException) {
	        errorMessage = "계정이 사용 불가합니다.";
	    } 

	    // 에러 메시지 추가
	    request.setAttribute("loginError", errorMessage);
	    
	    // 사용자 ID를 세션에 저장
	    request.getSession().setAttribute("userid", request.getParameter("userid"));
	    
	    // 실패 URL로 포워딩
	    request.getRequestDispatcher("/post").forward(request, response);
	}

}