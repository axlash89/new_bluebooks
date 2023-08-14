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
import com.bluebooks.order.bo.OrderBO;
import com.bluebooks.user.entity.UserEntity;

@RequestMapping("/order")
@Controller
public class OrderController {

	@Autowired
	private OrderBO orderBO;
	
	@GetMapping("/my_order_view")
	public String signUpView(Model model, HttpSession session) {
		
		int userId = (int) session.getAttribute("userId");
		UserEntity user = orderBO.getUserEntityByUserId(userId);
		session.setAttribute("userPoint", user.getPoint());
		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "order/myOrder");
		return "template/layout";
	}
	
	@GetMapping("/create_order_view")
	public String createOrderView(Model model, HttpSession session,
			@RequestParam(required=false) Integer bookId,
			@RequestParam(required=false) String bookIdString,
			@RequestParam(required=false) Integer finalPrice) {
		
		int userId = (int) session.getAttribute("userId");
		
		if (bookIdString != null) {
			List<CartView> orderedCartViewList = orderBO.getOrderedCartViewList(userId, bookIdString);
			model.addAttribute("orderedCartViewList", orderedCartViewList);
			model.addAttribute("bookIdString", bookIdString);
			model.addAttribute("finalPrice", finalPrice);
		} else {
			Book book = orderBO.getOrderedBook(bookId);
			model.addAttribute("bookId", bookId);
			model.addAttribute("book", book);
		}
		
		UserEntity user = orderBO.getUserEntityByUserId(userId);
		session.setAttribute("userPoint", user.getPoint());
		
		model.addAttribute("user", user);
		
		model.addAttribute("view", "order/createOrder");
		return "template/layout";
	}
	
	
}
