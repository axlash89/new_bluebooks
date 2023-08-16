package com.bluebooks.orderedbooks.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.orderedbooks.dao.OrderedBooksMapper;
import com.bluebooks.orderedbooks.domain.OrderedBooks;

@Service
public class OrderedBooksBO {

	@Autowired
	private OrderedBooksMapper orderedBooksMapper;
	
	public void insertOrderedBooksByOrderId(int orderId, int[] bookIdArr, int[] bookCountArr) {
		
		for (int i = 0; i < bookIdArr.length; i++) {
			orderedBooksMapper.insertOrderedBooksByOrderId(orderId, bookIdArr[i], bookCountArr[i]);
		}
		
	}
	
	public void insertOrderedSingleBookByOrderId(int orderId, int bookId) {
		orderedBooksMapper.insertOrderedSingleBookByOrderId(orderId, bookId);
	}
	
	public void insertOrderedSingleBookByOrderIdFromDetail(int orderId, int bookId, int bookCountFromDetail) {
		orderedBooksMapper.insertOrderedSingleBookByOrderIdFromDetail(orderId, bookId, bookCountFromDetail);
	}
	
	public List<OrderedBooks> getOrderedBooksListByOrderId(int orderId) {
		return orderedBooksMapper.selectOrderedBooksListByOrderId(orderId);
	}
	
	public List<OrderedBooks> getAllOfOrderedBooks() {
		return orderedBooksMapper.getAllOfOrderedBooks();
	}
	
}
