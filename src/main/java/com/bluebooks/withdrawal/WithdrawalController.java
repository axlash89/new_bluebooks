package com.bluebooks.withdrawal;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.paging.Pagination;
import com.bluebooks.withdrawal.bo.WithdrawalBO;
import com.bluebooks.withdrawal.bo.WithdrawalService;

@RequestMapping("/withdrawal")
@Controller
public class WithdrawalController {

	@Autowired
	private WithdrawalBO withdrawalBO;
	
	@Resource
	private WithdrawalService withdrawalService;

	@RequestMapping("/withdraw_view")
	public String withdraw(HttpSession session, Model model) {
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "user/withdraw");
		
		return "template/layout";
		
	}	


	@GetMapping("/witndrawn_user_view")
	public String withdrawnUserView(Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            Map<String, Object> map) throws Exception {
        
		
		int listCnt = withdrawalService.withdrawalCount();
        Pagination pagination = new Pagination(currentPage, cntPerPage, pageSize);
        pagination.setTotalRecordCount(listCnt);
 
        model.addAttribute("pagination", pagination);		
        model.addAttribute("withdrawalList", withdrawalService.selectWithdrawalList(pagination));
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/withdrawnUser");		
		return "template/layout";
	}
	
	
}
