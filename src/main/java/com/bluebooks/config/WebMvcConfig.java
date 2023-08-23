package com.bluebooks.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.bluebooks.common.FileManagerService;
import com.bluebooks.interceptor.PermissionInterceptor;

@Configuration  // 설정을 위한 spring bean
public class WebMvcConfig implements WebMvcConfigurer {

	@Autowired
	private PermissionInterceptor interceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry
		.addInterceptor(interceptor)
		.addPathPatterns("/**")
		.excludePathPatterns("/static/**", "/error", "/favicon", "/user/sign_out");
	}

	// 웹 이미지 path와 서버에 업로드 된 이미지와 매핑 설정
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry
		.addResourceHandler("/images/**")  // 웹 이미지 path  http://localhost/images/aaaa_34124215/sun.pngA
		.addResourceLocations("file:///" + FileManagerService.FILE_UPLOAD_PATH);  // windows는 ///  mac은 //  실제 파일 위치
	}
	
	
	
}
