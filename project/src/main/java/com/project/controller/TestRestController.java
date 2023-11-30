package com.project.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.MediaTypes;
import org.springframework.hateoas.server.mvc.WebMvcLinkBuilder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.project.dto.Post;
import com.project.service.PostService;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("/test")
@RequiredArgsConstructor
public class TestRestController {
	
	// @Autowired
	private final PostService postService;
	
	@GetMapping(value = "/list")
	public ResponseEntity<List<Post>> getNoticeList(
			@RequestParam(defaultValue = "0") int offset
			, @RequestParam(defaultValue = "9") int limit
			, @RequestParam(defaultValue = "") String selectKeyword
			, @RequestParam(defaultValue = "all") String viewType
			) {
		
		try {
			
			List<Post> postList = postService.getSelectResentlyPostList(offset, limit, selectKeyword);
			
			// 데이터마다 self link 추가하기
			for (Post post : postList) {
				Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
						.slash(post.getPostIdx())
						.withSelfRel()  // 자신의 링크
						.withRel("post-detail");  // 링크 이름 설정 
				
				// 다른 컨트롤러의 링크
				Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
						.slash("list")
						.withRel("notice-list");
				post.add(link);
				post.add(noticeListLink);
				
			}
			// 헤더에 content type 명시 
			HttpHeaders headers = new HttpHeaders();
			headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);
			
			return new ResponseEntity<>(postList, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("{noticeIdx}")
	public ResponseEntity<CollectionModel<Map<String, Object>>> getNotice(@PathVariable("noticeIdx") int postIdx) {
		
		try {
			Post post = postService.getSelectPost(postIdx);
			Post preNumNextNum = postService.getSelectPreNumNextNum(postIdx);
			int prevNum = preNumNextNum.getPrevnum();
			int nextNum = preNumNextNum.getNextnum();
			
			
			// 다른 행동 전이 링크 추가하기
			Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
					.slash(postIdx)
					.withSelfRel();
			post.add(link);
			
			
			// 이전글 다음글 링크 추가
			Link linkPrevNum = WebMvcLinkBuilder.linkTo(PostRestController.class)
					.slash(prevNum)
					.withRel("prev");
			Link linkNextNum = WebMvcLinkBuilder.linkTo(PostRestController.class)
					.slash(nextNum)
					.withRel("next");
			if(prevNum != 0) {
				preNumNextNum.add(linkPrevNum);
			}
			if(nextNum != 0) {
				preNumNextNum.add(linkNextNum);
			}
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("post", post);
			resultMap.put("prevNumNextNum", preNumNextNum);
			
			// 다른 컨트롤러 접근 링크 추가
			CollectionModel<Map<String, Object>> postResources = CollectionModel.of(Collections.singletonList(resultMap));
			
			Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
					.slash("list")
					.withRel("notice-list");
			Link postListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
					.slash("list")
					.withRel("post-list");
			postResources.add(noticeListLink);
			postResources.add(postListLink);
			
			
			HttpHeaders headers = new HttpHeaders();
			headers.add(HttpHeaders.CONTENT_TYPE, "application/json"); // 설정할 미디어 타입을 지정
			headers.add(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "*"); // CORS 정책을 설정할 수 있음
			return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	// 게시글 등록 
	@PostMapping
	public ResponseEntity<Post> postAdd(@ModelAttribute Post post) {
		try {
			postService.addPost(post);
			Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
            		.slash(post.getPostIdx())
            		.withSelfRel()
            		.withRel("post-detail");
            post.add(link);
            
            // 201응답인 CREATED에서는 생성된 데이터에 대한 접근 링크를 헤더에 추가해준다.
            HttpHeaders headers = new HttpHeaders();
            headers.setLocation(WebMvcLinkBuilder.linkTo(PostRestController.class).slash(post.getPostIdx()).toUri());
			return new ResponseEntity<>(post, HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	// 게시글 수정
	@PutMapping("/{postIdx}")
	public ResponseEntity<Post> postModify(@ModelAttribute Post post) {
		try {
			postService.modifyPost(post);
			Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
            		.slash(post.getPostIdx())
            		.withSelfRel()
            		.withRel("post-detail");
            post.add(link);
			return new ResponseEntity<Post>(post, HttpStatus.CREATED);
		} catch(Exception e) {
			return new ResponseEntity<Post>(HttpStatus.BAD_REQUEST);
		}
	}
	// 게시글 삭제
	@DeleteMapping("/{postIdx}")
	public ResponseEntity<Post> postDelete(@PathVariable("postIdx") int postIdx) {
		try {
			postService.removePost(postIdx);
			return new ResponseEntity<Post>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<Post>(HttpStatus.BAD_REQUEST);
		}
	}
	

}


