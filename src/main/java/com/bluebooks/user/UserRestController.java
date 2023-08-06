package com.bluebooks.user;

import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bluebooks.common.SHA256;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserBO userBO;
	
	/**
	 * 중복확인 API
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {		
		
		Map<String, Object> result = new HashMap<>();
		result.put("isDuplicatedId", false);
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(loginId);
		result.put("code", 1);
		
		if (userEntity != null) {
			result.put("isDuplicatedId", true);
		} 
		
		return result;
		
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param birthDate
	 * @param email
	 * @param phoneNumber
	 * @param zipCode
	 * @param address
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("birthDate") @DateTimeFormat(pattern = "yyyy/MM/dd") Date birthDate,
			@RequestParam("email") String email,
			@RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("zipCode") String zipCode,
			@RequestParam("address") String address) {
				
		SHA256 sha256 = new SHA256();
		
        String shaPassword = null;        
		
		try {
			shaPassword = sha256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			logger.warn("###[UserRestController 회원가입 시 패스워드 암호화 실패] phoneNumber:{}", phoneNumber);
		}		
		
		Integer userId = userBO.addUser(loginId, shaPassword, name, birthDate, email, phoneNumber, zipCode, address, 1000);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userId != null) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "회원가입 실패");
		}		
		
		return result;
		
	}
	
	/**
	 * 로그인 API
	 * @param loginId
	 * @param password
	 * @param session
	 * @return
	 */
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpSession session) {
		
		SHA256 sha256 = new SHA256();
		
        String shaPassword = null;
        
		try {
			shaPassword = sha256.encrypt(password);
		} catch (NoSuchAlgorithmException e) {
			logger.warn("###[UserRestController 로그인 시 패스워드 암호화 실패] loginId:{}", loginId);
		}
		
		UserEntity userEntity = userBO.getUserEntityByLoginIdPassword(loginId, shaPassword);
		
		Map<String, Object> result = new HashMap<>();
		
		if (userEntity != null) {
			session.setAttribute("userId", userEntity.getId());
			session.setAttribute("userLoginId", userEntity.getLoginId());
			session.setAttribute("userName", userEntity.getName());
			session.setAttribute("userPoint", userEntity.getPoint());
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "아이디 또는 비밀번호를 확인하세요.");
		}
		
		return result;
		
	}
	
	
}
