package com.bluebooks;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.bluebooks.test.CalcType;
import com.bluebooks.test.Status;

public class EnumTest {

	
	
	Status getStatus() {
		return Status.Y;
	}
	
	@Test
	void Status테스트() {
		// given - 준비
		Status status = getStatus();  // Y
		
		// when - 실행
		int v1 = status.getValue1();
		boolean v2 = status.isValue2();  // boolean 타입으로 되어있는 필드의 getter는 is로 시작함.
		
		// then - 검증
		assertEquals(v1, 1);
		assertEquals(v2, true);
		assertEquals(status, Status.Y);
	}
	
	
	@Test
	void 계산테스트() {
		// given
		CalcType calcType = CalcType.CALC_C;
						
		// when
		int result = calcType.calculate(500);
		
		// then
		assertEquals(result, 1500);
		
	}
	
}
