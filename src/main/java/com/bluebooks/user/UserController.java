package com.bluebooks.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluebooks.aop.TimeTrace;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@RequestMapping("/user")
@Controller
public class UserController {
	
	@Autowired
	private UserBO userBO;
	
	@GetMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "user/signUp");
		return "template/layout";
	}
	
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("view", "user/signIn");
		return "template/layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpSession session) {
		
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		return "redirect:/";
		
	}
	
	@RequestMapping("/edit_my_info_view")
	public String editMyInfo(HttpSession session, Model model) {
		
		String userLoginId = (String) session.getAttribute("userLoginId");		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		
		final String REGEX = "[0-9]+";
		
		if(userLoginId.matches(REGEX)) {
			model.addAttribute("kakaoUser", "kakaoUser");	
		}
		
		model.addAttribute("user", userEntity);		
		model.addAttribute("view", "my/myLayout");
		model.addAttribute("secondView", "/user/editMyInfo");
		
		return "template/layout";
		
	}
}
