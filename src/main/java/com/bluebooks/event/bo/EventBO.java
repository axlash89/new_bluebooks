package com.bluebooks.event.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.comment.bo.CommentBO;
import com.bluebooks.comment.domain.Comment;
import com.bluebooks.comment.domain.CommentView;
import com.bluebooks.common.Criteria;
import com.bluebooks.common.FileManagerService;
import com.bluebooks.event.dao.EventMapper;
import com.bluebooks.event.domain.Event;
import com.bluebooks.event.domain.EventView;
import com.bluebooks.like.bo.LikeBO;

@Service
public class EventBO {

	@Autowired
	private EventMapper eventMapper;

	@Autowired
	private FileManagerService fileManager;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	
	public int addEvent(MultipartFile file) {
		String imagePath = null;
		
		imagePath = fileManager.saveEventFile(file);
		if (imagePath == null) {
			return 0;
		}
		
		int row = eventMapper.insertEvent(imagePath);
		
		return row;
		
	}
	
	
	public void updateEventById(int eventId, MultipartFile file) {
		
		Event event = eventMapper.selectEventById(eventId);
		
		String originalImagePath = event.getImagePath();
		fileManager.deleteFile(originalImagePath);
		
		String imagePath = null;			
		imagePath = fileManager.saveEventFile(file);
		
		eventMapper.updateEventById(eventId, imagePath);		
		
	}
	
	public List<EventView> getEventViewList(Integer userId, Criteria criteria) {
		List<Event> eventList = eventMapper.selectEventList(criteria);
		
		List<EventView> eventViewList = new ArrayList<>();
		
		for (int i = 0; i < eventList.size(); i++) {
			EventView eventView = new EventView();
			List<CommentView> commentViewList = commentBO.getCommentViewListByEventId(eventList.get(i).getId(), userId);
			
			eventView.setEvent(eventList.get(i));
			eventView.setCommentViewList(commentViewList);
			
			eventViewList.add(eventView);			
		}
		
		return eventViewList;
		
	}
	
	public int getTotalEventViewCount() {
		return eventMapper.getTotalEventViewCount();
	}
	
	public void deleteEventById(int eventId) {
		
		// like 삭제
		List<Comment> commentListByEventId = commentBO.getCommentListByEventId(eventId);
		
		if (commentListByEventId.size() != 0) {
			int[] commentIdArr = new int[commentListByEventId.size()];
			for (int i = 0; i < commentListByEventId.size(); i++) {
				commentIdArr[i] = commentListByEventId.get(i).getId();
			}			
			likeBO.deleteLikeByCommentIdArr(commentIdArr);			
		}
		
		// comment 삭제
		commentBO.deleteCommentByEventId(eventId);
		
		
		eventMapper.deleteEventById(eventId);
				
	}
	
	public List<Event> getEventListForMain() {
		return eventMapper.selectEventListForMain();
	}
	
	
	
}
