package com.bluebooks.order;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.order.bo.OrderBO;
import com.bluebooks.order.domain.Order;

@RequestMapping("/order")
@RestController
public class OrderRestController {

	
	@Autowired
	private OrderBO orderBO;
	
	@PostMapping("/create")
	public Map<String, Object> createOrder(HttpSession session,
			@RequestParam("recipientName") String recipientName,
			@RequestParam("recipientPhoneNumber") String recipientPhoneNumber,
			@RequestParam("recipientZipCode") String recipientZipCode,
			@RequestParam("recipientAddress") String recipientAddress,
			@RequestParam("payBy") String payBy,
			@RequestParam("usedPoint") int usedPoint,
			@RequestParam("finalPrice") int finalPrice,
			@RequestParam("totalPoint") int totalPoint,
			@RequestParam(required = false) String bookIdString,
			@RequestParam(required = false) String bookCount,
			@RequestParam(required = false) Integer bookId,
			@RequestParam(required = false) Integer bookCountFromDetail) {
		
		Map<String, Object> result = new HashMap<>();
		
		int userId = (int) session.getAttribute("userId");
		
		orderBO.createOrder(userId, usedPoint, finalPrice, payBy, recipientName, recipientZipCode, 
				recipientAddress, recipientPhoneNumber, totalPoint, bookIdString, bookCount, bookId, bookCountFromDetail);
		
			result.put("code", 1);
			result.put("result", "성공");
		
		return result;
		
	}
	
	
}
