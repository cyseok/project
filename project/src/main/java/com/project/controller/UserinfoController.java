package com.project.controller;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dto.Userinfo;
import com.project.service.UserinfoService;


@Controller
@RequestMapping("/user")
public class UserinfoController {
   private static final Logger logger = LoggerFactory.getLogger(UserinfoController.class);

   @Autowired
   private UserinfoService userinfoservice;
   
   @Autowired
   private BCryptPasswordEncoder pwEncoder;

   // 회원가입 페이지 이동
   @RequestMapping(value = "/join", method = RequestMethod.GET)
   public String joinGET() {
      return "user/join";
   }

   // 회원가입
   @RequestMapping(value = "/join", method = RequestMethod.POST)
   public ResponseEntity<String> joinPOST(@Valid @ModelAttribute("Userinfo") Userinfo userinfo,
         @RequestParam("userinfoRole") String userinfoRole) throws Exception {

	  try {
		  userinfoservice.addUserinfo(userinfo, userinfoRole);
		  return ResponseEntity.ok("ok");
		
	  } catch (Exception e) {
		return ResponseEntity.badRequest().body("회원가입 실패: " + e.getMessage());
	  }
	  
   }
   
   @RequestMapping(value = "/memberDuplicateCheck", method = RequestMethod.POST)
   @ResponseBody
   public String memberDuplicateCheck(@RequestParam String id, @RequestParam String email) throws Exception {
       int idResult = userinfoservice.idCheck(id);
       int emailResult = userinfoservice.emailCheck(email);

       if (idResult != 0) {
           return "failId"; // 중복된 아이디가 존재
       } else if (emailResult != 0) {
           return "failEmail"; // 중복된 이메일이 존재
       } else {
           return "success"; // 중복 없음
       }
   }

   //로그인
   @PostMapping("/login")
   @ResponseBody
   public ResponseEntity<String> loginPOST(Userinfo userinfo
		   , @RequestParam String id
		   , @RequestParam String pw
		   , RedirectAttributes rttr
		   , HttpSession session) throws Exception {
	   System.out.println("컨트롤러실행 ");
	   
	   
      // session.setAttribute("userinfoId", id);
            System.out.println("아이디 : " +id + "비번 : " +pw);
      Userinfo userinfoAuth = userinfoservice.getUserinfoLogin(id);
            System.out.println(userinfoAuth);
      if (userinfoAuth != null) {

         //String rawPw = userinfo.getPw();
         //String encodePw = userinfoAuth.getPw();

         // 로그인 시
         if (pwEncoder.matches(pw, userinfoAuth.getPw())) {
        	 
        	userinfoAuth.setPw("");
            session.setAttribute("userinfo", userinfoAuth);
            userinfoservice.updateUserLogindate(userinfoAuth.getId());
            return ResponseEntity.ok("ok");
         } else {
           // rttr.addFlashAttribute("result", 0);
            return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
         }
         // 계정이 존재하지 않을때
      } else {
         // rttr.addFlashAttribute("result", 0);
         return ResponseEntity.badRequest().body("존재하지 않는 계정입니다.");
      }
   }

}