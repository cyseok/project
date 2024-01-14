package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.dto.Comment;
import com.project.dto.Post;
import com.project.service.CommentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentRestController {
	
	@Autowired
	private final CommentService commentService;
	
	// 댓글 리스트 출력 (/게시물 번호)
	@GetMapping("/comment-list/{postIdx}")
	public ResponseEntity<List<Comment>> commentList(@RequestParam("postIdx") int postIdx) {
		
		try {
	        List<Comment> comment = commentService.getCommentList(postIdx);
	        return new ResponseEntity<>(comment, HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}
	
	// 답글 리스트 출력 (/부모 댓글 번호)
	@GetMapping("/reply-list/{parentIdx}")
	public ResponseEntity<List<Comment>> replyList(@RequestParam("parentIdx") String parentIdx) {
		
		try {
	        List<Comment> reply = commentService.getReplyList(parentIdx);
	        return new ResponseEntity<>(reply, HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}
	
	// 댓글,답글 등록	
	@PostMapping
	public ResponseEntity<Comment> commentAdd(Comment comment) {
		try {
			commentService.addComment(comment);
			Comment commentSelect = commentService.getComment(comment.getCommentIdx());
			return new ResponseEntity<Comment>(commentSelect, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	// 댓글, 답글 수정
	@PatchMapping("/{commentIdx}")
	public ResponseEntity<Comment> commentModify(@PathVariable("commentIdx") String commentIdx, @RequestBody Comment comment) {
		try {
			commentService.modifyComment(comment);
			return new ResponseEntity<Comment>(comment, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
	}
	
	// 댓글, 답글 삭제
	@DeleteMapping("/{commentIdx}")
	public ResponseEntity<?> commentDelete(@PathVariable("commentIdx") String commentIdx) {
		try {
			commentService.removeComment(commentIdx);
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
}
