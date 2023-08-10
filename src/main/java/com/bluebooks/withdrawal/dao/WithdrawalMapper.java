package com.bluebooks.withdrawal.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.withdrawal.domain.Criteria;
import com.bluebooks.withdrawal.domain.Withdrawal;

@Repository
public interface WithdrawalMapper {

	public int insertWithdrawal(
			@Param("userId") int userId,
			@Param("userLoginId") String userLoginId,
			@Param("userCreatedAt") Date userCreatedAt,
			@Param("reason") String reason);
	
    public List<Withdrawal> selectWithdrawalList(Criteria criteria);
    
    public List<Withdrawal> selectWithdrawalListByLoginId(
    		@Param("criteria") Criteria criteria, 
    		@Param("searchKeyword") String searchKeyword);
    
    public List<Withdrawal> selectWithdrawalListByReason(
    		@Param("criteria") Criteria criteria, 
    		@Param("searchKeyword") String searchKeyword);
    
    public int getTotalCount();
    
    public int getTotalCountByLoginId(String searchKeyword);
    
    public int getTotalCountByReason(String searchKeyword);    
	
}
