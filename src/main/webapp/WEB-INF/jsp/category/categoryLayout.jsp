<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    
	<div class="d-flex justify-content-center">
	<c:if test="${not empty bookListByCategory }">
	    <div id="bookMenu" class="book-menus stop-drag">
	    	<h5 class="category-guide font-weight-bold text-center pt-2">분야보기&nbsp;</h5>
	    	<hr>
			<a href="/book/all_book_view?cid=656&cname=인문학" class="a-tag-deco-none-category"><div class="pt-2">인문학</div></a>
			<a href="/book/all_book_view?cid=798&cname=사회과학" class="a-tag-deco-none-category"><div class="pt-2">사회과학</div></a>
			<a href="/book/all_book_view?cid=1&cname=소설/시/희곡" class="a-tag-deco-none-category"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/all_book_view?cid=55889&cname=에세이" class="a-tag-deco-none-category"><div class="pt-2">에세이</div></a>
			<a href="/book/all_book_view?cid=74&cname=역사" class="a-tag-deco-none-category"><div class="pt-2">역사</div></a>		
			<a href="/book/all_book_view?cid=517&cname=예술/대중문화" class="a-tag-deco-none-category"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/all_book_view?cid=1196&cname=여행" class="a-tag-deco-none-category"><div class="pt-2">여행</div></a>
			<a href="/book/all_book_view?cid=55890&cname=건강/취미/레저" class="a-tag-deco-none-category"><div class="pt-2">건강/취미/레저</div></a>
			<a href="/book/all_book_view?cid=1322&cname=외국어" class="a-tag-deco-none-category"><div class="pt-2">외국어</div></a>
			<a href="/book/all_book_view?cid=351&cname=컴퓨터/모바일" class="a-tag-deco-none-category"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/all_book_view?cid=170&cname=경제·경영" class="a-tag-deco-none-category"><div class="pt-2">경제·경영</div></a>
			<a href="/book/all_book_view?cid=8257&cname=대학교재/전문서적" class="a-tag-deco-none-category"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/all_book_view?cid=1383&cname=수험서/자격증" class="a-tag-deco-none-category"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/all_book_view?cid=336&cname=자기계발" class="a-tag-deco-none-category"><div class="pt-2">자기계발</div></a>
			<a href="/book/all_book_view?cid=2913&cname=잡지" class="a-tag-deco-none-category"><div class="pt-2">잡지</div></a>	
			<a href="/book/all_book_view?cid=2551&cname=만화" class="a-tag-deco-none-category"><div class="pt-2">만화</div></a>		
			<a href="/book/all_book_view?cid=1137&cname=청소년" class="a-tag-deco-none-category"><div class="pt-2">청소년</div></a>	
			<a href="/book/all_book_view?cid=1230&cname=가정/요리/뷰티" class="a-tag-deco-none-category"><div class="pt-2">가정/요리/뷰티</div></a>	
	    </div>
	</c:if>    
	<c:if test="${not empty bestBookListByCategory }">
	    <div class="book-menus stop-drag">
	    	<h5 class="category-guide font-weight-bold text-center pt-2">베스트셀러&nbsp;</h5>
	    	<hr>			
			<a href="/book/best_book_view?cid=656&cname=인문학" class="a-tag-deco-none-category"><div class="pt-2">인문학</div></a>
			<a href="/book/best_book_view?cid=798&cname=사회과학" class="a-tag-deco-none-category"><div class="pt-2">사회과학</div></a>
			<a href="/book/best_book_view?cid=1&cname=소설/시/희곡" class="a-tag-deco-none-category"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/best_book_view?cid=55889&cname=에세이" class="a-tag-deco-none-category"><div class="pt-2">에세이</div></a>
			<a href="/book/best_book_view?cid=74&cname=역사" class="a-tag-deco-none-category"><div class="pt-2">역사</div></a>		
			<a href="/book/best_book_view?cid=517&cname=예술/대중문화" class="a-tag-deco-none-category"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/best_book_view?cid=1196&cname=여행" class="a-tag-deco-none-category"><div class="pt-2">여행</div></a>
			<a href="/book/best_book_view?cid=55890&cname=건강/취미/레저" class="a-tag-deco-none-category"><div class="pt-2">건강/취미/레저</div></a>
			<a href="/book/best_book_view?cid=1322&cname=외국어" class="a-tag-deco-none-category"><div class="pt-2">외국어</div></a>
			<a href="/book/best_book_view?cid=351&cname=컴퓨터/모바일" class="a-tag-deco-none-category"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/best_book_view?cid=170&cname=경제·경영" class="a-tag-deco-none-category"><div class="pt-2">경제·경영</div></a>
			<a href="/book/best_book_view?cid=8257&cname=대학교재/전문서적" class="a-tag-deco-none-category"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/best_book_view?cid=1383&cname=수험서/자격증" class="a-tag-deco-none-category"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/best_book_view?cid=336&cname=자기계발" class="a-tag-deco-none-category"><div class="pt-2">자기계발</div></a>
			<a href="/book/best_book_view?cid=2913&cname=잡지" class="a-tag-deco-none-category"><div class="pt-2">잡지</div></a>	
			<a href="/book/best_book_view?cid=2551&cname=만화" class="a-tag-deco-none-category"><div class="pt-2">만화</div></a>		
			<a href="/book/best_book_view?cid=1137&cname=청소년" class="a-tag-deco-none-category"><div class="pt-2">청소년</div></a>	
			<a href="/book/best_book_view?cid=1230&cname=가정/요리/뷰티" class="a-tag-deco-none-category"><div class="pt-2">가정/요리/뷰티</div></a>	
	    </div>
	</c:if> 
	<c:if test="${not empty newBookListByCategory }">
	    <div class="book-menus stop-drag">			
	   		<h5 class="category-guide font-weight-bold text-center pt-2">새로나온 책&nbsp;</h5>
	    	<hr>
			<a href="/book/new_book_view?cid=656&cname=인문학" class="a-tag-deco-none-category"><div class="pt-2">인문학</div></a>
			<a href="/book/new_book_view?cid=798&cname=사회과학" class="a-tag-deco-none-category"><div class="pt-2">사회과학</div></a>
			<a href="/book/new_book_view?cid=1&cname=소설/시/희곡" class="a-tag-deco-none-category"><div class="pt-2">소설/시/희곡</div></a>
			<a href="/book/new_book_view?cid=55889&cname=에세이" class="a-tag-deco-none-category"><div class="pt-2">에세이</div></a>
			<a href="/book/new_book_view?cid=74&cname=역사" class="a-tag-deco-none-category"><div class="pt-2">역사</div></a>		
			<a href="/book/new_book_view?cid=517&cname=예술/대중문화" class="a-tag-deco-none-category"><div class="pt-2">예술/대중문화</div></a>
			<a href="/book/new_book_view?cid=1196&cname=여행" class="a-tag-deco-none-category"><div class="pt-2">여행</div></a>
			<a href="/book/new_book_view?cid=55890&cname=건강/취미/레저" class="a-tag-deco-none-category"><div class="pt-2">건강/취미/레저</div></a>
			<a href="/book/new_book_view?cid=1322&cname=외국어" class="a-tag-deco-none-category"><div class="pt-2">외국어</div></a>
			<a href="/book/new_book_view?cid=351&cname=컴퓨터/모바일" class="a-tag-deco-none-category"><div class="pt-2">컴퓨터/모바일</div></a>
			<a href="/book/new_book_view?cid=170&cname=경제·경영" class="a-tag-deco-none-category"><div class="pt-2">경제·경영</div></a>
			<a href="/book/new_book_view?cid=8257&cname=대학교재/전문서적" class="a-tag-deco-none-category"><div class="pt-2">대학교재/전문서적</div></a>
			<a href="/book/new_book_view?cid=1383&cname=수험서/자격증" class="a-tag-deco-none-category"><div class="pt-2">수험서/자격증</div></a>
			<a href="/book/new_book_view?cid=336&cname=자기계발" class="a-tag-deco-none-category"><div class="pt-2">자기계발</div></a>
			<a href="/book/new_book_view?cid=2913&cname=잡지" class="a-tag-deco-none-category"><div class="pt-2">잡지</div></a>	
			<a href="/book/new_book_view?cid=2551&cname=만화" class="a-tag-deco-none-category"><div class="pt-2">만화</div></a>		
			<a href="/book/new_book_view?cid=1137&cname=청소년" class="a-tag-deco-none-category"><div class="pt-2">청소년</div></a>	
			<a href="/book/new_book_view?cid=1230&cname=가정/요리/뷰티" class="a-tag-deco-none-category"><div class="pt-2">가정/요리/뷰티</div></a>	
	    </div>
	</c:if>    
	    <div class="book-contents">
	    
	    	<jsp:include page="../${secondView}.jsp"/>
	    	
	    </div>
	    
    </div>