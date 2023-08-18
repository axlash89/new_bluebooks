<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블루북스</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<!-- Datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="/static/css/style.css">
</head>
<body class="d-flex justify-content-center">

	<div id="wrap">
	
		<header>
			<jsp:include page="../include/header.jsp"/>
		</header>
		
		<section class="contents">
		
			<jsp:include page="../${view}.jsp"/>
			
		</section>
		
		<footer>
			<jsp:include page="../include/footer.jsp"/>
		</footer>
		
	</div>

<div>
<div>최근 본 상품</div>
	<div><img src="" alt="최근 본 상품 1" id="recentBook1"></div>
	<input type="text" id="img">
	<input type="text" id="img2">
	<input type="text" id="img3">
</div>


<script>
	
function onPageLoad() {
	  var url = window.location.href;
	  var bookId = getBookIDFromURL(url);
	  console.log("bookId::" + bookId);
	  
	  if (bookId) {
	    var recentBooks = getCookie('recent_books');
	    var recentBookIds = recentBooks ? recentBooks.split('/') : [];
	   
	    if (!recentBookIds.includes(bookId)) {
	      recentBookIds.push(bookId);
	    }
	
	    // 최대 10개까지 유지
	    if (recentBookIds.length > 3) {
	      recentBookIds.shift();
	    }
	
	    recentBooks = recentBookIds.join('/');
	
	    // 24시간 후의 시간 객체 생성
	    var expirationDate = new Date();
	    expirationDate.setTime(expirationDate.getTime() + (24 * 60 * 60 * 1000));
	    console.log("expirationDate::" + expirationDate);
	
	    // 쿠키에 recent_products 저장 (유효기간: 24시간)
	    setCookie('recent_books', recentBooks, expirationDate);
	  }
	  

	  $('#img').val(recentBookIds[0]);
	  $('#img2').val(recentBookIds[1]);
	  $('#img3').val(recentBookIds[2]);
		  
	  
	
	// 페이지 로드 이벤트 리스너 등록
	window.addEventListener('load', onPageLoad);
	
	
	function setCookie(cookieName, value, expirationDate) {
	  var cookieValue = escape(value) + ((expirationDate == null) ? '' : '; expires=' + expirationDate.toUTCString());
	  document.cookie = cookieName + '=' + cookieValue;
	}
	
	function getCookie(cookieName) {
	  var name = cookieName + '=';
	  var decodedCookie = decodeURIComponent(document.cookie);
	  var cookieArray = decodedCookie.split(';');
	
	  for (var i = 0; i < cookieArray.length; i++) {
	    var cookie = cookieArray[i];
	    while (cookie.charAt(0) == ' ') {
	      cookie = cookie.substring(1);
	    }
	    if (cookie.indexOf(name) == 0) {
	      return cookie.substring(name.length, cookie.length);
	    }
	  }
	  return '';
	}
	
	//url에서 productId를 가져오는 함수
	function getBookIDFromURL(url) {
	  var regex = /[?&]bookId=(\d+)/;
	  var match = regex.exec(url);
	  if (match && match[1]) {
	     return match[1];		  
	  }
	  return null;
	}
	
	
</script>


</body>
</html>
