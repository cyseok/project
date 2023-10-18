package com.project.auth;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.UserinfoSecurityService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserinfoSecurityController {
	private final UserinfoSecurityService userinfoSecurityService;
	private final PasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "/security/add")
	@ResponseBody
	public String addUserinfo() {
		return null;
		
	}

}
