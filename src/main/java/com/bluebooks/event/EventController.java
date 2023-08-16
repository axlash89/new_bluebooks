package com.bluebooks.event;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.common.Criteria;

@RequestMapping("/event")
@Controller
public class EventController {

	@GetMapping("/event_list_view")
	public String eventListView(Model model, HttpSession session,
		Criteria criteria) {
		
		model.addAttribute("view", "event/eventList");
		
		return "template/layout";
		
	}
	
	
}
