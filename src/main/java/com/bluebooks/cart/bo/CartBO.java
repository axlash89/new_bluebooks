package com.bluebooks.cart.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;
import com.bluebooks.cart.dao.CartMapper;
import com.bluebooks.cart.domain.Cart;
import com.bluebooks.cart.domain.CartView;

@Service
public class CartBO {
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private CartMapper cartMapper;
	
	public int addToCart(int userId, int bookId) {
		return cartMapper.insertCart(userId, bookId);
	}
	
	public List<CartView> getCartViewList(int userId) {
		
		List<Cart> cartList = cartMapper.selectCartListByUserId(userId);		
		List<Book> bookList = new ArrayList<>();
		
		List<CartView> cartViewList = new ArrayList<>();
		
		for (int i = 0; i < cartList.size(); i++) {
			
			bookList.add(bookBO.getCartedBook(cartList.get(i).getBookId()));	
			
			CartView cartView = new CartView();
			cartView.setCart(cartList.get(i));
			cartView.setBook(bookList.get(i));
			
			cartViewList.add(cartView);
			
		}
		
		return cartViewList;
		
	}
	
}
