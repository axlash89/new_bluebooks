package com.bluebooks.notice.bo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.common.FileManagerService;
import com.bluebooks.notice.dao.NoticeRepository;
import com.bluebooks.notice.entity.NoticeEntity;

@Service
public class NoticeBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private NoticeRepository noticeRepository;

	@Autowired
	private FileManagerService fileManager;
	
	public Page<NoticeEntity> getNoticeList(Pageable pageable) {
		return noticeRepository.findAll(pageable);
	}
	
	public Page<NoticeEntity> getNoticeListBySearchKeyword(String searchKeyword, Pageable pageable) {
		return noticeRepository.findAllBySubjectContaining(searchKeyword, pageable);
	}
	
	
	public NoticeEntity getNoticeEntityById(int id) {
		return noticeRepository.findById(id).orElse(null);
	}
	
	
	public int addNotice(String subject, String content, MultipartFile file) {
		
		String imagePath = null;
		
		// 이미지가 있으면 업로드 후 imagePath 받아옴
		if (file != null) {
			imagePath = fileManager.saveFile("admin", file);
			if (imagePath == null) {
				return 0;
			}
		}
		
				
		NoticeEntity noticeEntity = noticeRepository.save(
				NoticeEntity.builder()
				.subject(subject)
				.content(content)
				.imagePath(imagePath)
				.build()
			);			
		
		return noticeEntity == null ? null : 1;
		
	}
	
	
	public void updateNotice(int noticeId, String subject, String content, MultipartFile file) {
		
				NoticeEntity noticeEntity = noticeRepository.findById(noticeId).orElse(null);
				
				if(noticeEntity == null) {
					logger.warn("###[공지사항 수정] notice is null. noticeId:{}", noticeId);
				}
								
				if(noticeEntity != null && file == null) {
					
					noticeEntity = noticeEntity.toBuilder()
							.subject(subject)
							.content(content)
							.build();
							noticeEntity = noticeRepository.save(noticeEntity);
							
				} else if (noticeEntity != null && file != null) {

					String imagePath = null;			
					imagePath = fileManager.saveFile("admin", file);
					
					if (imagePath != null && noticeEntity.getImagePath() != null) {
						fileManager.deleteFile(noticeEntity.getImagePath());
					}
					
					noticeEntity = noticeEntity.toBuilder()
							.subject(subject)
							.content(content)
							.imagePath(imagePath)
							.build();
							noticeEntity = noticeRepository.save(noticeEntity);
							
				}
				
	}
	
	
	
	public void deleteNoticeEntityByIdAndUserId(int noticeId) {
		
		NoticeEntity noticeEntity = noticeRepository.findById(noticeId).orElse(null);
		
		if (noticeEntity != null && noticeEntity.getImagePath() == null) {
			noticeRepository.deleteById(noticeId);
		} else if (noticeEntity != null && noticeEntity.getImagePath() != null) {
			noticeRepository.deleteById(noticeId);
			fileManager.deleteFile(noticeEntity.getImagePath());
		}
		
	}
	
	
	
}
