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

@Service
public class BookBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AladinApiBO aladinApiBO;
	
	@Autowired
	private BookMapper bookMapper;
	
	public List<Book> getSearchedBookList(String searchKeyword, Criteria criteria) {	
		List<Book> searchedBookList = aladinApiBO.getSearchedBookList(searchKeyword, criteria);
		for (int i = 0; i < searchedBookList.size(); i++) {						
			if(bookMapper.isDuplicatedBook(searchedBookList.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(searchedBookList.get(i));				
			} else {				
				searchedBookList.get(i).setId(bookMapper.isDuplicatedBook(searchedBookList.get(i).getIsbn13()).getId());	
			}
		}
		return searchedBookList;
	}
	
	public int getSearchedBookListTotalCount(String searchKeyword) {
		return aladinApiBO.getSearchedBookListTotalCount(searchKeyword);
	}
	
	public Book getBookById(int bookId) {
		return bookMapper.selectBookById(bookId);
	}
	
	public List<Book> getBestSellerTop10List() {
		List<Book> bestSellerTop10List = aladinApiBO.getBestSellerTop10List();
		
		for (int i = 0; i < bestSellerTop10List.size(); i++) {						
			if(bookMapper.isDuplicatedBook(bestSellerTop10List.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(bestSellerTop10List.get(i));				
			} else {				
				bestSellerTop10List.get(i).setId(bookMapper.isDuplicatedBook(bestSellerTop10List.get(i).getIsbn13()).getId());	
			}
		}		
		return bestSellerTop10List;		
	}
	
	public List<Book> getNoteworthyNewBookTop5List() {
		List<Book> noteworthyNewBookTop5List = aladinApiBO.getNoteworthyNewBookTop5List();
		
		for (int i = 0; i < noteworthyNewBookTop5List.size(); i++) {						
			if(bookMapper.isDuplicatedBook(noteworthyNewBookTop5List.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(noteworthyNewBookTop5List.get(i));				
			} else {				
				noteworthyNewBookTop5List.get(i).setId(bookMapper.isDuplicatedBook(noteworthyNewBookTop5List.get(i).getIsbn13()).getId());	
			}
		}		
		return noteworthyNewBookTop5List;		
	}
	
	public List<Book> getBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> bookListByCategory = aladinApiBO.getBookListByCategory(cid, criteria);
		
		for (int i = 0; i < bookListByCategory.size(); i++) {						
			if(bookMapper.isDuplicatedBook(bookListByCategory.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(bookListByCategory.get(i));				
			} else {				
				bookListByCategory.get(i).setId(bookMapper.isDuplicatedBook(bookListByCategory.get(i).getIsbn13()).getId());	
			}
		}		
		return bookListByCategory;		
	}
	
	
	public int getBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getBookListByCategoryTotalCount(cid);
	}
	
	
	public List<Book> getBestBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> bestBookListByCategory = aladinApiBO.getBestBookListByCategory(cid, criteria);
		
		for (int i = 0; i < bestBookListByCategory.size(); i++) {						
			if(bookMapper.isDuplicatedBook(bestBookListByCategory.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(bestBookListByCategory.get(i));				
			} else {				
				bestBookListByCategory.get(i).setId(bookMapper.isDuplicatedBook(bestBookListByCategory.get(i).getIsbn13()).getId());	
			}
		}		
		return bestBookListByCategory;		
	}

	public int getBestBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getBestBookListByCategoryTotalCount(cid);
	}
	
	public List<Book> getNewBookListByCategory(Integer cid, Criteria criteria) {
		List<Book> newBookListByCategory = aladinApiBO.getNewBookListByCategory(cid, criteria);
		
		for (int i = 0; i < newBookListByCategory.size(); i++) {						
			if(bookMapper.isDuplicatedBook(newBookListByCategory.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(newBookListByCategory.get(i));				
			} else {				
				newBookListByCategory.get(i).setId(bookMapper.isDuplicatedBook(newBookListByCategory.get(i).getIsbn13()).getId());	
			}
		}		
		return newBookListByCategory;		
	}
	
	public int getNewBookListByCategoryTotalCount(Integer cid) {
		return aladinApiBO.getNewBookListByCategoryTotalCount(cid);
	}
	
	public List<Book> getAdvancedSearchedBookList(String title, String author, String publisher, String pubPeriod, Criteria criteria) {
		List<Book> advancedSearchedBookListByCategory = aladinApiBO.getAdvancedSearchedBookList(title, author, publisher, criteria);
		
		for (int i = 0; i < advancedSearchedBookListByCategory.size(); i++) {						
			if(bookMapper.isDuplicatedBook(advancedSearchedBookListByCategory.get(i).getIsbn13()) == null) {
				bookMapper.insertBook(advancedSearchedBookListByCategory.get(i));				
			} else {				
				advancedSearchedBookListByCategory.get(i).setId(bookMapper.isDuplicatedBook(advancedSearchedBookListByCategory.get(i).getIsbn13()).getId());	
			}
		}		
		
		
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
				
				// enum으로 해보기
				
				Date timeSet = new Date();
				Calendar cal = Calendar.getInstance(); 
				cal.setTime(timeSet);
				
				if (pubPeriod.equals("threeM")) {		
					cal.add(Calendar.MONTH, -3); //3개월 빼기
					timeSet = cal.getTime();					
				} else if (pubPeriod.equals("sixM")) {
					cal.add(Calendar.MONTH, -6);
					timeSet = cal.getTime();					
				} else if (pubPeriod.equals("nineM")) {					
					cal.add(Calendar.MONTH, -9);
					timeSet = cal.getTime();					
				} else if (pubPeriod.equals("twentyFourM")) {					
					cal.add(Calendar.YEAR, -2);
					timeSet = cal.getTime();					
				}
				
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
