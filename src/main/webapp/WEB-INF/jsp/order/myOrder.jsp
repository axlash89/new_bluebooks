<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
	    
	    <div class="my-page-contents">
	    	<div>
		    	<div class="d-flex justify-content-center h4 normal-text mt-4">${userName}(${userLoginId})님</div>
		    	<div class="d-flex justify-content-center h5 normal-text">( 잔여 포인트 : ${userPoint}원 )</div>
		    	<c:choose>
		    		<c:when test="${periodText == 'week'}">
		    			<div class="h4 text-center normal-text mt-4">최근 일주일간의 주문 내역입니다.</div>
		    		</c:when>
		    		<c:when test="${periodText == 'oneMonth'}">
		    			<div class="h4 text-center normal-text mt-4">최근 한달 간의 주문 내역입니다.</div>
		    		</c:when>
		    		<c:when test="${periodText == 'threeMonths'}">
		    			<div class="h4 text-center normal-text mt-4">최근 3개월 간의 주문 내역입니다.</div>
		    		</c:when>
		    		<c:otherwise>
		    			<div class="h4 text-center normal-text mt-4">회원님의 전체 주문 내역입니다.</div>
		    		</c:otherwise>
		    	</c:choose>
		    	<div class="d-flex justify-content-end mt-3">
		    		<div><a href="/order/my_order_view?period=week" class="btn btn-info">최근 1주일</a><a href="/order/my_order_view?period=oneMonth" class="btn btn-info ml-1">1개월</a><a href="/order/my_order_view?period=threeMonths" class="btn btn-info ml-1">3개월</a><a href="/order/my_order_view" class="btn btn-primary ml-1">전체</a></div>
		    	</div>
	    	</div>
	    	
	    	<table class="table text-center mt-1">
	    		<thead class="board-head">
	    			<tr>
	    				<th>주문번호</th>
	    				<th>상품 정보</th>
	    				<th>수량</th>
	    				<th>결제금액</th>
	    				<th>주문상세</th>
	    				<th>배송정보</th>
	    			</tr>
	    		</thead>
	    		<tbody class="board-body">
	    			<c:forEach items="${orderViewList}" var="orderView">
		    			<tr>
		    				<td>${orderView.order.id}</td>
		    				<td>
			    				<c:forEach items="${orderView.bookList}" var="book">
			    					<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none-board">${fn:substring(book.title,0,20)}..</a><br>
			    				</c:forEach>
		    				</td>
		    				<td>
								<c:forEach items="${orderView.orderedBooksList}" var="orderedBooks">
			    					${orderedBooks.bookCount}권<br>
			    				</c:forEach>
							</td>
		    				<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderView.order.finalPrice}"/>원</td>
		    				<td>
		    					<form action="/order/my_order_more_detail" method="get">
		    						<input type="text" name="userId" class="d-none" value="${orderView.order.userId}">
		    						<input type="text" name="orderId" class="d-none" value="${orderView.order.id}">
		    						<input type="submit" value="더보기" class="btn btn-sm btn-secondary">
		    					</form>
		    				</td>
		    				<td class="font-weight-bold">${orderView.order.status}</td>
		    			</tr>
	    			</c:forEach>
	    		</tbody>
	    	</table>
	    	
	    </div>
	    <c:if test="${empty orderViewList}">
	    <div class="h5 text-center pt-3 pb-3 normal-text">주문하신 내역이 없습니다.</div>
	    </c:if>
	    
	    <c:choose>
	    <c:when test="${empty period}">
	    
	    <div class="d-flex justify-content-center">
		  	<ul class="pagination">
			    <c:if test="${pageMaker.prev}">
			        <li>
			            <a href="/order/my_order_view${pageMaker.makeQuery(pageMaker.startPage - 1)}" class="mr-2 text-dark">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/order/my_order_view${pageMaker.makeQuery(index)}" class="text-danger">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/order/my_order_view${pageMaker.makeQuery(index)}">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/order/my_order_view${pageMaker.makeQuery(pageMaker.endPage + 1)}" class="ml-2 text-dark">[다음]</a>
			        </li>
			    </c:if>   
			</ul>
		</div>
		
		</c:when>
		<c:otherwise>
	
		<div class="d-flex justify-content-center">
		  	<ul class="pagination">
			    <c:if test="${pageMaker.prev}">
			        <li>
			            <a href="/order/my_order_view${pageMaker.makeQuery(pageMaker.startPage - 1)}${period}" class="mr-2 text-dark">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/order/my_order_view${pageMaker.makeQuery(index)}${period}" class="text-danger">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/order/my_order_view${pageMaker.makeQuery(index)}${period}">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/order/my_order_view${pageMaker.makeQuery(pageMaker.endPage + 1)}${period}" class="ml-2 text-dark">[다음]</a>
			        </li>
			    </c:if>   
			</ul>
		</div>
		
		</c:otherwise>
		
		</c:choose>