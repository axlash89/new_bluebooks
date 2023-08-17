package com.bluebooks.like;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.like.bo.LikeBO;

@RestController
public class likeRestController {

	@Autowired
	private LikeBO likeBO;

	// mybatis로
	// GET : /like?postId=13	@RequestParam("postId")
	// GET : /like/13	@PathVariable
	@RequestMapping("/like/{commentId}")
	public Map<String, Object> like (HttpSession session,
			@PathVariable int commentId) {

		Map<String, Object> result = new HashMap<>();
		
		// 로그인 여부 체크
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 300);
			result.put("errorMessage", "로그인이 필요합니다.");
			return result;
		}		
		
		// BO 호출 -> like 여부 체크	
		if (likeBO.likeToggle(commentId, userId) > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "좋아요/해제 실패");
		}
		
		
		return result;
	}
	
}
