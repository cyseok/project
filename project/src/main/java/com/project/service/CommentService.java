package com.project.service;

import java.util.List;

import com.project.dto.Comment;

public interface CommentService {
	
	// 댓글 등록
    void addComment(Comment comment); 
   
    // 댓글 수정
    void modifyComment(Comment comment);
   
    // 댓글 삭제
    void removeComment(int commentIdx);
 
    // 전체 댓글 수 조회 
    void getCommentCount(int postIdx);
    
    // 대댓글 수 조회 
    void getReplyCount(int parentIdx);
    
    // 공지사항 댓글 목록 조회
    List<Comment> getCommentList(int postIdx);
    
    // 공지사항 대댓글 목록 조회
    List<Comment> getReplyList(int parentIdx);
}
