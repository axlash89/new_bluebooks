package com.bluebooks.order;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bluebooks.book.domain.Book;
import com.bluebooks.cart.domain.CartView;
import com.bluebooks.common.Criteria;
import com.bluebooks.common.PageMaker;
import com.bluebooks.order.bo.OrderBO;
import com.bluebooks.order.domain.OrderView;
import com.bluebooks.user.entity.UserEntity;

@RequestMapping("/order")
@Controller
public class OrderController {

	@Autowired
	private OrderBO orderBO;
	
	@GetMapping("/my_order_view")
	public String signUpView(Model model, HttpSession session, Criteria criteria, 
			@RequestParam(required=false) String period) {
		
		int userId = (int) session.getAttribute("userId");
		UserEntity user = orderBO.getUserEntityByUserId(userId);
		session.setAttribute("userPoint", user.getPoint());
		
		criteria.setPerPageNum(5);
		List<OrderView> orderViewList = orderBO.getOrderViewListByUserId(userId, criteria, period);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(criteria);
		pageMaker.setTotalCount(orderBO.getTotalOrderViewCountByUserId(userId, period));
		
		if (period != null) {
			model.addAttribute("period", "&period=" + period);
		}
		
		model.addAttribute("orderViewList", orderViewList);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "order/myOrder");
		return "template/layout";
	}
	
	
	@GetMapping("/create_order_view")
	public String createOrderView(Model model, HttpSession session,
			@RequestParam(required=false) Integer bookId,
			@RequestParam(required=false) Integer bookCount,
			@RequestParam(required=false) String bookIdString,
			@RequestParam(required=false) Integer finalPrice) {
		
		int userId = (int) session.getAttribute("userId");
		
		if (bookIdString != null) {
			
			List<CartView> orderedCartViewList = orderBO.getOrderedCartViewList(userId, bookIdString);
			model.addAttribute("orderedCartViewList", orderedCartViewList);
			model.addAttribute("bookIdString", bookIdString);
			model.addAttribute("finalPrice", finalPrice);
			
		} else if(bookId != null && bookCount == null) {
			
			Book book = orderBO.getOrderedBook(bookId);
			model.addAttribute("book", book);
			model.addAttribute("bookId", bookId);
			
		} else if(bookId != null && bookCount != null) {
			
			Book book = orderBO.getOrderedBook(bookId);
			model.addAttribute("book", book);
			model.addAttribute("bookId", bookId);
			model.addAttribute("bookCountFromDetail", bookCount);
			
		}
		
		UserEntity user = orderBO.getUserEntityByUserId(userId);
		session.setAttribute("userPoint", user.getPoint());
		
		model.addAttribute("user", user);
		
		model.addAttribute("view", "order/createOrder");
		return "template/layout";
	}
	
	
}
