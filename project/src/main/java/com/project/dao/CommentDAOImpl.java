package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.dto.Comment;
import com.project.mapper.CommentMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CommentDAOImpl implements CommentDAO{
	private final SqlSession sqlSession;

	@Override
	public int insertComment(Comment comment) {
		return sqlSession.getMapper(CommentMapper.class).insertComment(comment);
	}

	@Override
	public int updateComment(Comment comment) {
		return sqlSession.getMapper(CommentMapper.class).updateComment(comment);
	}

	@Override
	public int deleteComment(int commentIdx) {
		return sqlSession.getMapper(CommentMapper.class).deleteComment(commentIdx);
	}

	@Override
	public int selectCommentCount(int postIdx) {
		return sqlSession.getMapper(CommentMapper.class).selectCommentCount(postIdx);
	}

	@Override
	public int selectReplyCount(int parentIdx) {
		return sqlSession.getMapper(CommentMapper.class).selectReplyCount(parentIdx);
	}

	@Override
	public List<Comment> selectCommentList(int postIdx) {
		return sqlSession.getMapper(CommentMapper.class).selectCommentList(postIdx);
	}

	@Override
	public List<Comment> selectReplyList(int parentIdx) {
		return sqlSession.getMapper(CommentMapper.class).selectReplyList(parentIdx);
	}
	
	

}
