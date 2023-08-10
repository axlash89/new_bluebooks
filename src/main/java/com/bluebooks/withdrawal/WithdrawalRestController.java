package com.bluebooks.withdrawal;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.withdrawal.bo.WithdrawalBO;

@RequestMapping("/withdrawal")
@RestController
public class WithdrawalRestController {

	@Autowired
	private WithdrawalBO withdrawalBO;
	
	@PostMapping("/withdraw")
	public Map<String, Object> withdraw (
			@RequestParam("reason") String reason,
			HttpSession session) {
		
		int userId = (int) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		int row = withdrawalBO.deleteWithdrawal(userId, userLoginId, reason);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			session.removeAttribute("userId");
			session.removeAttribute("userLoginId");
			session.removeAttribute("userName");
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "회원탈퇴 실패");
		}
		
		return result;
		
	}
		
}
