<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <h3>책 상세정보</h3>
<table class="table">
	<thead>
		<tr>
			<th>상품정보</th>
			<th>수량</th>
			<th>상품금액</th>
			<th></th>
		</tr>	
	</thead>
	<tbody>
			<tr>
				
				<td><img src="${book.cover}">${book.title}</td>
				<td><input type="text" class="book-count" value="1" readOnly><a href="#" class="count-up-btn btn btn-secondary">▲</a><a href="#" class="count-down-btn btn btn-secondary">▼</a></td>
				<td><del><span>${book.priceStandard}</span></del><br>${book.priceSales}</td>
				<td>내일 도착 예정</td>
				<td><input type="button" class="cart-del-btn btn btn-sm btn-info" value="삭제" data-book-id="${cartView.book.id}"></td>
			</tr>
	</tbody>
</table>

<div class="d-flex justify-content-center pb-3">
	        <input type="text" id="bookId" name="bookId" class="d-none">
			<input type="button" id="addCartBtn" class="btn btn-info" value="장바구니 담기" data-book-id="${book.id}">
	<form action="/order/create_order_view" method="get">
	        <input type="text" id="sendBookId" name="bookId" class="d-none">
			<input type="submit" id="orderBtn" class="btn btn-info" value="바로 구매하기">
	</form>
	<input type="button" class="previous-btn btn btn-secondary ml-5" value="이전으로">
</div>


<script>
$(document).ready(function() {
	
	$('.add-cart-btn').on('click', function() {
			
		if(${empty userId}) {
			alert("로그인이 필요합니다.");
			return;
		}
		
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
		
				
});
</script>		