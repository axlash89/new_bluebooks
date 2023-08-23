package com.bluebooks.test;

import lombok.Getter;

@Getter
public enum Status {

	// 열거형 정의
	Y(1, true),
	N(0, false);
	
	// enum에 정의된 항목들의 필드
	private int value1;
	private boolean value2;
	
	// 생성자
	private Status(int value1, boolean value2) {
		this.value1 = value1;
		this.value2 = value2;
	}
	
}
