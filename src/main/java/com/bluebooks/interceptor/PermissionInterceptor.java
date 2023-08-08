package com.bluebooks.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request,   // 프리핸들은 컨트롤러를 수행할거냐 말거냐 결정하는 것
			HttpServletResponse response, Object handler) throws IOException {
		// 요청 url path를 가져온다.
		String uri = request.getRequestURI();
		logger.info("[$$$$$$ preHandle] uri:{}", uri);
		
		// 로그인 여부 확인 - session 확인
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// 비로그인 && /post 온 경우 => 로그인 페이지로 이동, 컨트롤러 수행 방지
		if (userId == null && uri.startsWith("/onetoone")) {
			response.sendRedirect("/user/sign_in_view");
			return false;  // 컨트롤러 수행 안함.
		}
		
		if (userId == null && (uri.startsWith("/user/edit_my_info_view") || uri.startsWith("/withdrawal"))) {
			response.sendRedirect("/user/sign_in_view");
			return false;
		}
				
		// 로그인 && /user로 온 경우 => 글 목록 페이지로 이동, 컨트롤러 수행 방지
		if (userId != null && uri.startsWith("/user/sign")) {
			response.sendRedirect("/main_view");			
			return false;  // 컨트롤러 수행 안함.
		}
		
		if (userLoginId == null) {
			if (uri.startsWith("/notice/notice_create_view")) {
				response.sendRedirect("/notice/notice_list_view");			
				return false;  // 컨트롤러 수행 안함.
			}	
		}
		
		if (userLoginId != null) {		
			if (userLoginId.equals("admin") == false && uri.startsWith("/notice/notice_create_view")) {
				response.sendRedirect("/notice/notice_list_view");			
				return false;  // 컨트롤러 수행 안함.
			}		
		}
		
		if (userLoginId == null) {
			if (uri.startsWith("/admin")) {
				response.sendRedirect("/main_view");			
				return false;  // 컨트롤러 수행 안함.
			}	
		}
		
		if (userLoginId != null) {		
			if (userLoginId.equals("admin") == false && uri.startsWith("/admin")) {
				response.sendRedirect("/main_view");			
				return false;  // 컨트롤러 수행 안함.
			}		
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler, 
			ModelAndView mav) {
		// view 객체가 존재한다는 것은 아직 jsp가 html로 변환되기 전이다.
		logger.info("[###### postHandle]");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, 
			HttpServletResponse response, Object handler,
			Exception ex) {
		// jsp가 html로 최종 변환된 후
		logger.info("[@@@@@@ afterCompletion]");
	}
	
}
