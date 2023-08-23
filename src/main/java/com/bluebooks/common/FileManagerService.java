package com.bluebooks.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component  // 일반적인 spring bean을 만들 때 사용
public class FileManagerService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// 실제 업로드가 된 이미지가 저장될 경로(서버)
	public static final String FILE_UPLOAD_PATH = "C:\\Users\\axlas\\Desktop\\kotaeyoung\\6_spring_project\\new_bluebooks\\workspace\\images/";
//	public static final String FILE_UPLOAD_PATH = "D:\\kotaeyoung\\6_spring_project\\bluebooks\\workspace\\images/";
	// 마지막에 / 붙인다.
	
	// input : loginId, MultipartFile(이미지 파일) 
	// output : web image path(String)
	public String saveFile(String loginId, MultipartFile file) {
		
		// 파일 디렉토리(폴더)   예) aaaa_167845645/sun.png
		String directoryName = loginId + "_" + System.currentTimeMillis() + "/";  // aaaa_167845645/
		String filePath = FILE_UPLOAD_PATH + directoryName;  // D:\\kotaeyoung\\6_spring_project\\bluebooks\\workspace\\images/aaaa_167845645/
		
		// 폴더 생성
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			// 폴더 만드는데 실패 시 이미지 경로를 null로 리턴
			logger.error("###[FileManagerService 폴더 생성 실패] FILE_UPLOAD_PATH:{}", FILE_UPLOAD_PATH);
			return null;
		}
		
		// 파일 업로드 : byte 단위 업로드
		try {
			byte[] bytes = file.getBytes();
			// ★★★★★ 한글 이름 이미지는 올릴 수 없으므로 나중에 영문자로 바꿔서 올리기
			Path path = Paths.get(filePath + file.getOriginalFilename());  // 디렉토리 경로 + 사용자가 올린 파일명
			Files.write(path, bytes);  // 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null;  // 이미지 업로드 실패 시 null 리턴
		}		
		
		// 파일 업로드가 성공했으면 웹 이미지 url path를 리턴한다.
		// /images/aaaa_1689839377639/git4.jpg
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}
	
	
	
	// 파일 삭제 메소드
		// input : imagePath
		// output : 없음
	public void deleteFile(String imagePath) {  // imagePath: /images/aaaa_1690358390267/London_Skyline.jpg
		// D:\\kotaeyoung\\6_spring_project\\memo\\workspace\\images/  /images/  aaaa_1690358390267/London_Skyline.jpg
		// 주소에 겹치는 /images/를 제거한다.
		
		Path path = Paths.get(FILE_UPLOAD_PATH + imagePath.replace("/images/", ""));
		
		if (Files.exists(path)) {  // 이미지가 존재하는가?
			// 이미지 삭제
			try {
				Files.delete(path);
			} catch (IOException e) {
				logger.info("###[FileManagerService 이미지 삭제 실패] imagePath:{}", imagePath);
			}
			
			// 폴더 삭제
			path = path.getParent();
			if (Files.exists(path)) {
				try {
					Files.delete(path);
				} catch (IOException e) {
					logger.info("###[FileManagerService 이미지 폴더 삭제 실패] imagePath:{}", imagePath);
				}
			}
			
		}
		
	}
	
	
	// 이벤트 게시판 파일 업로드
	public String saveEventFile(MultipartFile file) {
		
		// 파일 디렉토리(폴더)   예) aaaa_167845645/sun.png
		String directoryName = "event_" + System.currentTimeMillis() + "/";  // aaaa_167845645/
		String filePath = FILE_UPLOAD_PATH + directoryName;  // D:\\kotaeyoung\\6_spring_project\\bluebooks\\workspace\\images/aaaa_167845645/
		
		// 폴더 생성
		File directory = new File(filePath);
		if (directory.mkdir() == false) {
			// 폴더 만드는데 실패 시 이미지 경로를 null로 리턴
			logger.error("###[FileManagerService 폴더 생성 실패] FILE_UPLOAD_PATH:{}", FILE_UPLOAD_PATH);
			return null;
		}
		
		// 파일 업로드 : byte 단위 업로드
		try {
			byte[] bytes = file.getBytes();
			// ★★★★★ 한글 이름 이미지는 올릴 수 없으므로 나중에 영문자로 바꿔서 올리기
			Path path = Paths.get(filePath + file.getOriginalFilename());  // 디렉토리 경로 + 사용자가 올린 파일명
			Files.write(path, bytes);  // 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null;  // 이미지 업로드 실패 시 null 리턴
		}		
		
		// 파일 업로드가 성공했으면 웹 이미지 url path를 리턴한다.
		// /images/aaaa_1689839377639/git4.jpg
		return "/images/" + directoryName + file.getOriginalFilename();
		
	}
		
	
}
