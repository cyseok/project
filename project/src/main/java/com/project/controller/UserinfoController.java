package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/user")
public class UserinfoController {

   // 회원가입 페이지 이동
   @RequestMapping(value = "/join", method = RequestMethod.GET)
   public String join() {
      return "user/join";
   }
   
   // 아이디찾기 페이지 이동
   @RequestMapping(value = "/find", method = RequestMethod.GET)
   public String find() {
      return "user/find";
   }

}