package com.project.controller;

import java.util.Collection;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import com.project.security.CustomUserDetails;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/admin")
public class AdminController {
	
	@GetMapping(value = "/main")
	public String adminpage(Authentication authentication, Model model) {
	    CustomUserDetails userinfo = (CustomUserDetails) authentication.getPrincipal();
	    model.addAttribute("userinfo", userinfo);
	    
	    return "admin/adminmain";
	}

}
