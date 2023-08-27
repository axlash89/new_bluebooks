package com.bluebooks.order;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String myOrderView(Model model, HttpSession session, Criteria criteria, 
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
		
		model.addAttribute("periodText", period);
		model.addAttribute("orderViewList", orderViewList);
		model.addAttribute("nowPage", criteria.getPage());
        model.addAttribute("pageMaker", pageMaker);		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "order/myOrder");
		return "template/layout";
		
	}
	
	@GetMapping("/my_order_more_detail")
	public String myOrderMoreDetail(Model model, HttpSession session,
			HttpServletResponse response,
			@RequestParam("userId") int userId,
			@RequestParam("orderId") int orderId) {
		
		int currUserId = (int) session.getAttribute("userId");
		if (currUserId != userId) {
			try {
				response.sendRedirect("/order/my_order_view");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		OrderView orderView = orderBO.getOrderView(orderId);
		
		
		
		model.addAttribute("payByEnum", orderView.getOrder().getPayBy().getValue());
		model.addAttribute("orderView", orderView);
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "order/myOrderDetail");
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
