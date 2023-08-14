package com.bluebooks.cart.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.cart.dao.CartMapper;
import com.bluebooks.cart.domain.Cart;
import com.bluebooks.cart.domain.CartView;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class CartBO {
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CartMapper cartMapper;
	
	public void addBooksToCart(int userId, int[] bookIdArr) {
		for (int i = 0; i < bookIdArr.length; i++) {			
			if (cartMapper.isItExists(userId, bookIdArr[i]) > 0) {
				cartMapper.bookCountPlusOne(userId, bookIdArr[i]);
			} else {
				cartMapper.insertCart(userId, bookIdArr[i]);
			}
		}
	}
	
	public List<CartView> getCartViewList(int userId) {
		
		List<Cart> cartList = cartMapper.selectCartListByUserId(userId);	
		
		List<CartView> cartViewList = new ArrayList<>();
		
		for (int i = 0; i < cartList.size(); i++) {
			
			CartView cartView = new CartView();
			cartView.setCart(cartList.get(i));
			cartView.setBook(bookBO.getBookById(cartList.get(i).getBookId()));
			
			cartViewList.add(cartView);
			
		}
		
		return cartViewList;
		
	}
	
	public void deleteFromCart(int userId, int[] bookIdArr) {
		
		for (int i = 0; i < bookIdArr.length; i++) {
			cartMapper.deleteFromCart(userId, bookIdArr[i]);
		}
		
	}
	
	
	public void updateBookCount(int userId, int bookId, int bookCount) {
		cartMapper.updateBookCount(userId, bookId, bookCount);
	}
	
	public Cart selectOrderedCartListByUserIdAndBookId(int userId, int bookId) {
		return cartMapper.selectOrderedCartListByUserIdAndBookId(userId, bookId);
	}
	
	public int getRefreshedUserPoint(int userId) {
		UserEntity user = userBO.getUserEntityById(userId);
		return user.getPoint();
	}
	
	
}
