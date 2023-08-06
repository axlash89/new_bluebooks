package com.bluebooks.book;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/book")
@Controller
public class BookController {

	@GetMapping("/advanced_search_view")
	public String mainView(Model model) {		
		model.addAttribute("view", "book/advancedSearch");		
		return "template/layout";
		
	}
	
}
