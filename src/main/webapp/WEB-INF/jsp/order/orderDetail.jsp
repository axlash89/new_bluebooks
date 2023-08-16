<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h3 class="text-center">주문 상세정보</h3>
<table class="table">
	
	<tr>
		<th>주문자</th>
		<td>${orderView.user.name}</td>	
		<th>주문자 연락처</th>
		<td>${orderView.user.phoneNumber}</td>
		
	</tr>
	<tr>
		<th>주문한 책</th>
		<td>
			<c:forEach items="${orderView.bookList}" var="book">
				${book.title}<br>
			</c:forEach>			
		</td>	
		<td>
			<c:forEach items="${orderView.orderedBooksList}" var="book">
				${book.bookCount}권<br>
			</c:forEach>	
		</td>
	</tr>
	<tr>
		<th>최종 결제금액</th>
		<td>${orderView.order.finalPrice}원</td>
		<th>결제수단</th>
		<td>${orderView.order.payBy}</td>
	</tr>
	<tr>
		<th>상태</th>
		<td>${orderView.order.status}</td>
	</tr>
	<tr>
		<th>수령인 이름</th>
		<td>${orderView.order.recipientName}</td>
		<th>수령 주소</th>
		<td>${orderView.order.recipientAddress}</td>
	</tr>
	<tr>
		<th>수령인 연락처</th>
		<td>${orderView.order.recipientPhoneNumber}</td>
	</tr>	
</table>

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