package com.project.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

// 접근이 제한된 페이지를 요청한 경우 실행될 기능을 제공하기 위하한 클래스
// ▶ AccessDeniedHandler 인터페이스를 상속받은 자식클래스를 생성 
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// 접근 제한에 대한 명령 실행 - 계정 잠금 기능 활성화 등의 명령 작성
		response.setContentType("text/html;charset=UTF-8");
        response.getWriter().println("<script>alert('접근 권한이 없습니다');history.go(-1);</script>");
	}
}