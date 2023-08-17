package com.bluebooks.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.common.Criteria;
import com.bluebooks.order.domain.Order;

@Repository
public interface OrderMapper {

	public void insertOrder(Order order);
	
	public List<Order> selectOrderListByUserId(
			@Param("userId") int userId, 
			@Param("criteria") Criteria criteria);

	public int getTotalOrderViewCountByUserId(int userId);
	
	public List<Order> selectOrderListByUserIdAndByPeriod(
			@Param("userId") int userId, 
			@Param("period") String period,
			@Param("criteria") Criteria criteria);

	public int getTotalOrderViewCountByUserIdAndByPeriod(
			@Param("userId") int userId, 
			@Param("period") String period);
	
	public List<Order> selectOrderList(Criteria criteria);
	
	public int getTotalOrderViewCount();
	
	public List<Order> selectOrderListByPeriod(
			@Param("period") String period, 
			@Param("criteria")Criteria criteria);

	public int getTotalOrderViewCountByPeriod(String period);
	
	public void updateStatusByOrderId(
			@Param("orderId") int orderId,
			@Param("status") String status);
	
	public void updateStatusByOrderIdArr(Integer orderId);
	
	public List<Order> selectOrderListByUserIdList(
			@Param("userIdArr") int[] userIdArr, 
			@Param("criteria") Criteria criteria);	
	
	public Integer getTotalOrderViewCountByUserIdList(
			@Param("userIdArr") int[] userIdArr);
	
	public List<Order> selectOrderByIdList(
			@Param("orderIdArr") Integer[] orderIdArr, 
			@Param("criteria") Criteria criteria);
		
	public List<Order> selectOrderListByUserIdListAndByPeriod(
			@Param("userIdArr") int[] userIdArr,
			@Param("period") String period,
			@Param("criteria") Criteria criteria);
	
	public int getTotalOrderViewCountByUserIdListAndByPeriod(
			@Param("userIdArr") int[] userIdArr,
			@Param("period") String period);
	
	public List<Order> selectOrderByIdListAndByPeriod(
			@Param("orderIdArr") Integer[] orderIdArr, 
			@Param("period") String period,
			@Param("criteria") Criteria criteria);

	public int getTotalOrderViewCountByBookTitleAndByPeriod(
			@Param("orderIdArr") Integer[] orderIdArr, 
			@Param("period") String period);
	
	public Order getOrderById(int orderId);
	
}
