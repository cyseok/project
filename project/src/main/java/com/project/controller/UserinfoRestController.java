package com.project.controller;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.dto.Userinfo;
import com.project.security.CustomUserDetails;
import com.project.service.UserinfoService;
import com.project.util.MailSend;

@RestController
@RequestMapping("/user")
public class UserinfoRestController {

   @Autowired
   private UserinfoService userinfoservice;
   
   @Autowired
   private BCryptPasswordEncoder pwEncoder;
   
   @Autowired
   private MailSend mailSend;   

   // 회원가입
   @PostMapping(value = "/join")
   public ResponseEntity<String> joinPOST(@Valid Userinfo userinfo
		   ,HttpSession session
         , @RequestParam("userinfoRole") String userinfoRole) throws Exception {

	  try {
		  userinfoservice.addUserinfo(userinfo, userinfoRole);
		  session.setAttribute("userinfo", userinfo.getId());
		  return ResponseEntity.ok("ok");
		
	  } catch (Exception e) {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("회원가입 실패했습니다. 다시 시도해주세요.");
	  }
	  
   }
   
   // 아이디 중복검사
   @PostMapping(value = "/id-check", produces="text/javascript;charset=UTF-8")
   public ResponseEntity<String> idCheck(@RequestParam String id) throws Exception {

      int result = userinfoservice.idCheck(id);

      if (result != 0) {
    	  return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("중복 아이디가 존재합니다."); 
      } else {
    	  return ResponseEntity.ok("ok"); // 중복 아이디 x
      }
   } 
   
   // 이메일 중복검사
   @PostMapping(value = "/email-check", produces="text/javascript;charset=UTF-8")
   public ResponseEntity<String> emailCheck(@RequestParam String email) throws Exception {
	   
       int emailResult = userinfoservice.emailCheck(email);

       if (emailResult != 0) {
    	   return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("중복 이메일이 존재하거나 해당 이메일로 소셜로그인 계정이 이미 존재합니다."); 
       } else {
    	   return ResponseEntity.ok("ok"); // 중복 없음
       }
   }
   
   // 이메일 인증
   @PostMapping("/email-confirm")
   public ResponseEntity<String> emailConfirm(@RequestParam String email) throws Exception {
	    try {
		  return ResponseEntity.ok(mailSend.joinEmail(email));
	  } catch (Exception e) {
		  return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이메일 인증이 실패하였습니다.");
	  }
   }
   
   // 아이디 찾기
   @GetMapping("/find-id")
   public ResponseEntity<Userinfo> find(@RequestParam String name
		   ,@RequestParam String email) throws Exception {
	    try {
	    	Userinfo userinfo = userinfoservice.findUserinfo(name, email);
		  return new ResponseEntity<>(userinfo, HttpStatus.OK);
	  } catch (Exception e) {
		  return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	  }
   }
   
   // 닉네임 출력
   @GetMapping("/find-nickname")
   public ResponseEntity<Userinfo> findNickname(@RequestParam String id) throws Exception {
	    try {
	    	Userinfo userinfo = userinfoservice.getUserinfoById(id);
		  return new ResponseEntity<>(userinfo, HttpStatus.OK);
	  } catch (Exception e) {
		  return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	  }
   }
   
   // 닉네임 변경
   @PatchMapping("/{id}")
   public ResponseEntity<Userinfo> modifyNickname(@PathVariable("id") String id, @RequestBody Userinfo userinfo) throws Exception {
	    try {
	    	userinfoservice.modifyNickname(userinfo);
		  return new ResponseEntity<>(userinfo, HttpStatus.OK);
	  } catch (Exception e) {
		  return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	  }
   }
   
   //로그인
   @PostMapping(value = "/login" , produces="text/javascript;charset=UTF-8")
   public ResponseEntity<String> loginPOST(
		   @RequestBody Userinfo userinfo
		   , HttpSession session) throws Exception {
	   
	   Logger logger = LoggerFactory.getLogger(this.getClass());

            try {
            	Userinfo userinfoAuth = userinfoservice.getUserinfoLogin(userinfo.getId());
            	
		          if (userinfoAuth != null) {
		              // 로그인 시
		              if (pwEncoder.matches(userinfo.getPw(), userinfoAuth.getPw())) {
		            	  
		            	  CustomUserDetails customUserDetails=new CustomUserDetails(userinfoAuth);
		            	  
		            	  // 인증 사용자로 등록 처리
		            	  Authentication authentication=new UsernamePasswordAuthenticationToken
		            			  (customUserDetails, null, customUserDetails.getAuthorities());
		            	  
		            	  // 인증 사용자의 권한 정보를 저장
		            	  SecurityContextHolder.getContext().setAuthentication(authentication);
		            	  
		            	  userinfoAuth.setPw("");
		                  session.setAttribute("userinfo", userinfoAuth);
		                  session.setMaxInactiveInterval(60 * 60); 
		                  userinfoservice.updateUserLogindate(userinfoAuth.getId());
		                  
		                  
		                  return ResponseEntity.ok().build();
		                  
		              } else {
		                  return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("비밀번호가 일치하지 않습니다.");
		              }
		              
		          // 계정이 존재하지 않을때
		          } else {
		             return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("아이디와 비밀번호를 확인해주세요.");
		          }
		          
			} catch (Exception e) {
				logger.error("Exception during loginPOST:", e);
		        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("서버 오류가 발생했습니다.");
			}
      
   }
}