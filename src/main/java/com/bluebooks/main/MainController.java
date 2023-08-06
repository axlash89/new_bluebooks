package com.bluebooks.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/main_view")
	public String mainView(Model model) {
		
		model.addAttribute("view", "main");
		
		return "template/layout";
		
	}
	
}