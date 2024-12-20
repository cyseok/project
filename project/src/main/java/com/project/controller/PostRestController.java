package com.project.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.MediaTypes;
import org.springframework.hateoas.server.mvc.WebMvcLinkBuilder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

import com.project.dto.Likes;
import com.project.dto.Post;
import com.project.service.LikesService;
import com.project.service.PostService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/posts")
@RequiredArgsConstructor
public class PostRestController {
	
	@Autowired
	private final PostService postService;
	
	@Autowired
	private final LikesService likesService;
	
	@Autowired
	private final WebApplicationContext context; 
	
	// 게시글 목록 출력
	@GetMapping
	public ResponseEntity<CollectionModel<Post>> getPostList(
			@RequestParam("offset") int offset
			, @RequestParam("limit") int limit
			, @RequestParam("selectKeyword") String selectKeyword
			, @RequestParam("viewType") String viewType
			) {
		
		// 최신순 
		if ("recently".equals(viewType)) {
			
			try {
				List<Post> postList = postService.getSelectResentlyPostList(offset, limit, selectKeyword);
				
				// 데이터마다 self link 추가하기
				for (Post post : postList) {
					Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
							.slash(post.getPostIdx())
							.withRel("post-detail");  // 링크 이름 설정 
					post.add(link);
					
				}
				// 컨트롤러 다른 자원에 접근하는 링크
				CollectionModel<Post> postResources = CollectionModel.of(postList);
				
				Link postListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
						.slash("list")
						.withSelfRel();
				Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
						.slash("list")
						.withRel("notice-list");
				postResources.add(postListLink);
				postResources.add(noticeListLink);
				
				// 헤더에 content type 명시 
				HttpHeaders headers = new HttpHeaders();
				headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);
				
				return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
				
			} catch (Exception e) {
				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
			
		// 인기순
		} else if("like".equals(viewType)){
			
			try {
				List<Post> postList = postService.getSelectLikesPostList(offset, limit, selectKeyword);
				
				// 데이터마다 self link 추가하기
				for (Post post : postList) {
					Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
							.slash(post.getPostIdx())
							.withRel("post-detail");  // 링크 이름 설정 
					post.add(link);
					
				}
				// 컨트롤러 다른 자원에 접근하는 링크
				CollectionModel<Post> postResources = CollectionModel.of(postList);
				
				Link postListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
						.slash("list")
						.withSelfRel();
				Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
						.slash("list")
						.withRel("notice-list");
				postResources.add(postListLink);
				postResources.add(noticeListLink);
				
				// 헤더에 content type 명시 
				HttpHeaders headers = new HttpHeaders();
				headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);
				
				return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
				
			} catch (Exception e) {
				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}	
			
		// 조회순
		} else if("view".equals(viewType)){
			
			try {
				List<Post> postList = postService.getSelectViewPostList(offset, limit, selectKeyword);
				
				// 데이터마다 self link 추가하기
				for (Post post : postList) {
					Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
							.slash(post.getPostIdx())
							.withRel("post-detail");  // 링크 이름 설정 
					post.add(link);
					
				}
				// 컨트롤러 다른 자원에 접근하는 링크
				CollectionModel<Post> postResources = CollectionModel.of(postList);
				
				Link postListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
						.slash("list")
						.withSelfRel();
				Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
						.slash("list")
						.withRel("notice-list");
				postResources.add(postListLink);
				postResources.add(noticeListLink);
				
				// 헤더에 content type 명시 
				HttpHeaders headers = new HttpHeaders();
				headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);
				
				return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
				
			} catch (Exception e) {
				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}		
			
		// 댓글순
		} else {
			
			try {
				List<Post> postList = postService.getSelectCommentPostList(offset, limit, selectKeyword);
				
				// 데이터마다 self link 추가하기
				for (Post post : postList) {
					Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
							.slash(post.getPostIdx())
							.withRel("post-detail");  // 링크 이름 설정 
					post.add(link);
					
				}
				// 컨트롤러 다른 자원에 접근하는 링크
				CollectionModel<Post> postResources = CollectionModel.of(postList);
				
				Link postListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
						.slash("list")
						.withSelfRel();
				Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
						.slash("list")
						.withRel("notice-list");
				postResources.add(postListLink);
				postResources.add(noticeListLink);
				
				// 헤더에 content type 명시 
				HttpHeaders headers = new HttpHeaders();
				headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);
				
				return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
				
			} catch (Exception e) {
				return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		}
		
	}
	
	@GetMapping("/{postIdx}")
	public ResponseEntity<CollectionModel<Map<String, Object>>> getPost(
			@PathVariable("postIdx") int postIdx
			, @RequestParam String userinfoId) {
		
		try {
			Post post = postService.getSelectPost(postIdx);
			postService.addPostViewCount(postIdx);
			Post preNumNextNum = postService.getSelectPreNumNextNum(postIdx);
			int prevNum = preNumNextNum.getPrevnum();
			int nextNum = preNumNextNum.getNextnum();
			
			Likes likes = likesService.getPostLikes(postIdx, userinfoId);
			
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
			resultMap.put("likes", likes);
			
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
			
			return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping(value = "/image-upload")
	public ResponseEntity<String> imageUpload(@RequestParam("file") MultipartFile file) throws IllegalStateException, IOException {
		try {
			
			// 서버에 저장할 경로
			String uploadDirectory = context.getServletContext().getRealPath("/resources/assets/images/upload"); 
			
			// 업로드 된 파일의 이름
			String originalFileName = file.getOriginalFilename();
			
			// 업로드 된 파일의 확장자
			String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
			
			// 업로드 될 파일의 이름 재설정 (중복 방지를 위해 UUID 사용)
			String uuidFileName = UUID.randomUUID().toString() + fileExtension;
			
			// 위에서 설정한 서버 경로에 이미지 저장
			file.transferTo(new File(uploadDirectory, uuidFileName));
		
			System.out.println(uploadDirectory);
			
			// Ajax에서 업로드 된 파일의 이름을 응답 받을 수 있도록 해줍니다.
			return ResponseEntity.ok(uuidFileName);
		} catch (Exception e) {
			return ResponseEntity.badRequest().body("이미지 업로드 실패");
		}
		
	}

	// 게시글 등록 
	@PostMapping(produces = "application/json")
	public ResponseEntity<Post> postAdd(Post post) {
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
            
			return new ResponseEntity<Post>(post, headers, HttpStatus.CREATED);
		} catch (Exception e) {
			return new ResponseEntity<Post>(HttpStatus.BAD_REQUEST);
		}
	}
	
	// 게시글 수정
	@PostMapping(value = "/modify", produces = "application/json")
	public ResponseEntity<Post> postModify(Post post) {
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
	
	@GetMapping(value = "/my-postwrite")
	public ResponseEntity<List<Post>> getMyWriteList(@RequestParam String userinfoId) {
	    try {
	        List<Post> post = postService.getSelectWritePost(userinfoId);
	        return new ResponseEntity<>(post, HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}
	
	@GetMapping(value = "/my-postlikes")
	public ResponseEntity<List<Post>> getMyLikesList(@RequestParam String userinfoId) {
		try {
			List<Post> post = postService.getSelectLikesPost(userinfoId);
			return new ResponseEntity<>(post, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}

}


