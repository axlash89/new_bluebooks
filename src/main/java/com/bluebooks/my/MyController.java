package com.bluebooks.my;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/my")
@Controller
public class MyController {
	
	@GetMapping("/my_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "/order/myOrder");		
		return "template/layout";
	}
	
}
