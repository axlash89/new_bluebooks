<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<div>
	   	<div class="h3 d-flex justify-content-center mb-3">탈퇴한 회원 리스트</div>
	  	</div>	  	
	  	
  		<div>		
			<form action="/withdrawal/witndrawn_user_view" method="get">
				<div class="d-flex mb-2">
				<select id="searchCondition">
					<option id="byLoginId" selected>아이디</option>
					<option id="byReason">탈퇴 이유</option>
				</select>
					<input type="text" id="type" name="type" value="byLoginId" class="d-none">
					<input type="text" id="withdrawSearchBox" class="form-control" name="searchKeyword" placeholder="아이디를 입력하세요.">
			   		<input type="submit" id="withdrawSearchBtn" class="btn btn-secondary" value="검색">
		   		</div>
			</form>	 
		</div>
   		
   		
	  	<table class="table text-center">
	  		<thead>
	  			<tr>
	  				<th>회원번호</th>
	  				<th>아이디</th>
	  				<th>탈퇴 이유</th>
	  				<th>탈퇴일</th>
	  				<th>가입일</th>
	  			</tr>
	  		</thead>
	  		<tbody>
		   		<c:forEach items="${withdrawalList}" var="user">
		   			<tr>
		   				<td>${user.userId}</td>
		   				<td>${user.userLoginId}</td>
		   				<td>${user.reason}</td>
		   				<td>
							<fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
							<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy. M. d"/>
						</td>
		   				<td>
							<fmt:formatDate value="${user.userCreatedAt}" pattern="yyyy. M. d"/>
						</td>
		   			</tr>
	  			</c:forEach>
	  		</tbody>
	  	</table>
	  	<c:if test="${not empty emptyList}">
	  	<div class="d-flex justify-content-center">검색 결과가 없습니다.</div>
	  	</c:if>
	  	<c:choose>
	  	<c:when test="${empty searchKeyword}">
	  	<div class="d-flex justify-content-center">
		  	<ul class="pagination">
			    <c:if test="${pageMaker.prev}">
			        <li>
			            <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(pageMaker.startPage - 1)}" class="mr-2 text-dark">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(index)}" class="text-danger">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(index)}">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(pageMaker.endPage + 1)}" class="ml-2 text-dark">[다음]</a>
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
			            <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(pageMaker.startPage - 1)}${searchKeyword}" class="mr-2 text-dark">[이전]</a>
			        </li>		         
			    </c:if>
			 
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="index">
			    	<c:choose>
			    	<c:when test="${nowPage eq index}">
			        <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(index)}${searchKeyword}" class="text-danger">[${index}]</a>
			        </c:when>
			        <c:otherwise>
			        <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(index)}${searchKeyword}">[${index}]</a>
			        </c:otherwise>
			        </c:choose>
			    </c:forEach>
			 
			    <c:if test="${pageMaker.next}">
			        <li>
			            <a href="/withdrawal/witndrawn_user_view${pageMaker.makeQuery(pageMaker.endPage + 1)}${searchKeyword}" class="ml-2 text-dark">[다음]</a>
			        </li>
			    </c:if>   
			</ul>
		</div>
		</c:otherwise>
		</c:choose>
	  			
<script>
$(document).ready(function() {
	
	$('#searchCondition').on('change', function(){
		if ($('#searchCondition').val() == '아이디') {
			$('#type').val('byLoginId');
			$('#withdrawSearchBox').attr('placeholder', '아이디를 입력하세요.');
		} else {
			$('#type').val('byReason');
			$('#withdrawSearchBox').attr('placeholder', '탈퇴이유를 입력하세요.');
		}
	});
	
	$('#withdrawSearchBtn').on('click', function() {
		let keyword = $('#withdrawSearchBox').val().trim();
		if (!keyword) {
			alert("검색어를 입력하세요.")
			return false;			
		}				
	})
	
	
});
</script>   		