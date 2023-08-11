<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
		
		<c:forEach items="${searchedBookList}" var="book" varStatus="status">
   			
	   		<div class="d-flex align-items-center pt-4">	
	   			<div class="h5">
	   				${status.count}
	   			</div>
	   			<div>
	   				<img src="${book.cover}">
	   			</div>
	   			<div>
	   				<div>${book.id}</div>
	   				<div class="h5">${book.title}</div>
	   				<div>${book.author}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${book.publisher}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${book.pubDate}</div>
	   				<div class="small">${fn:substring(book.description, 0, 80)}...</div>
	   				
	   			</div>
	   			<div>
	   				<input class="check-box" type="checkbox" class="form-control">
	   			</div>
	   			<div>
	  				<button class="add-cart-btn form-control btn btn-sm btn-info d-block"  data-book-id="${book.id}">장바구니 담기</button>
	  				<button class="purchase-btn form-control btn btn-sm btn-secondary d-block"  data-book-id="${book.id}">바로 구매하기</button>
	   			</div>
	   		</div>	
   			
	  	</c:forEach>
		
		
		<div class="d-flex justify-content-center">
		  	<ul class="pagination">
			    <c:if test="${pageMaker.prev}">
			        <li>
			            <a href="/book/searched_result_view${pageMaker.makeQuery(pageMaker.startPage - 1)}&searchKeyword=${searchKeyword}" class="mr-2 text-dark">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/book/searched_result_view${pageMaker.makeQuery(index)}&searchKeyword=${searchKeyword}" class="text-danger">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/book/searched_result_view${pageMaker.makeQuery(index)}&searchKeyword=${searchKeyword}">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/book/searched_result_view${pageMaker.makeQuery(pageMaker.endPage + 1)}&searchKeyword=${searchKeyword}" class="ml-2 text-dark">[다음]</a>
			        </li>
			    </c:if>   
			</ul>
		</div>

<script>
	$(document).ready(function() {
		
		$('.add-cart-btn').on('click', function() {
			
			if(${empty userId}) {
				alert("로그인이 필요합니다.");
				return;
			}
			
			let bookId = $(this).data('book-id');
			
			$.ajax({
				type: "post"
				, url: "/cart/add"
				, data: { "bookId": bookId }				
				, success: function(data) {
					if (data.code == 1) {
						alert("장바구니 담기 완료");
						location.href="/cart/cart_list_view"
					} else {
						alert(data.errorMessage);
					}
				} 
				
				, error:function(request, status, error) {
					alert("장바구니 담기 실패, 관리자에게 문의하세요.")
				}
			
			});
			
		});
		
	});
</script>		