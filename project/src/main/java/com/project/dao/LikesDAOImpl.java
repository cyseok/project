package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.dto.Likes;
import com.project.mapper.LikesMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LikesDAOImpl implements LikesDAO{
	
	private final SqlSession sqlSession;

	@Override
	public int insertPostLikes(Likes likes) {
		return sqlSession.getMapper(LikesMapper.class).insertPostLikes(likes);
	}

	@Override
	public int deletePostLikes(Likes likes) {
		return sqlSession.getMapper(LikesMapper.class).deletePostLikes(likes);
	}

	@Override
	public Likes selectPostLikes(int postIdx, String userinfoId) {
		return sqlSession.getMapper(LikesMapper.class).selectPostLikes(postIdx, userinfoId);
	}

}
