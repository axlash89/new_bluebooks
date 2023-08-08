package com.bluebooks.onetoone.domain;

import com.bluebooks.onetoone.entity.OnetooneEntity;
import com.bluebooks.user.entity.UserEntity;

import lombok.Data;

@Data
public class OnetooneView {

	private UserEntity user;
	
	private OnetooneEntity onetoone;
	
}