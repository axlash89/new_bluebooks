<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   	<div class="d-flex justify-content-center pt-3">	
		<div class="bg-info">
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">제목</span><input type="text" id="title" class="form-control pl-3 col-8" placeholder="제목을 입력하세요">
			</div>
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">저자</span><input type="text" id="author" class="form-control pl-3 col-8" placeholder="저자를 입력하세요">
			</div>
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">출판사</span><input type="text" id="publisher" class="form-control pl-3 col-8" placeholder="출판사를 입력하세요">
				<input type="button" class="btn btn-info ml-2" value="찾기">
			</div>
			${result}
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">출간일</span>
				<label><input type="radio" name ="pubPeriod" value="all" checked="checked">전체</label>
				<label><input type="radio" name ="pubPeriod" value="threeM">3개월</label>
				<label><input type="radio" name ="pubPeriod" value="sixM">6개월</label>
				<label><input type="radio" name ="pubPeriod" value="nineM">9개월</label>
				<label><input type="radio" name ="pubPeriod" value="twentyfourM">24개월</label>
			</div>
			<hr>
			<div class="d-flex">
				<span class="col-4 d-flex align-items-center">ISBN 검색</span><input type="text" id="isbn13" class="form-control pl-3 col-8" placeholder="-없이 숫자만 입력하세요">
				<input type="button" class="btn btn-info ml-2" value="찾기">
			</div>
		</div>
	</div>