package com.bluebooks.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.bluebooks.book.domain.Book;
import com.bluebooks.event.domain.Event;
import com.bluebooks.main.bo.MainBO;

@Controller
public class MainController {

	@Autowired
	private MainBO mainBO;
	
	@GetMapping("/")
	public String mainView(Model model) {
		
		List<Book> bestSellerTop10List = mainBO.getBestSellerTop10List();
		model.addAttribute("bestSellerTop10List", bestSellerTop10List);
		List<Book> noteworthyNewBookTop5List = mainBO.getNoteworthyNewBookTop5List();
		model.addAttribute("noteworthyNewBookTop5List", noteworthyNewBookTop5List);
		List<Event> eventList = mainBO.getEventListForMain(); 		
		model.addAttribute("eventList", eventList);
				
		model.addAttribute("view", "main");
		
		return "template/layout";
		
	}
	
}