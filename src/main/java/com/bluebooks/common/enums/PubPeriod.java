package com.bluebooks.common.enums;

public enum PubPeriod {
	
	THREEM(3), SIXM(6), NINEM(9), TWENTYFOURM(24);
	
	private final int value;
	
	private PubPeriod(int value) {
		this.value = value;
	}
		
	public int getValue() {
		return this.value;
	}
	
}
