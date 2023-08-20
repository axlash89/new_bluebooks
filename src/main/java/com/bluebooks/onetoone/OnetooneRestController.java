package com.bluebooks.onetoone;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.onetoone.bo.OnetooneBO;

@RequestMapping("/onetoone")
@RestController
public class OnetooneRestController {
	
	@Autowired
	private OnetooneBO onetooneBO;

	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("subject") String subject,
			@RequestParam("content") String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		// 세션에서 유저 정보 받아옴
		int userId = (int)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
				
		// db insert
		int row = onetooneBO.addOnetoone(userId, userLoginId, subject, content, file);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "1:1 문의 업로드를 실패하였습니다.");
		}
		
		return result;
		
	}
	
	
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("onetooneId") int onetooneId,
			@RequestParam("subject") String subject,
			@RequestParam("content") String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		// 세션에서 userId, userLoginId
		int userId = (int) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		
		// BO update
		onetooneBO.updateOnetoone(userId, userLoginId, onetooneId, subject, content, file);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("onetooneId") int onetooneId,
			HttpSession session) {
		
		int userId = (int) session.getAttribute("userId");
		
		onetooneBO.deleteOnetooneEntityByIdAndUserId(onetooneId, userId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
		
	}
	
	
	@PutMapping("/answer")
	public Map<String, Object> update(
			@RequestParam("onetooneId") int onetooneId,
			@RequestParam("answer") String answer,
			HttpSession session) {
		
		// BO update
		onetooneBO.answerOnetoone(onetooneId, answer);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	@PutMapping("/delete_answer")
	public Map<String, Object> deleteAnswer(
			@RequestParam("onetooneId") int onetooneId) {
		
		// BO update
		onetooneBO.deleteAnswer(onetooneId);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	@PutMapping("/update_answer")
	public Map<String, Object> updateAnswer(
			@RequestParam("onetooneId") int onetooneId,
			@RequestParam("answer") String answer) {
		
		// BO update
		onetooneBO.updateAnswer(onetooneId, answer);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	
}
