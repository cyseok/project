package com.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.dto.Post;

public interface PostMapper {
	
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
   
    // 공지사항 목록 조회 (최근순, 조회수순, 인기순, 댓글순)
    List<Post> selectResentlyPostList(@Param("offset") int offset, @Param("limit") int limit, @Param("selectKeyword") String selectKeyword);
    List<Post> selectViewPostList(@Param("offset") int offset, @Param("limit") int limit, @Param("selectKeyword") String selectKeyword);
    List<Post> selectLikesPostList(@Param("offset") int offset, @Param("limit") int limit, @Param("selectKeyword") String selectKeyword);
    List<Post> selectCommentPostList(@Param("offset") int offset, @Param("limit") int limit, @Param("selectKeyword") String selectKeyword);
    
    // 상세보기 페이지에서 이전 글 번호와 다음 글 번호 저장
    Post selectPreNumNextNum(int postIdx);

}
