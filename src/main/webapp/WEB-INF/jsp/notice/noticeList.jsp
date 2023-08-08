<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<div>
	   	<div>공지사항</div>
	  	</div>
	  	
	  	<div>총 게시물 수 : ${noticeList.totalElements}</div>
	  	<table class="table text-center">
	  		<thead>
	  			<tr>
	  				<th>번호</th>
	  				<th>제목</th>
	  				<th>작성날짜</th>
	  			</tr>
	  		</thead>
	  		<tbody>
		   		<c:forEach items="${noticeList.content}" var="notice">
		   			<tr>
		   				<td>${notice.id}</td>
		   				<td><a href="/notice/notice_detail_view?id=${notice.id}">${notice.subject}</a></td>
		   				<td>
		   					<%-- ZonedDateTime -> Date -> String --%>
							<fmt:parseDate value="${notice.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
							<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일 HH:mm"/>
						</td>
		   			</tr>
	  			</c:forEach>
	  		</tbody>
	  	</table>
	  	<c:if test="${endPage eq 0}">
	   	<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    	<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}">이전</a></li>	
	      		<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${cnt}">${cnt + 1}</a></li>
		    	<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}">다음</a></li>	
		  </ul>
		</nav>
	  	</c:if>
	  	<c:if test="${endPage ne 0}">	 
	  	<nav aria-label="Page navigation example">
	  	<ul class="pagination justify-content-center">
	   	<c:choose>
	    	<c:when test="${nowPage eq 0}">
	    	<li class="page-item disabled">
	     			<a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}">이전</a>
	     		</li>	
	    	</c:when>
	    	<c:otherwise>
	    	<li class="page-item">
	     			<a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}">이전</a>
	     		</li>	
	    	</c:otherwise>	
	    </c:choose>	
	    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
		    <c:choose>
		    	<c:when test="${cnt eq nowPage}">
		    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/notice/notice_list_view?page=${cnt}">${cnt + 1}</a></li>
		    	</c:when>
		    	<c:otherwise>
		    		<li class="page-item"><a class="page-link" href="/notice/notice_list_view?page=${cnt}">${cnt + 1}</a></li>
		    	</c:otherwise>	
		    </c:choose>	
	    </c:forEach>			    
	   	<c:choose>
	    	<c:when test="${nowPage eq noticeList.totalPages - 1}">
		    	<li class="page-item disabled">
	      			<a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}">다음</a>
	      		</li>	
	    	</c:when>
	    	<c:otherwise>
		    	<li class="page-item">
	      			<a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}">다음</a>
	      		</li>	
	    	</c:otherwise>	
	    </c:choose>
	  	</ul>
		</nav>
		</c:if>   				
		
		<c:if test="${userLoginId eq 'admin'}">
	  	<div class="d-flex justify-content-end">
	  		<a href="/notice/notice_create_view" class="btn btn-info">글쓰기</a>
	  	</div> 
	  	</c:if>