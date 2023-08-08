package com.bluebooks.onetoone;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.onetoone.entity.OnetooneEntity;

@RequestMapping("/onetoone")
@Controller
public class OnetooneController {
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	// /onetoone/onetoone_list_view?page=2
	@GetMapping("/onetoone_list_view")
	public String onetooneListView(HttpSession session, Model model, @PageableDefault(page = 0, size = 3, sort = "id", direction = Sort.Direction.DESC) Pageable pageable){
		
		
		int userId = (int)session.getAttribute("userId");
		
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// nowPage 현재 페이지
		// startPage 블럭에서 보여줄 시작 페이지
		// endPage 블럭에서 보여줄 마지막 페이지
		
		Page<OnetooneEntity> onetooneList = onetooneBO.getOnetooneListByUserId(pageable, userId);
		
		int nowPage = onetooneList.getPageable().getPageNumber();
		int startPage = Math.max(0, onetooneList.getPageable().getPageNumber() - 4);
		int endPage;
		if (onetooneList.getTotalPages() != 0) {
			endPage = Math.min(onetooneList.getTotalPages() - 1, nowPage + 4);
		} else {
			endPage = 0;
		}
		
		
		model.addAttribute("onetooneList", onetooneList);
				
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "/onetoone/onetooneList");
		return "template/layout";
		
	}
	
	@GetMapping("/onetoone_create_view")
	public String onetooneCreateView(Model model) {
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "/onetoone/onetooneCreate");
		return "template/layout";
	}
	
	@GetMapping("/onetoone_detail_view")
	public String onetooneDetailView(
			@RequestParam("id") int id, Model model) {
		
		
		OnetooneEntity onetooneEntity = onetooneBO.getOnetooneEntityById(id);
		
		model.addAttribute("onetooneEntity", onetooneEntity);
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "/onetoone/onetooneDetail");
		return "template/layout";
		
	}

}
