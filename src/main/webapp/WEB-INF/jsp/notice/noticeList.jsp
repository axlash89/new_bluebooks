<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<div>
	   	<div>공지사항</div>
	  	</div>
	  	
	  	<div class="d-flex justify-content-end pr-3">
	  		<form action="/notice/notice_list_view" method="get">
	  		<input type="text" id="searchNoticeBox" name="searchKeyword" placeholder="제목을 입력하세요.">
	  		<input type="submit" id="searchNoticeBtn" value="검색">
	  		</form>
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
	  	
	  	<div class="d-flex justify-content-between">
		  	<c:choose>
		  	<c:when test="${empty searchKeyword}">
		  		<c:choose>
			  		<c:when test="${nowPage ne 0}">
			  		<a href="/notice/notice_list_view?page=0">첫 페이지로</a>
			  		</c:when>
			  		<c:otherwise>
			  		첫 페이지로
			  		</c:otherwise>
				</c:choose>
				
				<c:choose>
			  		<c:when test="${nowPage eq noticeList.totalPages - 1}">
			  		마지막 페이지로  		
			  		</c:when>
			  		<c:otherwise>
			  		<a href="/notice/notice_list_view?page=${noticeList.totalPages - 1}">마지막 페이지로</a>
			  		</c:otherwise>
				</c:choose>
		  	</c:when>
		  	<c:otherwise>
		  		<c:choose>
			  		<c:when test="${nowPage ne 0}">
		  				<a href="/notice/notice_list_view?page=0${searchKeyword}">첫 페이지로</a>
		  			</c:when>
		  			<c:otherwise>
		  			<div>첫 페이지로</div>
		  			</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${nowPage eq noticeList.totalPages - 1}">
					<div>마지막 페이지로</div>	
				</c:when>
				<c:otherwise>
					<a href="/notice/notice_list_view?page=${noticeList.totalPages - 1}${searchKeyword}" class="float-right">마지막 페이지로</a>
		   		</c:otherwise>
				</c:choose>
		  	</c:otherwise>
	   		</c:choose>
   		</div>
	  	
	  	<c:choose>
	  	<c:when test="${empty searchKeyword}">
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
		</c:when>
		<c:otherwise>
		<c:if test="${endPage eq 0}">
		   	<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    	<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}${searchKeyword}">이전</a></li>	
		      		<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
			    	<li class="page-item disabled"><a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}${searchKeyword}">다음</a></li>	
			  </ul>
			</nav>
	  	</c:if>
	  	<c:if test="${endPage ne 0}">	 
		  	<nav aria-label="Page navigation example">
		  	<ul class="pagination justify-content-center">
		   	<c:choose>
		    	<c:when test="${nowPage eq 0}">
		    	<li class="page-item disabled">
	     			<a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}${searchKeyword}">이전</a>
	     		</li>	
		    	</c:when>
		    	<c:otherwise>
		    	<li class="page-item">
	     			<a class="page-link" href="/notice/notice_list_view?page=${nowPage - 1}${searchKeyword}">이전</a>
	     		</li>	
		    	</c:otherwise>	
		    </c:choose>	
		    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
			    <c:choose>
			    	<c:when test="${cnt eq nowPage}">
			    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/notice/notice_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
			    	</c:when>
			    	<c:otherwise>
			    		<li class="page-item"><a class="page-link" href="/notice/notice_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
			    	</c:otherwise>	
			    </c:choose>	
		    </c:forEach>			    
		   	<c:choose>
		    	<c:when test="${nowPage eq noticeList.totalPages - 1}">
			    	<li class="page-item disabled">
		      			<a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}${searchKeyword}">다음</a>
		      		</li>	
		    	</c:when>
		    	<c:otherwise>
			    	<li class="page-item">
		      			<a class="page-link" href="/notice/notice_list_view?page=${nowPage + 1}${searchKeyword}">다음</a>
		      		</li>	
		    	</c:otherwise>	
		    </c:choose>
		  	</ul>
			</nav>
		</c:if>
		</c:otherwise>
		</c:choose>
			
		
		<c:if test="${userLoginId eq 'admin'}">
	  	<div class="d-flex justify-content-end">
	  		<a href="/notice/notice_create_view" class="btn btn-info">글쓰기</a>
	  	</div> 
	  	</c:if>
	  	
	  	<c:if test="${not empty searchKeyword}">
			<div class="d-flex justify-content-center">
				<a href="/notice/notice_list_view" class="btn btn-secondary">전체 목록으로</a>
			</div>
		</c:if>
		
<script>
$(document).ready(function() {


	$('#searchNoticeBtn').on('click', function() {
		let keyword = $('#searchNoticeBox').val().trim();
		if (!keyword) {
			alert("검색어를 입력하세요.")
			return false;			
		}				
	})	
	
});
</script>   