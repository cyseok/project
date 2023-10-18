package com.project.exception;

import lombok.Getter;

//로그인할때 사용자로부터 입력받은 아이디와 비밀번호에 대한 인증이 실패한 경우
//발생될 예외를 처리하기 위한 예외 클래스 
public class LoginAuthFailException extends Exception {
    private static final long serialVersionUID = 1L;
    
    //예외처리에 필요한 값을 저장하기 위한 필드
    // -> 사용자로부터 입력받은 아이디를 저장하기 위한 필드
    @Getter
    private String userid;
    
    public LoginAuthFailException(String message) {
        super(message);
    }
    
    public LoginAuthFailException(String message, String userid) {
        super(message);
        this.userid = userid;
    }
}