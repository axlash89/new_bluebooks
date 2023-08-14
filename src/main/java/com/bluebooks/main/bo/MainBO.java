package com.bluebooks.main.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;

@Service
public class MainBO {
	
	@Autowired
	private BookBO bookBO;
	
	public List<Book> getBestSellerTop10List() {
		return bookBO.getBestSellerTop10List();
	}
	
	public List<Book> getNoteworthyNewBookTop5List() {
		return bookBO.getNoteworthyNewBookTop5List();
	}
	
}
