package com.bluebooks.event;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.event.bo.EventBO;

@RequestMapping("/event")
@RestController
public class EventRestController {

	@Autowired
	private EventBO eventBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam(value = "file", required = false) MultipartFile file) {
		
		// db insert
		int row = eventBO.addEvent(file);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "이벤트 업로드를 실패하였습니다.");
		}
		
		return result;
		
	}
	
	
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("eventId") int eventId,
			@RequestParam("file") MultipartFile file) {
		
		eventBO.updateEventById(eventId, file);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("eventId") int eventId) {
		
		
		eventBO.deleteEventById(eventId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
		
	}
	
	
}
