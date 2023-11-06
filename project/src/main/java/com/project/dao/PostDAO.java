package com.project.dao;

import java.util.List;

import com.project.dto.Post;

public interface PostDAO {
	
	// 공지사항 등록
    int insertPost(Post post); 
   
    // 공지사항 수정
    int updatePost(Post post);
   
    // 공지사항 삭제
    int deletePost(int postIdx);
 
    // 공지사항 상세 보기
    Post selectPost(int postIdx);
   
    // 공지사항 조회수 
    int postViewCount(int postIdx);
   
    // 전체 게시글 수 조회 
    int selectPostCount(String selectKeyword);
   
    // 공지사항 목록 조회 (최근순, 추천순, 댓글순)
    List<Post> selectPostList(String selectKeyword);
    List<Post> selectResentlyPostList(String selectKeyword);
    List<Post> selectLikesPostList(String selectKeyword);
    List<Post> selectPostCommentList(String selectKeyword);
    
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Post selectPreNumNextNum(int postIdx);

}
