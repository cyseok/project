package com.project.exception;

public class NoticeNotFoundException extends RuntimeException{
	
	private static final long serialVersionUID = 1L;

	public NoticeNotFoundException(String message) {
		 super(message);
	}
}

