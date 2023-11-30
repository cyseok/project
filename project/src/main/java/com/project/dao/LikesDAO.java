package com.project.dao;

import org.apache.ibatis.annotations.Param;

import com.project.dto.Likes;

public interface LikesDAO {
	int insertPostLikes(Likes likes);
	int deletePostLikes(Likes likes);
	
	Likes selectPostLikes(@Param("postIdx") int postIdx, @Param("userinfoId") String userinfoId);

}
