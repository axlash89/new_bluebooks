package com.bluebooks.notice.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.bluebooks.notice.entity.NoticeEntity;

@Repository
public interface NoticeRepository extends JpaRepository<NoticeEntity, Integer> {

	public Page<NoticeEntity> findAll(Pageable pageable);
	
	public Page<NoticeEntity> findAllBySubjectContaining(String searchKeyword, Pageable pageable);
}
