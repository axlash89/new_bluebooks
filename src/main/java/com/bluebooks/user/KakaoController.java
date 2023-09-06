package com.bluebooks.user;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.KakaoProfile;
import com.bluebooks.user.entity.OAuthToken;
import com.bluebooks.user.entity.UserEntity;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class KakaoController {
	
	@Autowired
	private UserBO userBO;
		
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("/auth/kakao/callback")
	public String kakaoCallback(Model model, HttpSession session, 
			@RequestParam("code") String code) {
				
		// POST 방식으로 key=value 데이터를 요청(카카오쪽으로)
		RestTemplate rt = new RestTemplate();
				
		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		
		params.add("grant_type", "authorization_code");
		params.add("client_id", "1f3a717bfeb202d1b0336161e6208697");
		params.add("redirect_uri", "http://3.39.189.144/auth/kakao/callback");
		params.add("code", code);
		
		// HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		
		// Http 요청하기-POST방식으로-그리고 response 변수의 응답 받음.
		ResponseEntity<String> response = rt.exchange(
			"https://kauth.kakao.com/oauth/token",
			HttpMethod.POST,
			kakaoTokenRequest,
			String.class
		);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		OAuthToken oauthToken = null;
		
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		logger.info("카카오 액세스 토큰 : " + oauthToken.getAccess_token());
		
		RestTemplate rt2 = new RestTemplate();
		
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer " + oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded");
				
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);
		
		ResponseEntity<String> response2 = rt2.exchange(
			"https://kapi.kakao.com/v2/user/me",
			HttpMethod.POST,
			kakaoProfileRequest,
			String.class
		);
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		
		KakaoProfile kakaoProfile= null;
		
		try {
			kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// UserEntity 필요 : type, loginId, password, name , email birthDate, phoneNumber zipCode, address, point

		logger.info("카카오 번호 : " + kakaoProfile.getId());
		logger.info("카카오 이메일 : " + kakaoProfile.getKakao_account().getEmail());
		logger.info("블루북스 유저 메일 : " + kakaoProfile.getKakao_account().getEmail());
		UUID garbagePassword = UUID.randomUUID();
		logger.info("블루북스 유저 패스워드" + garbagePassword);
		
		UserEntity user = userBO.getUserEntityByLoginId(kakaoProfile.getId().toString());
		
		if (user != null) {
			
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userPoint", user.getPoint());

			return "redirect:/main_view";
			
		} else {
			
		model.addAttribute("kakaoId", kakaoProfile.getId());
		model.addAttribute("kakaoEmail", kakaoProfile.getKakao_account().getEmail());
		model.addAttribute("kakaoPassword", garbagePassword.toString());
		
		model.addAttribute("view", "user/signUpByKakao");
		return "template/layout";
		
		}
	}


//	MIME : application/x-www-form-urlencoded;charset=utf-8  (key=value)
//	https://kauth.kakao.com/oauth/token
//
//	grant_type=authorization_code
//
//	client_id=1f3a717bfeb202d1b0336161e6208697
//
//	redirect_uri=http://localhost/auth/kakao/callback
//
//	code=${AUTHORIZE_CODE}

	
	
}
