package com.bluebooks.orderedbooks.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.orderedbooks.dao.OrderedBooksMapper;

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
	
	public void insertOrderedSingleBookByOrderIdFromBookDetail(int orderId, int bookId, int bookCountFromBookDetail) {
		orderedBooksMapper.insertOrderedSingleBookByOrderIdFromBookDetail(orderId, bookId, bookCountFromBookDetail);
	}
	
}
