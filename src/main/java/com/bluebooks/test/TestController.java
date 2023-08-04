package com.bluebooks.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluebooks.book.dao.BookMapper;

@Controller
public class TestController {

	@Autowired
	private BookMapper bookMapper;
	
	@RequestMapping("/test1")
	public String test1() {
		
		return "test/test1";
		
	}
	
	@ResponseBody
	@RequestMapping("/test2")
	public String test2() {
		
		return "Hello world";
		
	}
	
	@ResponseBody
	@RequestMapping("/test3")
	public Map<String, Object> test3() {
		
		Map<String, Object> myMap = new HashMap<>();
		myMap.put("aaa", 111);
		myMap.put("bbb", 222);
		
		return myMap;
	}
	
	@ResponseBody
	@RequestMapping("/test4")
	public List<Map<String, Object>> test4() {
		return bookMapper.selectBookList();
	}
	
}
