package com.bluebooks.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.comment.bo.CommentBO;


@RequestMapping("/comment")
@RestController
public class CommentRestController {
		
	@Autowired
	private CommentBO commentBO;

	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("eventId") int eventId,
			@RequestParam("content") String content,
			HttpSession session) {
		
		int userId = (int)session.getAttribute("userId");
		
		int row = commentBO.addComment(eventId, userId, content);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "댓글 업로드 실패");
		}
		
		return result;
				
	}
	
	
	@PostMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("commentId") int commentId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		
		// 이중 체크
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 300);
			result.put("errorMessage", "로그인이 되지 않은 사용자입니다.");
			return result;
		}
		
		int row = commentBO.deleteCommentById(commentId);		
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "댓글 삭제 실패");
		}
		
		return result;
		
	}
	
}
