package com.bluebooks.admin.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.onetoone.domain.OnetooneView;

@Service
public class AdminBO {
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	public Page<OnetooneView> getAllOfOnetoone(Pageable pageable) {
		
		return onetooneBO.getAllOfOnetoone(pageable);
	}
	
}
