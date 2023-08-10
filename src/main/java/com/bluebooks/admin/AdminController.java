package com.bluebooks.admin;

import java.util.List;

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

import com.bluebooks.admin.bo.AdminBO;
import com.bluebooks.onetoone.entity.OnetooneEntity;
import com.bluebooks.user.entity.UserEntity;

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
	public String manageOnetooneView(Model model, @PageableDefault(page = 0, size = 3, sort = "id", direction = Sort.Direction.DESC) Pageable pageable,
			@RequestParam(required = false) String type,
			@RequestParam(required = false) String searchKeyword) {
		
		Page<OnetooneEntity> onetooneList = null;
		
		if (searchKeyword == null) {
			onetooneList = adminBO.getAllOfOnetoone(pageable);		
		} else {
				
			if (type.equals("byLoginId")) {		
				model.addAttribute("searchKeyword", "&type=" + type + "&searchKeyword=" + searchKeyword);
				onetooneList = adminBO.getOnetooneByLoginId(searchKeyword, pageable);
			} else {
				model.addAttribute("searchKeyword", "&type=" + type + "&searchKeyword=" + searchKeyword);
				onetooneList = adminBO.getOnetooneBySubject(searchKeyword, pageable);
			}
			
		}
				
		int nowPage = onetooneList.getPageable().getPageNumber();
		int startPage = Math.max(0, onetooneList.getPageable().getPageNumber() - 4);
		int endPage;
		if (onetooneList.getTotalPages() != 0) {
			endPage = Math.min(onetooneList.getTotalPages() - 1, nowPage + 4);
		} else {
			endPage = 0;
		}		
		
		List<UserEntity> userList = adminBO.getWriterList();
		
		model.addAttribute("onetooneList", onetooneList);
		model.addAttribute("userList", userList);
				
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/onetoone/onetooneList");		
		return "template/layout";
	}
	
	@GetMapping("/onetoone_detail_view")
	public String onetooneDetailView(
			@RequestParam("id") int id, Model model) {
				
		OnetooneEntity onetooneEntity = adminBO.getOnetooneEntityById(id);
		
		model.addAttribute("onetooneEntity", onetooneEntity);
		
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/onetoone/onetooneDetail");
		return "template/layout";
		
	}
	
	
	@GetMapping("/manage_user_view")
	public String manageUserView(Model model, 
								@PageableDefault(page = 0, size = 3, sort = "id", direction = Sort.Direction.DESC) Pageable pageable,
								@RequestParam(required= false) String searchKeyword) {		
		
		Page<UserEntity> userList = null;
		
		if(searchKeyword != null) {
			userList = adminBO.userSearchList(searchKeyword, searchKeyword, pageable);
		} else {
			userList = adminBO.getAllUserEntity(pageable);
		}		 
		
		int nowPage = userList.getPageable().getPageNumber();
		int startPage = Math.max(0, userList.getPageable().getPageNumber() - 4);
		int endPage;
		if (userList.getTotalPages() != 0) {
			endPage = Math.min(userList.getTotalPages() - 1, nowPage + 4);
		} else {
			endPage = 0;
		}		
		
		model.addAttribute("userList", userList);
				
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		
		model.addAttribute("nowPage", nowPage);
		
		model.addAttribute("searchKeyword", searchKeyword);
		
		
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/manageUser");		
		return "template/layout";
	}
	
	@GetMapping("/user_detail_view")
	public String manageUserView(
			@RequestParam("userId") int userId, Model model) {
		
		UserEntity user = adminBO.getUserEntityById(userId);
		
		model.addAttribute("user", user);
		
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/userDetail");		
		return "template/layout";
	}
	
}
