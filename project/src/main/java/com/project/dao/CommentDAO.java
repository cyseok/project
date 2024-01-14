package com.project.dao;

import java.util.List;

import com.project.dto.Comment;

public interface CommentDAO {
	
	// 댓글 등록
    int insertComment(Comment comment); 
   
    // 댓글 수정
    int updateComment(Comment comment);
   
    // 댓글 삭제
    int deleteComment(String commentIdx);
 
    // 등록한 댓글, 답글 정보 출력
    Comment selectComment(String commentIdx);
    
    // 해당 게시물의 전체 댓글 목록 조회
    List<Comment> selectCommentList(int postIdx);
    
    // 부모 댓글의 답글 목록 조회
    List<Comment> selectReplyList(String parentIdx);

}
