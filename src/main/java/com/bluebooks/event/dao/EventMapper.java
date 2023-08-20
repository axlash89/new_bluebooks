package com.bluebooks.event.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.common.Criteria;
import com.bluebooks.event.domain.Event;

@Repository
public interface EventMapper {

	public int insertEvent(String imagePath);
	
	public Event selectEventById(int eventId);
	
	public void updateEventById(
			@Param("eventId") int eventId, 
			@Param("imagePath") String imagePath);
	
	public List<Event> selectEventList(Criteria criteria);
	
	public int getTotalEventViewCount();
	
	public void deleteEventById(int eventId);
	
	public List<Event> selectEventListForMain();
	
	
}
