package com.bluebooks.test;

import java.util.function.Function;

public enum CalcType {
	// 열거형 정의
	CALC_A(value -> value), 
	CALC_B(value -> value * 10),
	CALC_C(value -> value * 3),
	CALC_ETC(value -> 0);
	
	// 필드 정의
	private Function<Integer, Integer> expression;
	
	// 생성자
	CalcType(Function<Integer, Integer> expression) {
		this.expression = expression;
	}
	
	// 계산 적용 메소드
	public int calculate(int value) {
		return expression.apply(value);
	}

}
