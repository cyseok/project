package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	// 댓글 리스트
	@GetMapping("/comment-list")
	public ResponseEntity<List<Comment>> commentList(@RequestParam("postIdx") int postIdx) {
		
		try {
	        List<Comment> comment = commentService.getCommentList(postIdx);
	        return new ResponseEntity<>(comment, HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}
	
	// 대댓글 리스트
	@GetMapping("/reply-list")
	public ResponseEntity<List<Comment>> replyList(@RequestParam("parentIdx") int parentIdx) {
		
		try {
	        List<Comment> reply = commentService.getReplyList(parentIdx);
	        return new ResponseEntity<>(reply, HttpStatus.OK);
	    } catch (Exception e) {
	    	return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	}
	
	// 댓글 등록	
	@PostMapping
	public ResponseEntity<String> commentAdd(Comment comment) {
		try {
			commentService.addComment(comment);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
	}
	
	// 댓글 수정
	@PostMapping("/modify")
	public ResponseEntity<String> commentModify(Comment comment) {
		try {
			commentService.modifyComment(comment);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
	}
	
	@DeleteMapping("/{commentIdx}")
	public ResponseEntity<Post> commentDelete(@PathVariable("commentIdx") int commentIdx) {
		try {
			commentService.removeComment(commentIdx);
			return new ResponseEntity<Post>(HttpStatus.NO_CONTENT);
		} catch (Exception e) {
			return new ResponseEntity<Post>(HttpStatus.BAD_REQUEST);
		}
	}
}
