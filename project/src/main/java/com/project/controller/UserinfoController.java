package com.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.security.CustomUserDetails;


@Controller
@RequestMapping("/user")
public class UserinfoController {

   // 회원가입 페이지 이동
   @GetMapping("/join")
   public String join() {
      return "user/join";
   }
   
   // 아이디찾기 페이지 이동
   @GetMapping("/find")
   public String find() {
      return "user/find";
   }

   // 아이디찾기 페이지 이동
   @GetMapping("/my-page")
   public String myPage(HttpSession session, Authentication authentication) {
	   CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
		
      return "user/my-page";
   }
}