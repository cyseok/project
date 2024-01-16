package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.dto.Post;
import com.project.mapper.PostMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PostDAOImpl implements PostDAO{
	private final SqlSession sqlSession;

	@Override
	public int insertPost(Post post) {
		return sqlSession.getMapper(PostMapper.class).insertPost(post);
	}

	@Override
	public int updatePost(Post post) {
		return sqlSession.getMapper(PostMapper.class).updatePost(post);
	}

	@Override
	public int deletePost(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).deletePost(postIdx);
	}

	@Override
	public Post selectPost(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).selectPost(postIdx);
	}

	@Override
	public int postViewCount(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).postViewCount(postIdx);
	}

	@Override
	public int postLikesCheck(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).postLikesCheck(postIdx);
	}
	
	@Override
	public int postLikesCancel(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).postLikesCancel(postIdx);
	}
	
	@Override
	public int insertComment(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).insertComment(postIdx);
	}
	
	@Override
	public int deleteComment(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).deleteComment(postIdx);
	}
	
	@Override
	public int selectPostCount(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectPostCount(selectKeyword);
	}
	
	@Override
	public List<Post> selectLikesPost(String userinfoId) {
		return sqlSession.getMapper(PostMapper.class).selectLikesPost(userinfoId);
	}
	
	@Override
	public List<Post> selectWritePost(String userinfoId) {
		return sqlSession.getMapper(PostMapper.class).selectWritePost(userinfoId);
	}

	@Override
	public List<Post> selectResentlyPostList(int offset, int limit, String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectResentlyPostList(offset, limit, selectKeyword);
	}
	
	@Override
	public List<Post> selectViewPostList(int offset, int limit, String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectViewPostList(offset, limit, selectKeyword);
	}

	@Override
	public List<Post> selectLikesPostList(int offset, int limit, String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectLikesPostList(offset, limit, selectKeyword);
	}

	@Override
	public List<Post> selectCommentPostList(int offset, int limit, String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectCommentPostList(offset, limit, selectKeyword);
	}

	@Override
	public Post selectPreNumNextNum(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).selectPreNumNextNum(postIdx);
	}


}
