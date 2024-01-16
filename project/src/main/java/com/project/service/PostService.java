package com.project.service;

import java.util.List;


import com.project.dto.Post;
import com.project.exception.PostNotFoundException;

public interface PostService {
	
	// 공지사항 등록
	void addPost(Post post); 
   
    // 공지사항 수정
    void modifyPost(Post post);
   
    // 공지사항 삭제
    void removePost(int postIdx);
 
    // 공지사항 상세 보기
    Post getSelectPost(int postIdx) throws PostNotFoundException;
   
    // 공지사항 조회수 증가
    void addPostViewCount(int postIdx);
    
    // 추천 체크 
    void addPostLikes(int postIdx);
    
    // 추천 취소 
    void removePostLikes(int postIdx);
    
    // 댓글 +1  
    void addComment(int postIdx);
    
    // 댓글 -1 
    void removeComment(int postIdx);
    
    // 사용자의 추천 게시글 조회
    List<Post> getSelectLikesPost(String userinfoId);
    
    // 사용자 작성 글 조회
    List<Post> getSelectWritePost(String userinfoId);
    
    // 공지사항 목록 조회 (최근순, 추천순, 댓글순)
    List<Post> getSelectResentlyPostList(int offset, int limit, String selectKeyword);
    List<Post> getSelectViewPostList(int offset, int limit, String selectKeyword);
    List<Post> getSelectLikesPostList(int offset, int limit, String selectKeyword);
    List<Post> getSelectCommentPostList(int offset, int limit, String selectKeyword);
    
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Post getSelectPreNumNextNum(int postIdx);

}
