<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <h3>책 상세정보</h3>
<table class="table">
	<thead>
		<tr>
			<th>상품정보</th>
			<th>수량</th>
			<th>상품금액</th>
			<th>책 상세정보</th>
		</tr>	
	</thead>
	<tbody>
			<tr>				
				<td>${book.id}<img src="${book.cover}">${book.title}</td>
				<td><input type="text" id="bookCount" value="1" readOnly><a href="#" id="countUpBtn" class="btn btn-secondary">▲</a><a href="#" id="countDownBtn" class="btn btn-secondary">▼</a></td>
				<td><del><span id="bookPriceStandard">${book.priceStandard}</span></del><br><span id="bookPriceSales">${book.priceSales}</span></td>
				<td>${book.description}</td>
			</tr>
	</tbody>
</table>

<div class="d-flex justify-content-center pb-3">
			<input type="button" id="addCartBtn" class="btn btn-info" value="장바구니 담기" data-book-id="${book.id}">
	<form action="/order/create_order_view" method="get">
			<input type="text" id="bookId" name="bookId" class="d-none">
			<input type="text" id="bookCountForOrder" name="bookCount" class="d-none">			
			<input type="submit" id="orderBtn" class="btn btn-info" value="바로 구매하기" data-book-id="${book.id}">
	</form>
	<input type="button" id="previousBtn" class="previous-btn btn btn-secondary ml-5" value="이전으로">
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
		$('#bookPriceStandard').text(parseInt(${book.priceStandard}) * $('#bookCount').val());
		$('#bookPriceSales').text(parseInt(${book.priceSales}) * $('#bookCount').val());
	});
	
	$('#countDownBtn').on('click', function(e) {
		e.preventDefault();
		
		let originalCount = parseInt($('#bookCount').val());
		
		if (originalCount > 1) {
			$('#bookCount').val(originalCount - 1);
		}
		$('#bookPriceStandard').text(parseInt(${book.priceStandard}) * $('#bookCount').val());
		$('#bookPriceSales').text(parseInt(${book.priceSales}) * $('#bookCount').val());
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