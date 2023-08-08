package com.bluebooks.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	@GetMapping("/admin_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/order/allOrder");		
		return "template/layout";
	}
	
	@GetMapping("manage_onetoone_view")
	public String manageOnetooneView(Model model) {
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
