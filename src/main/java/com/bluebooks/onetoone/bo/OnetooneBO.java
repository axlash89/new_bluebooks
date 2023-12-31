package com.bluebooks.onetoone.bo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bluebooks.common.FileManagerService;
import com.bluebooks.onetoone.dao.OnetooneRepository;
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
	
	public Page<OnetooneEntity> getOnetooneListByUserIdList(Pageable pageable, List<Integer> userNoList) {
		return onetooneRepository.findAllByUserIdIn(pageable, userNoList);	
	}
	
	public Page<OnetooneEntity> getOnetooneListBySubject(String subject, Pageable pageable) {
		return onetooneRepository.findAllBySubjectContaining(subject, pageable);	
	}
	
	
	
	public Page<OnetooneEntity> getAllOfOnetoone(Pageable pageable) {
		
		Page<OnetooneEntity> onetooneList = onetooneRepository.findAll(pageable);
				
		return onetooneList;
		
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
	
	public List<UserEntity> getWriterList() {
		
		List<OnetooneEntity> onetooneList = onetooneRepository.findAll();
		
		Set<Integer> idSet = new HashSet<>();
		
		for (int i = 0; i < onetooneList.size(); i++) {
			idSet.add(onetooneList.get(i).getUserId());
		}
		
		List<UserEntity> writerList = new ArrayList<>();
		
		Iterator<Integer> iter = idSet.iterator();
		while(iter.hasNext()) {
			writerList.add(userBO.getUserEntityById(iter.next()));
		}
		
		return writerList;
		
	}
	
	public void answerOnetoone(int onetooneId, String answer) {
		
		OnetooneEntity onetooneEntity = onetooneRepository.findById(onetooneId).orElse(null);
		
		if(onetooneEntity != null) {
			onetooneEntity = onetooneEntity.toBuilder()
					.answer(answer)
					.status("답변완료")
					.build();
					onetooneEntity = onetooneRepository.save(onetooneEntity);
		}
		
	}
	
	public void deleteAnswer(int onetooneId) {
		OnetooneEntity onetooneEntity = onetooneRepository.findById(onetooneId).orElse(null);
		
		onetooneEntity = onetooneEntity.toBuilder()
				.answer("")
				.status("미답변")
				.build();
				onetooneEntity = onetooneRepository.save(onetooneEntity);
		
	}
	
	public void updateAnswer(int onetooneId, String answer) {
		OnetooneEntity onetooneEntity = onetooneRepository.findById(onetooneId).orElse(null);
		
		onetooneEntity = onetooneEntity.toBuilder()
				.answer(answer)
				.build();
				onetooneEntity = onetooneRepository.save(onetooneEntity);
		
	}
	
	
}