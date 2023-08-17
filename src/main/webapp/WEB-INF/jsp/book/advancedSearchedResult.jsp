<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
		
		<div class="d-flex justify-content-end mr-5 pt-3">
			<label>전체선택<input type="checkbox" id="checkAll"></label>
		</div>
		<c:forEach items="${advancedSearchedBookList}" var="book" varStatus="status">
   			
	   		<div class="d-flex align-items-center pt-4">	
	   			<div class="h5">
	   			</div>
	   			<div>
	   				<img src="${book.cover}">
	   			</div>
	   			<div>
	   				<div class="h5">${book.title}</div>
	   				<div>${book.author}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${book.publisher}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${book.pubDate}</div>
	   				<div class="small">${fn:substring(book.description, 0, 80)}...</div>
	   				
	   			</div>
	   			<div>
	   				<input class="check-one form-control" type="checkbox" value="${book.id}">
	   			</div>
	   			<div>
	  				<button class="add-cart-btn form-control btn btn-sm btn-info d-block" data-book-id="${book.id}">장바구니 담기</button>
	  				<form action="/order/create_order_view" method="get">
	  					<input type="text" class="d-none" name="bookId" value="${book.id}">
	  					<button type="submit" class="purchase-btn form-control btn btn-sm btn-secondary d-block">바로 구매하기</button>
	   				</form>
	   			</div>
	   		</div>	
   			
	  	</c:forEach>
		<c:choose>
		<c:when test="${not empty advancedSearchedBookList}">
			<div class="d-flex justify-content-center">
			  	<ul class="pagination">
				    <c:if test="${pageMaker.prev}">
				        <li>
				            <a href="/book/advanced_searched_result_view${pageMaker.makeQuery(pageMaker.startPage - 1)}&title=${title}&author=${author}&publisher=${publisher}&pubPeriod=${pubPeriod}" class="mr-2 text-dark">[이전]</a>
				        </li>		         
				    </c:if>
				 
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
				    	<c:choose>
				    	<c:when test="${nowPage eq index}">
				        <a href="/book/advanced_searched_result_view${pageMaker.makeQuery(index)}&title=${title}&author=${author}&publisher=${publisher}&pubPeriod=${pubPeriod}" class="text-danger">[${index}]</a>
				        </c:when>
				        <c:otherwise>
				        <a href="/book/advanced_searched_result_view${pageMaker.makeQuery(index)}&title=${title}&author=${author}&publisher=${publisher}&pubPeriod=${pubPeriod}">[${index}]</a>
				        </c:otherwise>
				        </c:choose>
				    </c:forEach>
				 
				    <c:if test="${pageMaker.next}">
				        <li>
				            <a href="/book/advanced_searched_result_view${pageMaker.makeQuery(pageMaker.endPage + 1)}&title=${title}&author=${author}&publisher=${publisher}&pubPeriod=${pubPeriod}" class="ml-2 text-dark">[다음]</a>
				        </li>
				    </c:if>   
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<h5 class="text-center">검색된 도서가 없습니다.</h5>
		</c:otherwise>
		</c:choose>
<script>
	$(document).ready(function() {
		
		$('#checkAll').on('click', function() {
			if ($('#checkAll').is(':checked')) {
				$('.check-one').prop('checked', true);
			} else {
				$('.check-one').prop('checked', false);
			}
		});
		
		
		$(".check-one").click(function() {
			var total = $(".check-one").length;
			var checked = $(".check-one:checked").length;
			
			if(total != checked) {
				$("#checkAll").prop("checked", false);
			} else {
				$("#checkAll").prop("checked", true); 
			}
		});
		
		
		$('.add-cart-btn').on('click', function() {
			
			if(${empty userId}) {
				alert("로그인이 필요합니다.");
				return;
			}
			
			var checkArr = [];
			$(".check-one:checked").each(function() {
				checkArr.push($(this).val());
			});
				
			let bookId = $(this).data('book-id').toString();			
			
			if(checkArr.includes(bookId) == false) {
				checkArr.push(bookId);				
			}
			
			$.ajax({
				type: "post"
				, url: "/cart/add"
				, traditional: true
				, data: { bookIdArr: checkArr }			
				, success: function(data) {
					if (data.code == 1) {
						let result = confirm("선택하신 상품(들)이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?");
						if (result) {
							location.href="/cart/cart_list_view";
						}
					} else {
						alert(data.errorMessage);
					}
				} 
				
				, error:function(request, status, error) {
					alert("장바구니 담기 실패, 관리자에게 문의하세요.")
				}
			
			});
			
		});
		
		
		$('.purchase-btn').on('click', function() {
			
			if(${empty userId}) {
				alert("로그인이 필요합니다.");
				return false;
			}
			
		});
		
		
	});
</script>		