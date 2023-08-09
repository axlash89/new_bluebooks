package com.bluebooks.withdrawal.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.paging.Pagination;

@Mapper
@Repository
public interface WithdrawalMapper {

	public int insertWithdrawal(
			@Param("userId") int userId,
			@Param("userLoginId") String userLoginId,
			@Param("userCreatedAt") Date userCreatedAt,
			@Param("reason") String reason);
	
	
	//select * from Test_Table
    public List<Map<String, Object>> selectWithdrawalList() throws Exception;
    
    //Paging
    public List<Map<String, Object>> selectWithdrawalList(Pagination pagination) throws Exception;
 
    //count
    public int withdrawalCount() throws Exception;
	
	
	
}
