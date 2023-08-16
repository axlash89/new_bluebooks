package com.bluebooks.order.domain;

import java.util.List;

import com.bluebooks.book.domain.Book;
import com.bluebooks.orderedbooks.domain.OrderedBooks;
import com.bluebooks.user.entity.UserEntity;

import lombok.Data;

@Data
public class OrderView {

	private Order order;
	
	private List<OrderedBooks> orderedBooksList;

	private List<Book> bookList;
	
	private UserEntity user;
	
}
