<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<div class="d-flex justify-content-center pt-3">	
		<div class="bg-info">
		<form action="/book/advanced_searched_result_view" method="get">
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">제목</span><input type="text" id="title" class="form-control pl-3 col-8" name="title" placeholder="제목을 입력하세요">
			</div>
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">저자</span><input type="text" id="author" class="form-control pl-3 col-8" name="author" placeholder="저자를 입력하세요">
			</div>
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">출판사</span><input type="text" id="publisher" class="form-control pl-3 col-8" name="publisher" placeholder="출판사를 입력하세요">
				<input type="submit" id="normalSearchBtn" class="btn btn-info ml-2" value="찾기">
			</div>
			
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">출간일</span>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="all" checked="checked">전체</label>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="threeM">3개월</label>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="sixM">6개월</label>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="nineM">9개월</label>
				<label><input type="radio" class="pub-period" name="pubPeriod" value="twentyFourM">24개월</label>
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