package com.bluebooks.notice;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.common.FileManagerService;
import com.bluebooks.notice.bo.NoticeBO;
import com.google.gson.JsonObject;

@RequestMapping("/notice")
@RestController
public class NoticeRestController {

	@Autowired
	private NoticeBO noticeBO;
	
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("subject") String subject,
			@RequestParam("content") String content,
			HttpSession session) {
		
		// db insert
		int row = noticeBO.addNotice(subject, content);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "공지사항 업로드를 실패하였습니다.");
		}
		
		return result;
		
	}
	
	
	@PutMapping("/update")
	public Map<String, Object> update(
			@RequestParam("noticeId") int noticeId,
			@RequestParam("subject") String subject,
			@RequestParam("content") String content) {
				
		// BO update
		noticeBO.updateNotice(noticeId, subject, content);
		
		// 응답
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
	}
	
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("noticeId") int noticeId,
			HttpSession session) {
				
		noticeBO.deleteNoticeEntityById(noticeId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		return result;
		
	}
	
	
	@PostMapping(value="/upload_summernote_images", produces = "application/json")
	public JsonObject summerimage(@RequestParam("file") MultipartFile multipartFile) {
		JsonObject jsonObject = new JsonObject();
		String fileRoot = FileManagerService.FILE_UPLOAD_PATH;	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
					
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
			
		File targetFile = new File(fileRoot + savedFileName);	
			
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/images/" + savedFileName);
			jsonObject.addProperty("code", "1");
			jsonObject.addProperty("result", "성공");
					
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("code", "500");
			e.printStackTrace();
		}
			
		return jsonObject;
		 
	}
	
	
	
}
