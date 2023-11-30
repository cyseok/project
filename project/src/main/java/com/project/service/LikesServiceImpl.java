package com.project.service;

import org.springframework.stereotype.Service;

import com.project.dao.LikesDAO;
import com.project.dto.Likes;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LikesServiceImpl implements LikesService{
	
	private final LikesDAO likesDAO;

	@Override
	public void addPostLikes(Likes likes) {
		likesDAO.insertPostLikes(likes);
	}

	@Override
	public void removePostLikes(Likes likes) {
		likesDAO.deletePostLikes(likes);
	}

	@Override
	public Likes getPostLikes(int postIdx, String userinfoId) {
		return likesDAO.selectPostLikes(postIdx, userinfoId);
	}

}
