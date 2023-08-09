package com.bluebooks.withdrawal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.withdrawal.bo.WithdrawalBO;
import com.bluebooks.withdrawal.domain.Criteria;
import com.bluebooks.withdrawal.domain.Pagenation;

@RequestMapping("/withdrawal")
@Controller
public class WithdrawalController {

	@Autowired
	private WithdrawalBO withdrawalBO;
	
	@RequestMapping("/withdraw_view")
	public String withdraw(HttpSession session, Model model) {
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "user/withdraw");
		
		return "template/layout";
		
	}	


	@GetMapping("/witndrawn_user_view")
	public String withdrawnUserView(Model model, Criteria criteria) throws Exception {
        
		Pagenation pageNation = new Pagenation();
        pageNation.setCriteria(criteria);
        pageNation.setTotalCount(withdrawalBO.totalCount());
        
//        model.addAttribute("lists", withdrawalService.selectWithdrawalList(criteria));
//        model.addAttribute("pagenation", pageNation);
////		int listCnt = withdrawalService.totalCount();
////        Pagination pagination = new Pagination(currentPage, cntPerPage, pageSize);
////        pagination.setTotalRecordCount(listCnt);
// 
        model.addAttribute("pageNation", pageNation);		
        model.addAttribute("withdrawalList", withdrawalBO.selectWithdrawalList(criteria));
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/withdrawnUser");		
		return "template/layout";
	}
	
	
}
