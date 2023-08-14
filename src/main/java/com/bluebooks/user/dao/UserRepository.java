package com.bluebooks.user.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.bluebooks.user.entity.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
	
	public UserEntity findByLoginId(String loginId);
	
	public UserEntity findByLoginIdAndPassword(String loginId, String password);
	
	public UserEntity findByNameAndBirthDateAndPhoneNumber(String name, Date birthDate, String phoneNumber);
	
	public UserEntity findByLoginIdAndNameAndBirthDateAndPhoneNumber(String loginId, String name, Date birthDate, String phoneNumber);
	
	Page<UserEntity> findByNameContainingOrLoginIdContaining(String searchKeywordForLoginId, String searchKeywordForName, Pageable pageable);

	public List<UserEntity> findAllByLoginIdContaining(String searchKeyword);
	
	
	
}
