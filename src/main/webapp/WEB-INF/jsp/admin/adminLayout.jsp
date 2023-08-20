<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div class="d-flex justify-content-center">
	
	    <div class="my-page-menus">
	    	<a href="/admin/admin_view?period=week" class="a-tag-deco-none-category"><div class="my-menu">주문내역</div></a>
	    	<a href="/admin/manage_onetoone_list_view" class="a-tag-deco-none-category"><div class="my-menu">1:1 문의 관리</div></a>
	    	<a href="/admin/manage_user_view" class="a-tag-deco-none-category"><div class="my-menu">회원정보 관리</div></a>
	    	<a href="/withdrawal/witndrawn_user_view" class="a-tag-deco-none-category"><div class="my-menu">탈퇴한 회원</div></a>
	    </div>
	    
	    <div class="my-page-contents">
	    
	    	<jsp:include page="../${secondView}.jsp"/>
	    	
	    </div>
	    
    </div>    