package com.project.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import com.project.security.CustomUserDetails;
import com.project.service.NoticeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/qa")
public class QaController {
	
	// qa 상세보기
	@GetMapping("/detail/{qaIdx}")
	public String noticeList(@RequestParam("qaIdx") int qaIdx
			, Model model
			, Authentication authentication) {
		/*
		CustomUserDetails userinfo = null;
		// 비로그인시 
		if (authentication == null) {
			Diy diy = diyService.getselectDiy(diyIdx);
			model.addAttribute("diyDetail", diy);
		} else {
			// CustomUserDetails userinfo = (CustomUserDetails) authentication.getPrincipal();
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			
			DiyLove diyLove = new DiyLove();
			diyLove.setDiyIdx(diyIdx);
			diyLove.setUserinfoId(userinfo.getId());
			System.out.println("세션으로 전달받은 로그인 유저 정보 : " + userinfo);
		
		
		if(diyIdx == null) {
			return "redirect:/error"; 
		}
		
		Diy diy = diyService.getselectDiy(diyIdx);
		if (diy == null) {
			return "redirect:/error"; 
		}
		
		// 로그인한 유저인 경우 isLoggedin 변수를 true로 설정
		boolean isLoggedin = userinfo != null;
		
		// 로그인 한 유저가 좋아요 눌렀는지 확인
		DiyLove diyLoveStatus = diyLoveService.getDiyLoveStatusByIdByDiyIdx(diyIdx, userinfo != null ? userinfo.getId() : null);
		boolean isLoveAdded = diyLoveStatus != null;
		
		
		model.addAttribute("diyDetail", diy);
		model.addAttribute("diyLoveStatus", diyLoveStatus);
		System.out.println("diyLoveStatus : " + diyLoveStatus);
		model.addAttribute("isLoveAdded", isLoveAdded);
		model.addAttribute("isLoggedin", isLoggedin);
		model.addAttribute("userinfo", userinfo);
			
		}
		*/
	   return "qa/detail";
	}
}
