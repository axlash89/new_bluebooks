package com.bluebooks.book.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface BookMapper {
	
	public List<Map<String, Object>> selectBookList();

}
