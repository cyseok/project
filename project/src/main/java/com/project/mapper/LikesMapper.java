package com.project.mapper;

import org.apache.ibatis.annotations.Param;

import com.project.dto.Likes;

public interface LikesMapper {
	int insertPostLikes(Likes likes);
	int deletePostLikes(Likes likes);
	
	Likes selectPostLikes(@Param("postIdx") int postIdx, @Param("userinfoId") String userinfoId);

}
