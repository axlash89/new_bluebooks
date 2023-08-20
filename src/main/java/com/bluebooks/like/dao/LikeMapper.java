package com.bluebooks.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.like.domain.Like;

@Repository
public interface LikeMapper {

	public int selectLikeCountByCommentId(int commentId);
	
	public Like selectLikeByCommentIdAndUserId(
			@Param("commentId") int commentId, 
			@Param("userId") int userId);
	
	public int insertLikeByCommentIdAndUserId(
			@Param("commentId") int commentId,
			@Param("userId") int userId);

	public int deleteLikeByCommentIdAndUserId(
			@Param("commentId") int commentId, 
			@Param("userId") int userId);
	
	public int deleteLikeByCommentIdArr(
			@Param("commentIdArr") int[] commentIdArr);
	
	public void deleteLikeByUserId(int userId);
	
}
