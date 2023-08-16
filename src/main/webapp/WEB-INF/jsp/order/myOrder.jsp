<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	    
	    <div class="my-page-contents">
	    	<div>
		    	<div class="d-flex justify-content-center">${userName}님 안녕하세요!</div>
		    	<div class="d-flex justify-content-center">내 보유 포인트 : ${userPoint}원</div>
		    	<div class="d-flex justify-content-between mt-3">
		    		<div class="d-flex justify-content-center mt-3">내 주문내역</div><div><a href="/order/my_order_view?period=week" class="btn btn-info">최근 1주일</a><a href="/order/my_order_view?period=oneMonth" class="btn btn-info">1개월</a><a href="/order/my_order_view?period=threeMonths" class="btn btn-info">3개월</a><a href="/order/my_order_view" class="btn btn-primary">전체</a></div>
		    	</div>
	    	</div>
	    	
	    	<table class="table">
	    		<thead>
	    			<tr>
	    				<th>주문번호</th>
	    				<th>상품정보</th>
	    				<th>수량</th>
	    				<th>결제금액</th>
	    				<th>배송정보</th>
	    			</tr>
	    		</thead>
	    		<tbody>
	    			<c:forEach items="${orderViewList}" var="orderView">
		    			<tr>
		    				<td>${orderView.order.id}</td>
		    				<td>
			    				<c:forEach items="${orderView.bookList}" var="book">
			    				${fn:substring(book.title,0,15)}..<br>
			    				</c:forEach>
		    				</td>
		    				<td>
								<c:forEach items="${orderView.orderedBooksList}" var="orderedBooks">
			    					${orderedBooks.bookCount}<br>
			    				</c:forEach>
							</td>
		    				<td>${orderView.order.finalPrice}</td>
		    				<td>${orderView.order.status}</td>
		    			</tr>
	    			</c:forEach>
	    		</tbody>
	    	</table>
	    	
	    </div>
	    
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
	    
	    