package com.bluebooks.withdrawal.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.withdrawal.dao.WithdrawalMapper;

@Service
public class WithdrawalBO {

	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	public void deleteWithdrawal(int userId) {
		
		// user, onetoone, like, comment, cart 다 지워야함.
		
		// onetoone이 안지워짐.
		
		// UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		// Date userCreatedAt = Date.from(userEntity.getCreatedAt().toInstant());
		
		// int row = withdrawalMapper.insertWithdrawal(userId, userLoginId, userCreatedAt, reason);
		
		userBO.deleteUserEntityByUserId(userId);

		onetooneBO.deleteOnetooneByUserId(userId);
		
	}
	
	
}
