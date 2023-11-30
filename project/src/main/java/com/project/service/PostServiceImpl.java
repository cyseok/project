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
	public void modifyPost(Post post) {
		postDAO.updatePost(post);
	}

	@Override
	public void removePost(int postIdx) {
		postDAO.deletePost(postIdx);
	}

	@Override
	public Post getSelectPost(int postIdx) throws PostNotFoundException {
		
		/*
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("post", postDAO.selectPost(postIdx));
        resultMap.put("prevNumNextNum", postDAO.selectPreNumNextNum(postIdx));
        */
		Post post = postDAO.selectPost(postIdx);
		if (post == null) {
	        throw new PostNotFoundException("존재하는 글이 없습니다");
	    }
		return postDAO.selectPost(postIdx);
	}

	@Override
	public void getPostViewCount(int postIdx) {
		postDAO.postViewCount(postIdx);
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
