package com.bluebooks.user.bo;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.user.dao.UserRepository;
import com.bluebooks.user.entity.UserEntity;

@Service
public class UserBO {
	
	@Autowired
	private UserRepository userRepository;
	
	
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	
	public Integer addUser(String loginId, String Password, String name, Date birthDate, String email, String phoneNumber, String zipCode, String address, int point) {
		
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
					.loginId(loginId)
					.password(Password)
					.name(name)
					.birthDate(birthDate)
					.email(email)
					.phoneNumber(phoneNumber)
					.zipCode(zipCode)
					.address(address)
					.point(point)
					.build()
				);				
		
		return userEntity == null ? null : userEntity.getId();
		
	}
	
	
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	
}
