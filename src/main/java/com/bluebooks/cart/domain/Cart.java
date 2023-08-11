package com.bluebooks.cart.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Cart {

	private int id;
	private int userId;
	private int bookId;
	private int bookCount;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
