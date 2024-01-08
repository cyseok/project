package com.project.dao;

import java.util.List;

import com.project.dto.Comment;

public interface CommentDAO {
	
	// 댓글 등록
    int insertComment(Comment comment); 
   
    // 댓글 수정
    int updateComment(Comment comment);
   
    // 댓글 삭제
    int deleteComment(int commentIdx);
 
    // 전체 댓글 수 조회 
    int selectCommentCount(int postIdx);
    
    // 대댓글 수 조회 
    int selectReplyCount(int parentIdx);
    
    // 공지사항 댓글 목록 조회
    List<Comment> selectCommentList(int postIdx);
    
    // 공지사항 대댓글 목록 조회
    List<Comment> selectReplyList(int parentIdx);

}
