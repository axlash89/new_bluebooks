package com.bluebooks.orderedbooks.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderedBooksMapper {

	public void insertOrderedBooksByOrderId(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId,
			@Param("bookCount") int bookCount);
	
	public void insertOrderedSingleBookByOrderId(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId);
	
	public void insertOrderedSingleBookByOrderIdFromBookDetail(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId,
			@Param("bookCountFromBookDetail") int bookCountFromBookDetail);
	
	
}
