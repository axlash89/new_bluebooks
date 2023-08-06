package com.bluebooks.order;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/order")
@Controller
public class OrderController {

	@GetMapping("/my_order_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "order/myOrder");
		return "template/layout";
	}
	
}
