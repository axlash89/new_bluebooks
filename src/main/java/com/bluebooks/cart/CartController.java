package com.bluebooks.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.cart.bo.CartBO;
import com.bluebooks.cart.domain.CartView;
import com.mysql.cj.Session;

@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private CartBO cartBO;
	
	@GetMapping("/cart_list_view")	
	public String cartView(Model model, HttpSession session) {
		
		int userId = (int) session.getAttribute("userId");
		int RefreshedUserPoint = cartBO.getRefreshedUserPoint(userId);
		session.setAttribute("userPoint", RefreshedUserPoint);
		List<CartView> cartViewList = cartBO.getCartViewList(userId);
		
		model.addAttribute("cartViewList", cartViewList);
		
		model.addAttribute("view", "cart/cartList");
		
		return "template/layout";
		
	}
	
}
