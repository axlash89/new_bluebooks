<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<div>
   	<div class="h3 normal-text text-center pt-4 pb-2">장바구니</div>
</div>
<h5 class="normal-text text-right mb-2 mt-4 mr-2">총 상품금액 5만원 이상 주문 시 배송비 무료</h5>
<table class="table cart-table">
	<thead class="board-head">
		<tr>
			<th><c:if test="${not empty cartViewList}"><input type="checkbox" id="checkAll"></c:if></th>
			<th></th>
			<th class="book-info-in-table">상품정보</th>
			<th class="book-count-in-table">수량</th>
			<th class="book-price-in-table">금액</th>
			<th class="book-delivery-in-table">배송</th>
			<th></th>
		</tr>	
	</thead>
	<tbody class="board-body">
		<c:forEach items="${cartViewList}" var="cartView">
			<tr>
				<td class="price-parent"><input type="checkbox" class="check-one" value="${cartView.book.id}"><input type="text" value="${cartView.book.priceSales}" class="price d-none"></td>
				<td><a href="/book/book_detail_view?bookId=${cartView.book.id}" class="ml-2"><img src="${cartView.book.cover}"></a></td>
				<td><a href="/book/book_detail_view?bookId=${cartView.book.id}" class="a-tag-deco-none-category">${cartView.book.title}</a></td>
				<td class="changing-price-parent text-center"><a href="#" class="count-up-btn" data-book-id="${cartView.book.id}"><img src="/static/img/upArrow.png" alt="수량 증가 버튼" width="40px"></a><input type="text" class="book-count text-center w-25 text-dark" value="${cartView.cart.bookCount}" readOnly><a href="#" class="count-down-btn" data-book-id="${cartView.book.id}"><img src="/static/img/downArrow.png" alt="수량 감소 버튼" width="40px"></a><input type="text" value="${cartView.book.priceSales * cartView.cart.bookCount}" class="changing-price d-none"></td>
				<td class="text-center normal-text"><c:if test="${cartView.book.priceStandard ne cartView.book.priceSales}"><del><fmt:formatNumber value="${cartView.book.priceStandard * cartView.cart.bookCount}" pattern="#,###" />원</del><br></c:if><fmt:formatNumber value="${cartView.book.priceSales * cartView.cart.bookCount}" pattern="#,###" />원</td>
				<td class="text-center normal-text">내일<br>도착</td>
				<td><input type="button" class="cart-del-btn btn btn-sm btn-info" value="삭제" data-book-id="${cartView.book.id}"></td>
			</tr>
			<c:set var="totalPrice" value="${totalPrice + cartView.book.priceSales}" />
		</c:forEach>
	</tbody>
</table>
<c:choose>
<c:when test="${empty cartViewList}">
	<div class="text-center h5 normal-text">장바구니가 비어있습니다.</div>
<div class="d-flex justify-content-center pb-3">
	<input type="button" class="previous-btn btn-secondary ml-5 mt-3" value="이전으로">
</div>
</c:when>
<c:otherwise>
<div class="d-flex justify-content-between h5 px-5">
<div>
	<div>
		<div class="normal-text">총 상품 금액은<br><input type="text" id="totalPrice" class="cart-list-calculate" readOnly>원,</div>
		<div class="normal-text mt-2">배송비는<br><input type="text" id="deliveryFee" class="cart-list-calculate"  readOnly>원,</div>
		<div class="normal-text mt-2 mb-3">최종 결제금액은<br><input type="text" id="finalPrice" class="cart-list-calculate"  readOnly value="">원 입니다.</div>
	</div>
	
</div>	
	<div class="d-flex">
		<form action="/order/create_order_view" method="get">
		        <input type="text" id="sendBookIdString" name="bookIdString" class="d-none">
		        <input type="text" id="sendFinalPrice" name="finalPrice" class="d-none">
		<div class="normal-text text-right mb-4">현재 사용가능 포인트 : <fmt:formatNumber value="${userPoint}" pattern="#,###" />원</div>
		<input type="submit" id="orderBtn" class="btn btn-info cart-list-order-btn" value="주문하기">
		<input type="button" class="previous-btn btn btn-secondary cart-list-previous-btn" value="이전으로">
		</form>
	</div>
</div>
<div>		
		
	</div>
</c:otherwise>
</c:choose>


<script>
$(document).ready(function() {
	
	$('#checkAll').on('change', function() {
		
		$('#usedPoint').val(0);
		
		if ($('#checkAll').is(':checked')) {
			$('.check-one').prop('checked', true);
			
			let checkArrChange = [];
			$(".check-one:checked").each(function() {
				checkArrChange.push(parseInt($(this).parent().siblings('.changing-price-parent').children('.changing-price').val()));
			});
			
			add = function(checkArrChange) {
			    return checkArrChange.reduce((a, b) => a + b, 0);
			};	 
			
			let changeTotalSum = add(checkArrChange);
			
			$('#totalPrice').val(changeTotalSum);
			
			if($('#totalPrice').val() >= 50000) {
				$('#deliveryFee').val(0);
				$('#finalPrice').val(changeTotalSum);
			} else {
				$('#deliveryFee').val(2500);
				$('#finalPrice').val(changeTotalSum + 2500);
			}
		} else {
			$('.check-one').prop('checked', false);
			$('#totalPrice').val(0);
			$('#deliveryFee').val(0);
			$('#finalPrice').val(0);
		}
	});

	$('#checkAll').click();	
	
	
	$(".check-one").on('change', function() {
		
		$('#usedPoint').val(0);
		
		var total = $(".check-one").length;
		var checked = $(".check-one:checked").length;
		
		if(total != checked) {
			$("#checkAll").prop("checked", false);
			let checkArrChange = [];
			$(".check-one:checked").each(function() {
				checkArrChange.push(parseInt($(this).parent().siblings('.changing-price-parent').children('.changing-price').val()));
			});
			
			add = function(checkArrChange) {
			    return checkArrChange.reduce((a, b) => a + b, 0);
			};	 
			let changeSum = add(checkArrChange);
			$('#totalPrice').val(changeSum);
			if (checked != 0) {
				if($('#totalPrice').val() >= 50000) {
					$('#deliveryFee').val(0);
					$('#finalPrice').val(changeSum);
				} else {
					$('#deliveryFee').val(2500);
					$('#finalPrice').val(changeSum + 2500);
				}
			} else {
				$('#finalPrice').val(0);
				$('#deliveryFee').val(0);
			}
		} else {
			$("#checkAll").prop("checked", true); 
			
			
			let checkArrChange = [];
			$(".check-one:checked").each(function() {
				checkArrChange.push(parseInt($(this).parent().siblings('.changing-price-parent').children('.changing-price').val()));
			});
			
			add = function(checkArrChange) {
			    return checkArrChange.reduce((a, b) => a + b, 0);
			};	 
			
			let changeTotalSum = add(checkArrChange);
			
			$('#totalPrice').val(changeTotalSum);
			if($('#totalPrice').val() >= 50000) {
				$('#deliveryFee').val(0);
				$('#finalPrice').val(changeTotalSum);
			} else {
				$('#deliveryFee').val(2500);
				$('#finalPrice').val(changeTotalSum + 2500);
			}
			
		}
	});
	
	
	
	$('.count-up-btn').on('click', function(e) {
		e.preventDefault();
		
		if ($(this).parent().siblings('.price-parent').children('.check-one').prop('checked') == false) {
			$(this).parent().siblings('.price-parent').children('.check-one').click();
		}
		
		let cnt = parseInt($(this).siblings('input').val());
				
		if(cnt > 8) {
			alert("10권 이상의 대량 구매는 고객센터로 문의해주세요.")
			return;
		}
				
		cnt = cnt + 1;
		$(this).siblings('input').val(cnt);
		const originalPrice = $(this).parent().siblings('.price-parent').children('.price').val();
		let changingPrice = originalPrice * cnt;
		$(this).siblings('.changing-price').val(changingPrice);
		console.log(changingPrice);
		
		
		let checkArrChange = [];
		$(".check-one:checked").each(function() {
			checkArrChange.push(parseInt($(this).parent().siblings('.changing-price-parent').children('.changing-price').val()));
		});
		
		add = function(checkArrChange) {
		    return checkArrChange.reduce((a, b) => a + b, 0);
		};	 
		
		let changeTotalSum = add(checkArrChange);
		
		$('#totalPrice').val(changeTotalSum);
		
		var total = $(".check-one").length;
		if(total != 0) {
			if($('#totalPrice').val() >= 50000) {
				$('#deliveryFee').val(0);
				$('#finalPrice').val(changeTotalSum);
			} else {
				$('#deliveryFee').val(2500);
				$('#finalPrice').val(changeTotalSum + 2500);
			}
		} else {
			$('#finalPrice').val(0);
			$('#deliveryFee').val(0);
		}
		
		let bookId = $(this).data('book-id');
		let bookCount = $(this).siblings('.book-count').val();
		
		$.ajax({
			
			type: "post"
			, url: "/cart/count_update"
			, data: { "bookId": bookId, "bookCount": bookCount }				
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("수량 업데이트 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
	});
	
	$('.count-down-btn').on('click', function(e) {
		e.preventDefault();
		
		if ($(this).parent().siblings('.price-parent').children('.check-one').prop('checked') == false) {
			$(this).parent().siblings('.price-parent').children('.check-one').click();
		}
		
		let cnt = parseInt($(this).siblings('input').val());
		
		if(cnt == 1) {
			return;
		}
		
		cnt = cnt - 1;
		$(this).siblings('input').val(cnt);
		const originalPrice = $(this).parent().siblings('.price-parent').children('.price').val();
		let changingPrice = originalPrice * cnt;
		$(this).siblings('.changing-price').val(changingPrice);
		console.log(changingPrice);		
		
		
		let checkArrChange = [];
		$(".check-one:checked").each(function() {
			checkArrChange.push(parseInt($(this).parent().siblings('.changing-price-parent').children('.changing-price').val()));
		});
		
		add = function(checkArrChange) {
		    return checkArrChange.reduce((a, b) => a + b, 0);
		};	 
		
		let changeTotalSum = add(checkArrChange);
		
		$('#totalPrice').val(changeTotalSum);
		
		var total = $(".check-one").length;
		if(total != 0) {
			if($('#totalPrice').val() >= 50000) {
				$('#deliveryFee').val(0);
				$('#finalPrice').val(changeTotalSum);
			} else {
				$('#deliveryFee').val(2500);
				$('#finalPrice').val(changeTotalSum + 2500);
			}
		} else {
			$('#deliveryFee').val(0);
			$('#finalPrice').val(0);
		}
		
		

		let bookId = $(this).data('book-id');
		let bookCount = $(this).siblings('.book-count').val();
		
		$.ajax({
			
			type: "post"
			, url: "/cart/count_update"
			, data: { "bookId": bookId, "bookCount": bookCount }				
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("수량 업데이트 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
	});
	
	$('.previous-btn').on('click', function() {
		history.back();
	});
	
	
	$('.cart-del-btn').on('click', function() {
		
		if ($('#checkAll').is(':checked')) {
			let result = confirm("체크된 모든 상품을 삭제하여 장바구니를 비웁니다.\n계속 하시겠습니까?");
			if (!result) {
				return;
			}
		} else {
			let result = confirm("체크된 상품(삭제 버튼 클릭한 상품 포함)을 삭제합니다.\n계속 하시겠습니까?");
			if (!result) {
				return;
			}
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
			, url: "/cart/delete"
			, traditional: true
			, data: { bookIdArr: checkArr }				
			, success: function(data) {
				if (data.code == 1) {
					location.reload();
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("장바구니에서 삭제 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	
	$('#orderBtn').on('click', function() {
		
		let checkedBoxCount = $(".check-one:checked").length;
		
		if(checkedBoxCount == 0) {
			alert("선택하신 상품이 없습니다.");
			return false;
		}
		
		
		let result = confirm("주문 및 결제 페이지로 이동합니다.");
		if (!result) {
			return false;
		}
		
		var bookIdString = "";
		$(".check-one:checked").each(function() {
			bookIdString = bookIdString + $(this).val()+ "@";
		});
		
		bookIdString = bookIdString.toString();		
		bookIdString = bookIdString.slice(0, bookIdString.length - 1);
		
		let finalPrice = $('#finalPrice').val();
		
		$('#sendBookIdString').val(bookIdString);
		$('#sendFinalPrice').val(finalPrice);
		
	});
	
});
</script>