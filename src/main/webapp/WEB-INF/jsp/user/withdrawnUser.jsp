<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<style>
table, td, th {
border : 1px solid black;
}
th {
background : #F3F5F5;
}
 
table {
margin-top : 5%;
margin-left : auto;
margin-right: auto;
text-align: center;
width: 80%;
}
 
 a:link { color: red; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 
/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
    z-index: 1;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 0;
    width: 20px;
    height: 24px;
    line-height: 24px;
    text-align: center;
    color: #848484;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 12px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: #DAA520;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
    border: 1px solid #777;
    border-radius: 2px;
    width: 28px;
}
 
.paginate .paging .direction:hover {
    border: 1px solid #C40639;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
    cursor: pointer;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}
 
.bottom-left, .bottom-right {
    position: relative;
    z-index: 5;
}
 
.paginate ~ .bottom {
    margin-top: -50px;
}
 
 
.bottom select {
    background: transparent;
    color: #aaa;
    cursor: pointer;
}
 
 
/* paginate */
.paginate {
    padding: 0;
    line-height: normal;
    text-align: center;
    position: relative;
    margin: 20px 0 20px 0;
}
 
.paginate .paging {
    text-align: center;
}
 
.paginate .paging a, .paginate .paging strong {
    margin: 0;
    padding: 0;
    width: 20px;
    height: 28px;
    line-height: 28px;
    text-align: center;
    color: #999;
    display: inline-block;
    vertical-align: middle;
    text-align: center;
    font-size: 14px;
}
 
.paginate .paging a:hover, .paginate .paging strong {
    color: #C40639;
    font-weight: 600;
    font-weight: normal;
}
 
.paginate .paging .direction {
    z-index: 3;
    vertical-align: middle;
    background-color: none;
    margin: 0 2px;
}
 
.paginate .paging .direction:hover {
    background-color: transparent;
}
 
.paginate .paging .direction.prev {
    margin-right: 4px;
}
 
.paginate .paging .direction.next {
    margin-left: 4px;
}
 
.paginate .paging img {
    vertical-align: middle;
}
 
.paginate .right {
    position: absolute;
    top: 0;
    right: 0;
}
 
 
</style>




		<div>
	   	<div class="h3 d-flex justify-content-center mb-3">탈퇴한 회원 리스트</div>
	  	</div>
	  	
	  	<%-- <div class="d-flex justify-content-between"> 
	  		<c:choose>
	  			<c:when test="${not empty searchKeyword}">
	  			<div class="pt-2">검색어와 일치하는 회원 수 : ${userList.totalElements}</div>
	  			</c:when>
	  			<c:otherwise>
	  				<div class="pt-2">총 회원 수 : ${userList.totalElements - 1}</div>
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
   		</div> --%>
   		  		
   		
   		
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
		   					<%-- ZonedDateTime -> Date -> String --%>
							<fmt:parseDate value="${user.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
							<fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 M월 d일"/>
						</td>
		   				<td>
							<fmt:formatDate value="${user.userCreatedAt}" pattern="yyyy년 M월 d일"/>
						</td>
		   			</tr>
	  			</c:forEach>
	  		</tbody>
	  	</table>
	  	
	  	<!--paginate -->
    <div class="paginate">
        <div class="paging">
            <a class="direction prev" href="javascript:void(0);"
                onclick="movePage(1,${pagination.cntPerPage},${pagination.pageSize});">
                &lt;&lt; </a> <a class="direction prev" href="javascript:void(0);"
                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasPreviousPage == true}">-1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">
                &lt; </a>
 
            <c:forEach begin="${pagination.firstPage}"
                end="${pagination.lastPage}" var="idx">
                <a
                    style="color:<c:out value="${pagination.currentPage == idx ? '#cc0000; font-weight:700; margin-bottom: 2px;' : ''}"/> "
                    href="javascript:void(0);"
                    onclick="movePage(${idx},${pagination.cntPerPage},${pagination.pageSize});"><c:out
                        value="${idx}" /></a>
            </c:forEach>
            <a class="direction next" href="javascript:void(0);"
                onclick="movePage(${pagination.currentPage}<c:if test="${pagination.hasNextPage == true}">+1</c:if>,${pagination.cntPerPage},${pagination.pageSize});">
                &gt; </a> <a class="direction next" href="javascript:void(0);"
                onclick="movePage(${pagination.totalRecordCount},${pagination.cntPerPage},${pagination.pageSize});">
                &gt;&gt; </a>
        </div>
    </div>
    <!-- /paginate -->
	  	
	  	
	  <div class="bottom">
        <div class="bottom-left">
            <select id="cntSelectBox" name="cntSelectBox"
                onchange="changeSelectBox(${pagination.currentPage},${pagination.cntPerPage},${pagination.pageSize});"
                class="form-control" style="width: 100px;">
                <option value="10"
                    <c:if test="${pagination.cntPerPage == '10'}">selected</c:if>>10개씩</option>
                <option value="20"
                    <c:if test="${pagination.cntPerPage == '20'}">selected</c:if>>20개씩</option>
                <option value="30"
                    <c:if test="${pagination.cntPerPage == '30'}">selected</c:if>>30개씩</option>
            </select>
        </div>
    </div>
	  	
	  	
	  	
	  	
	  	
	  	<%-- 
	  	<div class="d-flex justify-content-between">
		  	<c:choose>
		  	<c:when test="${empty searchKeyword}">
		  		<c:choose>
			  		<c:when test="${nowPage ne 0}">
			  		<a href="/admin/manage_user_view?page=0">첫 페이지로</a>
			  		</c:when>
			  		<c:otherwise>
			  		첫 페이지로
			  		</c:otherwise>
				</c:choose>
				
				<c:choose>
			  		<c:when test="${nowPage eq userList.totalPages - 1}">
			  		마지막 페이지로  		
			  		</c:when>
			  		<c:otherwise>
			  		<a href="/admin/manage_user_view?page=${userList.totalPages - 1}">마지막 페이지로</a>
			  		</c:otherwise>
				</c:choose>
		  	</c:when>
		  	<c:otherwise>
		  		<a href="/admin/manage_user_view?page=${startPage}&searchKeyword=${searchKeyword}">첫 페이지로</a>
		   		<a href="/admin/manage_user_view?page=${endPage}&searchKeyword=${searchKeyword}" class="float-right">마지막 페이지로</a>
		  	</c:otherwise>
	   		</c:choose>
   		</div>
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
		<a href="/admin/manage_user_view" class="btn btn-secondary">전체 목록으로</a>
		</c:if> --%>
<script>
$(document).ready(function() {
	
	$('#userSearchBtn').on('click', function() {
		let searchKeyword = $('#userSearchBox').val().trim();
		if (!searchKeyword) {
			alert("아이디 또는 이름을 입력하세요.")
			return false;			
		}
	});
	
	
	//10,20,30개씩 selectBox 클릭 이벤트
	function changeSelectBox(currentPage, cntPerPage, pageSize){
	    var selectValue = $("#cntSelectBox").children("option:selected").val();
	    movePage(currentPage, selectValue, pageSize);
	
	
    function movePage(currentPage, cntPerPage, pageSize){
        
        var url = "${pageContext.request.contextPath}/list";
        url = url + "?currentPage="+currentPage;
        url = url + "&cntPerPage="+cntPerPage;
        url = url + "&pageSize="+pageSize;
        
        location.href=url;
    }
	
	
});
</script>   		