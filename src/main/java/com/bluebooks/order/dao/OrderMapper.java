package com.bluebooks.order.dao;

import org.springframework.stereotype.Repository;

import com.bluebooks.order.domain.Order;

@Repository
public interface OrderMapper {

	public void insertOrder(Order order);
	
}
