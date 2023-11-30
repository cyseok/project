package com.project.service;

import org.apache.ibatis.annotations.Param;

import com.project.dto.Likes;

public interface LikesService {
	void addPostLikes(Likes likes);
	void removePostLikes(Likes likes);
	
	Likes getPostLikes(@Param("postIdx") int postIdx, @Param("userinfoId") String userinfoId);

}
