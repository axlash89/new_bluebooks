package com.bluebooks.aladin;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.bluebooks.book.domain.Book;
import com.bluebooks.common.Criteria;

@Service
public class AladinApiBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public List<Book> JSONParser(String result, List<Book> list) {
		
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
		        book.setPriceStandard((long) bookObject.get("priceStandard"));
		        book.setPriceSales((long) bookObject.get("priceSales"));
		        book.setPoint((long) bookObject.get("mileage"));
		        book.setCover((String) bookObject.get("cover"));
		        book.setCreatedAt(ZonedDateTime.now());
		        book.setUpdatedAt(ZonedDateTime.now());
		        
		        list.add(book);
		        
            }
            
        } catch (ParseException e) {
        	
        	logger.error("###[AladinApiBO JSONParser] JSON 파싱 오류");
        	
        }
		
		return list;
		
	}
	
	
	public List<Book> getSearchedBookList (String searchKeyword, Criteria criteria) {

		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + searchKeyword + "&QueryType=Keyword&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> searchedBookList = new ArrayList<>();
		
		return JSONParser(result, searchedBookList);
		
	}
	
	public int getSearchedBookListTotalCount(String searchKeyword) {
		
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
	        long totalResults = (long) jsonObj.get("totalResults");
	        
	        totalCount = Long.valueOf(totalResults).intValue();	        
		} catch (ParseException e) {			
			logger.error("###[AladinApiBO getSearchedBookListTotalCount] searchKeyword:{}", searchKeyword);
		}
		
		if (totalCount > 200) {			
			totalCount = 200;			
		}
		
		return totalCount;
		
	}
	
	public List<Book> getBestSellerTop10List() {
		

		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=Bestseller&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> bestSellerTop10List = new ArrayList<>();
		
		return JSONParser(result, bestSellerTop10List);
		
	}
	
	
	public List<Book> getNoteworthyNewBookTop5List() {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=ItemNewSpecial&MaxResults=5&start=1&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> noteworthyNewBookTop5List = new ArrayList<>();
		
		return JSONParser(result, noteworthyNewBookTop5List);
		
	}
	
	
	public List<Book> getBookListByCategory(Integer cid, Criteria criteria) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=ItemNewAll&CategoryId=" + cid + "&MaxResults=" + criteria.getPerPageNum() + "&start="  + criteria.getPage() + "&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> bookListByCategory = new ArrayList<>();
		
		return JSONParser(result, bookListByCategory);
		
	}
		
	public int getBookListByCategoryTotalCount(Integer cid) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=ItemNewAll&CategoryId=" + cid + "&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		Integer totalCount = null;
		
		try {			
			JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj;
			jsonObj = (JSONObject) jsonParse.parse(result);
	        long totalResults = (long) jsonObj.get("totalResults");	        
	        totalCount = Long.valueOf(totalResults).intValue();	        
		} catch (ParseException e) {			
			logger.error("###[AladinApiBO getBookListByCategoryTotalCount] cid:{}", cid);			
		}		
		
		if (totalCount > 200) {			
			totalCount = 200;			
		}
		
		return totalCount;
		
	}
		
	public List<Book> getBestBookListByCategory(Integer cid, Criteria criteria) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=Bestseller&CategoryId=" + cid + "&MaxResults=" + criteria.getPerPageNum() + "&start="  + criteria.getPage() + "&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> bestBookListByCategory = new ArrayList<>();
		
		return JSONParser(result, bestBookListByCategory);
		
	}
	
	public int getBestBookListByCategoryTotalCount(Integer cid) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=Bestseller&CategoryId=" + cid + "&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		Integer totalCount = null;
		
		try {			
			JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj;
			jsonObj = (JSONObject) jsonParse.parse(result);
	        long totalResults = (long) jsonObj.get("totalResults");	        
	        totalCount = Long.valueOf(totalResults).intValue();	        
		} catch (ParseException e) {			
			logger.error("###[AladinApiBO getBestBookListByCategoryTotalCount] cid:{}", cid);			
		}		
		
		if (totalCount > 200) {			
			totalCount = 200;			
		}
		
		return totalCount;
		
	}
	
	public List<Book> getNewBookListByCategory(Integer cid, Criteria criteria) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=ItemNewSpecial&CategoryId=" + cid + "&MaxResults=" + criteria.getPerPageNum() + "&start="  + criteria.getPage() + "&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();

		List<Book> newBookListByCategory = new ArrayList<>();
		
		return JSONParser(result, newBookListByCategory);
		
	}
	
	
	public int getNewBookListByCategoryTotalCount(Integer cid) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemList.aspx?ttbkey=ttbrhxodud890305001&QueryType=ItemNewSpecial&CategoryId=" + cid + "&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		Integer totalCount = null;
		
		try {			
			JSONParser jsonParse = new JSONParser();
	        JSONObject jsonObj;
			jsonObj = (JSONObject) jsonParse.parse(result);
	        long totalResults = (long) jsonObj.get("totalResults");	        
	        totalCount = Long.valueOf(totalResults).intValue();	        
		} catch (ParseException e) {			
			logger.error("###[AladinApiBO getNewBookListByCategoryTotalCount] cid:{}", cid);			
		}		
		
		if (totalCount > 200) {			
			totalCount = 200;			
		}
		
		return totalCount;
		
	}
	
	public List<Book> getAdvancedSearchedBookList(String title, String author, String publisher, String pubPeriod, Criteria criteria) {
		
		String result = null;
		
		if (author == "" && publisher == "") {		
		
			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
			
		} else if (title == "" && publisher == "") {
			
			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + author + "&QueryType=Author&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
			
		} else if (title == "" && author == "") {

			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + publisher + "&QueryType=Publisher&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
			
		} else if (title != "" && author != "" && publisher != "") {

			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
			
		} else if (title == "" && author != "" && publisher != "") {

			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + author + "&QueryType=Author&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
			
		} else if (title != "" && author == "" && publisher != "") {

			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
	
		} else if (title != "" && author != "" && publisher == "") {

			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
					.get()
					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=" + criteria.getPerPageNum() + "&start=" + criteria.getPage() +"&SearchTarget=Book&output=js&Version=20131101")
					.retrieve()
					.bodyToMono(String.class)
					.block();		
		
		}

		List<Book> advancedSearchedListByCategory = new ArrayList<>();
				
		
		return JSONParser(result, advancedSearchedListByCategory);
		
	}
	
	
//	public int getAdvancedSearchedBookListTotalCount(String title, String author, String publisher) {
//		
//		
//		String result = null;
//		
//		if (author == null && publisher == null) {		
//		
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//			
//		} else if (title == null && publisher == null) {
//			
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + author + "&QueryType=Author&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//			
//		} else if (title == null && author == null) {
//
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + publisher + "&QueryType=Publisher&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//			
//		} else if (title != null && author != null && publisher != null) {
//
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//		
//		} else if (title == null && author != null && publisher != null) {
//
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + author + "&QueryType=Author&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//	
//		} else if (title != null && author == null && publisher != null) {
//
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//			
//		} else if (title != null && author != null && publisher == null) {
//
//			result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
//					.get()
//					.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=" + title + "&QueryType=Title&MaxResults=100&SearchTarget=Book&output=js&Version=20131101")
//					.retrieve()
//					.bodyToMono(String.class)
//					.block();		
//			
//		}
//		
//		Integer totalCount = null;
//		
//		try {			
//			JSONParser jsonParse = new JSONParser();
//	        JSONObject jsonObj;
//			jsonObj = (JSONObject) jsonParse.parse(result);
//	        long totalResults = (long) jsonObj.get("totalResults");	        
//	        totalCount = Long.valueOf(totalResults).intValue();	        
//		} catch (ParseException e) {			
//			logger.error("###[AladinApiBO getAdvancedSearchedBookListTotalCount]");			
//		}		
//		
//		if (totalCount > 200) {			
//			totalCount = 200;			
//		}
//		
//		return totalCount;
//		
//		
//	}
	
	
}
