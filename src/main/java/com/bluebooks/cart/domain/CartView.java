package com.bluebooks.cart.domain;

import com.bluebooks.book.domain.Book;

import lombok.Data;

@Data
public class CartView {

	private Cart cart;
	
	private Book book;
	
}
