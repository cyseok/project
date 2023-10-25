package com.project.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	// 공지사항 목록 페이지 요청
	@GetMapping
	public String noticeList() {
	   return "notice/list";
	}
	
	// 공지사항 상세보기
	@GetMapping("/{noticeIdx}")
	public String noticeDetail() {
	   return "notice/detail";
	}
	
	// 공지사항 수정 페이지 
	@GetMapping("/modify/{noticeIdx}")
	public String noticeModify() {
		return "/notice/modify";
	}
	
	// 공지사항 등록 페이지 요청
	@GetMapping("/write")
	public String diyAdd() {
		return "notice/write";
	}

}
