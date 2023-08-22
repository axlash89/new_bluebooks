package com.bluebooks.common;

public enum PayMethod {

CARD("신용카드"), POINT("카카오페이");
	
	private final String value;
	
	private PayMethod(String value) {
		this.value = value;
	}
		
	public String getValue() {
		return this.value;
	}
	
}
