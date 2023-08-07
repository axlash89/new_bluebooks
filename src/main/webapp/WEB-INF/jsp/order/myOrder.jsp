<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

   	<div class="d-flex justify-content-center pt-3">
	
	    <div class="my-page-menus">
	    	<a href="/order/my_order_view"><div class="font-weight-bold">내 주문내역</div></a>
	    	<a href="/onetoone/onetoone_list_view"><div class="">1:1 문의</div></a>
	    	<a href="/user/edit_my_info_view"><div class="">내 정보 수정</div></a>
	    	<a href="/withdrawal/withdraw_view"><div class="">회원탈퇴</div></a>
	    </div>
	    
	    <div class="my-page-contents">
	    	<div>
		    	<div class="d-flex justify-content-center">${userName}님 안녕하세요!</div>
		    	<div class="d-flex justify-content-center">내 보유 포인트 : ${userPoint}원</div>
		    	<div class="d-flex justify-content-between mt-3">
		    		<div class="d-flex justify-content-center mt-3">내 주문내역</div><div><a href="#" class="btn btn-info">최근 1주일</a><a href="#" class="btn btn-info">1개월</a><a href="#" class="btn btn-info">3개월</a><a href="#" class="btn btn-info">6개월</a></div>
		    	</div>
	    	</div>
	    	
	    	<table class="table">
	    		<thead>
	    			<tr>
	    				<th>번호</th>
	    				<th>상품정보</th>
	    				<th>수량</th>
	    				<th>상품금액</th>
	    				<th>배송정보</th>
	    			</tr>
	    		</thead>
	    		<tbody>
	    			<tr>
	    				<td></td>
	    				<td></td>
	    				<td></td>
	    				<td></td>
	    				<td></td>
	    			</tr>
	    		</tbody>
	    	</table>
	    	
	    </div>
	    
    </div>