package com.bluebooks;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class BlueBooksApplicationTests {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Test
	void contextLoads() {
		
	}
	
	// @Test
	void 더하기_테스트() {
		logger.debug("###### 더하기 테스트 시작");
		int a = 10;
		int b = 20;
		
		assertEquals(20, 더하기(a, b));
		
	}

	int 더하기(int x, int y) {
		return x + y;
	}
	
}
