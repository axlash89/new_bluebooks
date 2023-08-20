<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<div class="sign-up-text h3 text-center pt-5 pb-1">상세검색</div>
	<div>&nbsp;</div>
	<hr class="mt-2 mb-3">
   	<div class="d-flex justify-content-center pt-5">	
		<div>
		<form action="/book/advanced_searched_result_view" method="get">
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center sign-up-text">제목</span><input type="text" id="title" class="form-control col-8" name="title" placeholder="제목을 입력하세요">
			</div>
			<div class="d-flex pt-3">
				<span class="col-4 d-flex align-items-center sign-up-text">저자</span><input type="text" id="author" class="form-control col-8" name="author" placeholder="저자를 입력하세요">
			</div>
			<div class="d-flex pt-3">
				<span class="col-4 d-flex align-items-center sign-up-text">출판사</span><input type="text" id="publisher" class="form-control col-8" name="publisher" placeholder="출판사를 입력하세요">
				<input type="submit" id="normalSearchBtn" class="btn btn-info ml-3" value="찾기">
			</div>
			
			<div class="d-flex pt-4 mb-5">
				<span class="col-4 d-flex align-items-center sign-up-text">출간일</span>
				<div class="col-8">
				<label><input type="radio" class="pub-period" name="pubPeriod" value="all" checked="checked"> 전체</label><br>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="threeM"> 최근 3개월</label><br>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="sixM"> 최근 6개월</label><br>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="nineM"> 최근 9개월</label><br>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="twentyFourM"> 최근 2년</label>
				</div>
			</div>
		</form>	
		</div>
	</div>
	
<script>


$(document).ready(function() {
	
	
	
	$('#normalSearchBtn').on('click', function() {
		
		let title = $('#title').val().trim();		
		let author = $('#author').val().trim();
		let publisher = $('#publisher').val().trim();		
		
		
		if (!title && !author && !publisher) {
			alert("검색어를 입력하세요.");
			return false;
		}
		
	});
	
	$('#isbnSearchBtn').on('click', function() {

		let isbn = $('#isbn13').val();
		
		
		if (!isbn) {
			alert("검색어(ISBN)를 입력하세요.");
			return false;
		}
		
	});
	
	
});

</script>	