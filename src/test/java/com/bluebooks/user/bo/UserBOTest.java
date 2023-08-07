package com.bluebooks.user.bo;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.bluebooks.user.entity.UserEntity;

@SpringBootTest
class UserBOTest {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	UserBO userBO;

	// @Test
	void test() {
		fail("Not yet implemented");
	}
	
	@Test
	void 회원조회() {
		UserEntity user = userBO.getUserEntityByLoginId("axlash77");
		logger.info("###### user: {}", user);
		assertNotNull(user);
	}
	
	// @Transactional  // rollback
	// @Test
	// 쇼핑몰 같은 경우 기존 재고가 - 되어야하고,, 행이 들어가고 주문번호를 뽑아내야하고 
	// void 회원_추가_테스트() {
	//	Date date;
	//	userBO.addUser();
	//	}
	

}
