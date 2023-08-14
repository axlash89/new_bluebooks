package com.bluebooks.order.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;
import com.bluebooks.cart.bo.CartBO;
import com.bluebooks.cart.domain.Cart;
import com.bluebooks.cart.domain.CartView;
import com.bluebooks.order.dao.OrderMapper;
import com.bluebooks.order.domain.Order;
import com.bluebooks.orderedbooks.bo.OrderedBooksBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class OrderBO {
	
	@Autowired
	private CartBO cartBO;
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OrderedBooksBO orderedBooksBO;
	
	@Autowired
	private OrderMapper orderMapper;
	
	public List<CartView> getOrderedCartViewList(int userId, String bookIdString) {
		
		String[] bookIdStringArr = bookIdString.split("@");
		
		int[] bookIdArr = new int[bookIdStringArr.length];
		for (int i = 0; i < bookIdStringArr.length; i++) {
			bookIdArr[i] = Integer.parseInt(bookIdStringArr[i]);
		}		
		
		List<Cart> cartList = new ArrayList<>();
		for (int i = 0; i < bookIdArr.length; i++) {
			cartList.add(cartBO.selectOrderedCartListByUserIdAndBookId(userId, bookIdArr[i]));		
		}
		
		List<CartView> orderedCartViewList = new ArrayList<>();
		for (int i = 0; i < cartList.size(); i++) {
			CartView orderedCartView = new CartView();
			orderedCartView.setCart(cartList.get(i));			
			orderedCartView.setBook(bookBO.getBookById(cartList.get(i).getBookId()));
			orderedCartViewList.add(orderedCartView);
		}
				
		return orderedCartViewList;		
	}
	
	public Book getOrderedBook(int bookId) {
		return bookBO.getBookById(bookId);
	}
	
	public UserEntity getUserEntityByUserId(int userId) {
		return userBO.getUserEntityById(userId);
	}
	
	public void createOrder(int userId, int usedPoint, int finalPrice, String payBy, 
			String recipientName, String recipientZipCode, String recipientAddress, 
			String recipientPhoneNumber, int totalPoint, String bookIdString, String bookCount, Integer bookId) {
		
		Order order= new Order();
		order.setUserId(userId);
		order.setUsedPoint(usedPoint);
		order.setFinalPrice(finalPrice);
		order.setPayBy(payBy);
		order.setRecipientName(recipientName);
		order.setRecipientZipCode(recipientZipCode);
		order.setRecipientAddress(recipientAddress);
		order.setRecipientPhoneNumber(recipientPhoneNumber);		
		orderMapper.insertOrder(order);
		
		userBO.updateUserEntityPointById(userId, usedPoint, totalPoint);
		
		if (bookIdString != null) {		
			String[] bookIdStringArr = bookIdString.split("@");			
			int[] bookIdArr = new int[bookIdStringArr.length];
			for (int i = 0; i < bookIdStringArr.length; i++) {
				bookIdArr[i] = Integer.parseInt(bookIdStringArr[i]);
			}
			cartBO.deleteFromCart(userId, bookIdArr);
			
			String[] bookCountStringArr = bookCount.split("");
			int[] bookCountArr = new int[bookCountStringArr.length];
			for (int i = 0; i < bookCountStringArr.length; i++) {
				bookCountArr[i] = Integer.parseInt(bookCountStringArr[i]);
			}			
			orderedBooksBO.insertOrderedBooksByOrderId(order.getId(), bookIdArr, bookCountArr);
		} else {
			orderedBooksBO.insertOrderedSingleBookByOrderId(order.getId(), bookId);
		}
		
	}
	 
	
}
