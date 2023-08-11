package com.bluebooks.cart.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.cart.domain.Cart;

@Repository
public interface CartMapper {

	public List<Cart> selectCartListByUserId(int userId);
	
	
	public int insertCart(
			@Param("userId") int userId, 
			@Param("bookId") int bookId);
	
}
