package com.bluebooks.user.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.bluebooks.user.entity.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
	
	public UserEntity findByLoginId(String loginId);
	
	public UserEntity findByLoginIdAndPassword(String loginId, String password);

}
