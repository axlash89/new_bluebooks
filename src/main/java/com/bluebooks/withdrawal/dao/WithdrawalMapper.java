package com.bluebooks.withdrawal.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.withdrawal.domain.Criteria;

@Repository
public interface WithdrawalMapper {

	public int insertWithdrawal(
			@Param("userId") int userId,
			@Param("userLoginId") String userLoginId,
			@Param("userCreatedAt") Date userCreatedAt,
			@Param("reason") String reason);
	
	
    public List<Map<String, Object>> selectWithdrawalList(Criteria criteria);
    
    
    public int totalCount();
	
	
	
}
