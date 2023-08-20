<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>

    
<h4 class="normal-text text-center pt-4 pb-2">〃${book.title}〃</h4>

<div class="d-flex justify-content-center mt-2">
	<img src="${book.cover}" width="200px">
</div>				

<div class="text-center normal-text mt-2 w-100 h4">
	${book.author}
</div>

<div class="text-center normal-text mt-2 w-100 h5">
[ ${book.publisher} ]
</div>
<div class="text-center normal-text mt-2 w-100 h5">
${book.pubDate}
</div>
<div class="d-flex justify-content-center normal-text mt-3 w-100">
	<div class="w-50">${book.description}</div>
</div>	





<div class="d-flex justify-content-center normal-text mt-3 w-100 h4">
<div class="text-center">
	<c:if test="${book.priceStandard ne book.priceSales}"><del><span id="bookPriceStandard"><fmt:formatNumber value="${book.priceStandard}" pattern="#,###" />원</span></del><br></c:if><span id="bookPriceSales" class="h2"><fmt:formatNumber value="${book.priceSales}" pattern="#,###" />원</span>
</div>
</div>	
<div class="text-center">
<a href="#" id="countUpBtn"><img src="/static/img/upArrow.png" alt="수량 증가 버튼" width="40px"></a><input type="text" class="book-count-in-book-detail" id="bookCount" value="1" readOnly><a href="#" id="countDownBtn"><img src="/static/img/downArrow.png" alt="수량 감소 버튼" width="40px"></a>
</div>




<div class="d-flex justify-content-center pb-3 mt-3">
			<input type="button" id="addCartBtn" class="btn btn-info" value="장바구니 담기" data-book-id="${book.id}">
	<form action="/order/create_order_view" method="get">
			<input type="text" id="bookId" name="bookId" class="d-none">
			<input type="text" id="bookCountForOrder" name="bookCount" class="d-none">			
			<input type="submit" id="orderBtn" class="btn btn-secondary ml-3" value="바로 구매하기" data-book-id="${book.id}">
	</form>
	
</div>
<div class="d-flex justify-content-center pt-4 pb-5">
<input type="button" id="previousBtn" class="previous-btn btn btn-dark" value="이전으로">
</div>

<script>


	



	
$(document).ready(function() {
	
	$('#countUpBtn').on('click', function(e) {
		e.preventDefault();
		
		let originalCount = parseInt($('#bookCount').val());
		
		
		
		if (originalCount < 9) {
			$('#bookCount').val(originalCount + 1);
		} else {
			alert("10권 이상 구매는 고객센터로 문의해주세요.");
		}
		$('#bookPriceStandard').text(parseInt(${book.priceStandard}) * $('#bookCount').val() + "원");
		$('#bookPriceSales').text(parseInt(${book.priceSales}) * $('#bookCount').val() + "원");
	});
	
	$('#countDownBtn').on('click', function(e) {
		e.preventDefault();
		
		let originalCount = parseInt($('#bookCount').val());
		
		if (originalCount > 1) {
			$('#bookCount').val(originalCount - 1);
		}
		$('#bookPriceStandard').text(parseInt(${book.priceStandard}) * $('#bookCount').val() + "원");
		$('#bookPriceSales').text(parseInt(${book.priceSales}) * $('#bookCount').val() + "원");
	});
	
	
	$('#addCartBtn').on('click', function() {
			
		if(${empty userId}) {
			alert("로그인이 필요합니다.");
			return;
		}
		
		let bookId = $(this).data('book-id').toString();
		
		let bookCount = $('#bookCount').val();
		
		console.log(bookCount);
		
		
		$.ajax({
			type: "post"
			, url: "/cart/add"
			, data: { "bookId": bookId, "bookCount": bookCount }			
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
	
	$('#orderBtn').on('click', function() {
		
		let result = confirm("주문 및 결제 페이지로 이동합니다.");
		if (!result) {
			return false;
		}
		
		let bookCount = $('#bookCount').val();
		
		$('#bookCountForOrder').val(bookCount);
		
		let bookId = $(this).data('book-id').toString();
		$('#bookId').val(bookId);
		
		
	});
	

	$('#previousBtn').on('click', function(){
		history.back();
	});
	
	

	
	
	
				
});
</script>		