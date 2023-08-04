<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블루북스</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="/static/css/style.css">

</head>
<body>

	<div id="wrap" class="container">
	
		<header>
			<div>
	        	<div>
	        		<img src="/static/img/logo.png" width="80px">
	        		<div class="text-primary"><h5>블루북스</h5></div>
	        	</div>
        	</div>
        	<div>
        		<div class="d-flex">
		       		<input type="text" id="searchBox" class="form-control" placeholder="책의 제목 또는 저자 입력">
		       		<input type="button" id="searchBoxBtn" class="btn btn-secondary" value="검색">
        		</div>
        	</div>
            <nav>
                <ul class="nav nav-fill d-flex justify-content-around align-items-center font-weight-bold">
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">분야보기</div></li></a>
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">베스트셀러</div></li></a>
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">새로나온 책</div></li></a>
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">이벤트</div></li></a>
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">공지사항</div></li></a>
                    <a href="#"><li class="menus"><div class="d-flex justify-content-center">마이페이지</div></li></a>
                </ul>
            </nav>
		</header>
		
		<section>
		</section>
		
		<footer>
		</footer>
		
	</div>

</body>
</html>