package com.project.auth;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.project.dto.Userinfo;
import com.project.dto.UserinfoAuth;
import com.project.exception.ExistsUserinfoException;
import com.project.exception.UserinfoNotFoundException;
import com.project.security.CustomUserDetails;
import com.project.security.GoogleLoginBean;
import com.project.service.UserinfoService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/google")
@RequiredArgsConstructor
public class GoogleLoginController {
	private final GoogleLoginBean googleLoginBean;
	private final UserinfoService userinfoService;

	@RequestMapping("/login")
	public String googlelogin(HttpSession session) throws UnsupportedEncodingException {
		String googleAuthUrl = googleLoginBean.getAuthorizationUrl(session);
		return "redirect:" + googleAuthUrl;
	}

	@RequestMapping("/callback")
	public String googlelogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException, ExistsUserinfoException, UserinfoNotFoundException, ParseException {
		OAuth2AccessToken accessToken = googleLoginBean.getAccessToken(session, code, state);

		String apiResult = googleLoginBean.getUserProfile(accessToken);

		JSONParser parser = new JSONParser();
		Object object = parser.parse(apiResult);
		JSONObject responseObject = (JSONObject) object;

		String id = (String) responseObject.get("id");
		String email = (String) responseObject.get("email");
		String name = (String) responseObject.get("name");

		UserinfoAuth auth = new UserinfoAuth();
		auth.setId("google_" + id);
		auth.setAuth("ROLE_SOCIAL");

		List<UserinfoAuth> authList = new ArrayList<UserinfoAuth>();
		authList.add(auth);

		Userinfo userinfo = new Userinfo();
		userinfo.setId("google_" + id);
		userinfo.setPw(UUID.randomUUID().toString());
		userinfo.setName(name);
		userinfo.setEmail(email);
		userinfo.setAddress(null);
		userinfo.setEnabled("0");
		userinfo.setSecurityAuthList(authList);
		
		// 사용자의 정보를 userinfo 테이블과 auth 테이블에 저장
		userinfoService.addUserinfo(userinfo, "ROLE_SOCIAL");
		userinfoService.addUserinfoAuth(auth);
		userinfoService.updateUserLogindate(userinfo.getId());
		
		//네이버 로그인 사용자 정보를 사용하여 UserDetails 객체(로그인 사용자)를 생성하여 저장
		CustomUserDetails customUserDetails=new CustomUserDetails(userinfo);
		
		//UsernamePasswordAuthenticationToken 객체를 생성하여 Spring Security가 사용 가능한 인증 사용자로 등록 처리
		//UsernamePasswordAuthenticationToken 객체 : 인증 성공한 사용자를 Spring Security가 사용 가능한 인증 사용자로 등록 처리하는 객체
		Authentication authentication=new UsernamePasswordAuthenticationToken
				(customUserDetails, null, customUserDetails.getAuthorities());
		
		//SecurityContextHolder 객체 : 인증 사용자의 권한 관련 정보를 저장하기 위한 객체
		SecurityContextHolder.getContext().setAuthentication(authentication);
			
		return "redirect:/post";
	}
}
