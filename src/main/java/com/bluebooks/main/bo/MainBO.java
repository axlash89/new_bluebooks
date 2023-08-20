package com.bluebooks.main.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.book.bo.BookBO;
import com.bluebooks.book.domain.Book;
import com.bluebooks.event.bo.EventBO;
import com.bluebooks.event.domain.Event;

@Service
public class MainBO {
	
	@Autowired
	private BookBO bookBO;
	
	@Autowired
	private EventBO eventBO;
	
	public List<Book> getBestSellerTop10List() {
		return bookBO.getBestSellerTop10List();
	}
	
	public List<Book> getNoteworthyNewBookTop5List() {
		return bookBO.getNoteworthyNewBookTop5List();
	}
	
	public List<Event> getEventListForMain() {
		return eventBO.getEventListForMain();
	}
	
}
