package com.bluebooks.withdrawal.bo;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;
import com.bluebooks.withdrawal.dao.WithdrawalMapper;

@Service
public class WithdrawalAsyncBO {

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	public int insertWithdrawal(int userId, String userLoginId, String reason) {
		

		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		Date userCreatedAt = Date.from(userEntity.getCreatedAt().toInstant());
		
		int row = withdrawalMapper.insertWithdrawal(userId, userLoginId, userCreatedAt, reason);
		
		
		
		return row;
		
	}
	
}
