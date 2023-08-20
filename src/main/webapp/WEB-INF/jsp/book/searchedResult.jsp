<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	
		<h3 class="text-center pt-3 category-guide font-weight-bold">'${searchKeyword}'&nbsp;검색 결과&nbsp;(${searchedResultCount}건)</h3>
		<hr>
		<c:if test="${not empty searchedBookList}">
		<div class="d-flex justify-content-end mr-5 pt-1">
			<label><input type="checkbox" id="checkAll">전체선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		</div>
		</c:if>
		<div class="d-flex justify-content-center">
		<div>
		<c:forEach items="${searchedBookList}" var="book" varStatus="status">
   			
	   		<div class="book-box-in-list d-flex align-items-center stop-drag">	
	   			<div>
	   				<a href="/book/book_detail_view?bookId=${book.id}"><img src="${book.cover}" width="100px" class="ml-2 mr-2"></a>
	   			</div>
	   			<div class="book-info-in-book-box pl-2">
	   				<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none"><div class="book-title-in-book-box"><c:choose><c:when test="${fn:length(book.title) > 20}">${fn:substring(book.title, 0, 21)}..</c:when><c:otherwise>${book.title}</c:otherwise></c:choose></div></a>
	   				<hr>
	   				<div class="book-author-in-book-box"><c:choose><c:when test="${fn:length(book.author) > 10}">${fn:substring(book.author, 0, 11)}..</c:when><c:otherwise>${book.author}</c:otherwise></c:choose>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:choose><c:when test="${fn:length(book.publisher) > 6}">${fn:substring(book.publisher, 0, 7)}..</c:when><c:otherwise>${book.publisher}</c:otherwise></c:choose>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${book.pubDate}</div>
	   				<hr>
	   				<div class="small"><c:choose><c:when test="${empty book.description}"><span class="font-italic text-secondary">책 설명이 없습니다.</span></c:when><c:otherwise>${fn:substring(book.description, 0, 95)}...</c:otherwise></c:choose></div>
	   			</div>
	   				<input class="check-one ml-2 mr-1" type="checkbox" value="${book.id}">
	   			<div class="api-in-book-box">
	  				<button class="add-cart-btn api-btn-in-book-box form-control btn btn-sm btn-info d-block" data-book-id="${book.id}">장바구니로</button>
	  				<form action="/order/create_order_view" method="get">
	  					<input type="text" class="d-none" name="bookId" value="${book.id}">
	  					<button type="submit" class="purchase-btn api-btn-in-book-box form-control btn btn-sm btn-secondary d-block">바로 구매</button>
	   				</form>
	   			</div>
	   		</div>	
   			
	  	</c:forEach>
	  	</div>
		</div>
		
		<c:choose>
		<c:when test="${not empty searchedBookList}">
		<div class="d-flex justify-content-center mt-3 mb-2">
		  	<ul class="pagination">
			    <c:if test="${pageMaker.prev}">
			        <li>
			            <a href="/book/searched_result_view${pageMaker.makeQuery(pageMaker.startPage - 1)}&searchKeyword=${searchKeyword}" class="a-tag-deco-prev-paging">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/book/searched_result_view${pageMaker.makeQuery(index)}&searchKeyword=${searchKeyword}" class="a-tag-deco-now-paging">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/book/searched_result_view${pageMaker.makeQuery(index)}&searchKeyword=${searchKeyword}" class="a-tag-deco-paging">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/book/searched_result_view${pageMaker.makeQuery(pageMaker.endPage + 1)}&searchKeyword=${searchKeyword}" class="a-tag-deco-next-paging">[다음]</a>
			        </li>
			    </c:if>   
			</ul>
		</div>
		</c:when>
		<c:otherwise>
			<h5 class="sign-up-text text-center pt-3">검색된 도서가 없습니다.</h5>
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
				return false;
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