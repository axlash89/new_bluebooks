package com.bluebooks.like.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Like {

	private int commentId;
	private int userId;
	private ZonedDateTime createdAt;
	
}
