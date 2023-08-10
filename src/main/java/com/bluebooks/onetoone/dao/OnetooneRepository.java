package com.bluebooks.onetoone.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.bluebooks.onetoone.entity.OnetooneEntity;

@Repository
public interface OnetooneRepository extends JpaRepository<OnetooneEntity, Integer> {
	
	public List<OnetooneEntity> findAllByUserId(int userId); 
	
	public Page<OnetooneEntity> findAllByUserId(Pageable pageable, int userId);
	
	public Page<OnetooneEntity> findAllByUserIdIn(Pageable pageable, List<Integer> userNoList);
	
	public Page<OnetooneEntity> findAllBySubjectContaining(String subject, Pageable pageable);
	
	public Page<OnetooneEntity> findAll(Pageable pageable);
		
}
