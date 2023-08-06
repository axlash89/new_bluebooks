<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

  		<div class="d-flex justify-content-around pt-2">
			<div>
	        	<div>
	        		<a href="/main_view">
		        		<img src="/static/img/logo.png" width="80px">
		        		<h5>블루북스</h5>
	        		</a>
	        	</div>
	       	</div>
	       	<div class="mt-3">
	       		<div class="d-flex justify-content-between">
		       		<input type="text" id="searchBox" class="form-control" placeholder="책의 제목 또는 저자 입력">
		       		<input type="button" id="searchBoxBtn" class="btn btn-secondary" value="검색">
		       		<a href="/book/advanced_search_view" class="ml-2 mt-2 small">상세검색</a>
		       		
		       		<c:choose>
			       		<c:when test="${not empty userName}">
			       			<div class="ml-5">
				       			<span class="d-flex justify-content-end text-primary d-block small ml-3">${userName}님 안녕하세요!</span>
			       				<div class="d-flex justify-content-end"><a href="#" class="small">장바구니</a><a href="/user/sign_out" class="ml-2 small">로그아웃</a></div>
		       				</div>
			       		</c:when>
			       		<c:otherwise>
			       			<a href="/user/sign_up_view" class="ml-5 mt-2 small">회원가입</a>
			       			<a href="/user/sign_in_view" class="ml-2 mt-2 small">로그인</a>
		       			</c:otherwise>
	       			</c:choose>
	       		</div>
	       		<nav>
	                <ul class="nav nav-fill d-flex justify-content-between align-items-center font-weight-bold pt-2">
	                    <a href="#"><li class="menus">분야보기</li></a>
	                    <a href="#"><li class="menus">베스트셀러</li></a>
	                    <a href="#"><li class="menus">새로나온 책</li></a>
	                    <a href="#"><li class="menus">이벤트</li></a>
	                    <a href="#"><li class="menus">공지사항</li></a>
	                    <a href="/order/my_order_view" id="myPage"><li class="menus">마이페이지</li></a>
	                </ul>
	           	</nav>
	       	</div>
      	</div>	

<script>

$(document).ready(function() {

	$('#myPage').on('click', function() {
		
		if(${empty userName}) {
			alert("로그인 후 접근 가능한 메뉴입니다.");
			return false;
		}		
		
	});
	
});

</script>