package com.project.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.security.CustomUserDetails;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/posts")
public class PostController {
	
	// 게시글 목록 페이지 요청
	@GetMapping
	public String postList(HttpSession session, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
	   return "/post/list";
	}
	
	// 게시글 상세보기
	@GetMapping("/{postIdx}")
	public String postDetail(HttpSession session, Authentication authentication) {
		CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
	   return "/post/detail";
	}
	
	/*
	// 게시글 수정 페이지 
	@GetMapping("/modify/{postIdx}")
	public String postModify() {
		return "/post/modify";
	}
	
	// 게시글 작성 페이지
	@PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_SOCIAL', 'ROLE_MASTER')")
	@GetMapping("/write")
	public String postAdd(HttpSession session, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
		return "/post/write";
	}
	*/
	
	// 나의 작성글 페이지
	@GetMapping("/my-write")
	public String myWritePost(HttpSession session, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
		return "/post/my-write";
	}
	
	// 나의 추천글 페이지
	@GetMapping("/my-likes")
	public String myLikesPost(HttpSession session, Authentication authentication) {
		
		CustomUserDetails userinfo = null;
		
		if (authentication != null) {
			userinfo = (CustomUserDetails) authentication.getPrincipal();
			session.setAttribute("userinfoId", userinfo.getId());
		}
		return "/post/my-likes";
	}

}
