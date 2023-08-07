package com.bluebooks.withdrawal.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface WithdrawalMapper {

	public int insertWithdrawal(
			@Param("userLoginId") String userLoginId,
			@Param("userCreatedAt") Date userCreatedAt,
			@Param("reason") String reason);
	
}
