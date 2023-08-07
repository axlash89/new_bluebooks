package com.bluebooks.withdrawal.bo;

import java.time.ZonedDateTime;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;
import com.bluebooks.withdrawal.dao.WithdrawalMapper;

@Service
public class WithdrawalBO {

	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	
	public int insertWithdrawal(int userId, String userLoginId, String reason) {
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		Date userCreatedAt = Date.from(userEntity.getCreatedAt().toInstant());
		
		int row = withdrawalMapper.insertWithdrawal(userLoginId, userCreatedAt, reason);
		
		userBO.deleteUserEntityByUserId(userId);

		onetooneBO.deleteOnetooneEntityByUserId(userId);
		
		return row;
		
	}
	
	
}
