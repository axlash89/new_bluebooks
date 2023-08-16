package com.bluebooks.orderedbooks.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.orderedbooks.domain.OrderedBooks;

@Repository
public interface OrderedBooksMapper {

	public void insertOrderedBooksByOrderId(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId,
			@Param("bookCount") int bookCount);
	
	public void insertOrderedSingleBookByOrderId(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId);
	
	public void insertOrderedSingleBookByOrderIdFromDetail(
			@Param("orderId") int orderId, 
			@Param("bookId") int bookId,
			@Param("bookCountFromDetail") int bookCountFromDetail);
	
	public List<OrderedBooks> selectOrderedBooksListByOrderId(int orderId);
	
	
	public List<OrderedBooks> getAllOfOrderedBooks();
	
}
