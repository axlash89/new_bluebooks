<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<div>
	   	<div class="h3 d-flex normal-text justify-content-center pt-3 mb-4">회원 리스트</div>
	  	</div>
	  	
	  	<div class="d-flex justify-content-between"> 
	  		<c:choose>
	  			<c:when test="${not empty searchKeyword}">
	  			<div class="pt-2">검색어와 일치하는 회원 수 : ${userList.totalElements}</div>
	  			</c:when>
	  			<c:otherwise>
	  				<div class="pt-2 pl-2 normal-text">총 회원 수 : ${userList.totalElements - 1}</div>
	  			</c:otherwise>
	  		</c:choose>
	  		<div>		
				<form action="/admin/manage_user_view" method="get">
					<div class="d-flex mb-2">
						<input type="text" id="userSearchBox" class="form-control" name="searchKeyword" placeholder="아이디 또는 이름 입력">
				   		<input type="submit" id="userSearchBtn" class="btn btn-secondary" value="회원 검색">
			   		</div>
				</form>	 
			</div>   		
   		</div>
	  	<table class="table text-center">
	  		<thead class="board-head">
	  			<tr>
	  				<th>회원번호</th>
	  				<th>아이디</th>
	  				<th>이름</th>
	  				<th>전화번호</th>
	  				<th>가입일자</th>
	  				<th>상세보기</th>
	  			</tr>
	  		</thead>
	  		<tbody class="board-body">
		   		<c:forEach items="${userList.content}" var="user">
		   			<tr>
		   				<td>${user.id}</td>
		   				<td>${user.loginId}</td>
		   				<td>${user.name}</td>
		   				<td>${user.phoneNumber}</td>
		   				<td>
		   					<%-- ZonedDateTime -> Date -> String --%>
							<fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
							<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일"/>
						</td>
						<td><c:if test="${user.loginId ne 'admin'}"><a href="/admin/user_detail_view?userId=${user.id}" class="btn btn-sm btn-info">상세</a></c:if></td>
		   			</tr>
	  			</c:forEach>
	  		</tbody>
	  	</table>
	  	
	  	<c:if test="${not empty emptyList}">
	  	<div class="d-flex justify-content-center normal-text mb-3">검색 결과가 없습니다.</div>
	  	</c:if>
	  	<c:if test="${empty emptyList}">
	  	<div class="d-flex justify-content-between">
		  	<c:choose>
			  	<c:when test="${empty searchKeyword}">
			  		<c:choose>
				  		<c:when test="${nowPage ne 0}">
				  			<a href="/admin/manage_user_view?page=0">첫 페이지로</a>
				  		</c:when>
				  		<c:otherwise>
				  			<div>첫 페이지로</div>
				  		</c:otherwise>
					</c:choose>
					<c:choose>
				  		<c:when test="${nowPage eq userList.totalPages - 1}">
				  			<div>마지막 페이지로</div>	
				  		</c:when>
				  		<c:otherwise>
				  			<a href="/admin/manage_user_view?page=${userList.totalPages - 1}">마지막 페이지로</a>
				  		</c:otherwise>
					</c:choose>
			  	</c:when>
			  	<c:otherwise>
			  		<c:choose>
						<c:when test="${nowPage ne 0}">
				  			<a href="/admin/manage_user_view?page=${startPage}&searchKeyword=${searchKeyword}">첫 페이지로</a>
				  		</c:when>
				  		<c:otherwise>
							<div>첫 페이지로</div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${nowPage eq userList.totalPages - 1}">
							<div>마지막 페이지로</div>
						</c:when>
						<c:otherwise>
			   				<a href="/admin/manage_user_view?page=${endPage}&searchKeyword=${searchKeyword}" class="float-right">마지막 페이지로</a>
		   				</c:otherwise>
			   		</c:choose>
			  	</c:otherwise>
	   		</c:choose>
   		</div>
   		</c:if>
	  	<c:if test="${endPage eq 0}">
	   	<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_user_view?page=${nowPage - 1}">이전</a></li>	
	      		<li class="page-item disabled"><a class="page-link" href="/admin/manage_user_view?page=${cnt}">${cnt + 1}</a></li>
		    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_user_view?page=${nowPage + 1}">다음</a></li>	
		  </ul>
		</nav>
	  	</c:if>
	  	<c:if test="${endPage ne 0}">	 
	  	<nav aria-label="Page navigation example">
	  	<ul class="pagination justify-content-center">
	   	<c:choose>
	    	<c:when test="${nowPage eq 0}">
	    	<li class="page-item disabled">
	     			<a class="page-link" href="/admin/manage_user_view?page=${nowPage - 1}">이전</a>
     		</li>	
	    	</c:when>
	    	<c:otherwise>
	    	<li class="page-item">
   				<c:choose>
   				<c:when test="${not empty searchKeyword}">
     				<a class="page-link" href="/admin/manage_user_view?page=${nowPage - 1}&searchKeyword=${searchKeyword}">이전</a>
     			</c:when>
     			<c:otherwise>
     				<a class="page-link" href="/admin/manage_user_view?page=${nowPage - 1}">이전</a>
     			</c:otherwise>
     			</c:choose>
     		</li>	
	    	</c:otherwise>	
	    </c:choose>	
	    <c:choose>
	    <c:when test="${not empty searchKeyword}">
		    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
			    <c:choose>
			    	<c:when test="${cnt eq nowPage}">
			    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/admin/manage_user_view?page=${cnt}&searchKeyword=${searchKeyword}">${cnt + 1}</a></li>
			    	</c:when>
			    	<c:otherwise>
			    		<li class="page-item"><a class="page-link" href="/admin/manage_user_view?page=${cnt}&searchKeyword=${searchKeyword}">${cnt + 1}</a></li>
			    	</c:otherwise>	
			    </c:choose>	
		    </c:forEach>
	    </c:when>
	    <c:otherwise>
	    	<c:forEach begin="${startPage}" end="${endPage}" var="cnt">
			    <c:choose>
			    	<c:when test="${cnt eq nowPage}">
			    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/admin/manage_user_view?page=${cnt}">${cnt + 1}</a></li>
			    	</c:when>
			    	<c:otherwise>
			    		<li class="page-item"><a class="page-link" href="/admin/manage_user_view?page=${cnt}">${cnt + 1}</a></li>
			    	</c:otherwise>	
			    </c:choose>	
		    </c:forEach>
	    </c:otherwise>
	    </c:choose>			    
	   	<c:choose>
	    	<c:when test="${nowPage eq userList.totalPages - 1}">
		    	<li class="page-item disabled">
	      			<a class="page-link" href="/admin/manage_user_view?page=${nowPage + 1}">다음</a>
	      		</li>	
	    	</c:when>
	    	<c:otherwise>
		    	<li class="page-item">
		    	<c:choose>
		    	<c:when test="${not empty searchKeyword}">
	      			<a class="page-link" href="/admin/manage_user_view?page=${nowPage + 1}&searchKeyword=${searchKeyword}">다음</a>
	      		</c:when>
	      		<c:otherwise>
	      			<a class="page-link" href="/admin/manage_user_view?page=${nowPage + 1}">다음</a>
	      		</c:otherwise>
	      		</c:choose>
	      		</li>	
	    	</c:otherwise>	
	    </c:choose>   		
	  	</ul>
		</nav>
		</c:if>		
		<c:if test="${not empty searchKeyword}">
			<div class="d-flex justify-content-center">
				<a href="/admin/manage_user_view" class="btn btn-secondary">전체 목록으로</a>
			</div>
		</c:if>
<script>
$(document).ready(function() {
	
	$('#userSearchBtn').on('click', function() {
		let searchKeyword = $('#userSearchBox').val().trim();
		if (!searchKeyword) {
			alert("아이디 또는 이름을 입력하세요.")
			return false;			
		}
	});
	
	
});
</script>   		