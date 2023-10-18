package com.project.exception;

import com.project.dto.Userinfo;

import lombok.Getter;

//회원정보를 등록할 때 사용자로부터 입력받은 회원정보의 아이디가 기존 회원정보의 아이디와 중복될 경우 
//발생될 예외를 처리하기 위한 예외 클래스

@Getter
public class ExistsUserinfoException extends Exception {
	private static final long serialVersionUID = 1L;
	//예외처리에 필요한 값을 저장하기 위한 필드 선언
	private Userinfo userinfo; //사용자로부터 입력받은 회원정보를 저장

	public ExistsUserinfoException() {
		// TODO Auto-generated constructor stub
	}
	
	//매개변수로 예외 메세지와 예외처리에 필요한 값을 전달받아 필드에 저장 
	public ExistsUserinfoException(String message, Userinfo userinfo) {
		super(message);//부모 클래스 Exception의 생성자 호출 - 객체 생성시 메세지 전달 가능
		this.userinfo=userinfo;//클래스 내의 멤버 변수에 값 할당
	}
}
