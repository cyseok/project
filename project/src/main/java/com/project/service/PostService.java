package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.dto.Post;

public interface PostService {
	
	// 공지사항 등록
	void addPost(Post post); 
   
    // 공지사항 수정
    void modifyPost(Post post);
   
    // 공지사항 삭제
    void removePost(int postIdx);
 
    // 공지사항 상세 보기
    Post getSelectPost(int postIdx);
   
    // 공지사항 조회수 
    void getPostViewCount(int postIdx);
    
    // 공지사항 목록 조회 (최근순, 추천순, 댓글순)
    List<Post> getSelectPostList(String selectKeyword);
    List<Post> getSelectResentlyPostList(String selectKeyword);
    List<Post> getSelectLikesPostList(String selectKeyword);
    List<Post> getSelectPostCommentList(String selectKeyword);
    
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Post getSelectPreNumNextNum(int postIdx);

}
