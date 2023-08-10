package com.bluebooks.book;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.reactive.function.client.WebClient;

@RequestMapping("/book")
@Controller
public class BookController {

	@GetMapping("/advanced_search_view")
	public String mainView(Model model) {
		
		String result = WebClient.create("https://www.aladin.co.kr/ttb/api/")
				.get()
				.uri("ItemSearch.aspx?ttbkey=ttbrhxodud890305001&Query=aladdin&QueryType=Title&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101")
				.retrieve()
				.bodyToMono(String.class)
				.block();
		
		model.addAttribute("result", result);
		model.addAttribute("view", "book/advancedSearch");		
		return "template/layout";
		
	}
	;


}
