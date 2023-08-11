package com.bluebooks.aladin;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.reactive.function.client.WebClient;

import com.bluebooks.book.domain.Book;

@SpringBootTest
public class ApiTest {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Test
	void Test() {
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=aladdin&QueryType=Title&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		List<Book> searchedBookList = null;
		
		try {
		
			JSONParser jsonParser = new JSONParser();
	        
	        //JSON데이터를 넣어 JSON Object 로 만들어 준다.
	        JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			
	         
	        //books의 배열을 추출
	        JSONArray bookArray = (JSONArray) jsonObject.get("item");
	
		        for(int i = 0; i < bookArray.size(); i++){
		             
		            //배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
		            JSONObject bookObject = (JSONObject) bookArray.get(i);
		            
		            String isbn13 = (String) bookObject.get("isbn13");
		            
		            Book book = new Book();
		            book.setIsbn13(isbn13);
		            logger.info("###### user: {}", isbn13);		
		            
		        }
	    
		} catch (ParseException e) {
			
			logger.error("\"###### isbn13: {}\", isbn13");
			
		}
	
	}
}
