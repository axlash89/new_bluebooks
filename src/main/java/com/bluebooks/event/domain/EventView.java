package com.bluebooks.event.domain;

import java.util.List;

import com.bluebooks.comment.domain.CommentView;

import lombok.Data;

@Data
public class EventView {

	private Event event;
	
	private List<CommentView> commentViewList;
	
}
