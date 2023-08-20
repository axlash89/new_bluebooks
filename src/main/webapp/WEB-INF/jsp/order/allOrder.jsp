<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
	<div class="my-page-contents">
    	<div>
	    	<div class="d-flex justify-content-center h3 normal-text text-center pt-3 pb-4">주문내역 관리</div>
	    	
 		<c:choose>
    		<c:when test="${periodText == 'week'}">
    			<div class="h5 text-center normal-text">최근 일주일간의 주문 내역입니다.</div>
    		</c:when>
    		<c:when test="${periodText == 'oneMonth'}">
    			<div class="h5 text-center normal-text">최근 한달 간의 주문 내역입니다.</div>
    		</c:when>
    		<c:when test="${periodText == 'threeMonths'}">
    			<div class="h5 text-center normal-text">최근 3개월 간의 주문 내역입니다.</div>
    		</c:when>
    		<c:otherwise>
    			<div class="h5 text-center normal-text">전체 주문 내역입니다.</div>
    		</c:otherwise>
    	</c:choose>
    	
    		<div class="d-flex justify-content-between mt-4">
	    		<form action="/admin/admin_view" method="get" class="d-flex">
					<div class="d-flex">
						<select id="searchCondition">
			    			<option id="byLoginId" selected>아이디</option>
			    			<option id="byTitle">책 제목</option>
			    		</select>
						<div class="d-flex mb-2">
							<input type="text" id="type" name="type" value="byLoginId" class="d-none">
							<input type="text" id="orderSearchBox" class="form-control" name="searchKeyword" placeholder="아이디로 전체 검색">
					   		<input type="submit" id="orderSearchBtn" class="btn btn-secondary" value="검색">
				   		</div>
			   		</div>
				</form>
		    	<div><a href="/admin/admin_view?period=week" class="btn btn-info">최근 1주일</a><a href="/admin/admin_view?period=oneMonth" class="btn btn-info ml-1">1개월</a><a href="/admin/admin_view?period=threeMonths" class="btn btn-info ml-1">3개월</a><a href="/admin/admin_view" class="btn btn-primary ml-1">전체</a></div>
	    	</div>
    	</div>
    	
		
		
    	
    	<table class="table text-center">
    		<thead class="order-list-board-head">
    			<tr>
   					<th>주문번호</th>
   					<th>아이디</th>
    				<th>상품정보</th>
    				<th>권수</th>
    				<th>결제금액</th>
    				<th>주문상세</th>
    				<th>상태</th>
    				<th><input type="checkbox" id="checkAll" class="d-none"></th>
    				<th>처리</th>
    			</tr>
    		</thead>
    		<tbody class="order-list-board-body">
    			<c:forEach items="${orderViewList}" var="orderView">
		    			<tr>
		    				<td>${orderView.order.id}</td>
		    				<td>${orderView.user.loginId}</td>
		    				<td>
			    				<c:forEach items="${orderView.bookList}" var="book">
			    					<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none-board">${fn:substring(book.title,0,8)}..</a><br>
			    				</c:forEach>
		    				</td>
		    				<td>
								<c:forEach items="${orderView.orderedBooksList}" var="orderedBooks">
			    					${orderedBooks.bookCount}<br>
			    				</c:forEach>
							</td>
		    				<td>${orderView.order.finalPrice}</td>
		    				<td><a href="/admin/order_detail_view?orderId=${orderView.order.id}">더보기</a></td>
		    				<td>
		    					<c:choose>
		    					<c:when test="${orderView.order.status eq '결제완료'}">
			    					<select class="statusData" data-order-id="${orderView.order.id}">
			    						<option value="paid" selected>결제완료</option>
			    						<option value="delivering">배송중</option>
			    					</select>
		    					</c:when>
		    					<c:otherwise>
			    					<select class="statusData" data-order-id="${orderView.order.id}">
			    						<option value="paid">결제완료</option>
			    						<option value="delivering" selected>배송중</option>
			    					</select>
		    					</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<td><c:if test="${orderView.order.status eq '결제완료'}"><input type="checkbox" class="check-one" value="${orderView.order.id}"></c:if></td>
		    				<td><c:if test="${orderView.order.status eq '결제완료'}"><button class="send" class="btn btn-sm btn-secondary" data-order-id="${orderView.order.id}">배송</button></c:if></td>
		    			</tr>
		    			<c:if test="${orderView.order.status eq '결제완료'}"><script>$('#checkAll').removeClass('d-none');</script></c:if>
	    			</c:forEach>
    		</tbody>
    	</table>
    	
    </div>
    
    
    <c:choose>
	    <c:when test="${empty period && empty searchKeyword}">
		    <div class="d-flex justify-content-center">
			  	<ul class="pagination">
				    <c:if test="${pageMaker.prev}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.startPage - 1)}" class="mr-2 text-dark">[이전]</a>
				        </li>		         
				    </c:if>
				 
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
				    	<c:choose>
				    	<c:when test="${nowPage eq index}">
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}" class="text-danger">[${index}]</a>
				        </c:when>
				        <c:otherwise>
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}">[${index}]</a>
				        </c:otherwise>
				        </c:choose>
				    </c:forEach>
				 
				    <c:if test="${pageMaker.next}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.endPage + 1)}" class="ml-2 text-dark">[다음]</a>
				        </li>
				    </c:if>   
				</ul>
			</div>
		</c:when>
		<c:when test="${empty period && not empty searchKeyword}">
			<div class="d-flex justify-content-center">
			  	<ul class="pagination">
				    <c:if test="${pageMaker.prev}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.startPage - 1)}${type}${searchKeyword}" class="mr-2 text-dark">[이전]</a>
				        </li>		         
				    </c:if>
				 
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
				    	<c:choose>
				    	<c:when test="${nowPage eq index}">
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${type}${searchKeyword}" class="text-danger">[${index}]</a>
				        </c:when>
				        <c:otherwise>
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${type}${searchKeyword}">[${index}]</a>
				        </c:otherwise>
				        </c:choose>
				    </c:forEach>
				 
				    <c:if test="${pageMaker.next}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.endPage + 1)}${type}${searchKeyword}" class="ml-2 text-dark">[다음]</a>
				        </li>
				    </c:if>   
				</ul>
			</div>
		</c:when>
		<c:when test="${not empty period && empty searchKeyword}">
			<div class="d-flex justify-content-center">
			  	<ul class="pagination">
				    <c:if test="${pageMaker.prev}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.startPage - 1)}${period}" class="mr-2 text-dark">[이전]</a>
				        </li>		         
				    </c:if>
				 
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
				    	<c:choose>
				    	<c:when test="${nowPage eq index}">
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${period}" class="text-danger">[${index}]</a>
				        </c:when>
				        <c:otherwise>
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${period}">[${index}]</a>
				        </c:otherwise>
				        </c:choose>
				    </c:forEach>
				 
				    <c:if test="${pageMaker.next}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.endPage + 1)}${period}" class="ml-2 text-dark">[다음]</a>
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
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.startPage - 1)}${type}${searchKeyword}${period}" class="mr-2 text-dark">[이전]</a>
				        </li>		         
				    </c:if>
				 
				    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
				    	<c:choose>
				    	<c:when test="${nowPage eq index}">
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${type}${searchKeyword}${period}" class="text-danger">[${index}]</a>
				        </c:when>
				        <c:otherwise>
				        <a href="/admin/admin_view${pageMaker.makeQuery(index)}${type}${searchKeyword}${period}">[${index}]</a>
				        </c:otherwise>
				        </c:choose>
				    </c:forEach>
				 
				    <c:if test="${pageMaker.next}">
				        <li>
				            <a href="/admin/admin_view${pageMaker.makeQuery(pageMaker.endPage + 1)}${type}${searchKeyword}${period}" class="ml-2 text-dark">[다음]</a>
				        </li>
				    </c:if>   
				</ul>
			</div>
		</c:otherwise>		
		</c:choose>
		
		<c:if test="${not empty searchKeyword}">
			<div class="d-flex justify-content-center">
				<a href="/admin/admin_view" class="btn btn-secondary">전체 목록으로</a>
			</div>
		</c:if>
		
<script>
$(document).ready(function() {
	
	
	$('#searchCondition').on('change', function(){
		if ($('#searchCondition').val() == '아이디') {
			$('#type').val('byLoginId');
			$('#orderSearchBox').attr('placeholder', '아이디로 전체 검색');
		} else {
			$('#type').val('byTitle');
			$('#orderSearchBox').attr('placeholder', '책 제목으로 전체 검색');
		}
	});
	
	$('#orderSearchBtn').on('click', function() {
		let keyword = $('#orderSearchBox').val().trim();
		if (!keyword) {
			alert("검색어를 입력하세요.")
			return false;			
		}				
	})
		
	
	$('.statusData').on('change', function(){
		
		let orderId = $(this).data('order-id').toString();
		
		let status = $(this).find(':selected').val();
		
		if (status == 'paid') {
			status = '결제완료';
		} else {
			status = '배송중';
		}
				
		$.ajax({
			type: "post"
			, url: "/admin/order_status_change"
			, data: { "orderId": orderId, "status": status }		
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("배송처리 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
	});
	
	
	$('#checkAll').on('change', function() {
		
		if ($('#checkAll').is(':checked')) {
			$('.check-one').prop('checked', true);
		} else {
			$('.check-one').prop('checked', false);
		}
		
	});
	
	
	$(".check-one").on('change', function() {
		var total = $(".check-one").length;
		var checked = $(".check-one:checked").length;
		
		if(total != checked) {
			$("#checkAll").prop("checked", false);
		} else {
			$("#checkAll").prop("checked", true); 			
		}
	});	
	
	
	
	$('.send').on('click', function(){
		
		var checkArr = [];
		$(".check-one:checked").each(function() {
			checkArr.push($(this).val());
		});
			
		let orderId = $(this).data('order-id').toString();			
		
		if(checkArr.includes(orderId) == false) {
			checkArr.push(orderId);				
		}
		
		let result = confirm("선택된 주문을 배송처리 하시겠습니까?");
		if (!result) {
			return false;
		}
		
		$.ajax({
			type: "post"
			, url: "/admin/order_status_delivering"
			, traditional: true
			, data: { orderIdArr: checkArr }			
			, success: function(data) {
				if (data.code == 1) {
					location.reload(true);					
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("배송처리 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
	});
	
	
});
</script>   				