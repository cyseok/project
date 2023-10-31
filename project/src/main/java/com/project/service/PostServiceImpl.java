package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.dao.PostDAO;
import com.project.dto.Post;

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
	public void modifyPost(Post post) {
		postDAO.updatePost(post);
	}

	@Override
	public void removePost(int postIdx) {
		postDAO.deletePost(postIdx);
	}

	@Override
	public Post getSelectPost(int postIdx) {
		
		/*
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("post", postDAO.selectPost(postIdx));
        resultMap.put("prevNumNextNum", postDAO.selectPreNumNextNum(postIdx));
        */
		return postDAO.selectPost(postIdx);
	}

	@Override
	public void getPostViewCount(int postIdx) {
		postDAO.postViewCount(postIdx);
	}


	@Override
	public List<Post> getSelectPostList(String selectKeyword) {
		return postDAO.selectPostList(selectKeyword);
	}

	@Override
	public List<Post> getSelectResentlyPostList(String selectKeyword) {
		return postDAO.selectResentlyPostList(selectKeyword);
	}

	@Override
	public List<Post> getSelectLikesPostList(String selectKeyword) {
		return postDAO.selectLikesPostList(selectKeyword);
	}

	@Override
	public List<Post> getSelectPostCommentList(String selectKeyword) {
		return postDAO.selectPostCommentList(selectKeyword);
	}

	@Override
	public Post getSelectPreNumNextNum(int postIdx) {
		return postDAO.selectPreNumNextNum(postIdx);
	}

}
