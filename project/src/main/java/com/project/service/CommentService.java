package com.project.service;

import java.util.List;

import com.project.dto.Comment;

public interface CommentService {
	
	// 댓글 등록
    void addComment(Comment comment); 
   
    // 댓글 수정
    void modifyComment(Comment comment);
   
    // 댓글 삭제
    void removeComment(String commentIdx);
 
    // 등록한 댓글, 답글 정보 출력
    Comment getComment(String commentIdx);
    
    // 해당 게시물의 전체 댓글 목록 조회
    List<Comment> getCommentList(int postIdx);
    
    // 부모 댓글의 답글 목록 조회
    List<Comment> getReplyList(String parentIdx);
}
