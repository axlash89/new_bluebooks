package com.bluebooks.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.comment.domain.Comment;

@Repository
public interface CommentMapper {

	public int insertComment(
			@Param("eventId") int eventId,
			@Param("userId") int userId, 
			@Param("content") String content);
	

	public int deleteCommentById(int commentId);
	
	public int deleteCommentByEventId(int eventId);
	
	public List<Comment> selectCommentListByEventId(int eventId);
	
	public void deleteCommentByUserId(int userId);
	
}
