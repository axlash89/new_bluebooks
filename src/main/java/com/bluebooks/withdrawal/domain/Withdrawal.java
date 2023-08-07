package com.bluebooks.withdrawal.domain;

import java.time.ZonedDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class Withdrawal {
	
	private int id;
	private String userLoginId;
	private Date userCreatedAt;
	private String reason;
	private ZonedDateTime createdAt;
	
}
