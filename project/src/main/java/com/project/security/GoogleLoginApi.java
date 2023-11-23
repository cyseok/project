package com.project.security;

import com.github.scribejava.core.builder.api.DefaultApi20;


public class GoogleLoginApi extends DefaultApi20 {
	protected GoogleLoginApi() {

	}

	private static class InstanceHolder {
		private static final GoogleLoginApi INSTANCE = new GoogleLoginApi();
	}

	public static GoogleLoginApi instance() {
		return InstanceHolder.INSTANCE;
	}

	// 사용자 접근 토큰을 제공받기 위한 API의 URL 주소를 반환하는 메소드
	@Override
	public String getAccessTokenEndpoint() {
		return "https://accounts.google.com/o/oauth2/token";
	}
	
	// 로그인 처리를 위한 API의 URL 주소를 반환하는 메소드
	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://accounts.google.com/o/oauth2/v2/auth";
	}
}
