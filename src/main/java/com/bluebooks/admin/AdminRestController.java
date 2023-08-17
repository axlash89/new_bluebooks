package com.bluebooks.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.admin.bo.AdminBO;

@RequestMapping("/admin")
@RestController
public class AdminRestController {

	@Autowired
	private AdminBO adminBO;
	
	@PostMapping("/order_status_change")
	public Map<String, Object> orderStatusChange(HttpSession session,
			@RequestParam("orderId") int orderId,
			@RequestParam("status") String status) {
		
		Map<String, Object> result = new HashMap<>();
		
			adminBO.updateStatusByOrderId(orderId, status);
			result.put("code", 1);
			result.put("result", "성공");
		
		return result;
		
	}
	
	
	@PostMapping("/order_status_delivering")
	public Map<String, Object> orderStatusChangeByArr(HttpSession session,
			@RequestParam(required = false) Integer[] orderIdArr) {
		
		Map<String, Object> result = new HashMap<>();
		
			adminBO.updateStatusByOrderIdArr(orderIdArr);
			result.put("code", 1);
			result.put("result", "성공");
		
		return result;
		
	}
	
	
}
