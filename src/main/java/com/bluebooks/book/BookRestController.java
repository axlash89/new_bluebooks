package com.bluebooks.book;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.book.bo.BookBO;

@RequestMapping("/book")
@RestController
public class BookRestController {
	
	@Autowired
	private BookBO bookBO;
	
	@PostMapping("/recent_products")
	public Map<String, Object> getBookImagePath(
			@RequestParam("bookId") int bookId) {
		
		String coverImagePath = bookBO.getCoverByRecentBookId(bookId);
		
		Map<String, Object> result = new HashMap<>();
		
		if (coverImagePath != null) {
			result.put("code", 1);
			result.put("result", "성공");
			result.put("cover", coverImagePath);
			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "북 커버 이미지 경로 가져오기 실패");
		}
		
		return result;
				
	}
	
}
