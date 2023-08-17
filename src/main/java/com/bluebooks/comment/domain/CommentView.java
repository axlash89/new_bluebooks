package com.bluebooks.comment.domain;

import com.bluebooks.user.entity.UserEntity;

import lombok.Data;

@Data
public class CommentView {

	private Comment comment;
	
	private UserEntity user;
	
	private int likeCount;
	
	private boolean filledLike;
	
}
