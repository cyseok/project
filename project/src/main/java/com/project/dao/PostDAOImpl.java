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
	public int selectPostCount(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectPostCount(selectKeyword);
	}

	@Override
	public int selectResentlyPostCount(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectResentlyPostCount(selectKeyword);
	}

	@Override
	public int selectLikesPostCount(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectLikesPostCount(selectKeyword);
	}

	@Override
	public int selectPostCommentCount(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectPostCommentCount(selectKeyword);
	}

	@Override
	public List<Post> selectPostList(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectPostList(selectKeyword);
	}

	@Override
	public List<Post> selectResentlyPostList(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectResentlyPostList(selectKeyword);
	}

	@Override
	public List<Post> selectLikesPostList(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectLikesPostList(selectKeyword);
	}

	@Override
	public List<Post> selectPostCommentList(String selectKeyword) {
		return sqlSession.getMapper(PostMapper.class).selectPostCommentList(selectKeyword);
	}

	@Override
	public Post selectPreNumNextNum(int postIdx) {
		return sqlSession.getMapper(PostMapper.class).selectPreNumNextNum(postIdx);
	}

}
