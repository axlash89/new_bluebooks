package com.bluebooks.orderedbooks.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class OrderedBooks {

	private int id;
	private int orderId;
	private int bookId;
	private int bookCount;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
