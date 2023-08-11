package com.bluebooks.aladin;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.bluebooks.book.dao.BookMapper;
import com.bluebooks.book.domain.Book;
import com.bluebooks.common.Criteria;

@Service
public class AladinApiBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BookMapper bookMapper;
	
	public List<Book> getSearchedBookList (String searchKeyword, Criteria criteria) {

		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + searchKeyword + "&QueryType=Title&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPageStart() +"&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> searchedBookList = new ArrayList<>();
		
		try {
            
            JSONParser jsonParse = new JSONParser();
            
            //JSONParse에 json데이터를 넣어 파싱한 다음 JSONObject로 변환한다.
            JSONObject jsonObj = (JSONObject) jsonParse.parse(result);
            
            JSONArray bookArray = (JSONArray) jsonObj.get("item");
            
            for(int i=0; i < bookArray.size(); i++) {
            	
                JSONObject bookObject = (JSONObject) bookArray.get(i);
                
		        Book book = new Book();
		        
		        book.setIsbn13((String) bookObject.get("isbn13"));
		        book.setCategoryName((String) bookObject.get("categoryName"));
		        book.setTitle((String) bookObject.get("title"));
		        book.setAuthor((String) bookObject.get("author"));
		        book.setPublisher((String) bookObject.get("publisher"));
		        book.setPubDate((String) bookObject.get("pubDate"));
		        book.setDescription((String) bookObject.get("description"));
		        book.setPriceStandard((long) bookObject.get("priceStandard"));
		        book.setDescription((String) bookObject.get("description"));
		        book.setPriceStandard((long) bookObject.get("priceSales"));
		        book.setPriceSales((long) bookObject.get("priceSales"));
		        book.setPoint((long) bookObject.get("mileage"));
		        book.setCover((String) bookObject.get("cover"));
		        book.setCreatedAt(ZonedDateTime.now());
		        book.setUpdatedAt(ZonedDateTime.now());
		        
		        searchedBookList.add(book);
		        
            }
            
        } catch (ParseException e) {
        	
        	logger.error("###[AladinApiBO getSearchedBookList] searchKeyword:{}", searchKeyword);
        	
        }
		
		return searchedBookList;
		
	}
	
	public Integer getSearchedBookListTotalCount(String searchKeyword) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + searchKeyword + "&QueryType=Title&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		Integer totalCount = null;
		
		try {
			
			JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj;
			jsonObj = (JSONObject) jsonParse.parse(result);
	        JSONArray bookArray = (JSONArray) jsonObj.get("item");
	        
	        totalCount = bookArray.size();	        
			
		} catch (ParseException e) {
			
			logger.error("###[AladinApiBO getSearchedBookListTotalCount] searchKeyword:{}", searchKeyword);
			
		}
		
		return totalCount;
		
	}
	
}
