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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.project.dto.Post;
import com.project.service.PostService;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("/post")
@RequiredArgsConstructor
public class PostRestController {
	
	// @Autowired
	private final PostService postService;
	
	// List HATEOAS
	@GetMapping(value = "/list")
	public ResponseEntity<CollectionModel<Post>> getNoticeList(
			@RequestParam(defaultValue = "") String selectKeyword
			, @RequestParam(defaultValue = "all") String viewType
			) {
		
		List<Post> postList = postService.getSelectPostList(selectKeyword);
		//HttpHeaders headers = new HttpHeaders();
		//headers.setLocation(linkTo(PostRestController.class).slash(postList).toUri());

		// 다른 행동 전이 링크 추가하기
		for (Post post : postList) {
            Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
            		.slash(post.getPostIdx())
            		.withSelfRel()
            		.withRel("post-detail");
            post.add(link);
            
        }
		
		CollectionModel<Post> postResources = CollectionModel.of(postList);
	    Link noticeListLink = WebMvcLinkBuilder.linkTo(PostRestController.class)
	            .slash("list")
	            .withRel("post-list");
	    Link xxxxListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
	            .slash("list")
	            .withRel("xxxx-list");
	    postResources.add(noticeListLink);
	    postResources.add(xxxxListLink);

	    HttpHeaders headers = new HttpHeaders();
	    headers.add(HttpHeaders.CONTENT_TYPE, MediaTypes.HAL_JSON_VALUE);

	    return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
	    /*
	     * ResponseEntity.ok()
	            .headers(headers)
	            .body(postResources)
	     * */
	}
	
	// Other controller methods
		
		/*
		if ("all".equals(viewType)) {
			// 모든 영화제 목록 반환
			return (ResponseEntity<Post>) postService.getSelectPostList(selectKeyword);
		} else if ("ongoing".equals(viewType)) {
			// 진행 중인 영화제 목록 반환
			return festivalService.getOngoingFestivalList(selectKeyword);
		} else if ("upcoming".equals(viewType)) {
			// 마감 임박 중인 영화제 목록 반환
			return festivalService.getUpcomingFestivalList(selectKeyword);
		} else if ("sponsor".equals(viewType)) {
			// 후원자순으로 정렬된 영화제 목록 반환
			return festivalService.getSponsorFestivalList(selectKeyword);
		} else if ("collected".equals(viewType)) {
			// 금액순으로 정렬된 영화제 목록 반환
			return festivalService.getCollectedFestivalList(selectKeyword);
		} else {
			// 지원하지 않는 viewType이면 기본값인 모든 영화제 목록 반환
			return festivalService.getAllFestivalList(pageNum, pageSize, selectKeyword);
		}
		*/
	
	@GetMapping("{noticeIdx}")
	public ResponseEntity<CollectionModel<Map<String, Object>>> getNotice(@PathVariable("noticeIdx") int postIdx) {
		
		Post post = postService.getSelectPost(postIdx);
		Post preNumNextNum = postService.getSelectPreNumNextNum(postIdx);
		int prevNum = preNumNextNum.getPrevnum();
		int nextNum = preNumNextNum.getNextnum();
		
   

		// 다른 행동 전이 링크 추가하기
		
		// self link 추가
        Link link = WebMvcLinkBuilder.linkTo(PostRestController.class)
        		.slash(postIdx)
        		.withSelfRel();
        // 이름 변경 .withRel("next");
        // "self" : .withSelfRel();
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
        
        // 다른 링크들 추가
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("post", post);
        resultMap.put("prevNumNextNum", preNumNextNum);
        
        Link list = WebMvcLinkBuilder.linkTo(PostRestController.class)
        		.slash("list")
        		.withSelfRel();
        
        resultMap.put("post-list", list);
        
        CollectionModel<Map<String, Object>> postResources = CollectionModel.of(Collections.singletonList(resultMap));
        
        Link noticeListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
	            .slash("list")
	            .withRel("notice-list");
	    Link xxxxListLink = WebMvcLinkBuilder.linkTo(NoticeRestController.class)
	            .slash("list")
	            .withRel("xxxx-list");
	    postResources.add(noticeListLink);
	    postResources.add(xxxxListLink);
		
		 
		 HttpHeaders headers = new HttpHeaders();
		    headers.add(HttpHeaders.CONTENT_TYPE, "application/json"); // 설정할 미디어 타입을 지정
		    headers.add(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "*"); // CORS 정책을 설정할 수 있음
		    headers.setLocation(WebMvcLinkBuilder.linkTo(PostRestController.class).slash(postIdx).toUri());
		    return new ResponseEntity<>(postResources, headers, HttpStatus.OK);
		}
	

	}


