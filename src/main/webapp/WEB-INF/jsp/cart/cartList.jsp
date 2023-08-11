<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>장바구니</h3>

<table class="table">
	<thead>
		<th><input type="checkbox"></th>
		<th>상품정보</th>
		<th>수량</th>
		<th>상품금액</th>
		<th>배송정보</th>
		<th></th>
	</thead>
	<tbody>
	<c:forEach items="${cartViewList}" var="cartView">
	<tr>
		<td><input type="checkbox" checked></td>
		<td><img src="${cartView.book.cover}">${cartView.book.title}</td>
		<td><input type="text"></td>
		<td><strike>${cartView.book.priceStandard}</strike>${cartView.book.priceSales}</td>
		<td>내일 도착 예정</td>
		<td><input type="button" class="btn btn-sm btn-info" value="삭제"></td>
	</tr>
	</c:forEach>	
	</tbody>	
</table>

	<div>
		<div>총 상품 금액</div>
		<div>배송비 2,500원</div>
		<div>최종 결제금액 </div>
		<div>사용할 포인트 입력<input type="text"></div>
	</div>


<script>

</script>