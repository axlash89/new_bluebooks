package com.bluebooks.comment.bo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.comment.dao.CommentMapper;
import com.bluebooks.comment.domain.Comment;
import com.bluebooks.comment.domain.CommentView;
import com.bluebooks.like.bo.LikeBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class CommentBO {


	@Autowired
	private CommentMapper commentMapper;

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private LikeBO likeBO;
	
	
	public int addComment(int eventId, int userId, String content) {		
		return commentMapper.insertComment(eventId, userId, content);
	}

	public int deleteCommentById(int commentId) {
		return commentMapper.deleteCommentById(commentId);
	}
	
	public void deleteCommentByEventId(int eventId) {
		commentMapper.deleteCommentByEventId(eventId);		
	}
	
	public List<CommentView> getCommentViewListByEventId(int eventId, Integer userId) {
		
		List<Comment> commentList = commentMapper.selectCommentListByEventId(eventId);
		
		Map<Integer, Integer> commentIdAndLikeCountKeyValueMap = new HashMap<>();
		
		for (int i = 0; i < commentList.size(); i++) {
			commentIdAndLikeCountKeyValueMap.put(commentList.get(i).getId(), likeBO.getLikeCountByCommentId(commentList.get(i).getId()));						
		}
		
		List<Integer> keySet = new ArrayList<>(commentIdAndLikeCountKeyValueMap.keySet());
		
		keySet.sort((v1, v2) -> commentIdAndLikeCountKeyValueMap.get(v2).compareTo(commentIdAndLikeCountKeyValueMap.get(v1)));

		List<Comment> commentListOrderByLikeCount = new ArrayList<>();
        for (Integer key : keySet) {
        	
        	for (int i = 0; i < commentList.size(); i++) {
        		if (commentList.get(i).getId() == key) {
                	commentListOrderByLikeCount.add(commentList.get(i));
                	commentList.remove(i);
                	i--;
                	break;
        		}
        	}
        	
        }
		
		List<CommentView> commentViewList = new ArrayList<>();
		for (int i = 0; i < commentListOrderByLikeCount.size(); i++) {			
			CommentView commentView = new CommentView();
			UserEntity user = userBO.getUserEntityById(commentListOrderByLikeCount.get(i).getUserId());			
			int likeCount = likeBO.getLikeCountByCommentId(commentListOrderByLikeCount.get(i).getId());	
			boolean filledLike = false;
			if (userId != null) {
				filledLike = likeBO.getLikeOrNot(commentListOrderByLikeCount.get(i).getId(), userId);
			}
			
			commentView.setComment(commentListOrderByLikeCount.get(i));
			commentView.setUser(user);
			commentView.setLikeCount(likeCount);
			commentView.setFilledLike(filledLike);
			
			commentViewList.add(commentView);
		}
		
		return commentViewList;
	}
	
	
	public List<Comment> getCommentListByEventId(int eventId) {
		
		return commentMapper.selectCommentListByEventId(eventId);
		
	}
	
	public void deleteCommentByUserId(int userId) {
		commentMapper.deleteCommentByUserId(userId);		
	}
	
}
