package com.bluebooks.event;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.common.Criteria;
import com.bluebooks.common.PageMaker;
import com.bluebooks.event.bo.EventBO;
import com.bluebooks.event.domain.EventView;

@RequestMapping("/event")
@Controller
public class EventController {

	@Autowired
	private EventBO eventBO;
	
	@GetMapping("/event_list_view")
	public String eventListView(Model model, HttpSession session,
		Criteria criteria) {
		
		Integer userId = (Integer) session.getAttribute("userId"); 
		
		criteria.setPerPageNum(3);
		List<EventView> eventViewList = eventBO.getEventViewList(userId, criteria);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(eventBO.getTotalEventViewCount());
		
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);		
		model.addAttribute("eventViewList", eventViewList);
		model.addAttribute("view", "event/eventList");
		
		return "template/layout";
		
	}
	
	
}
