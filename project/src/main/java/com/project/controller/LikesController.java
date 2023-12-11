package com.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.dto.Likes;
import com.project.service.LikesService;
import com.project.service.PostService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class LikesController {
	
	@Autowired
	private final PostService postService;
	
	@Autowired
	private final LikesService likesService;
	
	// 추천 체크
	@PostMapping("/likesCheck")
	public ResponseEntity<String> likesCheck(@RequestParam("postIdx") int postIdx
			, @RequestParam("userinfoId") String userinfoId) {
		try {
			Likes likes = new Likes();
			likes.setPostIdx(postIdx);
			likes.setUserinfoId(userinfoId);
			
			likesService.addPostLikes(likes);
			postService.getPostLikesCheck(postIdx);
			return ResponseEntity.ok("ok");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("fail");
		}
		
	}
	
	// 추천 취소
	@PostMapping("/likesCancel")
	public ResponseEntity<String> likesCancel(@RequestParam int postIdx
			, @RequestParam("userinfoId") String userinfoId) {
		try {
			Likes likes = new Likes();
			likes.setPostIdx(postIdx);
			likes.setUserinfoId(userinfoId);
			
			likesService.removePostLikes(likes);
			postService.getPostLikesCancel(postIdx);
			return ResponseEntity.ok("ok");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("fail");
		}
		
	}

}
