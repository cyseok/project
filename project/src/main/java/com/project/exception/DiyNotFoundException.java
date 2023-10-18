package com.project.exception;

public class DiyNotFoundException extends RuntimeException{
	
	private static final long serialVersionUID = 1L;

	public DiyNotFoundException(String message) {
		 super(message);
	}
}

