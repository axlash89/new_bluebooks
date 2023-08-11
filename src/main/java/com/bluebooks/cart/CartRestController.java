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
	public Map<String, Object> CartAdd(HttpSession session,
			@RequestParam("bookId") int bookId) {
		
		Map<String, Object> result = new HashMap<>();
		
		Integer userId = (int)session.getAttribute("userId");
				
		int row = cartBO.addToCart(userId, bookId);
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "장바구니 담기 실패");
		}
		
		return result;
		
	}
	
}
