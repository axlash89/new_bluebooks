package com.bluebooks.withdrawal.bo;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;
import com.bluebooks.withdrawal.dao.WithdrawalMapper;
import com.bluebooks.withdrawal.domain.Criteria;

@Service
public class WithdrawalBO {

	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	public int deleteWithdrawal(int userId, String userLoginId, String reason) {
		
		// user(완료), onetoone(완료), like, comment, cart 다 지워야함.
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		Date userCreatedAt = Date.from(userEntity.getCreatedAt().toInstant());
		
		int row = withdrawalMapper.insertWithdrawal(userId, userLoginId, userCreatedAt, reason);

		userBO.deleteUserEntityByUserId(userId);
		
		onetooneBO.deleteOnetooneByUserId(userId);

		return row;
		
	}
	
 
//	public List<Withdrawal> getWithdrawalList() {
//		List<Withdrawal> withdrawalList = withdrawalMapper.selectWithdrawalList();
//		return withdrawalList;
//	}

	public List<Map<String, Object>> selectWithdrawalList(Criteria criteria) {
		// TODO Auto-generated method stub
		return withdrawalMapper.selectWithdrawalList(criteria);
	}


	public int totalCount() {
		// TODO Auto-generated method stub
		return withdrawalMapper.totalCount();
	}

}
