package com.bluebooks.withdrawal;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.common.PageMaker;
import com.bluebooks.withdrawal.bo.WithdrawalBO;
import com.bluebooks.withdrawal.domain.Criteria;
import com.bluebooks.withdrawal.domain.Withdrawal;

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
	public String withdrawnUserView(Model model, Criteria criteria,
			@RequestParam(required= false) String searchKeyword,
			@RequestParam(required= false) String type) throws Exception {
		
		List<Withdrawal> withdrawalList = null;
		PageMaker pageMaker = new PageMaker();
		if (searchKeyword == null) {
			withdrawalList = withdrawalBO.selectWithdrawalList(criteria);
			pageMaker.setCri(criteria);
			pageMaker.setTotalCount(withdrawalBO.getTotalCount());
		} else {
			model.addAttribute("searchKeyword", "&type=" + type + "&searchKeyword=" + searchKeyword);			
			if (type.equals("byLoginId")) {
				withdrawalList = withdrawalBO.selectWithdrawalListByLoginId(criteria, searchKeyword);
				pageMaker.setCri(criteria);
				pageMaker.setTotalCount(withdrawalBO.getTotalCountByLoginId(searchKeyword));
				if(withdrawalList.isEmpty()) {
					model.addAttribute("emptyList", "emptyList");
				}
			} else {
				withdrawalList = withdrawalBO.selectWithdrawalListByReason(criteria, searchKeyword);
				pageMaker.setCri(criteria);
				pageMaker.setTotalCount(withdrawalBO.getTotalCountByReason(searchKeyword));
				if(withdrawalList.isEmpty()) {
					model.addAttribute("emptyList", "emptyList");
				}
			}
		}
		
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);		
        model.addAttribute("withdrawalList", withdrawalList);
		model.addAttribute("view", "admin/adminLayout");
		model.addAttribute("secondView", "/user/withdrawnUser");		
		return "template/layout";
	}
	
	
}
