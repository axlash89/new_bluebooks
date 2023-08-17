package com.bluebooks.event.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Event {

	private int id;
	private String imagePath;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
