package com.bluebooks.event.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.comment.bo.CommentBO;
import com.bluebooks.comment.domain.CommentView;
import com.bluebooks.common.Criteria;
import com.bluebooks.common.FileManagerService;
import com.bluebooks.event.dao.EventMapper;
import com.bluebooks.event.domain.Event;
import com.bluebooks.event.domain.EventView;

@Service
public class EventBO {

	@Autowired
	private EventMapper eventMapper;

	@Autowired
	private FileManagerService fileManager;
	
	@Autowired
	private CommentBO commentBO;
	
	
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
		
		// comment 삭제
		commentBO.deleteCommentByEventId(eventId);
		
		// like 삭제
		
		
		eventMapper.deleteEventById(eventId);
		
		
	}
	
	
	
}
