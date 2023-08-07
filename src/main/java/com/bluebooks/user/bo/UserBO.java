package com.bluebooks.user.bo;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.onetoone.bo.OnetooneBO;
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
	
	
	public UserEntity updateUserEntityPasswordById(int userId, String password) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userEntity = userEntity.toBuilder()
					.password(password)
					.build();
					userEntity = userRepository.save(userEntity);					
		}
		
		return userEntity;
		
	}
	
	
	public UserEntity updateUserEntityEmailById(int userId, String email) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userEntity = userEntity.toBuilder()
					.email(email)
					.build();
					userEntity = userRepository.save(userEntity);					
		}
		
		return userEntity;
		
	}
	
	
	public UserEntity updateUserEntityPhoneNumberById(int userId, String phoneNumber) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userEntity = userEntity.toBuilder()
					.phoneNumber(phoneNumber)
					.build();
					userEntity = userRepository.save(userEntity);					
		}
		
		return userEntity;
		
	}
	
		
	public UserEntity updateUserEntityZipCodeAndAddressById(int userId, String zipCode, String address) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userEntity = userEntity.toBuilder()
					.zipCode(zipCode)
					.address(address)
					.build();
					userEntity = userRepository.save(userEntity);					
		}
		
		return userEntity;
		
	}
	
	public void deleteUserEntityByUserId(int userId) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userRepository.delete(userEntity);			
		}
		
	}
	
}
