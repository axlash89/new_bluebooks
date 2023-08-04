package com.bluebooks.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

	@GetMapping("/main_view")
	public String mainView() {
		
		return "template/layout";
		
	}
	
}