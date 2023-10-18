package com.project.controller;

import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;

import com.project.dto.NoticeDTO;
import com.project.security.CustomUserDetails;
import com.project.service.NoticeService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	// @Autowired
	private final NoticeService noticeService;
	private final WebApplicationContext context; //파일 업로드
	
	// 공지사항 리스트 페이지
	@GetMapping("/list")
	public String noticeList(@RequestParam Map<String, Object> map
			, Model model
			, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication == null) {
			model.addAttribute("result", noticeService.getSelectNoticeList(map));
			model.addAttribute("search", map);
		} else {
			// 로그인 한 사용자면 사용자의 정보를 리스트 페이지로 넘겨준다.
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			
			model.addAttribute("result", noticeService.getSelectNoticeList(map));
			model.addAttribute("search", map);
			model.addAttribute("userinfo", userinfo);
			System.out.println("세션으로 전달받은 로그인 유저 정보 : " + userinfo);
			
		}
		
	   return "notice/list";
	}
	
	// 공지사항 상세보기
	@GetMapping("/detail/{noticeIdx}")
	public String noticeDetail(@PathVariable("noticeIdx") int noticeIdx
			, Model model) {
		// 상세보기 클릭 시 조회수 1 증가
		noticeService.getViewNoticeCount(noticeIdx);
		model.addAttribute("notice", noticeService.getSelectNotice(noticeIdx));
		
	   return "notice/detail";
	}
	
	// 공지사항 등록 페이지 요청
	@GetMapping("/write")
	public String diyAdd(Model model
			, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication == null) {
		} else {
			// 로그인 한 사용자면 사용자의 정보를 리스트 페이지로 넘겨준다.
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			
			model.addAttribute("userinfo", userinfo);
			System.out.println("세션으로 전달받은 로그인 유저 정보 : " + userinfo);
			
		}
		return "notice/write";
	}
	
	// 공지사항 등록
	@PostMapping("/add")
	public String noticeWrite(Model model
			, NoticeDTO notice) {
		
		noticeService.addNotice(notice);
		
		return "redirect:/notice/list";
	}
	
	// 공지사항 삭제 
	@GetMapping("/remove/{noticeIdx}")
	public String noticeDelete(@PathVariable("noticeIdx") int noticeIdx) {
		
		noticeService.removeNotice(noticeIdx);
		
		return "redirect:/notice/list";
	}
	
	// diy 수정 페이지 
	@GetMapping("/modify/{noticeIdx}")
	public String diyModifyPage(@PathVariable("noticeIdx") int noticeIdx
			, Model model) {
		
		model.addAttribute("notice", noticeService.getSelectNotice(noticeIdx));
		
		return "/notice/modify";
	}
	
	// diy 수정 요청
	@PostMapping("/update")
	public String diyModify(NoticeDTO notice) {
		
		noticeService.modifyNotice(notice);
		
		return "redirect:/notice/list";
	}

	

}
