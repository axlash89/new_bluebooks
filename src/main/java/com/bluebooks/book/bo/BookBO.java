package com.bluebooks.book.bo;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.aladin.AladinApiBO;
import com.bluebooks.book.dao.BookMapper;
import com.bluebooks.book.domain.Book;
import com.bluebooks.common.Criteria;
import com.bluebooks.common.PubPeriod;

@Service
public class BookBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AladinApiBO aladinApiBO;
	
	@Autowired
	private BookMapper bookMapper;
	
	public List<Book> isDuplicatedOrNot(List<Book> bookList) {		
		for (int i = 0; i < bookList.size(); i++) {						
			if(bookMapper.isDuplicatedBook(bookList.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(bookList.get(i));				
			} else {				
				bookList.get(i).setId(bookMapper.isDuplicatedBook(bookList.get(i).getIsbn13()).getId());	
			}
		}		
		return bookList;
	}
	
	public List<Book> getSearchedBookList(String searchKeyword, Criteria criteria) {	
		List<Book> searchedBookList = aladinApiBO.getSearchedBookList(searchKeyword, criteria);		
		return isDuplicatedOrNot(searchedBookList);
	}
	
	public int getSearchedBookListTotalCount(String searchKeyword) {
		return aladinApiBO.getSearchedBookListTotalCount(searchKeyword);
	}
	
	public Book getBookById(int bookId) {
		return bookMapper.selectBookById(bookId);
	}
	
	public List<Book> getBestSellerTop10List() {
		List<Book> bestSellerTop10List = aladinApiBO.getBestSellerTop10List();		
		return isDuplicatedOrNot(bestSellerTop10List);		
	}
	
	public List<Book> getNoteworthyNewBookTop5List() {
		List<Book> noteworthyNewBookTop5List = aladinApiBO.getNoteworthyNewBookTop5List();		
		return isDuplicatedOrNot(noteworthyNewBookTop5List);		
	}
	
	public List<Book> getBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> bookListByCategory = aladinApiBO.getBookListByCategory(cid, criteria);		
		return isDuplicatedOrNot(bookListByCategory);		
	}
	
	
	public int getBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getBookListByCategoryTotalCount(cid);
	}
	
	
	public List<Book> getBestBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> bestBookListByCategory = aladinApiBO.getBestBookListByCategory(cid, criteria);		
		return isDuplicatedOrNot(bestBookListByCategory);		
	}

	public int getBestBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getBestBookListByCategoryTotalCount(cid);
	}
	
	public List<Book> getNewBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> newBookListByCategory = aladinApiBO.getNewBookListByCategory(cid, criteria);		
		return isDuplicatedOrNot(newBookListByCategory);		
	}
	
	public int getNewBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getNewBookListByCategoryTotalCount(cid);
	}
	
	public List<Book> getAdvancedSearchedBookList(String title, String author, String publisher, String pubPeriod, Criteria criteria) {
		List<Book> advancedSearchedBookListByCategory = aladinApiBO.getAdvancedSearchedBookList(title, author, publisher, criteria);		
		advancedSearchedBookListByCategory = isDuplicatedOrNot(advancedSearchedBookListByCategory);		
		
		if (pubPeriod.equals("all") == false) {
		
			for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {
				
				String pubDate = advancedSearchedBookListByCategory.get(i).getPubDate();
				
				Date bookDate = null;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
				try {
					bookDate = sdf.parse(pubDate);
				} catch (Exception e) {
					logger.error("###[getAdvancedSearchedBookList 출판 날짜(String pubDate) Date로 변환 실패]");
				}
				
				String pubPeriodForEnum = pubPeriod.toUpperCase();
				int numberOfmonths = PubPeriod.valueOf(pubPeriodForEnum).getValue();
				
				Date timeSet = new Date();
				Calendar cal = Calendar.getInstance(); 
				cal.setTime(timeSet);
				
				cal.add(Calendar.MONTH, - numberOfmonths); //3개월 빼기
				timeSet = cal.getTime();				
				
				if (bookDate.before(timeSet)) {
					advancedSearchedBookListByCategory.remove(i);
					i--;
				}
				
			}
		}
		
		if (title != "" && author != "" && publisher != "") {
			
			for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {
				if (!advancedSearchedBookListByCategory.get(i).getAuthor().contains(author) && !advancedSearchedBookListByCategory.get(i).getPublisher().contains(publisher)) {
					advancedSearchedBookListByCategory.remove(i);
					i--;
				}
			}
		} else if (title == "" && author != "" && publisher != "") {
			
			for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {
				if (!advancedSearchedBookListByCategory.get(i).getPublisher().contains(publisher)) {
					advancedSearchedBookListByCategory.remove(i);
					i--;
				}
			}
		} else if (title != "" && author == "" && publisher != "") {
			
			for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {
				if (!advancedSearchedBookListByCategory.get(i).getPublisher().contains(publisher)) {
					advancedSearchedBookListByCategory.remove(i);
					i--;
				}
			}			
		} else if (title != "" && author != "" && publisher == "") {
							
			for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {
				if (advancedSearchedBookListByCategory.get(i).getAuthor().contains(author) == false) {
					advancedSearchedBookListByCategory.remove(i);
					i--;
				}
			}	
		}
		
		return advancedSearchedBookListByCategory;
		
	}
	
	
	public int getAdvancedSearchedBookListTotalCount(String title, String author, String publisher) {
		
		int totalCount = aladinApiBO.getAdvancedSearchedBookListTotalCount(title, author, publisher);
				
		return totalCount;
	}
	
}
