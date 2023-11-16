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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dto.Userinfo;
import com.project.service.UserinfoService;
import com.project.util.MailSend;


@Controller
@RequestMapping("/user")
public class UserinfoController {
   private static final Logger logger = LoggerFactory.getLogger(UserinfoController.class);

   @Autowired
   private UserinfoService userinfoservice;
   
   @Autowired
   private BCryptPasswordEncoder pwEncoder;
   
   @Autowired
   private MailSend mailSend;   

   // 회원가입 페이지 이동
   @RequestMapping(value = "/join", method = RequestMethod.GET)
   public String joinGET() {
      return "user/join";
   }

   // 회원가입
   @PostMapping(value = "/join")
   public ResponseEntity<String> joinPOST(@Valid Userinfo userinfo,
         @RequestParam("userinfoRole") String userinfoRole) throws Exception {

	  try {
		  userinfoservice.addUserinfo(userinfo, userinfoRole);
		  return ResponseEntity.ok("ok");
		
	  } catch (Exception e) {
		return ResponseEntity.badRequest().body("회원가입 실패: " + e.getMessage());
	  }
	  
   }
   
   // 아이디 중복검사
   @PostMapping(value = "/id-check", produces="text/javascript;charset=UTF-8")
   @ResponseBody
   public ResponseEntity<String> idCheck(@RequestParam String id) throws Exception {

      int result = userinfoservice.idCheck(id);

      if (result != 0) {
    	  return ResponseEntity.badRequest().body("중복 아이디가 존재합니다."); // 중복 아이디가 존재
      } else {
    	  return ResponseEntity.ok("ok"); // 중복 아이디 x
      }
   } 
   
   // 이메일 중복검사
   @PostMapping(value = "/email-check" , produces="text/javascript;charset=UTF-8")
   @ResponseBody
   public ResponseEntity<String> emailCheck(@RequestParam String email) throws Exception {
	   
       int emailResult = userinfoservice.emailCheck(email);

       if (emailResult != 0) {
    	   return ResponseEntity.badRequest().body("중복 이메일이 존재합니다."); // 중복된 이메일 존재
       } else {
    	   return ResponseEntity.ok("ok"); // 중복 없음
       }
   }
   
   // 이메일 인증
   @PostMapping("/email-confirm")
   @ResponseBody
   public ResponseEntity<String> emailConfirm(@RequestParam String email) throws Exception {
	    try {
		  return ResponseEntity.ok(mailSend.joinEmail(email));
	  } catch (Exception e) {
		  return ResponseEntity.badRequest().body("중복 이메일이 존재합니다.");
	  }
   }
/*
   //로그인
   @PostMapping("/login")
   @ResponseBody
   public ResponseEntity<String> loginPOST(@RequestBody Userinfo userinfo
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
*/
   //로그인
   @PostMapping("/login")
   @ResponseBody
   public ResponseEntity<String> loginPOST(@RequestBody Userinfo userinfo
		   , RedirectAttributes rttr
		   , HttpSession session) throws Exception {
	   System.out.println("컨트롤러실행 ");
	   
	   logger.info("-====================================="+userinfo.getId());
      // session.setAttribute("userinfoId", id);
            System.out.println("아이디 : " +userinfo.getId() + "비번 : " +userinfo.getPw());
      Userinfo userinfoAuth = userinfoservice.getUserinfoLogin(userinfo.getId());
            System.out.println(userinfoAuth);
      if (userinfoAuth != null) {

         //String rawPw = userinfo.getPw();
         //String encodePw = userinfoAuth.getPw();

         // 로그인 시
         if (pwEncoder.matches(userinfo.getPw(), userinfoAuth.getPw())) {
        	 
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