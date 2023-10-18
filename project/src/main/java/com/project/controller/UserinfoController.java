package com.project.controller;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dto.Userinfo;
import com.project.service.UserinfoService;


@Controller
@RequestMapping(value = "/user")
public class UserinfoController {
   private static final Logger logger = LoggerFactory.getLogger(UserinfoController.class);

   @Autowired
   private UserinfoService userinfoservice;


   @Autowired
   private BCryptPasswordEncoder pwEncoder;

   // 회원가입 페이지 이동
   @RequestMapping(value = "/join", method = RequestMethod.GET)
   public String joinGET(Model model) {
      model.addAttribute("Userinfo", new Userinfo());
      return "user/join";
   }

   // 회원가입
   @RequestMapping(value = "/join", method = RequestMethod.POST)
   public String joinPOST(@ModelAttribute("Userinfo") Userinfo userinfo,
         @RequestParam("userinfoRole") String userinfoRole) throws Exception {

      userinfoservice.registerUser(userinfo, userinfoRole); // 회원가입 서비스 호출
      return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
   }


   /* 로그인 */

   // 로그인 페이지 이동
   @RequestMapping(value = "/login", method = RequestMethod.GET)
   public String loginGET() {

      return "user/login";
   }
   
   //로그인
   @RequestMapping(value = "/login", method = RequestMethod.POST)
   public String loginPOST(@ModelAttribute Userinfo userinfo, RedirectAttributes rttr, HttpSession session) throws Exception {

      session.setAttribute("userinfoId", userinfo.getId());

      Userinfo lto = userinfoservice.userLogin(userinfo);

      if (lto != null) {
         if (lto.getStatus() == 3) {
            // 탈퇴 회원은 로그인 차단
            rttr.addFlashAttribute("result", 0);
            return "redirect:/user/login";
         } else if (lto.getStatus() == 2) {
            // 휴면 계정은 활성화 요구 페이지로 바로 이동
            return "redirect:/user/dormantAccount";
         }

         String rawPw = userinfo.getPw();
         String encodePw = lto.getPw();

         if (pwEncoder.matches(rawPw, encodePw)) {
            lto.setPw("");
            session.setAttribute("userinfo", lto);
            return "redirect:/";
         } else {
            rttr.addFlashAttribute("result", 0);
            return "redirect:/user/login";
         }
      } else {
         rttr.addFlashAttribute("result", 0);
         return "redirect:/user/login";
      }
   }

}