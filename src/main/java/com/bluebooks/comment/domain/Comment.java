package com.bluebooks.comment.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Comment {

	private int id;
	private int eventId;
	private int userId;
	private String content;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
