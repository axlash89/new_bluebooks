<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    
	<div class="d-flex justify-content-center pt-3">
	
	    <div class="my-page-menus">
	    	<a href="/order/my_order_view"><div class="">내 주문내역</div></a>
	    	<a href="/onetoone/onetoone_list_view"><div class="">1:1 문의</div></a>
	    	<a href="/user/edit_my_info_view"><div class="">내 정보 수정</div></a>
	    	<a href="/withdrawal/withdraw_view"><div class="">회원탈퇴</div></a>
	    </div>
	    
	    <div class="my-page-contents">
	    
	    	<jsp:include page="../${secondView}.jsp"/>
	    	
	    </div>
	    
    </div>