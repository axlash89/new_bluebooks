<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	    	<div>
		    	<div>1:1 문의</div>
	    	</div>
	    	<div class="d-flex justify-content-between">
		    	<div class="pt-2">총 게시물 수 : ${onetooneList.totalElements}</div>
		    	<div>
		    	<c:if test="${userLoginId eq 'admin'}">		    		
					<form action="/admin/manage_onetoone_list_view" method="get" class="d-flex">
						<select id="searchCondition">
			    			<option id="byLoginId" selected>아이디</option>
			    			<option id="byTitle">제목</option>
			    		</select>
						<div class="d-flex mb-2">
							<input type="text" id="type" name="type" value="byLoginId" class="d-none">
							<input type="text" id="onetooneSearchBox" class="form-control" name="searchKeyword" placeholder="아이디를 입력하세요.">
					   		<input type="submit" id="onetooneSearchBtn" class="btn btn-secondary" value="검색">
				   		</div>
					</form>
				</c:if>	 
				</div>   	
			</div>
	    	<table class="table">
	    		<thead>
	    			<tr>
	    				<th>번호</th>
	    				<c:if test = "${userLoginId eq 'admin'}">
	    					<th>작성자</th>
	    				</c:if>
	    				<th>제목</th>	    				
	    				<th>상태</th>
	    				<th>작성날짜</th>
	    			</tr>
	    		</thead>
	    		<tbody>
		    		<c:forEach items="${onetooneList.content}" var="onetoone">
		    			<tr>
		    				
		    				<td>
		    				<c:choose>
			    				<c:when test="${userLoginId ne 'admin'}">		    				
			    					${onetoone.postNoForOneself}
			    				</c:when>
			    				<c:otherwise>
			    					${onetoone.id}
			    				</c:otherwise>
		    				</c:choose>		    				
		    				</td>
		    				<c:if test = "${userLoginId eq 'admin'}">
			    				<td>
			    					<c:forEach items="${userList}" var="user">
			    						<c:if test="${onetoone.userId eq user.id}">
			    							${user.loginId}
			    						</c:if>
			    					</c:forEach>
			    				</td>
		    				</c:if>
		    				<td>
		    					<c:choose>
			    					<c:when test="${userLoginId eq 'admin'}">
			    						<a href="/admin/onetoone_detail_view?id=${onetoone.id}">${onetoone.subject}</a>
			    					</c:when>
			    					<c:otherwise>
			    						<a href="/onetoone/onetoone_detail_view?id=${onetoone.id}">${onetoone.subject}</a>
			    					</c:otherwise>
		    					</c:choose>		    						    				
		    				
		    				</td>
		    				<td>
		    					${onetoone.status}
		    				</td>
		    				<td>  				
		    					<%-- ZonedDateTime -> Date -> String --%>
								<fmt:parseDate value="${onetoone.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
								<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일 HH:mm"/>		    					
							</td>
		    			</tr>
	    			</c:forEach>
	    		</tbody>
	    	</table>    
   					<c:choose>
	    				<c:when test="${userLoginId ne 'admin'}">		    				
	    					<c:if test="${endPage eq 0}">
						    	<nav aria-label="Page navigation example">
								  <ul class="pagination justify-content-center">				  
								    	<li class="page-item disabled"><a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage - 1}">이전</a></li>	
							      		<li class="page-item disabled"><a class="page-link" href="/onetoone/onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	<li class="page-item disabled"><a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage + 1}">다음</a></li>	
								  </ul>
								</nav>
					    	</c:if>
					    	<c:if test="${endPage ne 0}">	 
					    	<nav aria-label="Page navigation example">
							  <ul class="pagination justify-content-center">
						    	<c:choose>
							    	<c:when test="${nowPage eq 0}">
							    	<li class="page-item disabled">
						      			<a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage - 1}">이전</a>
						      		</li>	
							    	</c:when>
							    	<c:otherwise>
							    	<li class="page-item">
						      			<a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage - 1}">이전</a>
						      		</li>	
							    	</c:otherwise>	
							    </c:choose>	
							    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
								    <c:choose>
								    	<c:when test="${cnt eq nowPage}">
								    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/onetoone/onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	</c:when>
								    	<c:otherwise>
								    		<li class="page-item"><a class="page-link" href="/onetoone/onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	</c:otherwise>	
								    </c:choose>	
							    </c:forEach>			    
						    	<c:choose>
							    	<c:when test="${nowPage eq onetooneList.totalPages - 1}">
								    	<li class="page-item disabled">
							      			<a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage + 1}">다음</a>
							      		</li>	
							    	</c:when>
							    	<c:otherwise>
								    	<li class="page-item">
							      			<a class="page-link" href="/onetoone/onetoone_list_view?page=${nowPage + 1}">다음</a>
							      		</li>	
							    	</c:otherwise>	
							    </c:choose>
							  </ul>
							</nav>
							</c:if>
	    				</c:when>
	    				<c:otherwise>
	    				<c:choose>
	    				<c:when test="${searchKeyword eq 'none'}">
	    					<c:if test="${endPage eq 0}">
						    	<nav aria-label="Page navigation example">
								  <ul class="pagination justify-content-center">				  
								    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}">이전</a></li>	
							      		<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}">다음</a></li>	
								  </ul>
								</nav>
					    	</c:if>
					    	<c:if test="${endPage ne 0}">	 
					    	<nav aria-label="Page navigation example">
							  <ul class="pagination justify-content-center">
						    	<c:choose>
							    	<c:when test="${nowPage eq 0}">
							    	<li class="page-item disabled">
						      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}">이전</a>
						      		</li>	
							    	</c:when>
							    	<c:otherwise>
							    	<li class="page-item">
						      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}">이전</a>
						      		</li>	
							    	</c:otherwise>	
							    </c:choose>	
							    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
								    <c:choose>
								    	<c:when test="${cnt eq nowPage}">
								    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/admin/manage_onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	</c:when>
								    	<c:otherwise>
								    		<li class="page-item"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${cnt}">${cnt + 1}</a></li>
								    	</c:otherwise>	
								    </c:choose>	
							    </c:forEach>			    
						    	<c:choose>
							    	<c:when test="${nowPage eq onetooneList.totalPages - 1}">
								    	<li class="page-item disabled">
							      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}">다음</a>
							      		</li>	
							    	</c:when>
							    	<c:otherwise>
								    	<li class="page-item">
							      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}">다음</a>
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
								    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}${searchKeyword}">이전</a></li>	
							      		<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
								    	<li class="page-item disabled"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}${searchKeyword}">다음</a></li>	
								  </ul>
								</nav>
					    	</c:if>
					    	<c:if test="${endPage ne 0}">	 
					    	<nav aria-label="Page navigation example">
							  <ul class="pagination justify-content-center">
						    	<c:choose>
							    	<c:when test="${nowPage eq 0}">
							    	<li class="page-item disabled">
						      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}${searchKeyword}">이전</a>
						      		</li>	
							    	</c:when>
							    	<c:otherwise>
							    	<li class="page-item">
						      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage - 1}${searchKeyword}">이전</a>
						      		</li>	
							    	</c:otherwise>	
							    </c:choose>	
							    <c:forEach begin="${startPage}" end="${endPage}" var="cnt">
								    <c:choose>
								    	<c:when test="${cnt eq nowPage}">
								    		<li class="page-item disabled"><a class="page-link text-white bg-info" href="/admin/manage_onetoone_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
								    	</c:when>
								    	<c:otherwise>
								    		<li class="page-item"><a class="page-link" href="/admin/manage_onetoone_list_view?page=${cnt}${searchKeyword}">${cnt + 1}</a></li>
								    	</c:otherwise>	
								    </c:choose>	
							    </c:forEach>			    
						    	<c:choose>
							    	<c:when test="${nowPage eq onetooneList.totalPages - 1}">
								    	<li class="page-item disabled">
							      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}${searchKeyword}">다음</a>
							      		</li>	
							    	</c:when>
							    	<c:otherwise>
								    	<li class="page-item">
							      			<a class="page-link" href="/admin/manage_onetoone_list_view?page=${nowPage + 1}${searchKeyword}">다음</a>
							      		</li>	
							    	</c:otherwise>	
							    </c:choose>
							  </ul>
							</nav>
							</c:if>	
							</c:otherwise>
							</c:choose>    					
	    				</c:otherwise>
    				</c:choose>	
	    	   				
				<c:if test="${userLoginId ne 'admin'}">
		    	<div class="d-flex justify-content-end">
		    		<a href="/onetoone/onetoone_create_view" class="btn btn-info">글쓰기</a>
		    	</div>
		    	</c:if>

<script>
$(document).ready(function() {
	
	$('#searchCondition').on('change', function(){
		if ($('#searchCondition').val() == '아이디') {
			$('#type').val('byLoginId');
			$('#onetooneSearchBox').attr('placeholder', '아이디를 입력하세요.');
		} else {
			$('#type').val('byTitle');
			$('#onetooneSearchBox').attr('placeholder', '제목를 입력하세요.');
		}
	});
	
	$('#onetooneSearchBtn').on('click', function() {
		let keyword = $('#onetooneSearchBox').val().trim();
		if (!keyword) {
			alert("검색어를 입력하세요.")
			return false;			
		}				
	})
	
});
</script>