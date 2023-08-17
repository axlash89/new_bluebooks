package com.bluebooks.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.like.dao.LikeMapper;
import com.bluebooks.like.domain.Like;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;
	
	public int getLikeCountByCommentId(int commentId) {
		
		return likeMapper.selectLikeCountByCommentId(commentId);
		
	}
	
	public boolean getLikeOrNot(int commentId, Integer userId) {
		
		Like like = likeMapper.selectLikeByCommentIdAndUserId(commentId, userId);
		
		return like == null ? false : true;
	}
	
	public int likeToggle(int commentId, int userId) {
		
		Like like = likeMapper.selectLikeByCommentIdAndUserId(commentId, userId);		
		
		if (like == null) {			
			int row = likeMapper.insertLikeByCommentIdAndUserId(commentId, userId);
			return row;						
		} else {			
			int row = likeMapper.deleteLikeByCommentIdAndUserId(commentId, userId);
			return row;
		}
		
	}
	
}
