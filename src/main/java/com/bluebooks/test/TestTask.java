package com.bluebooks.test;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class TestTask {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
//	// 1분에 한번씩 수행
//	@Scheduled(cron = "*/10 * * * * *")
//	public void test() {
//		logger.info("###### test task!!!");
//	}
	
}
