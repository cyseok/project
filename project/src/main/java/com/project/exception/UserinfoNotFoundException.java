package com.project.exception;

public class UserinfoNotFoundException extends Exception {
	private static final long serialVersionUID = 1L;

	public UserinfoNotFoundException() {
		
	}

	public UserinfoNotFoundException(String message) {
		super(message);
	}
}