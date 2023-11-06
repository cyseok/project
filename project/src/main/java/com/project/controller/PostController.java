package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/post")
public class PostController {
	
	// 공지사항 목록 페이지 요청
	@GetMapping
	public String noticeList() {
	   return "/post/list";
	}
	
	// 공지사항 상세보기
	@GetMapping("/{postIdx}")
	public String noticeDetail() {
	   return "/post/detail";
	}
	
	// 공지사항 수정 페이지 
	@GetMapping("/modify/{postIdx}")
	public String noticeModify() {
		return "/post/modify";
	}
	
	// 공지사항 등록 페이지 요청
	@GetMapping("/write")
	public String diyAdd() {
		return "/post/write";
	}

}
