<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    
	<div class="d-flex justify-content-center">
	
	    <div class="my-page-menus">
	    	<a href="http://localhost/order/my_order_view?period=week" class="a-tag-deco-none-category"><div class="my-menu">내 주문내역</div></a>
	    	<a href="/onetoone/onetoone_list_view" class="a-tag-deco-none-category"><div class="my-menu">1:1 문의</div></a>
	    	<a href="/user/edit_my_info_view" class="a-tag-deco-none-category"><div class="my-menu">내 정보 수정</div></a>
	    	<a href="/withdrawal/withdraw_view" class="a-tag-deco-none-category"><div class="my-menu">회원탈퇴</div></a>
	    </div>
	    
	    <div class="my-page-contents">
	    
	    	<jsp:include page="../${secondView}.jsp"/>
	    	
	    </div>
	    
    </div>