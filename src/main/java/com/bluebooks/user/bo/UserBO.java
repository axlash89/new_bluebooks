package com.bluebooks.user.bo;

import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bluebooks.common.SHA256;
import com.bluebooks.user.dao.UserRepository;
import com.bluebooks.user.dto.MailDTO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class UserBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	public List<UserEntity> getUserEntityByLoginIdContaining(String searchKeyword) {
		return userRepository.findAllByLoginIdContaining(searchKeyword);
	}
	
	public UserEntity getUserEntityById(int userId) {
		return userRepository.findById(userId).orElse(null);
	}
	
	public List<UserEntity> getUserList() {
		return userRepository.findAll();
	}
	
	public Page<UserEntity> getAllUserEntity(Pageable pageable) {
		return userRepository.findAll(pageable);
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
	
	public String getUserEntityByNameAndBirthDateAndPhoneNumber(String name, Date birthDate, String phoneNumber) {
		
		UserEntity userEntity = userRepository.findByNameAndBirthDateAndPhoneNumber(name, birthDate, phoneNumber);
				
		if (userEntity != null) {
			
			String foundId = userEntity.getLoginId();
			
			int halfLength = foundId.length() / 2;	

			int starLength = foundId.length() - halfLength;
			
			foundId = foundId.substring(0, halfLength);
			
			for (int i = 0; i < starLength; i++) {
				foundId = foundId + "*";			
			}
			
			return foundId;
			
		} else {
			
			return null;
			
		}
		
	}
	
	public String getUserEntityByLoginIdAndNameAndBirthDateAndPhoneNumber(String loginId, String name, Date birthDate, String phoneNumber) {
		
		UserEntity userEntity = userRepository.findByLoginIdAndNameAndBirthDateAndPhoneNumber(loginId, name, birthDate, phoneNumber);				
		
		if (userEntity != null) {
			
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
	                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

	        String temporaryPassword = "";

	        int idx = 0;
	        for (int i = 0; i < 10; i++) {
	            idx = (int) (charSet.length * Math.random());
	            temporaryPassword += charSet[idx];
	        }
	        
	        SHA256 sha256 = new SHA256();
			
	        String shaPassword = null;
	        
			try {
				shaPassword = sha256.encrypt(temporaryPassword);
			} catch (NoSuchAlgorithmException e) {
				logger.warn("###[UserBO 임시 비밀번호 암호화 실패] loginId:{}", loginId);
			}
	        
			userEntity = userEntity.toBuilder()
					.password(shaPassword)
					.build();
					userEntity = userRepository.save(userEntity);
					

			String foundEmail = userEntity.getEmail();
					
			MailDTO mailDTO = new MailDTO();
			mailDTO.setAddress(foundEmail);
			mailDTO.setTitle(name + "님, 블루북스에서 임시 비밀번호를 보내드립니다.");
			mailDTO.setMessage("임시 비밀번호는 " + temporaryPassword + "입니다.");
			
			SimpleMailMessage message = new SimpleMailMessage();
	        message.setFrom("axlash7@gmail.com");
	        message.setTo(mailDTO.getAddress());
	        message.setSubject(mailDTO.getTitle());
	        message.setText(mailDTO.getMessage());

	        javaMailSender.send(message);
	        
	        
			String[] arr = foundEmail.split("@");
			
			int halfLength = arr[0].length() / 2;
			int starLength = arr[0].length() - halfLength;
			String foundEmailId = arr[0].substring(0, halfLength);
			
			for (int i = 0; i < starLength; i++) {
				foundEmailId = foundEmailId + "*";			
			}
						
			halfLength = arr[1].length() / 2;	
			starLength = arr[1].length() - halfLength;
			String foundEmailAddress = arr[1].substring(0, halfLength);
			
			for (int i = 0; i < starLength; i++) {
				foundEmailAddress = foundEmailAddress + "*";			
			}
			
			foundEmail = foundEmailId + "@" + foundEmailAddress;
			
			
			return foundEmail;
			
		} else {
			
			return null;			
			
		}
		
	}
	
	public Page<UserEntity> userSearchList(String searchKeywordForLoginId, String searchKeywordForName, Pageable pageable) {
		
		return userRepository.findByNameContainingOrLoginIdContaining(searchKeywordForLoginId, searchKeywordForName, pageable);
		
	}
		
}
