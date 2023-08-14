<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    
	<div class="d-flex justify-content-center pt-3">
	<c:if test="${not empty bookListByCategory }">
	    <div class="book-menus">			
			<a href="/book/all_book_view?cid=656"><div class="pt-2">인문학</div></a>
			<a href="/book/all_book_view?cid=798"><div class="pt-2">사회과학</div></a>
			<a href="/book/all_book_view?cid=74"><div class="pt-2">역사</div></a>		
			<a href="/book/all_book_view?cid=1"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/all_book_view?cid=55889"><div class="pt-2">에세이</div></a>
			<a href="/book/all_book_view?cid=1196"><div class="pt-2">여행</div></a>
			<a href="/book/all_book_view?cid=517"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/all_book_view?cid=55890"><div class="pt-2">건강/취미/레저과학</div></a>
			<a href="/book/all_book_view?cid=1322"><div class="pt-2">외국어</div></a>
			<a href="/book/all_book_view?cid=351"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/all_book_view?cid=8257"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/all_book_view?cid=1383"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/all_book_view?cid=336"><div class="pt-2">자기계발</div></a>
			<a href="/book/all_book_view?cid=1137"><div class="pt-2">청소년</div></a>	
			<a href="/book/all_book_view?cid=2105"><div class="pt-2">고전</div></a>
	    </div>
	</c:if>    
	<c:if test="${not empty bestBookListByCategory }">
	    <div class="book-menus">			
			<a href="/book/best_book_view?cid=656"><div class="pt-2">인문학</div></a>
			<a href="/book/best_book_view?cid=798"><div class="pt-2">사회과학</div></a>
			<a href="/book/best_book_view?cid=74"><div class="pt-2">역사</div></a>		
			<a href="/book/best_book_view?cid=1"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/best_book_view?cid=55889"><div class="pt-2">에세이</div></a>
			<a href="/book/best_book_view?cid=1196"><div class="pt-2">여행</div></a>
			<a href="/book/best_book_view?cid=517"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/best_book_view?cid=55890"><div class="pt-2">건강/취미/레저과학</div></a>
			<a href="/book/best_book_view?cid=1322"><div class="pt-2">외국어</div></a>
			<a href="/book/best_book_view?cid=351"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/best_book_view?cid=8257"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/best_book_view?cid=1383"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/best_book_view?cid=336"><div class="pt-2">자기계발</div></a>
			<a href="/book/best_book_view?cid=1137"><div class="pt-2">청소년</div></a>	
			<a href="/book/best_book_view?cid=2105"><div class="pt-2">고전</div></a>
	    </div>
	</c:if>    
	<c:if test="${not empty newBookListByCategory }">
	    <div class="book-menus">			
			<a href="/book/new_book_view?cid=656"><div class="pt-2">인문학</div></a>
			<a href="/book/new_book_view?cid=798"><div class="pt-2">사회과학</div></a>
			<a href="/book/new_book_view?cid=74"><div class="pt-2">역사</div></a>		
			<a href="/book/new_book_view?cid=1"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/new_book_view?cid=55889"><div class="pt-2">에세이</div></a>
			<a href="/book/new_book_view?cid=1196"><div class="pt-2">여행</div></a>
			<a href="/book/new_book_view?cid=517"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/new_book_view?cid=55890"><div class="pt-2">건강/취미/레저과학</div></a>
			<a href="/book/new_book_view?cid=1322"><div class="pt-2">외국어</div></a>
			<a href="/book/new_book_view?cid=351"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/new_book_view?cid=8257"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/new_book_view?cid=1383"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/new_book_view?cid=336"><div class="pt-2">자기계발</div></a>
			<a href="/book/new_book_view?cid=1137"><div class="pt-2">청소년</div></a>	
			<a href="/book/new_book_view?cid=2105"><div class="pt-2">고전</div></a>
	    </div>
	</c:if>    
	    <div class="book-contents">
	    
	    	<jsp:include page="../${secondView}.jsp"/>
	    	
	    </div>
	    
    </div>