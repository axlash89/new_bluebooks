package com.bluebooks.order.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Order {

	private int id;
	private int userId;
	private int usedPoint;
	private int finalPrice;
	private String payBy;
	private String status;
	private String recipientName;
	private String recipientZipCode;
	private String recipientAddress;
	private String recipientPhoneNumber;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
