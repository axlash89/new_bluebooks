package com.bluebooks.withdrawal.bo;

import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bluebooks.cart.bo.CartBO;
import com.bluebooks.comment.bo.CommentBO;
import com.bluebooks.common.Criteria;
import com.bluebooks.like.bo.LikeBO;
import com.bluebooks.onetoone.bo.OnetooneBO;
import com.bluebooks.user.bo.UserBO;
import com.bluebooks.user.entity.UserEntity;
import com.bluebooks.withdrawal.dao.WithdrawalMapper;
import com.bluebooks.withdrawal.domain.Withdrawal;

@Service
public class WithdrawalBO {

	@Autowired
	private WithdrawalMapper withdrawalMapper;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private OnetooneBO onetooneBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private CartBO cartBO;
	
	@Autowired
	private CommentBO commentBO;
	
	
	public int deleteWithdrawal(int userId, String userLoginId, String reason) {
		
		// user(완료), onetoone(완료), like(완료), comment(완료), cart(완료) 다 지워야함.
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);
		
		ZonedDateTime zonedDateTime = userEntity.getCreatedAt();
		Date userCreatedAt = Date.from(zonedDateTime.toInstant());
		
		int row = withdrawalMapper.insertWithdrawal(userId, userLoginId, userCreatedAt, reason);

		
		onetooneBO.deleteOnetooneByUserId(userId);
		
		likeBO.deleteLikeByUserId(userId);
		
		commentBO.deleteCommentByUserId(userId);
		
		cartBO.deleteCartByUserId(userId);

		userBO.deleteUserEntityByUserId(userId);

		return row;
		
	}
	

	public List<Withdrawal> selectWithdrawalList(Criteria criteria) {
		return withdrawalMapper.selectWithdrawalList(criteria);
	}
	public int getTotalCount() {
		return withdrawalMapper.getTotalCount();
	}
	
	public List<Withdrawal> selectWithdrawalListByLoginId(Criteria criteria, String searchKeyword) {
		return withdrawalMapper.selectWithdrawalListByLoginId(criteria, searchKeyword);
	}
	public int getTotalCountByLoginId(String searchKeyword) {
		return withdrawalMapper.getTotalCountByLoginId(searchKeyword);
	}
	
	public List<Withdrawal> selectWithdrawalListByReason(Criteria criteria, String searchKeyword) {
		return withdrawalMapper.selectWithdrawalListByReason(criteria, searchKeyword);
	}
	public int getTotalCountByReason(String searchKeyword) {
		return withdrawalMapper.getTotalCountByReason(searchKeyword);
	}
	

}
