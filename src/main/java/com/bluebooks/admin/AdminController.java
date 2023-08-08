package com.bluebooks.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.admin.bo.AdminBO;
import com.bluebooks.onetoone.domain.OnetooneView;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@Autowired
	private AdminBO adminBO;
	
	@GetMapping("/admin_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/order/allOrder");		
		return "template/layout";
	}
	
	@GetMapping("/manage_onetoone_list_view")
	public String manageOnetooneView(Model model, @PageableDefault(page = 0, size = 3, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		
		Page<OnetooneView> onetooneList = adminBO.getAllOfOnetoone(pageable);		
				
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
		
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/onetoone/onetooneList");		
		return "template/layout";
	}
	
	@GetMapping("/manage_user_view")
	public String manageUserView(Model model) {
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/manageUser");		
		return "template/layout";
	}
	
	@GetMapping("/witndrawn_user_view")
	public String withdrawnUserView(Model model) {
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/withdrawnUser");		
		return "template/layout";
	}
}
