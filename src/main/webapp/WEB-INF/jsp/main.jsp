<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

   		<div class="d-flex justify-content-center pt-3">			
			<div id="bestSellerBoxInMain" class="main-box">
				<div class="main-box-text text-center">이번주 베스트셀러 Top10</div>
				<div class="wrapper main-box-border-div">
					<div class="rolling-list">
						<div class="book-wrapper">
							<div class="inner">
								<c:forEach items="${bestSellerTop10List}" var="book">					
									<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none pt-4 ml-3"><img src="${book.cover}" width="80px" alt="북 커버 이미지">
									<div class="main-book-title">${fn:substring(book.title,0,15)}..</div></a>											
								</c:forEach>	
							</div>	
						</div>
					</div>
				</div>				
			</div>
		</div>
		
		<div class="d-flex justify-content-center pt-3">	
			<div id="newBookBoxInMain" class="main-box">
				<div class="main-box-text text-center">주목할만한 신간 Top5</div>
				<div class="d-flex justify-content-around main-box-border-div">
				<c:forEach items="${noteworthyNewBookTop5List}" var="book">
					<div class="book-in-new-book-box pt-3">
						<a href="/book/book_detail_view?bookId=${book.id}" class="a-tag-deco-none"><img src="${book.cover}" width="80px" alt="북 커버 이미지">
						<div class="main-book-title">${fn:substring(book.title,0,15)}..</div></a>
					</div>
				</c:forEach>		
				</div>
			</div>
		</div>
		
		<div class="d-flex justify-content-center pt-3 pb-5">
				<div id="leftSideOfEvent" class="d-flex align-items-center"><a href="#" class="prev d-none"><img src="/static/img/blue_previous_icon.png" width="20px"></a><%--<button class="prev">PREV</button>--%></div>
			<div class="main-box-for-event">
				<div class="main-box-text text-center">진행중인 이벤트</div>
				<div class="event-in-event-box">
					<c:forEach items="${eventList}" var="event" varStatus="status">
						<a href="/event/event_list_view"><img src="${event.imagePath}" alt="이벤트 이미지" width="680px" height="200px"></a>
						<c:set var="eventCount" value="${status.count}"/>
					</c:forEach>
				</div>
			</div>
   				<div id="rightSideOfEvent" class="d-flex align-items-center"><a href="#" class="next"><img src="/static/img/blue_next_icon.png" width="20px"></a><%--<button class="next">NEXT</button>--%></div>
		</div>
			
<script>

$(document).ready(function() {
//롤링 배너 복제본 생성
let roller = document.querySelector('.rolling-list');
roller.id = 'roller1'; // 아이디 부여

let clone = roller.cloneNode(true)
// cloneNode : 노드 복제. 기본값은 false. 자식 노드까지 복제를 원하면 true 사용
clone.id = 'roller2';
document.querySelector('.wrapper').appendChild(clone); // wrap 하위 자식으로 부착

document.querySelector('#roller1').style.left = '0px';
document.querySelector('#roller2').style.left = document.querySelector('.rolling-list .inner').offsetWidth + 'px';
// offsetWidth : 요소의 크기 확인(margin을 제외한 padding값, border값까지 계산한 값)

roller.classList.add('original');
clone.classList.add('clone');




let curPos = 0;
let position = 0;
const IMAGE_WIDTH = 680;
const prevBtn = document.querySelector(".prev")
const nextBtn = document.querySelector(".next")
const images = document.querySelector(".event-in-event-box")

let eventCount = ${eventCount}

function prev(){
  if(curPos > 0){
    nextBtn.removeAttribute("disabled")
    position = position + IMAGE_WIDTH;
    images.style.transform = 'translateX(' + position + 'px)';
    curPos = curPos - 1;
  }
  if(curPos == 0){
    // prevBtn.setAttribute('disabled', 'true');
	$('.prev').addClass('d-none');
	$('.next').removeClass('d-none');
  }
}

function next(){
  if(curPos < eventCount - 1){
    prevBtn.removeAttribute("disabled")
    position = position - IMAGE_WIDTH;
    images.style.transform = 'translateX(' + position + 'px)';
    curPos = curPos + 1;
  }
  if(curPos == eventCount - 1){
    // nextBtn.setAttribute('disabled', 'true')
    $('.next').addClass('d-none');
    $('.prev').removeClass('d-none');
  }

}
 
function init(){
  prevBtn.setAttribute('disabled', 'true')
  prevBtn.addEventListener("click", function(e) {
	  e.preventDefault();
	  prev();
  });
  nextBtn.addEventListener("click", function(e) {
	  e.preventDefault();
	  next();
  });
}
 
init();


});

</script>