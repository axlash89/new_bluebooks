package com.bluebooks.withdrawal;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/withdrawal")
@Controller
public class WithdrawalController {


	@RequestMapping("/withdraw_view")
	public String withdraw(HttpSession session, Model model) {
		
		model.addAttribute("view", "user/withdraw");
		
		return "template/layout";
		
	}

	
}
