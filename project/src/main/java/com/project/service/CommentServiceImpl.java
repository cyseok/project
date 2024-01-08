package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.CommentDAO;
import com.project.dto.Comment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(rollbackFor = Exception.class)
public class CommentServiceImpl implements CommentService{
	private final CommentDAO commentDAO;

	@Override
	public void addComment(Comment comment) {
		commentDAO.insertComment(comment);
	}

	@Override
	public void modifyComment(Comment comment) {
		commentDAO.updateComment(comment);
	}

	@Override
	public void removeComment(int commentIdx) {
		commentDAO.deleteComment(commentIdx);
	}

	@Override
	public void getCommentCount(int postIdx) {
		commentDAO.selectCommentCount(postIdx);
	}

	@Override
	public void getReplyCount(int parentIdx) {
		commentDAO.selectReplyCount(parentIdx);
	}

	@Override
	public List<Comment> getCommentList(int postIdx) {
		return commentDAO.selectCommentList(postIdx);
	}

	@Override
	public List<Comment> getReplyList(int parentIdx) {
		return commentDAO.selectReplyList(parentIdx);
	}
	
	

}
