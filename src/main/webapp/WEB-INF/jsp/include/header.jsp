<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

  		<div class="d-flex justify-content-around pt-2">
			<div>
	        	<div class="pl-2">
	        		<a href="/main_view" class="logo-text stop-drag">
		        		<img src="/static/img/bluebooks.png" class="mt-1 mb-1" width="80px"><br>
		        		<span class="text-center font-weight-bold h5">블루북스</span>
	        		</a>
	        	</div>
	       	</div>
	       	<div class="mt-3">
	       		<div class="d-flex justify-content-between">
					
		       		<form action="/book/searched_result_view" method="get" class="d-flex">
			       		<input type="text" id="searchBox" class="form-control" name="searchKeyword" placeholder="책의 제목 또는 저자 입력">
			       		<input type="submit" id="searchBoxBtn" class="btn btn-secondary" value="검색">
			       	</form>	
		       		
		       		<a href="/book/advanced_search_view" class="ml-2 mt-2 small header-menu stop-drag">상세검색</a>
		       		
		       		<c:choose>
			       		<c:when test="${not empty userName}">
			       			<div class="ml-5">
				       			<span class="d-flex justify-content-end d-block small ml-3 stop-drag header-text">${userName}님 안녕하세요!</span>			       			
			       				<div class="d-flex justify-content-end"><a href="/cart/cart_list_view" class="small header-menu stop-drag">장바구니</a><a href="/user/sign_out" class="ml-3 small header-menu stop-drag">로그아웃</a></div>
		       				</div>
			       		</c:when>
			       		<c:otherwise>
			       			<a href="/user/sign_up_view" class="ml-5 mt-2 small header-menu stop-drag">회원가입</a>
			       			<a href="/user/sign_in_view" class="ml-3 mt-2 small header-menu stop-drag">로그인</a>
		       			</c:otherwise>
	       			</c:choose>
	       		</div>
	       		<nav>
	                <ul class="nav nav-fill d-flex justify-content-between align-items-center pt-2">
	                    <a href="/book/all_book_view" class="header-menu stop-drag"><li>분야보기</li></a>
	                    <a href="/book/best_book_view" class="header-menu stop-drag"><li>베스트셀러</li></a>
	                    <a href="/book/new_book_view" class="header-menu stop-drag"><li>새로나온 책</li></a>
	                    <a href="/event/event_list_view" class="header-menu stop-drag"><li>이벤트</li></a>
	                    <a href="/notice/notice_list_view" class="header-menu stop-drag"><li>공지사항</li></a>
	                    <c:choose>
	                    <c:when test="${userLoginId ne 'admin'}">
	                   		<a href="/order/my_order_view" id="myPage" class="header-menu stop-drag"><li>마이페이지</li></a>
	                    </c:when>
	                    <c:otherwise>
	                    	<a href="/admin/admin_view?period=week" class="header-menu stop-drag"><li>관리자 페이지</li></a>
	                    </c:otherwise>
	                    </c:choose>
	                    
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
	
	$('#searchBoxBtn').on('click', function() {
		
		let searchBox = $('#searchBox').val().trim();
		
		if (!searchBox) {
			alert("검색어를 입력하세요.")
			return false;
		}
		
	});
	
});

</script>
