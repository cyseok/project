package com.project.exception;

//회원정보에 대한 변경, 삭제, 검색할 때 사용자로부터 전달받은 아이디의 회원정보가 없는 경우 
//발생될 예외를 처리하기 위한 예외 클래스 
public class UserinfoNotFoundException extends Exception {
	private static final long serialVersionUID = 1L;

	public UserinfoNotFoundException() {
		// TODO Auto-generated constructor stub
	}

	public UserinfoNotFoundException(String message) {
		super(message);//부모 클래스 Exception의 생성자 호출 - 객체 생성시 메세지 전달 가능
	}
}