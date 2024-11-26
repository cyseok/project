package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.PostDAO;
import com.project.dto.Post;
import com.project.exception.PostNotFoundException;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(rollbackFor = Exception.class)
public class PostServiceImpl implements PostService{
	
	private final PostDAO postDAO;
	
	@Override
	public void addPost(Post post) {
		postDAO.insertPost(post);
	}

	@Override
	public synchronized void modifyPost(Post post) {
		postDAO.updatePost(post);
	}

	@Override
	public void removePost(int postIdx) {
		postDAO.deletePost(postIdx);
	}

	@Override
	public Post getSelectPost(int postIdx) throws PostNotFoundException {
		
		Post post = postDAO.selectPost(postIdx);
		if (post == null) {
	        throw new PostNotFoundException("존재하는 글이 없습니다");
	    }
		return postDAO.selectPost(postIdx);
	}

	@Override
	public void addPostViewCount(int postIdx) {
		postDAO.postViewCount(postIdx);
	}
	
	@Override
	public void addPostLikes(int postIdx) {
		postDAO.postLikesCheck(postIdx);
	}
	
	@Override
	public void removePostLikes(int postIdx) {
		postDAO.postLikesCancel(postIdx);
	}
	
	@Override
	public void addComment(int postIdx) {
		postDAO.insertComment(postIdx);
	}
	
	@Override
	public void removeComment(int postIdx) {
		postDAO.deleteComment(postIdx);
	}
	
	@Override
	public List<Post> getSelectLikesPost(String userinfoId) {
		return postDAO.selectLikesPost(userinfoId);
	}
	
	@Override
	public List<Post> getSelectWritePost(String userinfoId) {
		return postDAO.selectWritePost(userinfoId);
	}

	@Override
	public List<Post> getSelectResentlyPostList(int offset, int limit, String selectKeyword) {
		return postDAO.selectResentlyPostList(offset, limit, selectKeyword);
	}
	
	@Override
	public List<Post> getSelectViewPostList(int offset, int limit, String selectKeyword) {
		return postDAO.selectViewPostList(offset, limit, selectKeyword);
	}

	@Override
	public List<Post> getSelectLikesPostList(int offset, int limit, String selectKeyword) {
		return postDAO.selectLikesPostList(offset, limit, selectKeyword);
	}

	@Override
	public List<Post> getSelectCommentPostList(int offset, int limit, String selectKeyword) {
		return postDAO.selectCommentPostList(offset, limit, selectKeyword);
	}

	@Override
	public Post getSelectPreNumNextNum(int postIdx) {
		return postDAO.selectPreNumNextNum(postIdx);
	}


}
