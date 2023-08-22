package com.bluebooks.order.domain;

import java.time.ZonedDateTime;

import javax.persistence.Convert;

import com.bluebooks.common.PayMethod;
import com.bluebooks.order.converter.PayMethodConverter;

import lombok.Data;

@Data
public class Order {

	private int id;
	private int userId;
	private int usedPoint;
	private int finalPrice;
	
	@Convert(converter=PayMethodConverter.class)
	private PayMethod payBy;
	
	private String status;
	private String recipientName;
	private String recipientZipCode;
	private String recipientAddress;
	private String recipientPhoneNumber;
	private ZonedDateTime createdAt;
	private ZonedDateTime updatedAt;
	
}
