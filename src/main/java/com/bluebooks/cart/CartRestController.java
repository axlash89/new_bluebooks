package com.bluebooks.cart;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.cart.bo.CartBO;

@RequestMapping("/cart")
@RestController
public class CartRestController {

	@Autowired
	private CartBO cartBO;
	
	
	@PostMapping("/add")
	public Map<String, Object> cartAdd(HttpSession session,
			@RequestParam(required = false) int[] bookIdArr,
			@RequestParam(required = false) Integer bookId,
			@RequestParam(required = false) int bookCount
			) {
		
		Map<String, Object> result = new HashMap<>();
		
		int userId = (int)session.getAttribute("userId");
		
		if(bookId ==  null) {
			cartBO.addBooksToCart(userId, bookIdArr);
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			cartBO.addBookToCart(userId, bookId, bookCount);
			result.put("code", 1);
			result.put("result", "성공");
		}
		return result;
		
	}
	
	@PostMapping("/delete")
	public Map<String, Object> cartDelete(HttpSession session,
			@RequestParam("bookIdArr") int[] bookIdArr) {
		
		Integer userId = (int)session.getAttribute("userId");
		
		cartBO.deleteFromCart(userId, bookIdArr);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("code", 1);
		result.put("result", "성공");
		
		return result;
		
	}
	
	@PostMapping("/count_update")
	public Map<String, Object> cartCountUpdate(HttpSession session,
			@RequestParam("bookId") int bookId,
			@RequestParam("bookCount") int bookCount) {
		
		Integer userId = (int)session.getAttribute("userId");
		
		cartBO.updateBookCount(userId, bookId, bookCount);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("code", 1);
		result.put("result", "성공");
		
		return result;
		
		
	}
	
	
}
