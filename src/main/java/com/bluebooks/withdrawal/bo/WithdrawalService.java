package com.bluebooks.withdrawal.bo;

import java.util.List;
import java.util.Map;

import com.bluebooks.paging.Pagination;

public interface WithdrawalService {

	//select * from Test_Table
    public List<Map<String, Object>> selectWithdrawalList() throws Exception;
    
    //Paging
    public List<Map<String, Object>> selectWithdrawalList(Pagination pagination) throws Exception;
 
    //count
    public int withdrawalCount() throws Exception;
	
}
