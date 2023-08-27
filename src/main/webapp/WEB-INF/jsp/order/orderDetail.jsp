<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>

<h4 class="text-center normal-text pt-3 pb-1">주문 상세정보</h4>
<h5 class="text-center normal-text pt-1 pb-2">(주문번호 ${orderView.order.id}번)</h5>


<table class="table">
	<tr>
		<th class="normal-text">주문자 ID</th>
		<td>${orderView.user.loginId}</td>	
		<th class="normal-text">주문자 이름</th>
		<td>${orderView.user.name}</td>	
	</tr>
	<tr>
		<th class="normal-text">수령인</th>
		<td>${orderView.order.recipientName}</td>	
		<th class="normal-text">수령인 연락처</th>
		<td>${orderView.order.recipientPhoneNumber}</td>
	</tr>
	<tr>
		<th class="normal-text">주문한 책</th>
		<td>
			<c:forEach items="${orderView.bookList}" var="book">
				<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none-board">${fn:substring(book.title,0,20)}..</a><br>
			</c:forEach>			
		</td>	
		<td>
			<c:forEach items="${orderView.orderedBooksList}" var="book">
				${book.bookCount}권<br>
			</c:forEach>	
		</td>
	</tr>
	<tr>
		<th class="normal-text">최종 결제금액</th>
		<td>${orderView.order.finalPrice}원</td>
		<th class="normal-text">결제수단</th>
		<td>${payByEnum}</td>
	</tr>
	<tr>
		<th class="normal-text">사용 포인트</th>
		<td>${orderView.order.usedPoint}원</td>
		<th class="normal-text">현재 상태</th>
		<td>${orderView.order.status}</td>
	</tr>
</table>
<hr>	
<div class="text-center d-flex justify-content-around mb-5 pt-2">
<div class="normal-text">수령 주소</div> <div>${orderView.order.recipientAddress}</div>
</div>
<div class="d-flex justify-content-center">
	<button id="previousBtn" class="btn btn-dark">이전으로</button>
</div>

<script>
$(document).ready(function() {	
	
	$('#previousBtn').on('click', function() {
		history.back();
	});
	
});
</script>