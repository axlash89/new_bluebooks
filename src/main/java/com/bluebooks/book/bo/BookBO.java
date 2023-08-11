package com.bluebooks.book.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.aladin.AladinApiBO;
import com.bluebooks.book.dao.BookMapper;
import com.bluebooks.book.domain.Book;
import com.bluebooks.common.Criteria;

@Service
public class BookBO {

	@Autowired
	private AladinApiBO aladinApiBO;
	
	@Autowired
	private BookMapper bookMapper;
	
	public List<Book> getSearchedBookList(String searchKeyword, Criteria criteria) {	
		List<Book> searchedBookList = aladinApiBO.getSearchedBookList(searchKeyword, criteria);
		for (int i = 0; i < searchedBookList.size(); i++) {
			bookMapper.insertSearchedBook(searchedBookList.get(i));
		}
		return searchedBookList;
	}
	
	public Integer getSearchedBookListTotalCount(String searchKeyword) {
		return aladinApiBO.getSearchedBookListTotalCount(searchKeyword);
	}
	
	public Book getCartedBook(int bookId) {
		return bookMapper.selectCartedBook(bookId);
	}
	
}
