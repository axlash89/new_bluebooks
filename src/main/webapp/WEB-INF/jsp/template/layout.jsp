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



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14c1b4924cf47a096076123c4238d1a2"></script>


<script>
$("#findIdModal").on('shown.bs.modal', function() {
	// id 속성값이 myModal인 element 에 지도를 표시하는 로직
	
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.537020114667015, 126.95138137833497), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); 

var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter()
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);


function resizeMap() {
    var mapContainer = document.getElementById('map');
    mapContainer.style.width = '400px';
    mapContainer.style.height = '400px'; 
}


});
</script>

<div id="recentBooks" class="text-center">
	<img src="/static/img/look.png" width="50px" class="mb-3">
	
	<div class="mb-2"><a href="#" id="link1"><img src="/static/img/emptyBook.png" id="img1" width="43px" class="recentBooksImg"></a></div>
	<div class="mb-2"><a href="#" id="link2"><img src="/static/img/emptyBook.png" id="img2" width="53px" class="recentBooksImg d-none"></a></div>
	<div><a href="#" id="link3"><img src="/static/img/emptyBook.png" id="img3" width="63px" class="recentBooksImg d-none"></a></div>
</div>

<script>

	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();
		if (scrollTop < 70) {
		 scrollTop = 70;
		}
		var speed = 1200;
		var easing         = 'swing';
		$("#recentBooks").stop();
		$("#recentBooks").animate( { "top" : scrollTop }, { duration : speed, easing : easing });
	});
	

	

	function onPageLoad() {
		
	  var url = window.location.href;
	  var bookId = getBookIDFromURL(url);
	  
	  var coverImagePath = "a";
	  
	  if (bookId) {
		  $.ajax({
				type: "post"
				, url: "/book/recent_products"
				, data: { "bookId": bookId }			
				, success: function(data) {
					if (data.code == 1) {
						coverImagePath = data.cover;
						 
						 if (coverImagePath != "a") {
							var recentCoverImagePaths = getCookie('recent_books');
							var recentCoverImagePathArr = recentCoverImagePaths ? recentCoverImagePaths.split('@') : [];
							
							var recentBookIds = getCookie('recent_books_id');
							var recentBookIdArr = recentBookIds ? recentBookIds.split('/') : [];
						   
						    if (!recentCoverImagePathArr.includes(coverImagePath)) {
						    	recentCoverImagePathArr.push(coverImagePath);
						    }
						    
						    if (!recentBookIdArr.includes(bookId)) {
						    	recentBookIdArr.push(bookId);
						    }

						    // 최대 3개까지 유지
						    if (recentCoverImagePathArr.length > 3) {
						    	recentCoverImagePathArr.shift();
						    }
						    
						    if (recentBookIdArr.length > 3) {
						    	recentBookIdArr.shift();
						    }
						    
						    if (recentCoverImagePathArr.length == 1) {
						  		document.getElementById("img1").src = recentCoverImagePathArr[0];
						  		$('#img1').removeClass('d-none');
						    } else if (recentCoverImagePathArr.length == 2) {
						    	document.getElementById("img1").src = recentCoverImagePathArr[0];						    	
						    	document.getElementById("img2").src = recentCoverImagePathArr[1];
						    	$('#img1').removeClass('d-none');
						    	$('#img2').removeClass('d-none');
						    } else if (recentCoverImagePathArr.length == 3) {
						    	document.getElementById("img1").src = recentCoverImagePathArr[0];
						    	document.getElementById("img2").src = recentCoverImagePathArr[1];
						    	document.getElementById("img3").src = recentCoverImagePathArr[2];
						    	$('#img1').removeClass('d-none');
						    	$('#img2').removeClass('d-none');
						    	$('#img3').removeClass('d-none');
						    }
						    
						    if (recentCoverImagePathArr.length == 1) {
						    	document.getElementById("link1").href = "/book/book_detail_view?bookId=" + recentBookIdArr[0];
						    } else if (recentCoverImagePathArr.length == 2) {
						    	document.getElementById("link1").href = "/book/book_detail_view?bookId=" + recentBookIdArr[0];
							    document.getElementById("link2").href = "/book/book_detail_view?bookId=" + recentBookIdArr[1];
						    } else if (recentCoverImagePathArr.length == 3) {
						    	document.getElementById("link1").href = "/book/book_detail_view?bookId=" + recentBookIdArr[0];
							    document.getElementById("link2").href = "/book/book_detail_view?bookId=" + recentBookIdArr[1];
							    document.getElementById("link3").href = "/book/book_detail_view?bookId=" + recentBookIdArr[2];
						    }

						    recentCoverImagePaths = recentCoverImagePathArr.join('@');
							
						    recentBookIds = recentBookIdArr.join('/');
						    
						    // 24시간 후의 시간 객체 생성
						    var expirationDate = new Date();
						    expirationDate.setTime(expirationDate.getTime() + (24 * 60 * 60 * 1000));
						    console.log("expirationDate::" + expirationDate);

						    // 쿠키에 저장 (유효기간: 24시간)
						    setCookie('recent_books', recentCoverImagePaths, expirationDate);
						    setCookie('recent_books_id', recentBookIds, expirationDate);
						    
						 }
						    
						 }	 else {
						alert(data.errorMessage);
					}
				 
				}
				, error:function(request, status, error) {
					alert("최근 본 책 가져오기 실패, 관리자에게 문의하세요.")
				}
			
		  });
		  
	  } else {
		
		// 24시간 후의 시간 객체 생성
		// var expirationDate = new Date();
		// expirationDate.setTime(expirationDate.getTime() + (24 * 60 * 60 * 1000));
		  
		  
	 	var recentCoverImagePaths2 = getCookie('recent_books');
		var recentCoverImagePathArr2 = recentCoverImagePaths2 ? recentCoverImagePaths2.split('@') : [];
	    if (recentCoverImagePathArr2.length == 1) {
	  		document.getElementById("img1").src = recentCoverImagePathArr2[0];
	  		$('#img1').removeClass('d-none');
	    } else if (recentCoverImagePathArr2.length == 2) {
	    	document.getElementById("img1").src = recentCoverImagePathArr2[0];
	    	document.getElementById("img2").src = recentCoverImagePathArr2[1];
	  		$('#img1').removeClass('d-none');
	    	$('#img2').removeClass('d-none');
	    } else if (recentCoverImagePathArr2.length == 3) {
	    	document.getElementById("img1").src = recentCoverImagePathArr2[0];
	    	document.getElementById("img2").src = recentCoverImagePathArr2[1];
	    	document.getElementById("img3").src = recentCoverImagePathArr2[2];
	    	$('#img1').removeClass('d-none');
	    	$('#img2').removeClass('d-none');
	    	$('#img3').removeClass('d-none');
	    }
	    
	    
	    // setCookie('recent_books', recentCoverImagePaths2, expirationDate);
	    
	    
	    var recentBookIds2 = getCookie('recent_books_id');
		var recentBookIdArr2 = recentBookIds2 ? recentBookIds2.split('/') : [];
	  
		document.getElementById("link1").href = "/book/book_detail_view?bookId=" + recentBookIdArr2[0];
	    document.getElementById("link2").href = "/book/book_detail_view?bookId=" + recentBookIdArr2[1];
	    document.getElementById("link3").href = "/book/book_detail_view?bookId=" + recentBookIdArr2[2];
	    
	    // setCookie('recent_books_id', recentBookIds2, expirationDate);
	    
	  }
	  
	
	  
	    
	}


	// 페이지 로드 이벤트 리스너 등록
	window.addEventListener('load', onPageLoad);


	function setCookie(cookieName, value, expirationDate) {
	  var cookieValue = escape(value) + ((expirationDate == null) ? '' : ';path=/; expires=' + expirationDate.toUTCString());
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
