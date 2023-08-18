package com.bluebooks.book.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bluebooks.book.domain.Book;

@Repository
public interface BookMapper {
	
	public List<Map<String, Object>> selectBookList();

	public void insertBook(Book book);
	
	public Book selectBookById(int bookId);
	
	public Book isDuplicatedBook(String isbn13);
	
	public List<String> selectBookByRecentBookIds(
			@Param("recentBookIds") Integer[] recentBookIds);
	
}
