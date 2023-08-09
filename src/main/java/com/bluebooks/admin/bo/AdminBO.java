package com.bluebooks.admin.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.onetoone.entity.OnetooneEntity;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;
import com.bluebooks.withdrawal.bo.WithdrawalBO;
import com.bluebooks.withdrawal.domain.Withdrawal;

@Service
public class AdminBO {
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	@Autowired
	private UserBO userBO;
	
	
	public Page<OnetooneEntity> getAllOfOnetoone(Pageable pageable) {
		return onetooneBO.getAllOfOnetoone(pageable);
	}
	
	public List<UserEntity> getWriterList() {						
		return onetooneBO.getWriterList();
	}
	
	public OnetooneEntity getOnetooneEntityById(int id) {
		return onetooneBO.getOnetooneEntityById(id);
	};
	
	public Page<UserEntity> getAllUserEntity(Pageable pageable) {
		return userBO.getAllUserEntity(pageable);
	}
	
	public UserEntity getUserEntityById(int id) {
		return userBO.getUserEntityById(id);
	}
	
	public Page<UserEntity> userSearchList(String searchKeywordForLoginId, String searchKeywordForName, Pageable pageable) {
		return userBO.userSearchList(searchKeywordForLoginId, searchKeywordForName, pageable);
	}
	
}
