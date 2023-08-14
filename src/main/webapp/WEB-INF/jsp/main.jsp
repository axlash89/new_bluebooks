<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

   		<div class="d-flex justify-content-center pt-3">			
			<div id="bestSellerBoxInMain" class="bg-info">
				<div><h5>금주 베스트셀러 Top10</h5></div>
				<div class="d-flex justify-content-around">
				<c:forEach items="${bestSellerTop10List}" var="book">
					<div class="book-in-best-seller-box bg-warning">
						<img src="${book.cover}" width="80px" alt="북 커버 이미지">
						<div>${book.title}</div>
					</div>
				</c:forEach>	
				</div>				
			</div>
		</div>
		
		<div class="d-flex justify-content-center pt-3">	
			<div id="newBookBoxInMain" class="bg-info">
				<div><h5>주목할만한 신간 Top5</h5></div>
				<div class="d-flex justify-content-around">
				<c:forEach items="${noteworthyNewBookTop5List}" var="book">
					<div class="book-in-new-book-box bg-warning">
						<img src="${book.cover}" width="80px" alt="북 커버 이미지">
						<div>${book.title}</div>
					</div>
				</c:forEach>		
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center pt-3">	
			<div id="eventBoxInMain" class="bg-info">
				<div>진행중인 이벤트</div>
				<div class="d-flex justify-content-center">
					<div class="event-in-event-box bg-warning">
						<img src="https://cdn.pixabay.com/photo/2015/11/30/23/32/champagner-1071356_1280.jpg" width="550px" height="120px" alt="이벤트 이미지">
						<div class="d-flex justify-content-center">기간, 당첨자 혜택 등</div>
					</div>
				</div>
			</div>
		</div>