package com.bluebooks.onetoone.bo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.common.FileManagerService;
import com.bluebooks.onetoone.dao.OnetooneRepository;
import com.bluebooks.onetoone.domain.OnetooneView;
import com.bluebooks.onetoone.entity.OnetooneEntity;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;

@Service
public class OnetooneBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OnetooneRepository onetooneRepository;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private FileManagerService fileManager;
	
	public int addOnetoone(int userId, String userLoginId, String subject, String content, MultipartFile file) {
		
		String imagePath = null;
		
		// 이미지가 있으면 업로드 후 imagePath 받아옴
		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
			if (imagePath == null) {
				return 0;
			}
		}
		
		// 개개인 글번호 생성
		List<OnetooneEntity> onetooneEntityList = onetooneRepository.findAllByUserId(userId);		
		int maxPostNo = 0;		
		for (int i = 0; i < onetooneEntityList.size(); i++) {
			if (maxPostNo < onetooneEntityList.get(i).getPostNoForOneself()) {
				maxPostNo = onetooneEntityList.get(i).getPostNoForOneself();
			}
		}		
				
		OnetooneEntity onetooneEntity = onetooneRepository.save(
				OnetooneEntity.builder()
				.userId(userId)
				.postNoForOneself(maxPostNo + 1)
				.subject(subject)
				.content(content)
				.imagePath(imagePath)
				.status("미답변")
				.build()
			);			
		
		return onetooneEntity == null ? null : 1;
		
	}
	
	public Page<OnetooneEntity> getOnetooneListByUserId(Pageable pageable, int userId) {
		return onetooneRepository.findAllByUserId(pageable, userId);	
	}
	
	public Page<OnetooneView> getAllOfOnetoone(Pageable pageable) {
		
		Page<OnetooneEntity> onetooneList = onetooneRepository.findAll(pageable);
				
		List<OnetooneView> onetooneViewList = new ArrayList<>();		
		for (int i = 0; i < onetooneList.getContent().size(); i++) {
			OnetooneView onetoone = new OnetooneView();
			UserEntity user = userBO.getUserEntityById(onetooneList.getContent().get(i).getUserId());
			onetoone.setUser(user);
			onetoone.setOnetoone(onetooneList.getContent().get(i));
			onetooneViewList.add(onetoone);
		}
		
		PageRequest pageRequest = PageRequest.of(pageable.getPageNumber(), onetooneList.getSize());
		
		int start = (int) pageRequest.getOffset();
		int end = Math.min((start + pageRequest.getPageSize()), onetooneViewList.size());
		Page<OnetooneView> pages = new PageImpl<>(onetooneViewList.subList(start, end), pageRequest, onetooneViewList.size());
		
		return pages;
		
	}
	
	public OnetooneEntity getOnetooneEntityById(int id) {
		return onetooneRepository.findById(id).orElse(null);
	}
		
	
	public void updateOnetoone(int userId, String userLoginId, int onetooneId, String subject, String content, MultipartFile file) {
		
		// 업데이트 대상인 기존 글을 가져와 본다.(validation, 이미지 교체시 기존 이미지 제거를 위해)
		OnetooneEntity onetooneEntity = onetooneRepository.findById(onetooneId).orElse(null);
		
		if(onetooneEntity == null) {
			logger.warn("###[1:1 문의 수정] onetoone is null. onetooneId:{}", onetooneId);
		}
		
		
		if(onetooneEntity != null && file == null) {
			
			onetooneEntity = onetooneEntity.toBuilder()
					.subject(subject)
					.content(content)
					.build();
					onetooneEntity = onetooneRepository.save(onetooneEntity);
					
		} else if (onetooneEntity != null && file != null) {

			String imagePath = null;			
			imagePath = fileManager.saveFile(userLoginId, file);
			
			if (imagePath != null && onetooneEntity.getImagePath() != null) {
				fileManager.deleteFile(onetooneEntity.getImagePath());
			}
			
			onetooneEntity = onetooneEntity.toBuilder()
					.subject(subject)
					.content(content)
					.imagePath(imagePath)
					.build();
					onetooneEntity = onetooneRepository.save(onetooneEntity);
					
		}
				
		
	}
	
	
	
	public void deleteOnetooneEntityByIdAndUserId(int onetooneId, int userId) {
		
		OnetooneEntity onetooneEntity = onetooneRepository.findById(onetooneId).orElse(null);
		
		if (onetooneEntity != null && onetooneEntity.getUserId() == userId && onetooneEntity.getImagePath() == null) {
			onetooneRepository.deleteById(onetooneId);
		} else if (onetooneEntity != null && onetooneEntity.getUserId() == userId && onetooneEntity.getImagePath() != null) {
			onetooneRepository.deleteById(onetooneId);
			fileManager.deleteFile(onetooneEntity.getImagePath());
		}
		
	}
	
	
	public void deleteOnetooneByUserId(int userId) {
		
		List<OnetooneEntity> onetooneList = onetooneRepository.findAllByUserId(userId);
		
		if (onetooneList.size() > 0) {			
			for (int i = 0; i < onetooneList.size(); i++) {				
				if (onetooneList.get(i).getImagePath() != null) {				
					fileManager.deleteFile(onetooneList.get(i).getImagePath());				
				}				
			}			
			onetooneRepository.deleteAll(onetooneList);			
		}		
		
	}
	
}