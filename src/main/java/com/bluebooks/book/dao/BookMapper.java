package com.bluebooks.book.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.bluebooks.book.domain.Book;

@Repository
public interface BookMapper {
	
	public List<Map<String, Object>> selectBookList();

	public void insertSearchedBook(Book book);
	
	public Book selectCartedBook(int bookId);
	
}
