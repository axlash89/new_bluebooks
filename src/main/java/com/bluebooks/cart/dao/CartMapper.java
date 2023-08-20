package com.bluebooks.cart.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.cart.domain.Cart;

@Repository
public interface CartMapper {

	public List<Cart> selectCartListByUserId(int userId);
	
	public int isItExists(
			@Param("userId") int userId, 
			@Param("bookId") int bookId);
	
	public int bookCountPlusOne(
			@Param("userId") int userId, 
			@Param("bookId") int bookId);
	
	public int bookCountPlus (
		@Param("userId") int userId, 
		@Param("bookId") int bookId,
		@Param("bookCount") int bookCount);
	
	public int insertCart(
			@Param("userId") int userId, 
			@Param("bookId") int bookId);
	
	public int insertCartByBookCount(
			@Param("userId") int userId, 
			@Param("bookId") int bookId,
			@Param("bookCount") int bookCount);
	
	public void deleteFromCart(
			@Param("userId") int userId,
			@Param("bookIdArr") int[] bookIdArr);
	
	public void updateBookCount(
			@Param("userId") int userId,
			@Param("bookId") int bookId,
			@Param("bookCount") int bookCount);
	
	public Cart selectOrderedCartListByUserIdAndBookId(
			@Param("userId") int userId,
			@Param("bookId") int bookId);
	
	public void deleteCartByUserId(int userId);
	
}
